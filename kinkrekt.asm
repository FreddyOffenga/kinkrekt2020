; Outline logo - 20 x 4 chars
; graphics 2

; F#READY, May 2020

; Fixed bug in data, 
; Only XL O.S. compatible
; Added smooth build-up
; Added glitch fx

screen_mem	= $305c	; $be70

	org $80

main
;	jsr graphics
; ugly hack to set graphics 2 (XL OS only!)
	lda #$32
	sta $6a		; lda #$12, sta RAMTOP - could be used to make this prog compatible with 16K and BASIC ON...
;	sta $2b		; ICAX2Z
	jsr $ef8e+2	; jsr $f3f4 works for Altirra OS (but plz use original Rev.2 XL/XE OS!)

	lda #227
	sta 756

print
	ldy #79
	
showgfx

wframe
	lda $d40b
	bne wframe
	sta 708
	lda 20
	and #31
	bne wframe

	tya
	lsr
	tax
	lda gfx,x
glitch1
	sta $d1fe
;	sta 708
	bcs low_nibble

; high nibble	
	lsr
	lsr
	lsr
	lsr

low_nibble
	and #15
	tax
	
	lda lookup,x
	sta screen_mem+100,y

glitch2
	sta $d010
	dey
	bpl showgfx
	
	lda #$99	; sta adr,y
	sta glitch1
	sta glitch2
	bne print
	
gfx
	dta 5,102,116,87,102,116,87,102,118,64
	dta 10,84,170,161,69,58,170,84,166,48
	dta 10,146,169,42,170,169,58,170,166,48
	dta 9,102,134,98,146,150,136,41,134,32

lookup
	dta 0,65,67,68,69,81,82,87,88,90,124

; ASCII
;	dta 64, 1, 3, 4, 5,17,18,23,24,26,124
	
	run main
