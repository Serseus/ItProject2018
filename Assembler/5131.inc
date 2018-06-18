;******************************************************************************
; NAME:           at89c5131.inc
;------------------------------------------------------------------------------
; PURPOSE:
;	 Include file for Raisonance
;   This file defines Sfr registers and BIT Registers for AT89C5131
;******************************************************************************


; _____ C 5 1   C O R E ______________________________________________________

		ACC   DATA   0E0H ;        /* Sfr ( ACC, bit addressable)*/
		B     DATA   0F0H ;        /* B,   bit addressable)*/
		PSW   DATA   0D0H ;        /* PSW, bit addressable)*/
		SP    DATA   081H ;
		DPL   DATA   082H ;
		DPH   DATA   083H ;

 		PM_PD   EQU 2		;		   /* Power Down Mode */
		PM_IDL  EQU 1     ;			/* Idle Mode */

; _____  I / O    P O R T ____________________________________________________

		P0    DATA   080H ;        /* P0, bit addressable)*/
		P0_7	BIT	 087H ; 
		P0_6	BIT	 086H ; 
		P0_5	BIT	 085H ; 
		P0_4	BIT	 084H ; 
		P0_3	BIT	 083H ; 
		P0_2	BIT	 082H ; 
		P0_1	BIT	 081H ; 
		P0_0	BIT	 080H ; 

		P1    DATA   090H ;        /* P1, bit addressable)*/
		P1_7	BIT	 097H ; 
		P1_6	BIT	 096H ; 
		P1_5	BIT	 095H ; 
		P1_4	BIT	 094H ; 
		P1_3	BIT	 093H ; 
		P1_2	BIT	 092H ; 
		P1_1	BIT	 091H ; 
		P1_0	BIT	 090H ; 

		P2    DATA   0A0H ;        /* P2, bit addressable)*/
		P2_7	BIT	 0A7H ; 
		P2_6	BIT	 0A6H ; 
		P2_5	BIT	 0A5H ; 
		P2_4	BIT	 0A4H ; 
		P2_3	BIT	 0A3H ; 
		P2_2	BIT	 0A2H ; 
		P2_1	BIT	 0A1H ; 
		P2_0	BIT	 0A0H ; 

		P3    DATA   0B0H ;        /* P3, bit addressable)*/
		P3_7	BIT	 0B7H ; 
		P3_6	BIT	 0B6H ; 
		P3_5	BIT	 0B5H ; 
		P3_4	BIT	 0B4H ; 
		P3_3	BIT	 0B3H ; 
		P3_2	BIT	 0B2H ; 
		P3_1	BIT	 0B1H ; 
		P3_0	BIT	 0B0H ; 

		P4    DATA   0C0H ;        /* P4, bit addressable)*/
		P4_1	BIT	 0C1H ; 
		P4_0	BIT	 0C0H ; 


; _____ T I M E R S __________________________________________________________
		TH0   DATA   08CH  ; 
		TL0   DATA   08AH  ;
		TH1   DATA   08DH  ;
		TL1   DATA   08BH  ;
		TH2   DATA   0CDH  ;
		TL2   DATA   0CCH  ;
		TCON  DATA   088H  ;        /* TCON,  bit addressable)*/
		TMOD  DATA   089H  ;
		T2CON DATA   0C8H  ;        /* T2CON, bit addressable)*/
		T2MOD DATA   0C9H  ;
		RCAP2H DATA  0CBH  ;
		RCAP2L DATA  0CAH  ;
		WDTRST DATA  0A6H  ;
		WDTPRG DATA  0A7H  ;
		
;                            /* TCON bits */
		TF1    BIT   08FH
		TR1    BIT   08EH
		TF0    BIT   08DH
		TR0    BIT   08CH
		IE1_   BIT   08BH
		IT1    BIT   08AH
		IE0_   BIT   089H
		IT0    BIT   088H
;                            /* T2CON bits */
		TF2    BIT   0CFH
		EXF2   BIT   0CEH
		RCLK   BIT   0CDH
		TCLK   BIT   0CCH
		EXEN2  BIT   0CBH
		TR2    BIT   0CAH
		C_T2   BIT   0C9H
		CP_RL2 BIT   0C8H

		
; _____ S E R I A L    I / O _________________________________________________

		SCON  DATA   098H  ;
		SBUF  DATA   099H  ;
		SADEN DATA   0B9H  ;
		SADDR DATA   0A9H  ;

		FE_SM0 BIT   09FH  ;
		SM1   BIT    09EH  ;
		SM2   BIT    09DH  ;
		REN   BIT    09CH  ;
		TB8   BIT    09BH  ;
		RB8   BIT    09AH  ;
		TI    BIT    099H  ;
		RI    BIT	 098H  ;

