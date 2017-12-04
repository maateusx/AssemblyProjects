# Para Casa 2
# Nome: Mateus
# Move data between two register.

.data 					   #dados e variáveis do nosso programa
	inicio_string: .asciiz "\nEntre um numero: "
	fim_string: .asciiz "O inteiro foi movido do registrador $t1 para &t2.\n&t2 = "

.text 					   #instruções e códigos do nosso programa
	.globl inicio
	
	inicio:
		li $v0, 4 		   # system call para imprimir uma string
		la $a0, inicio_string 	   # carrega o endereço da string em $a0
		syscall
		jal le_inteiro_do_teclado  # chama função para ler
		la  $t1, 0($v0)		   # carrega o inteiro lido em $t7
		move $t2, $t1
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
		la $a0, ($t2)		   # $a0 irá conter o valor de $t1
		syscall		
		jr $ra			   # retorna para a main (inicio)
		
	fim:
		li $v0, 10		   # system call para encerrar o programa
		syscall	
