#fork compilatore riscV
#linker con nome 
#-o oggetto con nome
#.s script
riscv64-unknown-elf-as -g -o $1.o $1.s
#lo carico ed eseguo
riscv64-unknown-elf-ld -o $1 $1.o
#avvio lo stream
qemu-riscv64 -g 2223 $1