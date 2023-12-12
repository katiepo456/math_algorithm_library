;Insertion Sort code.asm
;Jaden Cypes

.data
_printNum PROTO             ;prototype for C function
                            ;declare the array
arry DWORD 10,9,8,7,6,5,4,3,2,1

.code
asmInsertionSort PROC
	push rbp			;pushing the stack down to create shadow space	
	sub rsp, 20h		;extend it 20h
	lea rbp, [rsp + 20h];add the space

	mov rcx, LENGTHOF arry	;add the numbers of items in the array
	lea rsi, arry		;load the address of the array

	mov rax, 4			;rax will be 'i'
	xor rbx, rbx		;rbx will be 'j'

	outerLoop:
		cmp rax, rcx	;if i >= the number of items in the array, exit
		jge endLoop
		push rcx		;save the number of items
		mov rcx, [rsi+rax] ;rcx is now array[i], the current
		mov rbx, rax	;make rbx one less than rax, j = i-1
		sub rbx, 4		
		
		whileLoop:
			cmp ebx, 0	;if j < 0, exit the loop
			jl endWhile

			cmp [rsi+rax], rcx ;if array[j] <= rcx, exit the loop
			jle endWhile

			push [rsi+rbx] ;array[j+1] = array[j]
			pop[rsi+rbx+4] 

			sub rbx, 4	;j--
			jmp whileLoop ;go back to the top of the while loop


		endWhile:
		mov [rsi+rbx+4], rcx ;array[j+1] = current
		add rax, 4		;i++
		pop rcx			;return back to the orginal number of items 
		jmp outerLoop;go ;back to the outer loop

	endLoop:
	lea rcx, arry
	call _printNum
	
	lea rsp, [rbp]		;dereferencing the shadowspace
	pop rbp				;cleaning out the stack
	ret
asmInsertionSort ENDP
END