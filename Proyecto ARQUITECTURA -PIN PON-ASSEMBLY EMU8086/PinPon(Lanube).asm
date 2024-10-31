buffer_start:
    dw 320 * 200 dup(0)  ; Reserva 64000 bytes inicializados a 0
 

code_start:

    mov ah,0x00
    mov al,0x13
    int 10h
    
    mov di, buffer_start  ; Dirección del inicio del buffer
    mov cx, 320 * 200     ; Total de píxeles
    mov al, 0             ; Color de fondo (0 = negro)
    rep stosb             ; Llena el buffer con el color de fondo
    
for:
    
    ;Movimiento de la pelota
    call borrar_pelota
    
    ;Actualizacion de la posicion de la pelota 
    
    call actualizar_posicion_P    
    call chequear_colisiones_bordes

    ;Dibujar pelota
    
    call draw_pelota
            
   ; Dibujar paletas
    
   call draw_paletaI
   call draw_paletaD
    
    
   ;Detectar colisiones con paletas
    
   call chequear_colisiones_paletas
    
    ;controlar movimiento de las paletas
    
   call mover_paleta_izquierda
   call mover_paleta_derecha
    
    ;retraso para controlar velocidad del juego

   call delay
    
    jmp for

;----------------------------------------------------------------------
;SUBRUTINAS
;----------------------------------------------------------------------


;----------------------------------------------
;Subrutina para dibujar la pelota en pantalla
;----------------------------------------------


draw_pelota:
    
    mov cx,pAx
    mov dx,pAy
    
    mov ah,0Ch
    mov al,04h
    
    mov si,Tam_Pelota
    mov di,0
    
draw_rows:

    push cx ;guardamos posicion x
    push dx ;guardamos posicion y
    
    mov cx,pAx
    add dx,di
    mov bx,0
    
draw_pixels:
    
    int 10h
    inc cx
    inc bx
    cmp bx,si
    jl draw_pixels
    
    pop dx
    pop cx
    inc di
    cmp di,si
    jl draw_rows

    ;codigo para dibujar pelota en la posicion actual
ret


actualizar_posicion_P:
    ;Subrutina Actualizar la posicion de la pelota
    mov ax,pAx
    add ax,Vpx
    mov pAx,ax
    
    mov ax,pAy
    add ax,Vpy
    mov pAy,ax
    
    call chequear_colisiones_bordes
        
ret 

random:

in al,0x40
and al,0x03
add al,1
ret

chequear_colisiones_bordes:
    ;Subrutina chequear colisiones de los bordes
     ;Colision con la parte superior
     
     cmp pAy,0
     jl colision_superior
     
     cmp pAy,200 - 4
     jg colision_inferior
     
     ;Colisiones de los bordes izquierda derecha
     
     cmp pAx,0
     jl colision_derecha
     
     cmp pAx,320 - 4
     jg colision_izquierda

ret
     
colision_derecha:
    inc jugador1
    call reiniciar_pelota
    
    call cambiar_puntaje
    call delay
ret  
colision_izquierda:
    inc jugador2 
    call reiniciar_pelota 
    
    call cambiar_puntaje
    call delay
ret

reiniciar_pelota:

mov pAx,160
mov pAy,100

neg Vpy
neg Vpx

ret
     
colision_superior:

    mov ax,Vpy
    neg ax
    mov Vpy,ax
    
    mov pAy,0
    
ret 

colision_inferior:

    mov ax,Vpy
    neg ax
    mov Vpy,ax
    mov pAy,190

ret 
    
cambiar_puntaje:
            

borrar_pelota:

    mov cx,pAx
    mov dx,pAy
    
    mov ah,0Ch
    mov al,00h
    
    mov si,Tam_Pelota
    mov di,0
    
borrar_rows:
    
    push cx
    push dx
    
    mov cx,pAx
    add dx, di
    mov bx,0
    
borrar_pixeles:

    int 10h
    inc cx
    inc bx
    cmp bx,si
    jl borrar_pixeles
    
    pop dx
    pop cx
    inc di
    cmp di,si
    jl borrar_rows

ret            

;---------------------------------------------------------------------------------------------
;Fin pelota
;---------------------------------------------------------------------------------------------

;-------------------------------------------
;Inicio Paletas
;-------------------------------------------
draw_paletaI:

    mov cx,PaletaI_x
    mov dx,PaletaI_y
    
    mov ah,0Ch
    mov al,0Fh
    
    mov si,Paleta_ancho
    mov di,0


draw_paleta_rows:

    push cx 
    push dx
    
    mov cx,PaletaI_x
    add dx,di
    mov bx,0
 

draw_paleta_pixeles:

    int 10h
    inc cx
    inc bx
    cmp bx,si
    jl draw_paleta_pixeles
    
    pop dx
    pop cx
    inc di
    cmp di,paleta_alto
    jl draw_paleta_rows
    
ret        

draw_paletaD:

    mov cx,PaletaD_x
    mov dx,paletaD_y
    
    mov ah,0Ch
    mov al,0Fh
    
    mov si,Paleta_ancho
    mov di,0 
    
draw_paletaD_rows:

    push cx
    push dx
    
    mov cx,PaletaD_x
    add dx,di
    mov bx,0

    
draw_paletaD_pixeles:

    int 10h
    inc cx
    inc bx
    cmp bx,si
    jl draw_paletaD_pixeles
    
    pop dx
    pop cx
    inc di
    cmp di,Paleta_alto
    jl draw_paletaD_rows
    
ret  
             
chequear_colisiones_paletas:
    ;Subrutina chequear colisiones de las paletas
ret 


mover_paletas:

    mov ah, 01h
    int 16h
    jz no_tecla
    
    mov ah,00h
    int 16h
    cmp al,0x4B
    je mover_paleta_izquierda
    
    cmp al,0x4D
    je mover_paleta_derecha
    
no_tecla:

ret    

    

ret

mover_paleta_izquierda:
    ;subrutina mover paleta izquierda
        
ret
  
mover_paleta_derecha:
    ;subrutina mover paleta derecha 
    
    
ret

;-----------------------------------------------
;subrutina pausas y marcadores 
;-----------------------------------------------
delay:
    ;Subrutina de retraso para controlar la velocidad del juego
    mov cx, 0Fh
delay_loop:

    nop
    loop delay_loop
ret 

;
;
;
 ;Posicion Inicial de la pelota
    pxBall dw 0A0h
    pyBall dw 64h
   ;Posicion actual de la pelota
    pAx dw 158
    pAy dw 98
   ;Tamanio de pelota
    Tam_Pelota dw 4
   ;Velocidad de pelota
    Vpx dw 9
    Vpy dw 5
   ;Posicion de las paletas
    
    PaletaI_x dw 0Ah
    PaletaI_y dw 0Ah
    
    PaletaD_x dw 306
    paletaD_y dw 0Ah
    
   ;/Tamanio y configuracion de paletas
   
    Paleta_ancho dw 4
    Paleta_alto dw 31
    
    ;contador racha jugador
    
    jugador1 dw 0
    jugador2 dw 0




