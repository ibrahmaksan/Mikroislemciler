
; IBRAHIM AKSAN 
; Karekok Hesaplama (Alt Program Kullanarak)

org 900h ; Ram' e 0100:0200 den itibaren yazmaktadir.      
mov bx, 200H ; offseti 200h olarak aldim. 200h dan baslayarak yazacak.
        
mov si, 0
mov di,100 ; bu kadar donecek, 100 den baslayarak 0 a kadar tum sayilarin karekokunu hesaplayacak.        

mov dx, 100 ; sayi 100 den basladigi icin islem uzun surebilir. di ve dx i ayni sayi olmak
;sartiyla daha kucuk bir sayi yazilirsa sonuc daha kisa surede hesaplanabilir.       
mov cl, 0 ; sonucun tutuldugu register
          

Tekrar: 
    mov ax,0 ; register sifirlandi.
    mov dx,di ; yeni sayi dx e atildi. di benim dongu degiskenimdi.
    mov cx,0 ; sonuc registeri sifirlandi.
    call karekok ; karekok alt programini cagirdigim yer
    cmp di,0; di = 0 olduysa artik program tamamlanmistir.
    jz son   ; bitir
    jmp Tekrar; bitmediyse yeni sayiyi alip devam edecek.    

karekok proc             
    mov al, cl      
    mul cl ; ax = cl * cl oldu         
    cmp ax, dx    
    ja  Eksilt  ; ax , dx ' den buyukse sonucun bir azaltilmasi gerekir.      
    je  Bitir   ; ax = dx ise sonuc cl dir ve direkt bitirilir.              
    inc cl      ; ikisine de girmezse cl bir arttirilir.     
    jmp karekok ; yeniden kontrol saglanir.      

Eksilt:             
    dec cl          
           
Bitir:              
    mov [bx+si], cl ; sonuc ram e yazilir.
    inc si
    dec di ; sayi bir azaltilir.
    karekok endp ;karekok alt programi sonlanir
    ret ;karekok ' un cagrildigi yere doner.
    
    
Son:
    hlt             
