;Selection Sort code.asm
;Jaden Cypes

.data
_printNum PROTO             ;prototype for C function
                            ;declare the array
arry DWORD 12,19,18,17,16,15,14,13,10,11

.code
asmSelectionSort PROC
    push rbp                ;reserving the shadowspace
    push rbx
    sub rsp, 20h
    lea rbp, [rsp + 20h]

    mov rcx, LENGTHOF arry ;pass number of integers
    lea rsi, arry          ;pass address of sArray

outerLoop:
    mov rdx, rcx           ;number of comparisons to make
    movsx rax, BYTE PTR[rsi] ;value of current min
    mov rdi, rsi           ;position of current min
    innerLoop:
        add    rsi, 4       ;move to the next element
        cmp    [rsi], rax   ;compare the values
        jnb    notSmaller   ;jump if not below
        movsx  rax, BYTE PTR[rsi] ;value of new min
        mov    rdi, rsi    ;position of new min
    notSmaller:
        dec    rdx         ;decrease the number of comparisons
        jnz    innerLoop   ;loop back to the innerLoop

        movsx    rdx, BYTE PTR[rsi] ;swap elements
        mov    [rsi], rax   
        mov    [rdi], rdx
        add    rsi, 4      ;move to next element
        dec    rcx         ;decrease number of elements to sort
        jnz    outerLoop   ;loop the outerLoop

Done:
	lea rcx, arry        ;pass the array address to rcx
	call _printNum		   ;call the function to print the array
    
    lea rsp, [rbp]         ;dereferencing the shadowspace
    pop rbx
    pop rbp
    ret
asmSelectionSort ENDP
END                        ;end of process