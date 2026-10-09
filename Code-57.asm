global _main
extern _printf

section .data
    array dd 5, 10, 15, 20    ; Array elements
    msg db "Task 20: Comprehensive Multi-Hazard Sequence", 10
        db "Final Loop Accumulation (EAX) = %d", 10
        db "All RAW, Load-Use, and Control hazards resolved!", 10, 0

section .text
_main:
    ; Register Setup
    mov eax, 0          ; Accumulator (Sum = 0)
    mov ebx, 0          ; Index offset
    mov ecx, 4          ; Loop counter (4 iterations)

.loop_start:
    ; Load-Use Handling
    mov edx, [array + ebx]  ; Load current array element
    
    ; Useful instruction in latency slot (RAW avoidance)
    add ebx, 4              ; Advance array index offset (Independent work)
    
    ; Dependent Arithmetic
    add eax, edx            ; Accumulate loaded value into EAX
    
    ; Branch / Control Hazard Handling
    sub ecx, 1              ; Decrement loop counter
    cmp ecx, 0              ; Check condition
    jg .loop_start          ; Loop back if counter > 0
    nop                     ; Branch delay slot

.end:
    ; Output Display (Sum = 5 + 10 + 15 + 20 = 50)
    push eax
    push msg
    call _printf
    add esp, 8
    
    xor eax, eax
    ret
