global _main
extern _printf

section .data
    msg db "Task 11: Arithmetic Expression Scheduling (A+B)+(C+D)", 10
        db "Temp1 (A + B) = %d", 10
        db "Temp2 (C + D) = %d", 10
        db "Final Result = %d (Zero Stalls)", 10, 0

section .text
_main:
    ; Values setup (A=10, B=20, C=30, D=40)
    mov eax, 10         ; R1 = A (10)
    mov ebx, 20         ; R2 = B (20)
    mov ecx, 30         ; R3 = C (30)
    mov edx, 40         ; R4 = D (40)
    
    ; Operation 1: Temp1 = A + B
    add eax, ebx        ; EAX (R5) = 10 + 20 = 30
    
    ; Operation 2: Temp2 = C + D (Independent; decouples R5 from final addition)
    add ecx, edx        ; ECX (R6) = 30 + 40 = 70
    
    ; Operation 3: Result = Temp1 + Temp2
    mov edx, eax
    add edx, ecx        ; EDX (R7) = 30 + 70 = 100
    
    ; Output Display
    push edx
    push ecx
    push eax
    push msg
    call _printf
    add esp, 16
    
    xor eax, eax
    ret