global _main
extern _printf

section .data
    array dd 42, 99      ; Initial Array: [0] = 42, [1] = 99
    msg db "Task 13: Array Element Swap", 10
        db "After Swap -> Array[0] = %d, Array[1] = %d (Zero Stalls)", 10, 0

section .text
_main:
    ; Load first element: LW R1, 0(R3)
    mov eax, [array]     ; EAX (R1) = 42
    
    ; Load second element: LW R2, 4(R3) -> Fills load-use latency of R1
    mov ebx, [array + 4] ; EBX (R2) = 99
    
    ; Cross-store to perform swap
    mov [array], ebx     ; Store R2 (99) into Array[0]
    mov [array + 4], eax ; Store R1 (42) into Array[1]
    
    ; Output Display
    push dword [array + 4]
    push dword [array]
    push msg
    call _printf
    add esp, 12
    
    xor eax, eax
    ret
