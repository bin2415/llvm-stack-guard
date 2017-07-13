#ifndef LLVM_CODEGEN_STACKDOUBLEPROTECTOR_H
#define LLVM_CODEGEN_STACKDOUBLEPROTECTOR_H

#include "llvm/ADT/SmallPtrSet.h"
#include "llvm/ADT/Triple.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/ValueMap.h"
#include "llvm/Pass.h"
#include "llvm/PassAnalysisSupport.h"

namespace llvm {
	class BasicBlock;
	class DominatorTree;
	class Function;
	class Instruction;
	class Module;
	class TargetLowingBase;
	class TargetMachine;
	class Type;

	class StackDoubleProtector : public FunctionPass {
	
	private:
		const TargetMachine *TM = nullptr;

		//TIL-targetLoweringBase
		//const TargetLoweringBase *TLI = nullptr;

		Triple trip;

		Function *F;
		Module *M;

		DominatorTree *DT;

		unsigned SSPBufferSize = 0;

		//将代码插入到Pass中，首先将stackguard存进stack中,
		//其次在return地址之前将存的stackguard与TLS中的stackguard进行比较
		bool InsertStackDoubleProtectors();

		//产生随机化的数并将数放入到fs:0x28中去
		void randomCananyMemory();

		//如果遇到fork函数，则需要将TLS中的stackguard更新
		bool changeStackGuard();

		BasicBlock *CreateFailBB();

	public:
		static char ID;
		StackDoubleProtector() : FunctionPass(ID), SSPBufferSize(8) {
		}

		void getAnalysisUsage(AnalysisUsage &AU) const override;

		bool runOnFunction(Function &Fn) override;

		
	};
}


#endif

