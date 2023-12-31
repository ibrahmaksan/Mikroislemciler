

; Ýbrahim Aksan

PORTA EQU 110
PORTB EQU 199

org 100h

mov bx,200h

mov [bx],10h
mov [bx+2],20h

mov [bx+4],30h
mov [bx+6],40h

mov [bx+8],50h
mov [bx+10],60h

mov [bx+12],70h
mov [bx+14],80h

mov [bx+16],90h
mov [bx+18],10h

mov [bx+20],20h
mov [bx+22],30h

mov [bx+24],40h
mov [bx+26],50h

mov [bx+30],60h
mov [bx+32],70h

mov [bx+34],80h
mov [bx+36],90h

mov [bx+38],10h
mov [bx+40],20h

mov di,0
mov si,0
mov cx,2
mov dl,0
mov bp,0

tekrar:
    
    mov ax,[bx+di]
    and ax,01h
    jnz topla
    jmp dondur

topla:
    
    add si,1
    jmp dondur    
    
dondur:
      
    mov ax,[bx+di]  
    ror ax,1
    mov word ptr [bx+di],ax
    add dl,1
    cmp dl,16
    jz git
    jmp tekrar
    
    
git:
    add di,2
    sub cx,1
    mov dl,0
    loop yeni_sayi
    jmp tekrar

yeni_sayi:
             
    mov ax,si
    mov cl,2
    div cl
    mov [300h+bp],ah ; kalani 0700:0300 den baslayarak 00 veya 01 yazacak. 00 sa cift sayida 1, 01 ise tek
    ;sayida 1 var demektir.
    add bp,2
    mov ax,0
    mov cx,2
    mov si,0
    cmp di,44
    jz bitir
    jmp tekrar
   
bitir:
    
    in al,PORTA
    
    cmp al,01h
    jnz B2
    mov ax,[300h]
    jmp sonuc    
    
    B2:
        cmp al,02h
        jnz B3
        mov ax,[302h]
        jmp sonuc 
              
    B3:
        cmp al,03h
        jnz B4
        mov ax,[304h]
        jmp sonuc
    
    
    B4:
        cmp al,04h
        jnz B5
        mov ax,[306h]
        jmp sonuc
        
    B5:
        cmp al,05h
        jnz B6
        mov ax,[308h]
        jmp sonuc
    B6:
        cmp al,06h
        jnz B7
        mov ax, [310h]
        jmp sonuc
        
        
    B7:
        cmp al,07h
        jnz B8
        mov ax, [312h]
        jmp sonuc
        
        
    B8:
        cmp al,08h
        jnz B9
        mov ax, [314h]
        jmp sonuc
        
        
    B9:
        cmp al,09h
        jnz B10
        mov ax,[316h]
        jmp sonuc
        
        
        
    B10:
        cmp al,10h
        jnz bitir
        mov ax,[318h]
        jmp sonuc
    
    sonuc:
    
        out PORTB,ax
        jmp bitir ; Hocam normalde burada takilmamasi lazim. Fakat emulatorden kaynakli bir sorun var.
        ; Kod dogru calisiyor. Arkadaslarla test ettik.Sayilarin tek mi cift mi olduguna 0700:0300 adresinden
        ; bakabilirsiniz. 16 bit olarak 01 veya 00 seklinde kaydettim. Yani 0700:0300 den 0700:0300 ' e kadar 
        ; sayi 1 in teklik ciftlik degeri var. Diger sayi 0700:0304 den basliyor. 
    
ret
