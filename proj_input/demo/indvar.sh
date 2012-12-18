#!/bin/bash
fname=$1
rm llvmprof.out # Otherwise your profile runs are added together
rm superblocks
clang -emit-llvm -o $fname.bc -c $fname.c || { echo "Failed to emit llvm bc"; exit 1; }
echo "Time with no optimization"
lli $fname.bc
opt -loop-simplify < $fname.bc > $fname.ls.bc || { echo "Failed to opt loop simplify"; exit 1; }
opt -insert-edge-profiling $fname.ls.bc -o $fname.profile.ls.bc
llc $fname.profile.ls.bc -o $fname.profile.ls.s
g++ -o $fname.profile $fname.profile.ls.s /y/students/jezra/build/Debug+Asserts/lib/libprofile_rt.so
./$fname.profile $2
opt -load /y/students/jezra/build/projects/project1/Debug+Asserts/lib/LLVMHello.so -lamp-insts -insert-lamp-profiling -insert-lamp-loop-profiling -insert-lamp-init < $fname.ls.bc > $fname.lamp.bc || { echo "Failed to opt load"; exit 1; }
llc < $fname.lamp.bc > $fname.lamp.s || { echo "Failed to llc"; exit 1; }
g++ -o $fname.lamp.exe $fname.lamp.s /y/students/jezra/llvm/projects/project1/tools/lamp-profiler/lamp_hooks.o || { echo "Failed to g++"; exit 1; }
echo "Done generating lamp profile".
opt -mem2reg < $fname.ls.bc > $fname.lss.bc
echo "After mem2reg pass"
lli $fname.lss.bc
opt -load /y/students/jezra/build/projects/project1/Debug+Asserts/lib/LLVMHello.so -lamp-inst-cnt -lamp-map-loop -lamp-load-profile -profile-loader -profile-info-file=llvmprof.out -hello < $fname.ls.bc > $fname.final.bc || { echo "Failed to opt-load"; exit 1; }
opt -mem2reg < $fname.final.bc > $fname.slicm.bc
llc $fname.slicm.bc -o $fname.slicm.s 
g++ $fname.slicm.s -o $fname.slicm 
echo "After hello pass"
./$fname.slicm
opt -load /y/students/jezra/build/projects/project1/Debug+Asserts/lib/LLVMHello.so -lamp-inst-cnt -lamp-map-loop -lamp-load-profile -profile-loader -profile-info-file=llvmprof.out -indvar < $fname.slicm.bc > $fname.finish.bc || { echo "Failed to opt-load"; exit 1; }
llc $fname.finish.bc -o $fname.finish.s 
g++ $fname.finish.s -o $fname.finish 
opt -mem2reg < $fname.finish.bc > $fname.last.bc
echo "After induction variable pass"
#./$fname.finish
lli $fname.last.bc
