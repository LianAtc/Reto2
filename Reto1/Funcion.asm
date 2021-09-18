section .data
;a y N se encuentran en memoria
	a dq 5
	N dq 2
; a=5 n=2
;section .bss


section .text
	global _start

_start:

	mov rbx, qword[a]	  ; rbx = 5
	mov rcx, qword[N]   ; rcx = 2
	cmp rbx, 0
	jl no_cumple
	cmp rcx, 0
	jl no_cumple
	cmp rbx, 255
	jg no_cumple
	cmp rcx, 255
	jg no_cumple

;----------------------------------------------------------------
;OPERACION TERMINO DERECHO

mov rax, 1
mov r10, rbx ;Copia de a
mov r11, rcx ;Copia de N
mov r12, rbx
mov r13, rcx
mov r15, 0

inc rcx

vuelta:
	mov r9, rcx  ; r9 = N + 1
	mul rbx      ; rax = a * rax
	loop vuelta  ; mientras rcx != 0

	sub rax, r10     ; rax = a'(N+1) - a
	mov r11, rax     ; r11 = a´(N+1) -a 
	dec r10		     ; r10 = a-1

	cdq
	div r10          ;rax = a'(N+1) - a / (a*1)
	mov r10, rax     ;EN R10 ESTA EL PRIMER RESULTADO

;r12 copia de a
;r13 copia de N
	mov rcx, r13
	mov r14, 0

;----------------------------------------------------------------
;OPERACION TERMINO IZQUIERDO

suma:
	inc r14				; i=1
	jmp a_pot
    continuo_suma:
	cmp r14, r13        ; i!=N
	jne suma    
	jmp exit         

a_pot:
	mov rcx, r14
	mov rax, 1
	potencia:
		mul r12       ;r12 = a
	loop potencia
	add r15, rax      ; En r15 se encuentra el otro RESULTADO
	jmp continuo_suma

	

no_cumple:
	mov rax, 0

exit:
    ; ---- return 0 ---- ;
	mov rax, 60		
	mov rdi, 0
	syscall
    ; ------------------ ;