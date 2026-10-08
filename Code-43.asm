global _main
extern _printf

section .data
    mem_val dd 100       ; Memory location (0(R2))
    msg db "Task 6: Classic Load-Use Stall", 10
        db "Loaded Value (EAX) = %d", 10
        db "ALU Result (ECX) = %d (After 1-Cycle Load-Use Stall)", 10, 0

section .text
_main:
    ; Values setup
    mov edx, 15          ; R4 = 15
    
    ; Memory Load: LW R1, 0(R2)
    mov eax, [mem_val]   ; Data ready at end of MEM stage (Cycle 4)
    
    ; 1-Cycle Stall required because data isn't ready at start of EX stage
    nop                  ; Hardware/Compiler stall bubble
    
    ; ALU Operation: ADD R3, R1, R4
    mov ecx, eax         ; Uses forwarded value from MEM/WB
    add ecx, edx         ; ECX (R3) = 100 + 15 = 115
    
    ; Output Display
    push ecx
    push eax
    push msg
    call _printf
    add esp, 12
    
    xor eax, eax
    ret