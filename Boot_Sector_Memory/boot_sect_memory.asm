mov ah, 0x0e ; Indicates tty mode

; Fails to print as it tries to print the memory address not the contents
mov al, "1"
int 0x10
mov al, the_secret
int 0x10

; Tries to print the contents of what's at the memory address
; Fails to account for the BIOS placing the bootsector at address 0x7c00

mov al, "2"
int 0x10
mov al, [the_secret]
int 0x10

; Adds the BIOS offset to the to the memory address then derefences it to get the value
; Need a second register because you cannot run mov al, [ax]
; I.e. register cannot be used as both the source and destination of the same cmd
mov al, '3'
int 0x10
mov bx, the_secret
add bx, 0x7c00
mov al, [bx]
int 0x10

; Use a shortcut since we know that the value is stored at byte 0x2d in our binary
; Ineffective as every time the code changes need to recount label offsets
mov al, '4'
int 0x10
mov al, [0x7c2d]
int 0x10

jmp $ ; infinite loop

the_secret:
    ; ASCII code 0x58 i.e X is stored just before the zero padding
    ; This code is stored at 0x2d
    db "X"

; zero padding and BIOS number to indicate boot sector
times 510-($-$$) db 0
dw 0xaa55
