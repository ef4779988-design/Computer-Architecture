global _main
extern _printf

section .data
    src_val dd 750       ; Source memory location (0(R2))
    dest_val dd 0        ; Destination memory location (0(R3))
    msg db "Task 10: Load-to-Store Forwarding (0 Stalls)", 10
        db "Source Value Loaded (EAX) = %d", 10
        db "Destination Value Stored (dest_val) = %d", 10, 0

section .text
_main:
    ; Load Instruction: LW R1, 0(R2) -> Data ready at end of MEM stage
    mov eax, [src_val]   ; Read 750 from RAM
    
    ; Store Instruction: SW R1, 0(R3) -> Data required at start of MEM stage (0 stalls via MEM-to-MEM forwarding)
    mov [dest_val], eax  ; Store 750 into destination address
    
    ; Output Display
    push dword [dest_val]
    push eax
    push msg
    call _printf
    add esp, 12
    
    xor eax, eax
    ret
