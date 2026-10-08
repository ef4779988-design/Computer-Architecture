global _main
extern _printf

section .data
    msg db "Task 4: Multi-Operand Hazard Simulation", 10
        db "Producer 1 (EAX) = %d", 10
        db "Producer 2 (EBX) = %d", 10
        db "Consumer Output (ECX) = %d (Both operands resolved safely)", 10, 0

section .text
_main:
    ; Values setup
    mov eax, 10         ; R3 = 10
    mov ebx, 20         ; R4 = 20
    mov ecx, 5          ; R5 = 5
    mov edx, 15         ; R6 = 15
    
    ; Producer 1: R1 = R3 + R4 (Distance 2 relative to consumer)
    add eax, ebx        ; EAX (R1) = 30
    
    ; Producer 2: R2 = R5 + R6 (Distance 1 relative to consumer)
    mov ebx, ecx
    add ebx, edx        ; EBX (R2) = 20
    
    ; 2 NOPs stall for R2 (Distance 1) which concurrently satisfies R1
    nop                 ; Stall cycle 1
    nop                 ; Stall cycle 2
    
    ; Consumer: R7 = R1 + R2 (Reads both safely)
    mov ecx, eax        ; Load R1 (30)
    add ecx, ebx        ; ECX (R7) = 30 + 20 = 50
    
    ; Output Display
    push ecx
    push ebx
    push eax
    push msg
    call _printf
    add esp, 16
    
    xor eax, eax
    ret