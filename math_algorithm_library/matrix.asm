; Kathryn James
; CSI-370: Computer Architecture
; Matrix Multiplication & Addition - MASM

; matrix.asm
							   
_getMatrix   PROTO                                 ; C++ function prototypes
_printMatrix PROTO

.DATA
matrixA DWORD 5,1,6,2,8,4,7,3,12
matrixB DWORD 5,1,6,2,8,4,7,3,12
matrixM DWORD 0,0,0,0,0,0,0,0,0

n QWORD 3                                          ; size of nxn matrix

i QWORD ?                                          ; counters for looping through matrices
j QWORD ?
k QWORD ?

mult BYTE "Product Matrix: ",0                     ; titles for the resulting matrix
sum  BYTE "Sum Matrix: ",0

.CODE											   ; code program segment

COMMENT @

@
_matrixAdd PROC                                    ; _matrixMult function declaration
    push rbp
    push rbx
    sub rsp, 20h
    lea rbp, [rsp + 20h]

    lea rsi, matrixA                               ; load matrix addresses into registers
    lea rdi, matrixB
    lea r8, matrixM

    mov r10, n                                     ; store size of matrix in r10

    mov i, 0                                       ; column counter
    outer:
        mov j, 0                                   ; row counter
        inner:
            mov rax, i                             ; first index [i][j]
            mov rbx, n                             ; size of the matrix
            mul rbx
            add rax, j                             ; second index [i][j]
    
            movsx rcx, WORD PTR[rsi][rax*4]        ; access element of matrixA
            movsx rbx, WORD PTR[rdi][rax*4]        ; access element of matrixB
    
            add rcx, rbx                           ; add elements together
    
            mov [r8][rax*4], rcx                   ; move value to respective element of result array
            
            inc j
            cmp j, r10                             ; check for end of row
            jne inner
        inc i
        cmp i, r10                                 ; check for end of columns
        jne outer

    lea rcx, matrixM							   ; pass matrix to print to console
	lea rdx, sum                                   ; pass title of resulting matrix
    call _printMatrix
    
    lea rsp, [rbp]
    pop rbx
    pop rbp
    ret
_matrixAdd ENDP


COMMENT @

@
_matrixMult PROC                                   ; _matrixMult function declaration
    push rbp
    push rbx
    sub rsp, 20h
    lea rbp, [rsp + 20h]
    
    ;call _getMatrix
    ;mov rsi, rax

    lea rsi, matrixA                               ; load matrix addresses into registers
    lea rdi, matrixB
    lea r8, matrixM

    mov i, 0
    outer:
        mov j, 0
        middle:
            mov k, 0
            inner:
                mov rax, i                         ; first index [i][k]
                mov rbx, n                         ; size of the matrix
                mul rbx
                add rax, k                         ; second index [i][k]
    
                movsx rcx, WORD PTR[rsi][rax*4]    ; access element of matrixA
    
                mov rax, k                         ; first index [k][j]
                mov rbx, n                         ; size of the matrix
                mul rbx
                add rax, j                         ; second index [k][j]
    
                movsx rbx, WORD PTR[rdi][rax*4]    ; access element of matrixB
    
                mov rax, rcx
                mul rbx                            ; product stored in rdx:rax
                mov rcx, rax                       ; dot product result stored in rcx
    
                mov rax, i                         ; first index [i][j]
                mov rbx, n                         ; size of the matrix
                mul rbx
                add rax, j                         ; second index [i][j]
    
                add [r8][rax*4], rcx               ; add value to respective element of resulting matrix
    
                inc k
                mov rax, n
                cmp k, rax
                jne inner
            inc j
            mov rax, n
            cmp j, rax
            jne middle
        inc i
        mov rax, n
        cmp i, rax
        jne outer

    lea rcx, matrixM							   ; pass matrix to print to console
	lea rdx, mult                                  ; pass title of resulting matrix
    call _printMatrix
    
    lea rsp, [rbp]
    pop rbx
    pop rbp
    ret
_matrixMult ENDP

END