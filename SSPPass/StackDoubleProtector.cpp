#include "StackDoubleProtector.h"
#include "llvm/ADT/SmallPtrSet.h"
#include "llvm/ADT/Statistic.h"
#include "llvm/Analysis/BranchProbabilityInfo.h"
#include "llvm/Analysis/EHPersonalities.h"
#include "llvm/Analysis/OptimizationDiagnosticInfo.h"
#include "llvm/CodeGen/Passes.h"
#include "llvm/CodeGen/TargetPassConfig.h"
#include "llvm/IR/Attributes.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/DataLayout.h"
#include "llvm/IR/DebugInfo.h"
#include "llvm/IR/DebugLoc.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/IR/Dominators.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Instruction.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/Intrinsics.h"
#include "llvm/IR/MDBuilder.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Type.h"
#include "llvm/IR/User.h"
#include "llvm/Pass.h"
#include "llvm/Support/Casting.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Target/TargetLowering.h"
#include "llvm/Target/TargetMachine.h"
#include "llvm/Target/TargetOptions.h"
#include "llvm/Target/TargetSubtargetInfo.h"
#include <utility>

using namespace llvm;

#define DEBUG_TYPE "stack-double-protector"

char StackDoubleProtector::ID = 0;

void StackDoubleProtector::getAnalysisUsage(AnalysisUsage &AU) const {
	AU.addRequired<TargetPassConfig>();
	AU.addPreserved<DominatorTreeWrapperPass>();
}

//Address为257表示在用户模式下的fs段寄存器
static Constant* SegmentOffsetStack(IRBuilder<> &IRB, unsigned Offset, unsigned AddressSpace) {
	return ConstantExpr::getIntToPtr(
		ConstantInt::get(Type::getInt32Ty(IRB.getContext()), Offset),
		Type::getInt8PtrTy(IRB.getContext())->getPointerTo(AddressSpace)
	);
}
static Value* getTheStackGuardValue(IRBuilder<> &IRB) {
	return SegmentOffsetStack(IRB, 0x28, 257);
}
static bool CreateDoublePrologue(Function* F, Module *M, ReturnInst *RI, AllocaInst *&AI) {
	IRBuilder<> B(&F->getEntryBlock().front());
	PointerType *PtrTy = Type::getInt8PtrTy(RI->getContext());
	AI = B.CreateAlloca(PtrTy, nullptr, "StackDoubleGuard");
	Value* DoubleGuard = getTheStackGuardValue(B);
	Value* loadedDoubleGuard = B.CreateLoad(DoubleGuard, true, "stackDoubleGuard");
	//将canany值存进allocaInst中去
	errs() << "stack protector store\n";
	B.CreateStore(loadedDoubleGuard, AI, true);
	return true;
}

void StackDoubleProtector::randomCananyMemory() {
	IRBuilder<> B(&F->getEntryBlock().front());
	Value* cananyMemory = getTheStackGuardValue(B);
	unsigned random = std::rand();
	ConstantInt *canany = ConstantInt::get(Type::getInt32Ty(F->getContext()), random, false);
	errs() << "Random Protector store\n";
	errs() << canany->getType() << ",";
	errs() << cast<PointerType>(cananyMemory->getType())->getElementType() << "\n";
	B.CreateStore(canany, cananyMemory, true);
}
bool StackDoubleProtector::runOnFunction(Function &Fn) {
	F = &Fn;
	M = F->getParent();
	DominatorTreeWrapperPass *DTWP = getAnalysisIfAvailable<DominatorTreeWrapperPass>();
	DT = DTWP ? &DTWP->getDomTree() : nullptr;
	TM = &getAnalysis<TargetPassConfig>().getTM<TargetMachine>();
	trip = TM->getTargetTriple();
	//TLI = TM->getSubtargetImpl(Fn)->getTargetLowering();

	if (!F->getName().equals("main")) {        //一开始随机化canany
		InsertStackDoubleProtectors();
	}

	return true;
}

bool StackDoubleProtector::InsertStackDoubleProtectors() {
	AllocaInst *AI = nullptr;

	for (Function::iterator I = F->begin(), E = F->end(); I != E;) {
		BasicBlock* BB = &*I++;
		ReturnInst *RI = dyn_cast<ReturnInst>(BB->getTerminator());
		if (!RI)
			continue;
		CreateDoublePrologue(F, M, RI, AI);  //将canany保存进栈中
		BasicBlock *FailBB = CreateFailBB();
		BasicBlock *NewBB = BB->splitBasicBlock(RI->getIterator(), "SP_double_return");

		if (DT && DT->isReachableFromEntry(BB)) {
			DT->addNewBlock(NewBB, BB);
			DT->addNewBlock(FailBB, BB);
		}
		BB->getTerminator()->eraseFromParent(); //将以前的return指令转移到新的basicblock中

		NewBB->moveAfter(BB);
		IRBuilder<> B(BB);
		Value* stackGuard = getTheStackGuardValue(B);
		Value* loadedStackGuard = B.CreateLoad(stackGuard, true, "stackDoubleGuard");
		LoadInst* loadedValue = B.CreateLoad(AI, true);
		Value *Cmp = B.CreateICmpEQ(loadedStackGuard, loadedValue);
		B.CreateCondBr(Cmp, NewBB, FailBB);
}
	return true;
}

BasicBlock *StackDoubleProtector::CreateFailBB() {
	LLVMContext &Context = F->getContext();
	BasicBlock *FailBB = BasicBlock::Create(Context, "CallStackDoublecheckFailBlk", F);
	IRBuilder<> B(FailBB);
	//B.SetCurrentDebugLocation(DebugLoc::get(0, 0, F->getSubprogram));
	Constant *StackChkFail = M->getOrInsertFunction("__stack_chk_fail", Type::getVoidTy(Context));

	B.CreateCall(StackChkFail, {});
	B.CreateUnreachable();
	return FailBB;
}

//char StackDoubleProtector::ID = 0;
static RegisterPass<StackDoubleProtector> X("SSPPass", "Stack Double Protector", false, false);
