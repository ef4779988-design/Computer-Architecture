global _main
extern _printf

section .data
    msg db "Task 5: Chain of Cumulative Additions", 10
        db "Final Cumulative Sum (EAX) = %d", 10, 0

section .text
_main:
    ; Register setup (R1 = EAX, R2 = EBX, R3 = ECX, R4 = EDX)
    mov eax, 10         ; Initial R1 = 10
    mov ebx, 5          ; R2 = 5
    mov ecx, 15         ; R3 = 15
    mov edx, 20         ; R4 = 20
    
    ; Step 1: R1 = R1 + R2
    add eax, ebx        ; EAX = 10 + 5 = 15
    nop                 ; Stall cycle 1
    nop                 ; Stall cycle 2
    
    ; Step 2: R1 = R1 + R3 (Dependent on previous R1)
    add eax, ecx        ; EAX = 15 + 15 = 30
    nop                 ; Stall cycle 1
    nop                 ; Stall cycle 2
    
    ; Step 3: R1 = R1 + R4 (Dependent on previous R1)
    add eax, edx        ; EAX = 30 + 20 = 50
    
    ; Output Display
    push eax
    push msg
    call _printf
    add esp, 8
    
    xor eax, eax
    ret
