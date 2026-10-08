global _main
extern _printf

section .data
    msg db "Task 15: Structural Hazard Simulation", 10
        db "Write Port 1 Output (EAX) = %d", 10
        db "Write Port 2 Output (EBX) = %d (Resolved via 1 Stall)", 10, 0

section .text
_main:
    ; Values setup
    mov eax, 100        ; Initial value 1
    mov ebx, 200        ; Initial value 2
    
    ; Operation 1: Writing to EAX (WB Stage Slot 1)
    add eax, 50         ; EAX = 150
    
    ; 1-cycle delay to avoid structural conflict on write port
    nop                 ; Structural hazard stall bubble
    
    ; Operation 2: Writing to EBX (WB Stage Slot 2)
    add ebx, 50         ; EBX = 250
    
    ; Output Display
    push ebx
    push eax
    push msg
    call _printf
    add esp, 12
    
    xor eax, eax
    ret