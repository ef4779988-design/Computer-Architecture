global _main
extern _printf

section .data
    mem_dest dd 0        ; Memory destination initialized to 0
    msg db "Task 9: Store After Arithmetic (0 Stalls)", 10
        db "Computed Sum (EAX) = %d", 10
        db "Memory Value after Store (mem_dest) = %d", 10, 0

section .text
_main:
    ; Values setup
    mov ebx, 15          ; R2 = 15
    mov ecx, 25          ; R3 = 25
    
    ; Arithmetic Operation: ADD R4, R2, R3 (EX stage produces result)
    mov eax, ebx
    add eax, ecx         ; EAX (R4) = 15 + 25 = 40
    
    ; Store Instruction: SW R4, 0(R5) (MEM stage consumes result via EX-to-MEM forwarding)
    mov [mem_dest], eax  ; Store 40 into RAM (0 stalls)
    
    ; Output Display
    push dword [mem_dest]
    push eax
    push msg
    call _printf
    add esp, 12
    
    xor eax, eax
    ret