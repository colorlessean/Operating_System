[org 0x7c00] ; tell the assembler that our offset is bootloader code

; the main routine makes sure the parameters are ready and then calls the function
mov bx, HELLO
call print

call print_n1

move dx, 0x12fe
call print_hex

; can hang now
jmp $

; include the subroutines below the hang
%include "boot_sect_print.asm"
%include "boot_sect_print_hex.asm"

; data

HELLO:
    db 'Hello World', 0

GOODBYE:
    db 'Goodbye', 0

; padding and magic number
times 510-($-$$) db 0
dw 0xaa55

; je target     jump if equal
; jne           jump if not equal
; jl            jump if less than
; jle           jump if less than or equal
; jg            jump if greater than
; jge           jump if greater than or equal

; call will jump to the function but store the previous memory location to the IP register
; ret will jump back to the memory location stored in the IP (instruction pointer) register