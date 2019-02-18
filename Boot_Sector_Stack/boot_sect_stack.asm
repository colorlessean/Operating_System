mov ah, 0x0e ; tty mode

mov bp, 0x8000 ; address far away from 0x7c00 so we don't get overwritten
mov sp, bp ; if the stack is empty then sp will point to the top

push 'A'
push 'B'
push 'C'

; to show how the stack goes downwards
mov al, [0x7ffe] ; 0x8000 - 2
int 0x10

; can only access the top of the stack so only 0x7ffe
mov al, [0x8000]
int 0x10

; pop from the stack to get the letters that were pushed to it
; can only pop full words so need an extra register to manipulate
pop bx
mov al, bl
int 0x10 ; prints C

pop bx
mov al, bl
int 0x10 ; prints B

pop bx
mov al, bl
int 0x10 ; prints A

; data that has een popped from the stack is garbage now
mov al, [0x8000]
int 0x10

jmp $
times 510-($-$$) db 0
dw 0xaa55
