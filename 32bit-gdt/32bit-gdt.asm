gdt_start: ; gdt starts will a null 8 bytes
    dd 0x0 ; 4 bytes
    dd 0x0 ; 4 bytes 

gdt_code: ; segment of memory for code, base = 0x00000000, length = 0xffff
    dw 0xffff ; segement length, bits 0-15
    dw 0x0 ; segement base, bits 0-15
    db 0x0 ; segement base, bits 16-31
    db 10011010b ; flags (8 bits)
    db 11001111b ; flags (4 bits) + segement length bits 16-19
    db 0x0 ; segement base, bits 24-31

gdt_data: ; segement of memory for data base and length same as code segement
    dw 0xffff
    dw 0x0
    db 0x0
    db 10011010b
    db 11001111b
    db 0x0 

gdt_end: ; empty end of gdt

; GDT Descriptor

gdt_descriptor:
    dw gdt_end - gdt_start - 1 ; size (16 bits), always one less than its true style
    dd gdt_start ; address (32 bits)

; constants definition
CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start
