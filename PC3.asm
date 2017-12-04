# Para Casa 3
# Nome: Mateus
# Sequence of Fibonacci

.data 					   #dados e variáveis do nosso programa
	inicio_string: .asciiz "\nEntre um numero: "
	fim_string: .asciiz "A sequencia eh:\n"
	
	fibs: .word   0 : 1      # "array" que irá conter os valores da sequencia
	size: .word  1             # tamanho do "array" = 10
	
	head: .asciiz  "A sequencia eh:\n"
	space:.asciiz  " "          # espçao entre os números

.text 					   #instruções e códigos do nosso programa
	.globl inicio
	
	inicio:
		li $v0, 4 		   # system call para imprimir uma string
		la $a0, inicio_string 	   # carrega o endereço da string em $a0
		syscall
		jal le_inteiro_do_teclado  # chama função para ler
		la  $t1, 0($v0)		   # carrega o inteiro lido em $t1
		li $v0, 4 		   # system call para imprimir uma string
		la $a0, fim_string 	   # carrega o endereço da string em $a0
		syscall
		jal faz_sequencia	   #chama função de gerar sequencia e imprimir
	
	le_inteiro_do_teclado:
		li $v0, 5		   # system call para ler um inteiro
		syscall		
		jr $ra			   # retorna para a main (inicio)
		
	imprime_inteiro:
		li $v0, 1		   # system call para imprimir um inteiro
		la $a0, ($t1)		   # $a0 irá conter o valor de $t1
		syscall		
		jr $ra			   # retorna para a main (inicio)
	
	faz_sequencia:
      		la   $t7, fibs        # carrega o endereço da string
    		lw   $t5, size	      # carrega um conteudo na RAM em $t0:  $t0 = var1
		sw   $t1, size	      # salva o conteudo de $t1 na RAM:  var1 = $t1
		la   $t5, size        # carrega o endereço do size
   		lw   $t5, 0($t5)      # carrega o tamanho do "array"
   		li   $t2, 1           # O primeiro elemento eh 1
   		add.d $f0, $f2, $f4
   		sw   $t2, 0($t7)      # F[0] = 1
   		sw   $t2, 4($t7)      # F[1] = F[0] = 1
   		addi $t1, $t5, -2     # tamanho do contador do loop
		loop:
			lw   $t3, 0($t7)      # pega valor do "array" da posição F[n] 
			lw   $t4, 4($t7)      # pega valor do "array" da posição F[n+1]
			mul $t2, $t3, 2	      # $t2 = 2 * f[n]
			add  $t2, $t2, $t4    # $t2 = F[n] + F[n+1]
			sw   $t2, 8($t7)      # Salva F[n+2] = F[n] + F[n+1] no "array"
			addi $t7, $t7, 4      
			addi $t1, $t1, -1     # decrementa o contador do loop
			bgtz $t1, loop        # repete se ainda não terminou
			la   $a0, fibs        # primeira argumento para a função print
			add  $a1, $zero, $t5  # segundo argumento para a função print
			jal  print            # chama função de imprimir
			li   $v0, 10          # system call para finalizar o programa
			syscall
	
	print:
		add  $t0, $zero, $a0  
		add  $t1, $zero, $a1  # inicializa o contador do loop com tamanho do "array1'
		la   $a0, head        
		li   $v0, 4           # system call para imprimir uma string
		syscall               
		out:
			la   $a0, space       # carrega endereço do space
			li   $v0, 4           # system call para imprimir uma string
			syscall               
			lw   $a0, 0($t0)      # carrega numero da sequencia
			li   $v0, 1           # system call para imprimir um inteiro
			syscall               
			la   $a0, space       # carrega endereço do space
			li   $v0, 4           # system call para imprimir uma string
			syscall               
			addi $t0, $t0, 4      # incrementa no endereço
			addi $t1, $t1, -1     # decrementa o contador do loop
			bgtz $t1, out         # repete se ainda não terminou
			jr   $ra              # retorna para a funçao
	

