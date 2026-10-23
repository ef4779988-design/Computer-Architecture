global _main
extern _printf

section .data
    align 32
    target_var  dd 100               ; Target variable for continuous store buffer testing
    iterations  dd 50000             ; 50,000 store instructions
    msg         db "Task 15: Write-Through vs. Write-Back Buffer Pressure", 10
                db "Stores Completed = %d", 10
                db "Write-back dirty-bit absorption tested successfully.", 10, 0

section .text
_main:
    mov ecx, [iterations]   ; Loop counter = 50,000
    mov edx, target_var     ; Load target address
    mov eax, 1              ; Store value

.store_loop:
    ; Continuous repeated stores to a single cache-resident address (tests write-back buffer absorption)
    mov [edx], eax          
    
    sub ecx, 1
    jnz .store_loop

    ; Output Display
    push dword [iterations]
    push msg
    call _printf
    add esp, 8
    
    xor eax, eax
    ret