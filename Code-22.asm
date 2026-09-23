global _main
extern _printf

section .data
    formatRaw   db "Raw EFLAGS = 0x%08X", 10, 0
    formatFlags db "Zero Flag (ZF) = %d, Carry Flag (CF) = %d", 10, 0

section .text
_main:
    ; Step 1: Perform subtraction (5 - 5 = 0) -> ZF = 1, CF = 0
    mov eax, 5
    sub eax, 5

    ; Step 2: Push EFLAGS onto stack and pop into EBX
    pushfd
    pop ebx

    ; Display raw EFLAGS
    push ebx
    push formatRaw
    call _printf
    add esp, 8

    ; Step 4: Extract Zero Flag (Bit 6)
    mov ecx, ebx
    shr ecx, 6
    and ecx, 1

    ; Step 5: Extract Carry Flag (Bit 0)
    mov edx, ebx
    and edx, 1

    ; Step 6: Print Flag values
    push edx            ; CF
    push ecx            ; ZF
    push formatFlags
    call _printf
    add esp, 12

    ; Return 0
    xor eax, eax
    ret