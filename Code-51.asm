global _main
extern _printf

section .data
    array dd 10, 20      ; Array elements
    msg db "Task 14: Loop Unrolling (Zero Stalls)", 10
        db "Processed Iteration 1 (EAX) = %d", 10
        db "Processed Iteration 2 (EBX) = %d", 10, 0

section .text
_main:
    ; Values setup
    mov ecx, 5           ; Scalar addition value
    
    ; Unrolled Loads
    mov eax, [array]     ; Load Iteration 1 element
    mov ebx, [array + 4] ; Load Iteration 2 element (fills latency for EAX)
    
    ; Unrolled Computations
    add eax, ecx         ; Process Iteration 1 (EAX = 10 + 5 = 15)
    add ebx, ecx         ; Process Iteration 2 (EBX = 20 + 5 = 25)
    
    ; Unrolled Stores
    mov [array], eax
    mov [array + 4], ebx
    
    ; Output Display
    push ebx
    push eax
    push msg
    call _printf
    add esp, 12
    
    xor eax, eax
    ret
