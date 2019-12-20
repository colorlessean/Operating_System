; recieving data in dx
print_hex:
    pusha

    mov cx, 0 ; the index variable


; Get the last char of dx then convert to ascii
; For numeric ascii values add 0x30
; For alphabetic characters A-F add 0x40
; Then move the ASCII byte to the correct position on the resulting string
hex_loop:
    cmp cx, 4 ; loop 4 times
    je end

    ; 1. Convert last character of dx to ascii
    mov ax, dx ; using ax as the working register
    and ax, 0x000f ; masks first three values to zero
    add al, 0x30 ; add 30 to N to convert to ascii N
    cmp al, 0x39 ; if > 9 add extra 8 to convert A to F
    jle step2
    add al, 7 ; A is ascii 65 instead of 58 so 65-58=7

step2:
    ; 2. Get the correct position of the string to place our ascii character
    ; bx base address + string length - index of character
    mov bx, HEX_OUT + 5 ; base + length
    sub bx, cx ; our index variable
    mov [bx], al ; copy the ascii character on al to the position pointed by bx
    ror dx, 4

    add cx, 1 ; increment index and loop
    jmp hex_loop

end:
    ; prepare parameter and call the function
    ; remeber that print recieves values in bx
    mov bx, HEX_OUT
    call print

    ; reload register values and return
    popa
    ret

HEX_OUT:
    db '0x0000', 0 ; reserve memory for the new string
    