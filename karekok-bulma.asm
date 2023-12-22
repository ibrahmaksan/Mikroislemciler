
; Karekok Recursive
org 900h            
mov bx, 200H
        
mov si, 0
mov di,100          

mov dx, 100        
mov cl, 0
          

Tekrar: 
    mov ax,0
    mov dx,di
    mov cx,0
    call karekok
    cmp di,0
    jz son
    jmp Tekrar          

karekok proc             
    mov al, cl      
    mul cl          
    cmp ax, dx      
    ja  Eksilt      
    je  Bitir                  
    inc cl          
    jmp karekok       

Eksilt:             
    dec cl          
    jmp Bitir       

Bitir:              
    mov [bx+si], cl
    inc si
    dec di 
    ret
    karekok endp
    
Son:
    hlt             