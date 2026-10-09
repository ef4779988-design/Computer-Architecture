global _main
extern _printf

section .data
    msg db "Task 18: Unconditional Jump Delay Slot", 10
        db "Delay Slot Value (EBX) = %d", 10
        db "Jump Target Output (EAX) = %d", 10, 0

section .text
_main:
    mov eax, 5
    mov ebx, 10
    
    jmp .jump_target     ; Unconditional Jump
    add ebx, 15          ; Jump Delay Slot (Executes in pipeline before target jump)

.jump_target:
    add eax, 50          ; Target execution: EAX = 5 + 50 = 55

    ; Output Display
    push eax
    push ebx
    push msg
    call _printf
    add esp, 12
    
    xor eax, eax
    ret
