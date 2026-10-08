global _main
extern _printf

section .data
    msg db "Task 2: Manual NOP Insertion (Distance 1)", 10
        db "Producer Output (EAX) = %d", 10
        db "Consumer Output (ECX) = %d (After NOP Delay Stalls)", 10, 0

section .text
_main:
    ; Values setup
    mov eax, 10         ; R2 = 10
    mov ebx, 20         ; R3 = 20
    mov edx, 5          ; R5 = 5
    
    ; Producer Instruction: R1 = R2 + R3
    add eax, ebx        ; EAX (R1) = 30
    
    ; Manual NOP Insertion to delay execution for pipeline alignment
    nop                 ; Stall Cycle 1
    nop                 ; Stall Cycle 2
    
    ; Consumer Instruction: R4 = R1 - R5
    mov ecx, eax        ; Reads EAX safely after NOP delay
    sub ecx, edx        ; ECX (R4) = 30 - 5 = 25
    
    ; Output Display
    push ecx
    push eax
    push msg
    call _printf
    add esp, 12
    
    xor eax, eax
    ret