; ModuleID = 'stack_example.ll'
source_filename = "stack_example.ll"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [32 x i8] c"You have already controlled it.\00", align 1

; Function Attrs: nounwind uwtable
define void @success() #0 {
  %StackDoubleGuard = alloca i8*
  %stackDoubleGuard = load volatile i8*, i8* addrspace(257)* inttoptr (i32 40 to i8* addrspace(257)*)
  store volatile i8* %stackDoubleGuard, i8** %StackDoubleGuard
  %1 = call i32 @puts(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @.str, i32 0, i32 0))
  %stackDoubleGuard1 = load volatile i8*, i8* addrspace(257)* inttoptr (i32 40 to i8* addrspace(257)*)
  %2 = load volatile i8*, i8** %StackDoubleGuard
  %3 = icmp eq i8* %stackDoubleGuard1, %2
  br i1 %3, label %SP_double_return, label %CallStackDoublecheckFailBlk

SP_double_return:                                 ; preds = %0
  ret void

CallStackDoublecheckFailBlk:                      ; preds = %0
  call void @__stack_chk_fail()
  unreachable
}

declare i32 @puts(i8*) #1

; Function Attrs: nounwind uwtable
define void @vulnerable() #0 {
  %StackDoubleGuard = alloca i8*
  %stackDoubleGuard = load volatile i8*, i8* addrspace(257)* inttoptr (i32 40 to i8* addrspace(257)*)
  store volatile i8* %stackDoubleGuard, i8** %StackDoubleGuard
  %s = alloca [12 x i8], align 1
  %1 = getelementptr inbounds [12 x i8], [12 x i8]* %s, i32 0, i32 0
  %2 = call i32 (i8*, ...) bitcast (i32 (...)* @gets to i32 (i8*, ...)*)(i8* %1)
  %3 = getelementptr inbounds [12 x i8], [12 x i8]* %s, i32 0, i32 0
  %4 = call i32 @puts(i8* %3)
  %stackDoubleGuard1 = load volatile i8*, i8* addrspace(257)* inttoptr (i32 40 to i8* addrspace(257)*)
  %5 = load volatile i8*, i8** %StackDoubleGuard
  %6 = icmp eq i8* %stackDoubleGuard1, %5
  br i1 %6, label %SP_double_return, label %CallStackDoublecheckFailBlk

SP_double_return:                                 ; preds = %0
  ret void

CallStackDoublecheckFailBlk:                      ; preds = %0
  call void @__stack_chk_fail()
  unreachable
}

declare i32 @gets(...) #1

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** %argv) #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i8**, align 8
  store i32 0, i32* %1, align 4
  store i32 %argc, i32* %2, align 4
  store i8** %argv, i8*** %3, align 8
  call void @vulnerable()
  ret i32 0
}

declare void @__stack_chk_fail()

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)"}
