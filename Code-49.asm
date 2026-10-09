global _main
extern _printf

section .data
    array dd 15, 25      ; Array: A = 15, B = 25
    msg db "Task 12: Double Load Scheduling", 10
        db "Loaded A (EAX) = %d, Loaded B (EBX) = %d", 10
        db "Result 1 (ECX) = %d, Result 2 (EDX) = %d (Zero Stalls)", 10, 0

section .text
_main:
    ; Values setup
    mov edx, 50          ; R5 = 50
    mov ecx, 100         ; R8 = 100
    
    ; Load A: LW R1, 0(R4)
    mov eax, [array]     ; EAX (R1) = 15
    
    ; Load B: LW R6, 4(R4) -> Fills load-use latency of Load A
    mov ebx, [array + 4] ; EBX (R6) = 25
    
    ; Compute with A: ADD R2, R1, R5 -> Fills load-use latency of Load B
    push ecx             ; Save R8 for second calculation
    mov ecx, eax
    add ecx, edx         ; ECX (R2) = 15 + 50 = 65
    
    ; Compute with B: ADD R7, R6, R8
    pop edx              ; Restore R8 into EDX
    add edx, ebx         ; EDX (R7) = 25 + 100 = 125
    
    ; Output Display
    push edx
    push ecx
    push ebx
    push eax
    push msg
    call _printf
    add esp, 20
    
    xor eax, eax
    ret
