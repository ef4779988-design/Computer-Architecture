global _main
extern _printf

section .data
    msg db "Task 3: Manual NOP Insertion (Distance 2)", 10
        db "Producer Output (EAX) = %d", 10
        db "Independent Instruction Result (ECX) = %d", 10
        db "Consumer Output (EDX) = %d", 10, 0

section .text
_main:
    ; Values setup
    mov eax, 10         ; R4 = 10
    mov ebx, 20         ; R5 = 20
    mov ecx, 0x0F       ; R7 / R8 setup
    mov edx, 3          ; R10 = 3
    
    ; Producer Instruction: R2 = R4 + R5
    add eax, ebx        ; EAX (R2) = 30
    
    ; Independent Instruction: R6 = R7 & R8 (Absorbs 1 cycle)
    and ecx, 0x0A       ; ECX (R6) = 0x0F & 0x0A = 10
    
    ; Single NOP required to reach Cycle 5
    nop                 ; Absorbs remaining 1 cycle
    
    ; Consumer Instruction: R9 = R2 | R10
    mov edx, eax        ; Reads R2 (EAX) safely
    or  edx, 3          ; EDX (R9) = 30 | 3 = 31
    
    ; Output Display
    push edx
    push ecx
    push eax
    push msg
    call _printf
    add esp, 16
    
    xor eax, eax
    ret
