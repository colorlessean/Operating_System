; special registers for segmentation cs, ds, ss, es i.e. code, data, stack, extra (user defined)
mov ah, 0x0e ; enters tty mode

mov al, [secret]
int 0x10
; this does not work

mov bx, 0x7c0 ; segmentation is automatically over by 4 
mov ds, bx ; move to the data segement value the value at bx
; All memory references will be offset standard by the ds value

mov al, [secret]
int 0x10

mov al, [es:secret]
; accesses with segment of es
int 0x10
; es is currently 0x0000 so this will not work

mov bx, 0x7c0
mov es, bx

mov al, [es:secret]
int 0x10

jmp $ ; hangs

secret:
    db "X"

; padding and end of sector value
times 510 - ($-$$) db 0
dw 0xaa55