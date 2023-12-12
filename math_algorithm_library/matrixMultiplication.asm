; Kathryn James
; CSI-370: Computer Architecture
; Matrix Multiplication - MASM

; matrixMultiplication.asm
							   
_getMatrix   PROTO                                 ; C++ function prototypes
_printMatrix PROTO

.DATA
matrixA DWORD 2,7,9,4,1,6,7,5,4
matrixB DWORD 5,1,6,2,8,4,7,3,12
matrixP DWORD 0,0,0,0,0,0,0,0,0

n QWORD 3                                          ; size of nxn matrix
i QWORD ?                                          ; counters for looping through matrices
j QWORD ?
k QWORD ?

titleA BYTE "Matrix A: ",0
titleB BYTE "Matrix B: ",0
mult   BYTE "A*B Matrix: ",0                       ; title for the resulting matrix

.CODE											   ; code program segment

COMMENT @
Matrix multiplication is a binary operation that produces a matrix from two matrices. By
multplying the row of the first matrix by the column of the second matrix, the sum of the
dot products are found for the corresponding element of the product matrix. Through a 
triple-nested for loop, this function computes the product of two matrices that are loaded
in the rsi and rdi registers. @
_matrixMultiplication PROC                          ; _matrixMult function declaration
    push rbp
    push rbx
    sub rsp, 20h
    lea rbp, [rsp + 20h]
    
    ;call _getMatrix
    ;mov rsi, rax

    lea rsi, matrixA                               ; load matrix addresses into registers
    lea rdi, matrixB
    lea r8, matrixP

    mov r10, n                                     ; store size of matrix in r10

    mov i, 0
    outer:
        mov j, 0
        middle:
            mov k, 0
            inner:
                mov rax, i                         ; first index [i][k]
                mov rbx, r10                       ; size of the matrix
                mul rbx
                add rax, k                         ; second index [i][k]
    
                movsx rcx, WORD PTR[rsi][rax*4]    ; access element of matrixC
    
                mov rax, k                         ; first index [k][j]
                mov rbx, r10                       ; size of the matrix
                mul rbx
                add rax, j                         ; second index [k][j]
    
                movsx rbx, WORD PTR[rdi][rax*4]    ; access element of matrixD
    
                mov rax, rcx
                mul rbx                            ; product stored in rdx:rax
                mov rcx, rax                       ; dot product result stored in rcx
    
                mov rax, i                         ; first index [i][j]
                mov rbx, r10                       ; size of the matrix
                mul rbx
                add rax, j                         ; second index [i][j]
    
                add [r8][rax*4], rcx               ; add value to respective element of resulting matrix
    
                inc k
                cmp k, r10
                jne inner
            inc j
            cmp j, r10
            jne middle
        inc i
        cmp i, r10
        jne outer

    lea rcx, matrixA							   ; pass matrix to print to console
	lea rdx, titleA                                ; pass title of matrix
    call _printMatrix

    lea rcx, matrixB							   ; pass matrix to print to console
	lea rdx, titleB                                ; pass title of matrix
    call _printMatrix
    
    lea rcx, matrixP							   ; pass matrix to print to console
	lea rdx, mult                                  ; pass title of resulting matrix
    call _printMatrix
    
    lea rsp, [rbp]
    pop rbx
    pop rbp
    ret
_matrixMultiplication ENDP

END