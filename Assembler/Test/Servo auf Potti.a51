		code at 0
		include 5131.inc
		
anfang:	mov P2,#0000000b
        lcall kurz
        mov P2,#0000010b
        lcall lang
        ;ljmp anfang
        lcall Ain0
        mov p0,A
        ljmp anfang

                   ; ca. mit.; ca. hinten; 
kurz : mov R6,A ; 1 = 90 ; 1,5 = 135 ; 2 = 180
kurz1: mov R7,#4
kurz2: djnz R7,kurz2
       djnz R6,kurz1
       ret

lang : mov R6,#250
lang1: mov R7,#36
lang2: djnz R7,lang2
       djnz R6,lang1
       ret

	
;***** ADDA Hilfsprogramm *******;   
    Adr_lies			EQU	10010001b	;1001 fest, 000 durch Platine, 1 Wert lesen
	Adr_schreib		EQU	10010000b	;1001 fest, 000 durch Platine, 0 Wert lesen
	Contr_Ain0		EQU	01000000b	;4 einzelne ADU, Kanal0
	Contr_Ain1		EQU	01000001b	;4 einzelne ADU, Kanal1
	Contr_Ain2		EQU	01000010b	;4 einzelne ADU, Kanal2
	Contr_Ain3		EQU	01000011b	;4 einzelne ADU, Kanal3
	
	delay				EQU	10		; Zeitverzögerung der Datenübertragung nach jedem Bit
										; Normalwert 10, minimal 1 möglich = schneller
										; diese Verzögerung wird nur wirksam bei $set (fast=0)
	$set (fast=0)					; maximale Schnelligkeit mit fast=1
										
	reg7				data	07		; als Register verwendete Speicherstellen
	reg0				data	00

;****** hier die verwendeten I2C-Leitungen eintragen ************************
	daten			EQU	p4.1 		;SDA-Leitung: alte Boards P3.5, USB-Boards P4.1
	clock			EQU	p4.0 		;SCL-Leitung: alte Boards P3.4, USB-Boards P4.0	
;	Trigger: 	EQU	p3.6	;Hilfsausgang für das Oszilloskop
;***************************************************************************

public Ain0,Ain1,Ain2,Ain3,Aout									; für normale Ein- und Ausgaben
public initAD0,initAD1,initAD2,initAD3,ADin_fast,stoppAD	; für schnelle Eingaben
public initDA,DAout_fast,stoppDA									; für schnelle Ausgaben
public initi2c,starti2c,stoppi2c,ausgabei2c					; I2C-Bus-Routinen
public einleseni2c_ohne_ack,einleseni2c_mit_ack


;******* Verwendung der Hilfsprogramme (Beispiele) ***************************
;	Übergaberegister ist immer der Akku
; -------------- einfache Ein- und Ausgaben --------------------------
; 		lcall	Ain0			; Einlesen analoger Eingang 0 (0 bis 5V)
;		mov	P2,a			; Ausgeben des digitalisierten Wertes an P2
;		mov	a,P1			; 8 Schalterstellungen einlesen und
;		lcall	Aout			; Ausgeben als Analogwert 0 bis 5V an Aout
; -------------- schnelle Eingaben ----------------------------------
;		mov	r0,#80h		; Anfangsadresse int. RAM
;		lcall	initAD0		; Analogeingang0 initialisieren
;in:	lcall	ADin_fast	; einen Analogwert einlesen
;		mov	@r0,a			; Wert im RAM ablegen
;		inc	r0				; nächste Speicherstelle
;		cjne	r0,#0ffh,in	; Endwert?
;		lcall	stoppAD		; Ende AD-Protokoll
; -------------- schnelle Ausgaben ---------------------------------
;		mov	r0,#80h		; Anfangsadresse int. RAM
;		lcall	initDA		; Analogausgang initialisieren
;out:	mov	a,@r0			; Wert aus RAM holen
;		lcall	DAout_fast	; als Analogwert ausgeben
;		inc	r0				; nächste Speicherstelle
;		cjne	r0,#0ffh,out; Endwert?
;		lcall	stoppDA		; Ende DA-Protokoll

;************ Analoge Eingänge einlesen ***************************
Ain0:	mov	a,#Contr_Ain0		;Controll-Byte Kanal0
		lcall	Ain
		ret
Ain1:	mov	a,#Contr_Ain1		;Controll-Byte Kanal1
		lcall	Ain
		ret
Ain2:	mov	a,#Contr_Ain2		;Controll-Byte Kanal2
		lcall	Ain
		ret
Ain3:	mov	a,#Contr_Ain3		;Controll-Byte Kanal3
		lcall	Ain
		ret

Ain:	
	lcall	initAD					; Analogeingang initialisieren
	lcall einleseni2c_ohne_ack	; Wert holen und einlesen beenden
	lcall	stoppi2c					; Protokoll beenden
	ret
	
initAD0:
	push	acc
	mov	a,#Contr_Ain0			;Controll-Byte Kanal0
	lcall	initAD
	pop	acc
	ret
initAD1:	
	push	acc
	mov	a,#Contr_Ain1			;Controll-Byte Kanal1
	lcall	initAD
	pop	acc
	ret
initAD2:	
	push	acc
	mov	a,#Contr_Ain2			;Controll-Byte Kanal2
	lcall	initAD
	pop	acc
	ret
