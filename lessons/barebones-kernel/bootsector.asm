[org 0x7c00] ; offset for bootsector
KERNEL_OFFSET equ 0x1000

    mov [BOOT_DRIVE], dl ; BIOS sets the bootdrive in the register dl on boot
    mov bp, 0x9000
    mov sp, bp

    mov bx, MSG_REAL_MODE
    call print
    call print_n1

    call load_kernel ; read the kernel from the disk
    call switch_to_pm ; disable interupts, load GDT, ect. jumps to BEGIN_PM
    jmp $ ; never to be exectuted

%include "../Boot_Sector_Functions_Strings/boot_sect_print.asm"
%include "../Boot_Sector_Functions_Strings/boot_sect_print_hex.asm"
%include "../bootsector_disk/bootsector_disk_disk.asm"
%include "../32bit-gdt/32bit-gdt.asm"
%include "../32bit-print/32bit-print.asm"
%include "../32bit-enter/32bit-switch.asm"

[bits 16]
load_kernel:
    mov bx, MSG_LOAD_KERNEL
    call print
    call print_n1

    mov bx, KERNEL_OFFSET
    mov dh, 2
    mov dl, [BOOT_DRIVE]
    call disk_load
    ret

[bits 32]
BEGIN_PM: 
    mov ebx, MSG_PROT_MODE
    call print_string_pm
    call KERNEL_OFFSET
    jmp $ ; will stay here when kernel returns to control to bootsector (shouldn't happen)

BOOT_DRIVE db 0 ; good idea to store in memory as dl may be overwritten at some point
MSG_REAL_MODE db "Started in 16 bit Real Mode", 0
MSG_PROT_MODE db "Landed in 32 bit Protected Mode", 0
MSG_LOAD_KERNEL db "Loading Kernel into Memory"

; padding on the bootsector
times 510-($-$$) db 0
dw 0xaa55
