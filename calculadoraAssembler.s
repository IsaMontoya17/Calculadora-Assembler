		.data
numero1:	.word 0
numero2:	.word 0
operador:	.word 0
resultado:	.word 0
cadenaSuma:	.asciz "%d sumado con %d es igual a: %d"
cadenaResta:	.asciz "%d restado con %d es igual a: %d"
cadenaMul:	.asciz "%d multiplicado con %d es igual a: %d"
cadenaDiv:	.asciz "%d dividido entre %d es igual a: %d y tiene residuo %d"
mensajeDiv:	.asciz "No se puede dividir entre 0"

		.text
main:		bl modificar
		cmp r2, #1
		beq suma
		cmp r2, #2
		beq resta
		cmp r2, #3
		beq multiplicacion
		cmp r2, #4
		beq division       
		b stop
		
suma:		
		add r2, r0, r1
		ldr r4, =resultado
		str r2, [r4]
		mov r4, r2
		sub sp, sp, #8
		str r2, [sp, #4]
		str r1, [sp]
		mov r3, r0
		mov r0, #0
		mov r1, #0
		ldr r2, =cadenaSuma
		bl printf 
		add sp, sp, #8
		bl cargar
		b stop

resta:		sub r2, r0, r1
		ldr r4, =resultado
		str r2, [r4]
		mov r4, r2
		sub sp, sp, #8
		str r2, [sp, #4]
		str r1, [sp]
		mov r3, r0
		mov r0, #0
		mov r1, #0
		ldr r2, =cadenaResta
		bl printf 
		add sp, sp, #8
		bl cargar
		b stop

multiplicacion: mov r3, r1
		mul r1, r0, r1
		ldr r4, =resultado
		str r1, [r4]
		mov r4, r1
		sub sp, sp, #8
		str r1, [sp, #4]
		str r3, [sp]
		mov r3, r0
		mov r0, #0
		mov r1, #0
		ldr r2, =cadenaMul
		bl printf 
		add sp, sp, #8
		bl cargar
		b stop

division:
		mov r4, r0
		mov r5, r1
		cmp r5, #0
		beq stopDiv
		bl sdivide
		ldr r7, =resultado
		str r0, [r7]
		mov r7, r0
		sub sp, sp, #12
		str r1, [sp, #8]
		str r0, [sp, #4]
		str r5, [sp]
		mov r3, r4
		mov r0, #0
		mov r1, #0
		ldr r2, =cadenaDiv
		bl printf 
		add sp, sp, #12
		bl cargar
		b stop

stopDiv:	mov r0, #0
		mov r1, #0
		ldr r2, =mensajeDiv
		bl printf 
		wfi

cargar:		ldr r0, =numero1
		ldr r0, [r0]
		ldr r1, =numero2
		ldr r1, [r1]
		ldr r2, =operador
		ldr r2, [r2]
		bx lr

modificar:	ldr r4, =numero1
		ldr r5, =numero2
		ldr r6, =operador
		str r0, [r4]
		str r1, [r5]
		str r2, [r6]
		bx lr

stop: 		wfi
