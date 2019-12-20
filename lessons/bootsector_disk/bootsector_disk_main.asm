[org 0x7c00]
    mov bp, 0x8000 ; set the stack far away from boot code
    mov sp, bp

    mov bx, 0x9000
    mov dh, 2 ; read 2 sectors
    ; bios sets dl to our boot disk number

    call disk_load

    mov dx, [0x9000] ; retrieve the first loaded word, 0xdada
    call print_hex

    call print_n1

    mov dx, [0x9000 + 512] ; first word from second loaded sector 0xface
    call print_hex

    jmp $ ; hang

%include "../Boot_Sector_Function_Strings/boot_sect_print_hex.asm"
%include "../Boot_Sector_Function_Strings/boot_sect_print.asm"

%include "bootsector_disk_disk.asm"

; Magic Number
times 510 - ($-$$) db 0
dw 0xaa55

; boot sector is sector 1 of cly 0 of head 0 of hdd 0
; from now on is sector 2

times 256 dw 0xdada ; sector 2 = 512 bytes
times 256 dw 0xface ; sector 3 = 512 bytes


