global _main
extern _printf

section .data
    msg_taken db "Task 16: Branch Delay Slot", 10
              db "Branch Taken! Counter (EAX) = %d (Delayed slot executed safely)", 10, 0

section .text
_main:
    mov eax, 5          ; Counter = 5
    cmp eax, 5          ; Check condition (eax == 5)
    
    je .branch_target   ; Branch instruction
    nop                 ; Branch Delay Slot (executes regardless of jump in MIPS pipeline)

    ; Fallthrough (if not taken)
    mov eax, 0
    jmp .end

.branch_target:
    add eax, 10         ; EAX = 5 + 10 = 15

.end:
    ; Output Display
    push eax
    push msg_taken
    call _printf
    add esp, 8
    
    xor eax, eax
    ret
