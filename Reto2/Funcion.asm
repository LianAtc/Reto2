section .data
	mensaje db "Es un numero fuerte",10
	len1 equ $-mensaje     ; calculamos la longitud del mensaje anterior
	mensaje2 db "No es un numero fuerte",10
	len2 equ $-mensaje2 
	;Numero guardado en memoria
	numero dq 40585

section .bss
	;Se guarda en memoria la letra
	fuerte resb 1  ;1 byte para 1 caracter

section .text
	global _start

_start:

	mov r9, 0  ;Sumador de cada factorial de digito
	mov r13, 10
	mov r12, 1 ;Para el factorial de 0
	mov rax, qword[numero]  ;Aqui coloco el numero a probar
	mov r10, rax

resto: 

	cmp rax,0
	je fin
	mov r14, rax     ; rax = 145
	cdq
	div r13			 ;rax = 145/10 = 14   rdx = 5	
	mov r15, rdx	
	;cmp r15,0		 ; rdx == 0  ->  5!=0
	jmp g_factorial

g_factorial:
	mov r11, rax     ;copia de 14
	mov rax, 1	     ;mult utiliza a rax multiplixar
	cmp rdx, 0
	je facto_cero

factorial:
	mul r15         ; rax = rax * rdx = 5*1
	dec r15			 ; rdx = 4
	cmp r15, 0       ; 4 != 0
	jne factorial
	jmp anadir_suma       ; rdx==0

facto_cero:
	mov rax, 1
	jmp anadir_suma

anadir_suma:
	add r9, rax			  ; r9 = 5!  	
	mov rax, r11          ; rax = 14   
	jmp resto

fin: 
	cmp r9, r10
	je es_fuerte
	jmp no_fuerte

es_fuerte:
	mov rbx, 84 
	mov qword[fuerte], rbx 
	mov rax, 1		    ; función a utilizar (printf)
	mov rdi, 1		    ; imprimir en pantalla: 1
	mov rsi, mensaje	
	mov rdx, len1	    ; numero de elementos a imprimir
	syscall
	jmp exit

no_fuerte:
	mov rbx, 70 
	mov qword[fuerte], rbx 
	mov rax, 1		    
	mov rdi, 1		    
	mov rsi, mensaje2	
	mov rdx, len2	    
	syscall

exit:
    ; ---- return 0 ---- ;
	mov rax, 60		; función para terminar la ejecución del programa. Similar a int 21h
	mov rdi, 0
	syscall
    ; ------------------ ;