initAD3:	
	push	acc
	mov	a,#Contr_Ain3			;Controll-Byte Kanal3
	lcall	initAD
	pop	acc
	ret
	
initAD:								; Analogeingang initialisieren
	push	acc
	push	acc						; Controll-Byte mit Kanalnummer retten
	lcall	initI2C					; Initialisierung der Leitungen (Grundzustand)
	lcall	starti2c					; Startbedingung des I2C-Bus: Jetzt gehts los
	mov	a,#Adr_schreib			; Adresse des IC und Schreibwunsch (zur Kanalwahl)
	lcall	ausgabei2c				; ausgeben
	pop	acc						; Controll-Byte mit Kanalnummer
	lcall	ausgabei2c				; ausgeben
	lcall	stoppi2c
	lcall	starti2c
	mov	a,#Adr_lies				; Adresse des IC und Lesewunsch
	lcall	ausgabei2c				; ausgeben
	lcall	einleseni2c_mit_ack	; Wandlung starten
	pop	acc
	ret

;ADin_fast 	siehe unten wie einleseni2c_ohne_ack

stoppAD:								; Ende AD-Protokoll
	push	acc
	lcall	einleseni2c_ohne_ack	; Ende dem I2c-IC mitteilen
	lcall	stoppi2c
	pop	acc
	ret

Aout:									; Analoge Ausgabe 
	lcall	initDA					; mit Initialisierung
	lcall	DAout_fast
	lcall	stoppDA					; und Abschluss des Protokolls

initDA:								; Analogausgang initialisieren
	push	acc
	lcall	initi2c					
	lcall	starti2c
	mov	a,#Adr_schreib
	lcall	ausgabei2c
	mov	a,#Contr_Ain0
	lcall	ausgabei2c
	pop	acc
	ret	
; DAout_fast	wie ausgabei2c siehe unten
; stoppDA		wie stoppi2c siehe unten	

initI2C:								;Leitungen in den Grundzustand High
	setb	Daten
	setb	Clock
	lcall	warte
	ret

starti2c:							;Startbedingung
	;setb Trigger	
	;nop
	;clr Trigger
	clr	daten
	lcall	warte
	clr	clock
	lcall	warte
	ret

;*********** Byte im Akku ausgeben ****************************************
;*********** Adressen- oder Datenausgabe **********************************
;*********** Acknoledge-Bit = Carry nach Up-Ende **************************
DAout_fast:
ausgabei2c:
	push	reg7
	mov 	reg7,#08h		;Rundenzähler
aloop:
	mov 	c,acc.7			;Datenbit aus Akku holen
	mov 	daten,c			;und ausgeben
	lcall	warte
	setb	clock				;Daten sind gültig
	rl 	a					;Daten links schieben => nächstes Datenbit
	lcall	warte
	clr 	clock				;Datenausgabe ist beendet
	lcall	warte
	djnz 	reg7,aloop
	setb 	daten				;Leitung freigeben (high) für Acknowledge-Bit
	lcall	warte
	setb 	clock				;Slave kann bestätigen
	lcall	warte
	mov 	c,daten			;Acknoledge-Bit einlesen
	clr 	clock		;
	pop	reg7
	ret

ADin_fast:					; Wert der letzten Wandlung holen, steht dann im Akku
einleseni2c_mit_ack:
	lcall	lies8bit			;Datenbyte der letzten Wandlung lesen und Konvertierung des neuen Datenbytes starten
	clr	daten				;Acknowledge-Bit senden
	lcall	warte	
	setb	clock				;Ackn. gültig
	lcall	warte
	clr	clock				;Ackn. beendet
	;clr daten
	ret
	
einleseni2c_ohne_ack:	; kein Ack kündigt dem IC an, dass dies die letzte Wandlung war
	lcall	lies8bit			;aktuelles Datenbyte lesen
	setb	daten				;kein Acknowledge-Bit senden, dies ist das letzte Datenbyte
	lcall	warte
	setb	clock				;Ackn. gültig
	lcall	warte
	clr	clock				;Ackn. beendet	
	lcall	warte
	clr	daten
	ret
	
;einleseni2c:				; alte Routine, wird nicht mehr gebraucht				
;	lcall	einleseni2c_mit_ack	;DA-Wandlung startet
;   lcall	einleseni2c_ohne_ack ;Wert abholen und Ende des Zugriffs ankündigen
;	ret

lies8bit:					;8Bit seriell einlesen und im Akku ablegen
	push	reg7
	setb	daten				;Leitung freigeben (high) für Daten
	mov	reg7,#08h		;Rundenzähler
eloop:	
	setb	clock				;Daten sind gültig
	lcall	warte
	mov	c,daten			;lesen
	mov	acc.7,c			;Datenbit in den Akku
	rl		a					;Daten links schieben => nächstes Datenbit
	lcall	warte
	clr	clock				;Daten lesen ist beendet
	lcall	warte
	djnz	reg7,eloop
	pop	reg7
	ret

stoppDA:
stoppi2c:
	setb	clock				;Stoppbedingung
	lcall	warte
	setb	daten
	lcall	warte
	ret

warte :						;Zeitverzögerung
$if (fast=1)
	ret
$else
	push	reg0
	mov	reg0,#delay
wloop:	
	djnz	reg0,wloop	
	pop	reg0
	ret						
$endif




end
