global _main
extern _printf

section .data
    msg db "Task 17: Branch Scheduling (Useful Delay Slot)", 10
        db "Independent Calculation Result (EBX) = %d", 10
        db "Branch Target Result (EAX) = %d (Zero Branch Penalty)", 10, 0

section .text
_main:
    mov eax, 10         ; Loop counter / Condition variable
    mov ebx, 20         ; Value for independent work
    mov ecx, 30
    
    cmp eax, 10         ; Compare condition
    je .target          ; Conditional Branch
    
    ; Useful instruction scheduled inside Branch Delay Slot:
    add ebx, ecx        ; EBX = 20 + 30 = 50 (Fills delay slot instead of NOP)

.target:
    add eax, 100        ; EAX = 10 + 100 = 110

.end:
    ; Output Display
    push eax
    push ebx
    push msg
    call _printf
    add esp, 12
    
    xor eax, eax
    ret