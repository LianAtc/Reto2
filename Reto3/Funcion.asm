section .data
	mensaje1 db "Es palindromo"
	len1 equ $-mensaje1 
	mensaje2 db "No es palindromo"
	len2 equ $-mensaje2 
    palabra db "reconocer"
	lenp  equ $-palabra 
	salto db 10

section .bss
    palindromo resb 1

section .text
	global _start

_start:

	mov r11, 0 ;Contador de coincidencias
	mov r12, 0 ;Contador del programa
    
	mov r15, lenp

    mov rax, qword[palabra]

	mov rax, palabra
	mov rbx, palabra
	mov rcx, lenp

	add rbx, lenp
	dec rbx

	vuelta:
		mov r9b, byte[rax]
		mov r10b, byte[rbx]
		cmp r9, r10
		je coincidencia
		continuo:
		inc rax
		dec rbx
		inc r12
		cmp r12, lenp
		jne vuelta
		jmp verificar
		

coincidencia:
	add r11, 1
	jmp continuo

verificar:
	mov r15, lenp
	cmp r15, r11
	je es_palindromo
	jmp no_palindromo

es_palindromo:
	mov rbx, 84 
	mov qword[palindromo], rbx 
	mov rax, 1		    
	mov rdi, 1		    
	mov rsi, mensaje1	
	mov rdx, len1	    
	syscall
	jmp exit

no_palindromo:
	mov rbx, 70 
	mov qword[palindromo], rbx 
	mov rax, 1		    
	mov rdi, 1		    
	mov rsi, mensaje2	
	mov rdx, len2	    
	syscall

exit:
	mov rax, 1		    
	mov rdi, 1		    
	mov rsi, salto	
	mov rdx, 1	    
	syscall

    ; ---- return 0 ---- ;
	mov rax, 60		; función para terminar la ejecución del programa. Similar a int 21h
	mov rdi, 0
	syscall
    ; ------------------ ;