mov bx,200h

mov word ptr [bx],1010h
mov word ptr [bx+2],1010h
mov word ptr [bx+4],1010h
mov word ptr [bx+6],1010h

mov di,0 ; tek cikarsa tek,cift cikarsa cift sayida
;bir var
mov si,0
mov dh,0

  
mov ax,[bx]

tekrar:
    or al,0
    jnp ekle
    jmp dondur

ekle:
    add di,1
    jmp dondur


dondur:
    add dh,1    
    cmp dh,2
    jz ram_degistir 
    shr ax,8
    jmp tekrar
    
ram_degistir:
    add si,2
    cmp si,8
    jz bitir
    mov ax,[bx+si]
    mov dh,0
    jmp tekrar
    
bitir:
    hlt    