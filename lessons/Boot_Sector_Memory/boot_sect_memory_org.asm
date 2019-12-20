[org 0x7c00] ; Defines the offset for all memory location calls following in the file
mov ah, 0x0e ; Defines the cmd as being tty mode

; Will fail regardless of org as still addressing the pointer
mov al, '1'
int 0x10
mov al, the_secret
int 0x10

; Memory offset is defined so will run to correct address
mov al, '2'
int 0x10
mov al, [the_secret]
int 0x10

; Adding the offset twice does not result in the correct memory location
mov al, '3'
int 0x10
mov bx, the_secret
add bx, 0x7c00
mov al, [bx]
int 0x10

; Still using the hardcoded memory location will result in the same thing
; Adding new code will still break this and a recount will need to be done
mov al, '4'
int 0x10
mov al, [0x7c2d]
int 0x10

jmp $ ; Infinite loop

the_secret: ; Defines what variale the_secret is
    db 'X'

; Adds in the remaining padding and the end of sector bootsector indicator
times 510-($-$$) db 0
dw 0xaa55