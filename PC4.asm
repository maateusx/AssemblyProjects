# Para Casa 4
# Nome: Mateus

.data 					   #dados e variáveis do nosso programa
	inicio_string: .asciiz "\nEntre bit por bit:\n"
	fim_string: .asciiz "\nO encode gerou = "
	r: .word 0

.text 					   #instruções e códigos do nosso programa
	.globl inicio
	
	inicio:
		li $v0, 4 		   # system call para imprimir uma string
		la $a0, inicio_string 	   # carrega o endereço da string em $a0
		syscall
		
		jal le_inteiro_do_teclado  # chama função para ler
		la  $t0, 0($v0)		   # carrega o inteiro lido em $t0
		jal le_inteiro_do_teclado  # chama função para ler
		la  $t1, 0($v0)		   # carrega o inteiro lido em $t1
		jal le_inteiro_do_teclado  # chama função para ler
		la  $t2, 0($v0)		   # carrega o inteiro lido em $t2
		jal le_inteiro_do_teclado  # chama função para ler
		la  $t4, 0($v0)		   # carrega o inteiro lido em $t4
		
		# inicio operacoes
		
		# inicio c6 = 0^2^4
		add $s1,$t4,0 		#$s1 = $t4
		add $s2,$t2,0		#$s2 = $t2
		add $s0,$t2,0		#$s0 = $t2
		while1:  # calcula $t2^$t4
			beq $t9,$s1, fim1
			mul $s2,$s2,$s0 #$s2*$s0
			add $t9,$t9,1
			j fim1
		fim1:
		add $s3,$s2,0 		#$s3 = $s2
		add $s4,$t0,0		#$s4 = $t0
		add $s0,$t0,0		#$s0 = $t0
		while2: #calcula $t0^($t2^$t4)  
			beq $t9,$s3, fim2
			mul $s4,$s4,$s0 #$s4*$s0
			add $t9,$t9,1
			j fim2
		fim2:
		add $t6,$s4,0 		#$t6 = $s4
		# fim c6
		
		# inicio c5 = $t0^$t1^$t4
		add $s1,$t4,0 		#$s1 = $t4
		add $s2,$t1,0		#$s2 = $t1
		add $s0,$t1,0		#$s0 = $t1
		while3:  #$t1^$t4
			beq $t9,$s1, fim3
			mul $s2,$s2,$s0 # $s2 * $s0
			add $t9,$t9,1
			j fim3
		fim3:
		add $s3,$s2,0		#$s3 = $s2
		add $s4,$t0,0		#$s4 = $t0
		add $s0,$t0,0		#$s0 = $t0
		while4: #$t0^($t1^$t4)  
			beq $t9,$s3, fim4
			mul $s4,$s4,$s0 #$s4 * $s0
			add $t9,$t9,1
			j fim4
		fim4:
		add $t5,$s4,0 		#$t5 = $s4
		# fim c5
		
		# inicio c3 = $t0^$t1^$t2
		add $s1,$t2,0 		#$s1 = $t2
		add $s2,$t1,0		#$s2 = $t1
		add $s0,$t1,0		#$s0 = $t1
		while5:  #$t2^$t4
			beq $t9,$s1, fim5
			mul $s2,$s2,$s0 # s2 * s0
			add $t9,$t9,1
			j fim5
		fim5:
		add $s3,$s2,0 		#$s3 = $s2
		add $s4,$t0,0 		#$s4 = $t0
		add $s0,$t0,0 		#$s0 = $t0
		while6: #$t0^($t2^$t4)  
			beq $t9,$s3, fim6
			mul $s4,$s4,$s0 #$s4 * $s0
			add $t9,$t9,1
			j fim6
		fim6:
		add $t3,$s4,0 		#$t3 = $s4
		# fim c3
		#fim operacoes
		
		li $v0, 4 		   # system call para imprimir uma string
		la $a0, fim_string 	   # carrega o endereço da string em $a0
		syscall
		jal imprime_inteiro	   # chama função para imprimir o numero lido
		j   fim			   # encerra o programa
	
	le_inteiro_do_teclado:
		li $v0, 5		   # system call para ler um inteiro
		syscall		
		jr $ra			   # retorna para a main (inicio)
		
	imprime_inteiro:
		li $v0, 1		   # system call para imprimir um inteiro
		la $a0, ($t0)		   # $a0 irá conter o valor de $t3
		syscall
		li $v0, 1		   # system call para imprimir um inteiro
		la $a0, ($t1)		   # $a0 irá conter o valor de $t5
		syscall		
		li $v0, 1		   # system call para imprimir um inteiro
		la $a0, ($t2)		   # $a0 irá conter o valor de $t6
		syscall
		li $v0, 1		   # system call para imprimir um inteiro
		la $a0, ($t3)		   # $a0 irá conter o valor de $t7
		syscall	
		li $v0, 1		   # system call para imprimir um inteiro
		la $a0, ($t4)		   # $a0 irá conter o valor de $t7
		syscall
		li $v0, 1		   # system call para imprimir um inteiro
		la $a0, ($t5)		   # $a0 irá conter o valor de $t7
		syscall	
		li $v0, 1		   # system call para imprimir um inteiro
		la $a0, ($t6)		   # $a0 irá conter o valor de $t7
		syscall	
		jr $ra			   # retorna para a main (inicio)
		
	fim:
		li $v0, 10		   # system call para encerrar o programa
		syscall	
