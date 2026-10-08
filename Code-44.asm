global _main
extern _printf

section .data
    mem_val dd 200       ; Memory location (0(R2))
    msg db "Task 7: Load-Use with Independent Work", 10
        db "Loaded Value (EAX) = %d", 10
        db "Independent SUB Result (EBX) = %d", 10
        db "Dependent ADD Result (ECX) = %d (Zero Stalls)", 10, 0

section .text
_main:
    ; Values setup
    mov edx, 50          ; R4 = 50
    mov ecx, 80          ; R6 = 80
    mov ebx, 30          ; R7 = 30
    
    ; Memory Load: LW R1, 0(R2)
    mov eax, [mem_val]   ; Initiate memory load
    
    ; Independent Instruction: SUB R5, R6, R7 (Fills load-use latency)
    sub ecx, ebx         ; ECX (R5) = 80 - 30 = 50
    mov ebx, ecx         ; Store R5 in EBX for display
    
    ; Dependent Instruction: ADD R3, R1, R4 (Uses forwarded R1)
    mov ecx, eax         ; Load forwarded R1
    add ecx, edx         ; ECX (R3) = 200 + 50 = 250
    
    ; Output Display
    push ecx
    push ebx
    push eax
    push msg
    call _printf
    add esp, 16
    
    xor eax, eax
    ret