export PATH=/lib/llvm-20/bin:$PATH

rm -rf test *.prof*

# -u__llvm_profile_runtime /usr/lib/llvm-20/lib/clang/20/lib/linux/libclang_rt.profile-x86_64.a
clang `#-v` -c -fprofile-instr-generate -fcoverage-mapping -fcoverage-mcdc -o test.o test.c
clang -fprofile-instr-generate -fcoverage-mapping -fcoverage-mcdc -o test test.o
./test

llvm-nm test.o | grep -E '(__llvm_profile_runtime|__llvm_profile_get_size_for_buffer|__llvm_profile_write_buffer)'
echo ----
llvm-nm test   | grep -E '(__llvm_profile_runtime|__llvm_profile_get_size_for_buffer|__llvm_profile_write_buffer)'
echo ----
llvm-nm /usr/lib/llvm-20/lib/clang/20/lib/linux/libclang_rt.profile-x86_64.a |\
    grep -E '(__llvm_profile_runtime|__llvm_profile_get_size_for_buffer|__llvm_profile_write_buffer)'
