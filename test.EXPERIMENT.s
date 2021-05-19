# imports

.include "./Funcoes/dataImports"

.text
Inicio: 

	
	
	#startMenu()
	#drawMenu()
	
	#selecionar:
	#mv t0 s2
	#li t1 POS_SAIR
	#beq t0 t1 sair
	#li t0 POS_START
	#beq t0 t1 comecajogo
	#j Inicio

	
	
	
	comecajogo:
	#colisao x parede = 5 e 283 
	li s1 150
	li s0 70
	printbitmapEficiente(zero zero background )
	
	vamola:
	li a0, 4
	li a1, 3
	li s4 70
	li s3 70
	alterScoreP1()
	alterScoreP2()
	
	#y=275 x=100
	li s8, 0xFF000000
	add s8, s1, s8
	li t2, 320
	mul t1, s0, t2
	add s8, t1, s8
	faddi(fs0 10)
	faddi(fs1 1)
Fim:
	
	
	li s8, 0xFF000000
	add s8, s1, s8
	li t2, 320
	mul t1, s0, t2
	add s8, t1, s8
	
	
	
	colidirDiagonal(114, 11,0,103 , s0, s1, fs0, fs1)
	fmv.s fs0, fa0
	fmv.s fs1, fa1
	colidirDiagonal(99,304 ,0 ,208 , s0, s1, fs0, fs1)
	fmv.s fs0, fa0
	fmv.s fs1, fa1
	colidirDiagonal(480,116 ,390 ,16 , s0, s1, fs0, fs1)
	fmv.s fs0, fa0
	fmv.s fs1, fa1
	colidirDiagonal(480, 210 ,395 ,306 , s0, s1, fs0, fs1)
	fmv.s fs0, fa0
	fmv.s fs1, fa1
	#agr os flippers
	colidirDiagonal(34, 100 ,14 ,144 , s0, s1, fs0, fs1)
	fmv.s fs0, fa0
	fmv.s fs1, fa1
	colidirDiagonal(15, 180 ,34 ,220 , s0, s1, fs0, fs1)
	fmv.s fs0, fa0
	fmv.s fs1, fa1
	colidirDiagonal(450, 102 470 ,144 , s0, s1, fs0, fs1)
	fmv.s fs0, fa0
	fmv.s fs1, fa1
	colidirDiagonal(470, 180 450 ,224 , s0, s1, fs0, fs1)
	fmv.s fs0, fa0
	fmv.s fs1, fa1
	
	checkColisaoParedes( s0, s1, fs0, fs1 )
	fmv.s fs0, fa0
	fmv.s fs1, fa1
	li s9 1
	colidirPlanetas( s8, obstaculosPosicao obstaculosRaio obstaculosVidas s9 fs0 fs1)
	mv s9, a0
	j continua2
	continua2:
	#flipperBate(470, 180,450,224, s0, s1, fs0, fs1, 15)
	#fmv.s fs0, fa0
	#fmv.s fs1, fa1
	
	#player remoto
	lerAPI()
	j depoisAPI
	FlipperEsquerdoS:
	useFlipper( 12 144 32 100 FES1 s0, s1, fs0, fs1, 15 s9 88 0)
	fmv.s fs0 fa0
	fmv.s fs1, fa1
	mv s9, a1
	j depoisAPI
	FlipperDireitoS:
	useFlipper( 12 180 32 220 FDS1 s0, s1, fs0, fs1, 15 s9 172 0)
	fmv.s fs0 fa0
	fmv.s fs1, fa1
	mv s9, a1
	j depoisAPI
	
	
	depoisAPI:
	
	#player 1
	getInputFlipper()
	j depoisdoflipper
	FlipperEsquerdo:
	useFlipper( 470 144 452 100 FEI1 s0, s1, fs0, fs1, 15 s9 84 408)
	fmv.s fs0 fa0
	fmv.s fs1, fa1
	mv s9, a1
	j depoisdoflipper
	FlipperDireito:
	useFlipper( 470 180 452 224 FDI1 s0, s1, fs0, fs1, 15 s9 176 408)
	fmv.s fs0 fa0
	fmv.s fs1, fa1
	mv s9, a1
	j depoisdoflipper
	
	
	
	depoisdoflipper:
	li s11 4
	rem s11 s1, s11
	sub s11 s1 s11
	printbitmapClean(s11 s0 40 40)
	move(fs0, fs1 s0 s1)
	gravidade(fs0, s0, 1, 20)
	perdaEnergia(fs0, 990, 1000)
	perdaEnergia(fs1, 990, 1000)
	
	printbitmap(s1 s0 Ball )
	li a7 32
	li a0 50
	ecall
	continua:
	j Fim2



INICIO:	la s0,NUM		# define o endere�o do n�mero de notas
	la s0,NOTAS		# define o endere�o das notas
	lw t0 CONTADORDENOTAS	# zera o contador de notas
	li a2,24		# define o instrumento
	li a3,127		# define o volume

LOOP:   blt s6,a0,FIMNOTA
LOOPQ:	beq t0,s1, INICIO	# contador chegou no final? ent�o  v� para INICIO, o LOOPQ deve ser retirado apos concluir o blt
	lw a0,0(s0)		# le o valor da nota
	lw a1,4(s0)		# le a duracao da nota
	li a7,31		# define a chamada de syscall
	ecall			# toca a nota
	mv a0,a1		# passa a dura��o da nota para a pausa
	# Isto deve ser retirado quando o blt estiver concluido
	li a7,31		# define a chamada de syscal 
	ecall			# realiza uma pausa de a0 ms
	#######################################################
	addi s0,s0,8		# incrementa para o endere�o da pr�xima nota
	addi t0,t0,1		# incrementa o contador de notas
				# volta ao loop
	
FIMNOTA: 
	
	
	
	
	
Fim2:
	j Fim


sair:
li a7 10
ecall


# Declaração de funções necessárias
PrintbitmapEficiente: 
    printbitmapEficiente( a2 a3 a0 )

PrintbitmapClean:
    printbitmapClean( a2 a3 a4 a5 )
    
PrintGif:
    printGif( a4 a5 a6 a7 )
    
Printbitmap:
    printbitmap( a2 a3 )
subir: upSelected(s2)
descer: downSelected(s2)
N2IP1: num2img( s3 t4 )
N2IP2: num2img( s4 t4 )
