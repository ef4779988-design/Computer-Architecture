global _main
extern _printf

section .data
    msg db "Task 19: Combined RAW and Control Hazard", 10
        db "Computed Reg (EAX) = %d", 10
        db "Branch Status = Equal (Branch Taken Safely)", 10, 0

section .text
_main:
    mov ebx, 10
    mov ecx, 10
    
    ; ALU Producer for Branch Condition
    mov eax, ebx
    add eax, ecx        ; EAX = 10 + 10 = 20 (RAW producer)
    
    ; Pipeline stall to allow ALU result to be evaluated for branch comparison
    nop                 ; Stall cycle for RAW hazard resolution before branch
    
    ; Branch Consumer dependent on EAX
    cmp eax, 20         ; Evaluates branch condition
    je .taken           ; Control Hazard
    nop                 ; Branch Delay Slot

.taken:
    ; Output Display
    push eax
    push msg
    call _printf
    add esp, 8
    
    xor eax, eax
    ret
