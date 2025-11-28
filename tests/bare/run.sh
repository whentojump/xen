export PATH=/home/wentaoz5/wentaoz5/ktest-project/xen-patches/llvm-bare-install/bin:$PATH

rm -rf test *.prof*

# -u__llvm_profile_runtime /media/wd-sn580-2t-1/users/wentaoz5/ktest-project/xen-patches/llvm-bare-install/lib/clang/22/lib/x86_64-unknown-linux-gnu/libclang_rt.profile.a
clang `#-v` -c -fprofile-instr-generate -fcoverage-mapping -fcoverage-mcdc -o test.o test.c
clang -fprofile-instr-generate -fcoverage-mapping -fcoverage-mcdc -o test test.o
./test

llvm-nm test.o | grep -E '(__llvm_profile_runtime|__llvm_profile_get_size_for_buffer|__llvm_profile_write_buffer)'
echo ----
llvm-nm test   | grep -E '(__llvm_profile_runtime|__llvm_profile_get_size_for_buffer|__llvm_profile_write_buffer)'
echo ----
llvm-nm /media/wd-sn580-2t-1/users/wentaoz5/ktest-project/xen-patches/llvm-bare-install/lib/clang/22/lib/x86_64-unknown-linux-gnu/libclang_rt.profile.a |\
    grep -E '(__llvm_profile_runtime|__llvm_profile_get_size_for_buffer|__llvm_profile_write_buffer)'

if [[ -f manual.profraw ]]; then
    llvm-profdata merge manual.profraw -o manual.profdata
    llvm-cov show test -instr-profile=manual.profdata -show-branches=count -show-mcdc
fi
