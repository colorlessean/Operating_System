; Infinite Loop (e9 fd ff)
; boot sector has e9 fd ff then followed by 16 pairs per line for 30 lines of zeros
; followed then with a 16 bit value of 0xAA55 which appears as 55 aa as x86 is little endian

loop:
    jmp loop

; Fill with 510 zeros minus the size of the pervious code
times 510-($-$$) db 0
; The aforementioned 16 bit values
dw 0xaa55 