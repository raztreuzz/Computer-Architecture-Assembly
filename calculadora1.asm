org 100h

;code

mov dx,offset mensaje  

mov ah,0x09
int 21h 

mov dx, offset espacio
mov ah, 0x09
int 21h 


rutina_1:

mov dx,offset submenu
mov ah,0x09
int 21h

call bucle 

rutina_2:


mov dx, offset espacio
mov ah, 0x09
int 21h 

mov dx,offset submenu2
mov ah,0x09
int 21h

call bucle2
 
bucle:

xor ax,ax

mov ah,0x01
int 21h

mov bh,al

mov ah,0x01
int 21h


mov bl,al
mov [num1],bx

mov ah,0x00
int 16h

cmp al,0DH
je rutina_2

cmp al,08
je rutina_1

bucle2:

xor ax,ax

mov ah,0x01
int 21h

mov bh,al

mov ah,0x01
int 21h

mov bl,al
mov [num2],bx

mov ah,0x00
int 16h

cmp al,0DH
je fase2


cmp al,08
je rutina_2   


fase2:   

mov dx,offset espacio
mov ah,0x09
int 21h

mov dx,offset menu
mov ah,0x09
int 21h
jmp elegir

elegir:

xor ax,ax

mov ah,0x01
int 21h

cmp al,0x31
je suma

cmp al,0x32
je resta

cmp al,0x33
je multiplicacion

suma:

mov ax,num1
sub ah,0x30
sub al,0x30

mov bx,num2
sub bh,0x30
sub bl,0x30

add ax,bx

mov [resultado],ax

call imprimir

resta:

mov ax,num1
sub ah,0x30
sub al,0x30

mov bx,num2
sub bh,0x30
sub bl,0x30

sub ax,bx
mov [resultado],ax

call imprimir

multiplicacion:

mov ax,num1
sub ah,0x30
sub al,0x30

mov bx,num2
sub bh,0x30
sub bl,0x30

mul bx
mov [resultado],ax                                                      

mov ax, 00h
int 16h

imprimir:


mov dx,offset espacio
mov ah,0x09
int 21h


mov dx,offset espacio
mov ah,0x09
int 21h



mov dx,offset resultado2
mov ah,0x09
int 21h

mov ax,resultado

add al,0x30
add ah,0x30

mov ch,ah
mov cl,al

mov ah,0x02
mov dl,ch
int 21h

mov ah,0x02
mov dl,cl
int 21h

jmp fin


;decenas

;centenas











fin:
    mov ah, 4Ch
    int 21h
 



    

;section data
mensaje db 'Bienvenido a la calculadora$'   
menu db 10,13, 'Elija una opcion' ,10,13,'1. Suma' ,10,13,'2. resta',10,13,'3. Multiplicacion',10,13,'4. Division',10,13,'5. Salir',10,13,'La opcion que eligio es: ','$'
submenu db 10,13,'Ingrese el primer numero a operar(presione enter para guardar y presiona delete para regresar 1 vez maximo):$ '
submenu2 db 10,13,'Ingrese el segundo numero a operar(presione enter para guardar y presiona delete para regresar 1 vez maximo):$ '
espacio db 10,13,' ','$'
resultado2 db 10,13,'El resultado es: ','$'

num1 dw ?
num2 dw ?
resultado dw ?    






