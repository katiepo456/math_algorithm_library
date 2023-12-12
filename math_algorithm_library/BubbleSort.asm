;Bubble Sort code.asm
;Jaden Cypes

.data
_printNum PROTO			;prototype for C function
						;declare the array and length
arry  DWORD 3,7,9,1,8,2,4,5,3,6,10 
len EQU 10

.code
asmBubbleSort PROC
	push rbp			;pushing the stack down to create shadow space	
	sub rsp, 20h		;extend it 20h
	lea rbp, [rsp + 20h];add the space

	mov rcx, len		;put length in rcx
		
	outerLoop:
		push rcx		;save what is in rcx
		lea rsi, arry	;load the first elememt of the array

		innerLoop:
			movsx rax, BYTE PTR [rsi]	  ;pass the first element
			movsx rbx, BYTE PTR [rsi + 4] ;pass the next element
			cmp rax, rbx ;compare the values
			jg skip		 ;if rbx is greater, skip this pair
			xchg rax, [rsi + 4] ;exchange the values
			;mov [rsi], rax
	
	skip:
		movsx rdx, BYTE PTR [rsi + 4] ;move to the next element
		add rsi, rdx	
		loop innerLoop	;go back to inner loop
		pop rcx			;start the rcx counter over 
		loop outerloop	;loop the outer loop
	
	lea rcx, arry		;pass the array address to rcx
	call _printNum		;call the function to print the array
	
	lea rsp, [rbp]		;dereferencing the shadowspace
	pop rbp				;cleaning out the stack
	ret
asmBubbleSort ENDP
END                        ;end of process