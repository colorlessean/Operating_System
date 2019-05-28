[bits 32]
[extern main] ; must have same name as kernel.c main function
call main ; calls the c function. Linker will know where it is placed in memory
jmp $
