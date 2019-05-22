; load dh sectors from drive dl into ES:BX
disk_load:
    pusha
    ; reading from disk requires setting values in all registers
    ; overwrite input parameters from dx
    ; save current dx to the stack for now
    push dx

    mov ah, 0x02 ; loading int 0x13 function 0x02 = read
    mov al, dh   ; number of sectors to read
    mov cl, 0x02 ; cl is sector number
    mov ch, 0x00 ; ch is cylinder number 
    ; dl is drive number which is automatically set by the BIOS
    ; (0 = floppy, 1 = floppy2, 0x80 = hdd, 0x81 = hdd2 
    mov dh, 0x00 ; dh is the head number

    ; [es:bx] pointer to buffer where data is stored
    ; caller sets it up for us and is the standard location for int 0x13
    int 0x13 ; BIOS interupt
    jc disk_error ; if error (carry bit will be true)

    pop dx
    cmp al, dh ; BIOS also sets al to the number of sectors read
    jne sectors_error ; if they are not equal there is an error 

    ; restore registers and return
    popa
    ret

disk_error:
    mov bx, DISK_ERROR
    call print
    call print_n1
    mov dh, ah ; ah = error code, dl = disk that dropped the error
    call print_hex
    jmp disk_loop

sectors_error:
    mov bx, SECTORS_ERROR
    call print

disk_loop:
    jmp $ ; hang

; Set constants which will be called
DISK_ERROR: db "Disk read error", 0
SECTORS_ERROR: db "Incorrect number of sectors read", 0
