
; dl ye kadar olan asal sayilarin bellege yazdirilmasi 


mov bx,0200h

mov dl,25

mov si,00
mov di,00


mov ch,0

j1: ; dl surekli bir azalip 1 e kadar tum sayilar asal mi degil mi kontrol edilecek.
   mov cl,dl
   mov si,0


tekrar: 
   mov al,dl
   mov ah,0 ; bolumu her seferinde sifirlamak lazim bolumle ilgilenmiyoruz cunku
   div cl
   
   cmp ah,0
   jnz kalanVar
    
   inc si
kalanVar:
    loop tekrar ; bu sayede aslinda cx azalirken cl azalmis olacak. cl = 0 oldugunda sayi kendinden kucuk
    ;tum sayilara bolunerek kontrol edilmis olur. Daha pratik yollari da var tabi. Fakat en basit haliyle yazdim.
    cmp si,2
    jnz AsalDegil
    mov [bx+di],dl ; asalsa direkt atiyoruz bellege
    inc di
    
AsalDegil:  
    
    dec dl
    cmp dl,1
    jnz j1

hlt
    
    
    
   
   
   
   
   




