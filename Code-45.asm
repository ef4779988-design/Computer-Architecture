global _main
extern _printf

section .data
    array   dd 500, 600    ; Array containing values
    ptr_var dd array       ; Changed 'ptr' to 'ptr_var'
    msg     db "Task 8: Back-to-Back Address Dependency", 10
            db "Loaded Pointer Address (EAX) = 0x%08X", 10
            db "Data Read from Pointer Offset (EBX) = %d", 10, 0

section .text
_main:
    ; First Load: LW R1, 0(R2) -> Load pointer address into EAX
    mov eax, [ptr_var]   ; Read pointer address
    
    ; Mandatory 1-cycle stall for address calculation alignment
    nop                  ; Hardware/Compiler stall bubble
    
    ; Second Load: LW R3, 4(R1) -> Read value at pointer + offset 4
    mov ebx, [eax + 4]   ; EBX gets second element of array (600)
    
    ; Output Display
    push ebx
    push eax
    push msg
    call _printf
    add esp, 12
    
    xor eax, eax
    ret