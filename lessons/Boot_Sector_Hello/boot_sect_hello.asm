; Simple Boot Sector that prints a message to the screen using a BIOS routine

mov ah, 0x0e ; indicates tele-type mode (tty)

mov al, 'H' ; Moves the letter that needs to be printed into the register
int 0x10 ; interupt 0x10 causes screen-related ISR to run which is indicated a tty from above
mov al, 'E'
int 0x10
mov al, 'L'
int 0x10 ; two interupts allows the same letter to be printed twice
int 0x10
mov al, 'O'
int 0x10

jmp $ ; Jump to current address = infinte loop

; padding and the boot sector indication at the end of sector
times 510 - ($-$$) db 0 
dw 0xaa55