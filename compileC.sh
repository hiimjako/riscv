#c compiler
#bash compileC.sh "name"
riscv64-unknown-elf-gcc -o $1 $1.s
qemu-riscv64 $1
rm -r *