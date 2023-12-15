
;Ibrahim AKSAN - 203 608 59 039


; port adresleri
PORTA EQU 110
PORTB EQU 199
 

mov bx,200h

; asagida sayilari bx offsetinden baslayarak ram'e yerlestirdim.
      
mov word ptr [bx],1000h  ;carpanin ilk 16 biti
mov word ptr [bx+2],1200h   ;Carpanin son 16 biti

mov word ptr [bx+4],1200h   ;Carpilanin ilk 16 biti
mov word ptr [bx+6],2003h   ;Carpilanin son 16 biti
    
mov word ptr [bx+8],0000h  ;carpimin ilk 16  biti
mov word ptr [bx+10],0000h  ;carpim 32-16
mov word ptr [bx+12],0000h  ;48-32
mov word ptr [bx+14],0000h  ;64-48

mov cx,32 ; 32 bitlik carpma yaptigimiz icin 32 defa donecegiz.
       

dongu:
    
    mov di,[bx]  ; carpanin ilk 16 bitini dx e attim. lsb 1-0 kontrolu yapilacak.
    and di,01H 	 ; and ve xor islemi lsb icin yapilacak. and ' leme islemi ile son bit 1 se sonuc 1 gelecek ve xor da 1-1 geldiginden 0 cikacak
    xor di,01H
    jz topla ; carpanin lsb si 1 se toplayip kaydirmak gerek.
    


kaydir:
    
    clc  ; cf = 0  yapmamizin sebebi asagida rcr yapmamizdir. diger turlu kaydirma yaparken fazladan carry alabilir.
    mov ax,[bx+14]  
    rcr ax,1        ;carpim sonucunun son 16 bitini(64-48) 1 bit saga kaydirdim.
    mov word ptr [bx+14],ax
    
    mov ax,[bx+12]      
    rcr ax,1        ;carpim sonucunun sondan bir onceki 16 bitini(48-32) 1 bit saga kaydirdim.
    mov word ptr [bx+12],ax
    
    mov ax,[bx+10]
    rcr ax,1        ;carpim sonucunun sondan iki onceki 16 bitini(32-16) 1 bit saga kaydirdim.
    mov word ptr[bx+10],ax
    	
    mov ax,[bx+8]
    rcr ax,1        ;carpim sonucunun ilk 16 bitini(16-0) 1 bit saga kaydirdim.
    mov word ptr [bx+8],ax
    	  
    mov ax,[bx+2]
    shr ax,1        ;carpanin son 16 bitini 1 bit saga kaydir. Elde varsa carry de tutulur.
    mov word ptr [bx+2],ax
     
    mov ax,[bx]
    rcr ax,1        ;Gelen carry ile carpanin ilk 16 biti 1 bit saga kaydirilir.
    mov word ptr [bx],ax
       		   	
    loop dongu	; cx 1 azaltildi. 0 oldugunda dongu tamamlanmis olacak.
    
    mov cx,[bx+8] ; ramde surekli degerler degiseceginden onlari registerlarda sakladim.
    mov dx,[bx+10] ; siralama lsb den msb ye dogru.
    mov di,[bx+12]
    mov si,[bx+14]
    
    jmp bitir		;bitir. 


topla: 

    mov dx,[bx+4]	;carpilanin 0-16 biti dx e atildi. Toplama islemi yapacagiz.
    add [bx+12],dx  ;carpim sonucunun 32-48 bitiyle topladik. Burdan carry cikarsa 48-64 bitlik kisma akratilacak.
    mov dx,[bx+6]  ;carpilanin son 16 bitini dx e attik.
    adc [bx+14],dx ;carpim sonucun 48-64 bitlik kismina ekledik.
    jmp kaydir  
    ; carpim sonucunda son 32-48 ve 48-64 bitlik kisimlarina eklememizin sebebi surekli sonucu donduruyor olusumuz.
    ;Yani aslinda ekledigimiz degerler donerek 0-32 bit arasina yerlesecekler.

    

bitir:
    
    
    in al,PORTA
    
    cmp al,01h
    jnz B2
    mov ax,cx
    jmp sonuc    
    
    B2:
        cmp al,02h
        jnz B3
        mov ax,	dx
        jmp sonuc 
    					
    B3:
        cmp al,03h
        jnz B4
        mov ax,	di
        jmp sonuc
    
    
    B4:
        cmp al,04h
        jnz bitir
        mov ax,si
        jmp sonuc
    
    sonuc:
    
        out PORTB,ax
        jmp bitir
    
ret