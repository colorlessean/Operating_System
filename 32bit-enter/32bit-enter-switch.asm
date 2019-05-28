[bits 16]

switch_to_pm:
    cli ; 1. disable all interupts
    lgdt [gdt_descriptor] ; 2. load the gdt descriptor
    mov eax, cr0
    or eax, 0x1 ; 3. Set 32 bit mode bit in cr0
    mov cr0, eax
    jmp CODE_SEG:init_pm ; 4. Far jump by using a different segement

[bits 32]
init_pm: ; using 32 bit instructions
    mov ax, DATA_SEG ; 5. Update the segement registers
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax 

    mov ebp, 0x90000 ; 6. Update the statck right at the top of the free space
    mov esp, ebp

    call BEGIN_PM ; call well known label with useful code