;_____ B A U D    R A T E    G E N E R A T O R ______________________________
		BRL   DATA   09AH
		BDRCON DATA  09BH

; _____ P C A ________________________________________________________________
		CCON   DATA   0D8H ;      /* CCON, bit addressable)*/
		CMOD   DATA   0D9H ;
		CL     DATA   0E9H ;
		CH     DATA   0F9H ;
		CCAPM0 DATA   0DAH ;
		CCAPM1 DATA   0DBH ;
		CCAPM2 DATA   0DCH ;
		CCAPM3 DATA   0DDH ;
		CCAPM4 DATA   0DEH ;
		CCAP0H DATA   0FAH ;
		CCAP1H DATA   0FBH ;
		CCAP2H DATA   0FCH ;
		CCAP3H DATA   0FDH ;
		CCAP4H DATA   0FEH ;
		CCAP0L DATA   0EAH ;
		CCAP1L DATA   0EBH ;
		CCAP2L DATA   0ECH ;
		CCAP3L DATA   0EDH ;
		CCAP4L DATA   0EEH ;

;                             /* CCON bits */
		CF    BIT     0DFH ;
		CR    BIT  	  0DEH ;
		CCF4  BIT  	  0DCH ;
		CCF3  BIT     0DBH ;
		CCF2  BIT     0DAH ;
		CCF1  BIT     0D9H ;
		CCF0  BIT     0D8H ;


; _____ I N T E R R U P T ____________________________________________________
		IE0   DATA   0A8H ;       /* IE0,  bit addressable			*/
		IE1   DATA   0B1H ;
		IPL0  DATA   0B8H ;       /* IPL0, bit addressable		*/
		IPH0  DATA   0B7H ;
		IPL1  DATA   0B2H ;
		IPH1  DATA   0B3H ;

;                             /* IE0 bits */
		EA   	BIT   0AFH
		EC   	BIT   0AEH
		ET2   BIT   0ADH
		ES    BIT   0ACH
		ET1   BIT   0ABH
		EX1   BIT   0AAH
		ET0   BIT   0A9H
		EX0   BIT   0A8H
;                             /* IPL0 bits */
		PPCL  BIT   0BEH
		PT2L  BIT   0BDH
		PSL   BIT   0BCH
		PTIL  BIT   0BBH
		PXIL  BIT   0BAH
		PT0L  BIT   0B9H
		PX0L  BIT   0B8H

; _____ P L L ________________________________________________________________
		PLLCON DATA   0A3H ;
		PLLDIV DATA   0A4H ;

; _____ K E Y B O A R D ______________________________________________________
		KBF   DATA   09EH ;
		KBE   DATA   09DH ;
		KBLS  DATA   09CH ;

; _____ T W I ________________________________________________________________
		SSCON DATA   093H ;
		SSCS  DATA   094H ;
		SSDAT DATA   095H ;
		SSADR DATA   096H ;

; _____ S P I ________________________________________________________________
		SPCON DATA   0C3H ;
		SPSTA DATA   0C4H ;
		SPDAT DATA   0C5H ;
; _____ U S B ________________________________________________________________
		USBCON DATA   0BCH ;
		USBADDR DATA  0C6H ;
		USBINT DATA   0BDH ;
		USBIEN DATA   0BEH ;
		UEPNUM DATA   0C7H ;
		UEPCONX DATA  0D4H ;
		UEPSTAX DATA  0CEH ;
		UEPRST DATA   0D5H ;
		UEPINT DATA   0F8H ;         /* UEPINT, bit addressable) */
		UEPIEN DATA   0C2H ;
		UEPDATX DATA  0CFH ;
		UBYCTLX DATA  0E2H ;
		UBYCTHX DATA  0E3H ;
		UDPADDL DATA  0D6H ;
		UDPADDH DATA  0D7H ;
		UFNUML DATA   0BAH ;
		UFNUMH DATA   0BBH ;
;                                /* UEPINT bits */
		EP6INT BIT    0FEH
		EP5INT BIT    0FDH
		EP4INT BIT    0FCH
		EP3INT BIT    0FBH
		EP2INT BIT    0FAH
		EP1INT BIT    0F9H
		EP0INT BIT    0F8H

; _____ M I S C . ____________________________________________________________

		PCON   DATA   087H
		AUXR   DATA   08EH
		AUXR1  DATA   0A2H
		CKCON0 DATA   08FH
		CKCON1 DATA   0AFH
		CKSEL  DATA   085H
		LEDCON DATA   0F1H
		FCON   DATA   0D1H
		EECON  DATA   0D2H



