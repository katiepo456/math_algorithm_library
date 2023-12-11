; Kathryn James
; CSI-370: Computer Architecture
; Matrix Addition - MASM

; matrixAddition.asm
							   
_getMatrix   PROTO                                 ; C++ function prototypes
_printMatrix PROTO

.DATA
matrixA DWORD 5,1,6,2,8,4,7,3,12
matrixB DWORD 5,1,6,2,8,4,7,3,12
matrixS DWORD 0,0,0,0,0,0,0,0,0

n QWORD 3                                          ; size of nxn matrix
i QWORD ?                                          ; counters for looping through matrices
j QWORD ?

titleA BYTE "Matrix A: ",0
titleB BYTE "Matrix B: ",0
sum    BYTE "A+B Matrix: ",0                       ; title for the resulting matrix

.CODE											   ; code program segment

COMMENT @
Matrix addition is the operation of adding two matrices by adding the corresponding entries 
together. This operation only works on square matrices. This function loads two matrices
into the rsi and rdi registers and performs matrix addition by looping through all of the
elements and storing the sum in its respective entry in the resulting matrix. @
_matrixAdd PROC                                    ; _matrixAdd function declaration
    push rbp
    push rbx
    sub rsp, 20h
    lea rbp, [rsp + 20h]

    lea rsi, matrixA                               ; load matrix addresses into registers
    lea rdi, matrixB
    lea r8, matrixS

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

    lea rcx, matrixA							   ; pass matrix to print to console
	lea rdx, titleA                                ; pass title of matrix
    call _printMatrix

    lea rcx, matrixB							   ; pass matrix to print to console
	lea rdx, titleB                                ; pass title of matrix
    call _printMatrix
    
    lea rcx, matrixS							   ; pass matrix to print to console
	lea rdx, sum                                   ; pass title of resulting matrix
    call _printMatrix
    
    lea rsp, [rbp]
    pop rbx
    pop rbp
    ret
_matrixAdd ENDP

END