.data
.include "./colisaoParedes.s"
diagonamos: .string "Batemo na diagas "
sencos: .string "AQUI TA SENO COSENO NESSA PORRA^^^^^ \n"

#RETORNA EM FS0 A VELOCIDADE Y E EM FS1 A VELOCIDADE X
.macro colidirDiagonal(%y1, %x1,%y0,%x0, %ybola, %xbola, %vybola, %vxbola)
addi sp, sp,-100
sw s0,0(sp)
sw s1,4(sp)
sw s2,8(sp)
sw s3,12(sp)
sw s4,16(sp)
sw s5,20(sp)
sw s6, 24(sp)
sw s7, 28(sp)

fsw fs0,48(sp)
fsw fs1, 52(sp)
fsw fs2, 56(sp)
fsw fs3, 60(sp)
fsw fs4, 64(sp)
fsw fs5, 68(sp)
fsw fs6, 72(sp)
fsw fs7, 76(sp)
fsw fs8, 80(sp)
fsw fs9 84(sp)
fsw fs10, 88(sp)
fsw fs11, 92(sp)
addi t0, %ybola, RAIO
addi t1, %xbola, RAIO
fcvt.s.w fs2, t0 #ybola = fs2 e xbola = fs3
fcvt.s.w fs3, t1

faddi(ft0, %y1)
faddi(ft1,%x1)
faddi(ft2,%y0)
faddi(ft3,%x0)
fsub.s ft4, ft0,ft2  #delta y
fsub.s ft5, ft1,ft3 #delta x
fmul.s ft6, ft4,ft4  #ft6 = y^2
fmul.s ft7, ft5, ft5 #ft7 = x^2
fadd.s ft8, ft6,ft7 # ft8 = hip^2
fsqrt.s ft8,ft8 # ft8 = hipotenusa
fdiv.s fs11, ft5, ft8 #fs11 = cos
fdiv.s fs10, ft4, ft8 #fs10 = sen
#printFloatln(fs11)
#printFloatln(fs10)
#printStringln(sencos)
fdiv.s fs4, ft4, ft5 #tangente do angulo da funcao afim
# y = fs4x + b
# b = y- fs4x
# b = ft0 - fs4*ft1  # a = fs4,  b = fs5
#fs11 = cos #fs10 = sen
fmul.s fs5, fs4, ft1
fsub.s fs5, ft0, fs5
# a = fs4,  b = fs5 y =ax+b
#ybola = fs2 e xbola = fs3
#calculo da distancia:    deltabola*cos
#delta bola = ybola -  (a*xbola +b)

fmul.s fa0, fs4, fs3
fadd.s fa0, fa0, fs5
fsub.s fa0, fs2 , fa0
#deltabola*cos:
fmul.s fa0, fs11, fa0
fabs.s fa0, fa0
fcvt.w.s t0, fa0
li t1 RAIO
ble t0, t1 colidiupai
j fimnaocolidiu

colidiupai:
#printStringln(diagonamos)
fmv.s fs0, %vybola #vx = fs0	vy = fs1
fmv.s fs1, %vxbola
fmul.s fs7 fs0 fs0
fmul.s fs8 fs1 fs1
fadd.s fs7 fs7 fs8
#printFloatln(fs7)
faddi(ft0, 0)
fsub.s fs11, ft0, fs11
rotacaoXVetor(fs0, fs1, fs10,  fs11)
#fs11 = cos fs10 = sen
faddi(ft0, 0)
fsub.s fs0, ft0, fs0
fsub.s fs10, ft0, fs10
rotacaoXVetor(fs0, fs1, fs10,  fs11)
fmul.s fs7 fs0 fs0
fmul.s fs8 fs1 fs1
fadd.s fs7 fs7 fs8
#printFloatln(fs7)



conclusao:
fmv.s fa0 fs0
fmv.s fa1 fs1
j fimcolidiu

fimcolidiu:

lw s0,0(sp)
lw s1,4(sp)
lw s2,8(sp)
lw s3,12(sp)
lw s4,16(sp)
lw s5,20(sp)
lw s6, 24(sp)
lw s7, 28(sp)
flw fs0,48(sp)
flw fs1, 52(sp)
flw fs2, 56(sp)
flw fs3, 60(sp)
flw fs4, 64(sp)
flw fs5, 68(sp)
flw fs6, 72(sp)
flw fs7, 76(sp)
flw fs8, 80(sp)
flw fs9 84(sp)
flw fs10, 88(sp)
flw fs11, 92(sp)

addi sp, sp, 100
j end













fimnaocolidiu:
fmv.s fa0, %vybola
fmv.s fa1, %vxbola
lw s0,0(sp)
lw s1,4(sp)
lw s2,8(sp)
lw s3,12(sp)
lw s4,16(sp)
lw s5,20(sp)
lw s6, 24(sp)
lw s7, 28(sp)
flw fs0,48(sp)
flw fs1, 52(sp)
flw fs2, 56(sp)
flw fs3, 60(sp)
flw fs4, 64(sp)
flw fs5, 68(sp)
flw fs6, 72(sp)
flw fs7, 76(sp)
flw fs8, 80(sp)
flw fs9 84(sp)
flw fs10, 88(sp)
flw fs11, 92(sp)

addi sp, sp, 100
j end

end:





.end_macro
