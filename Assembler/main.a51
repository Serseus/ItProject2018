		include 5131.inc
        Motor data 030h
        MotorLowTH1 data 036h
        MotorLowTL1 data 037h
        MotorHighTH1 data 038h
        MotorHighTL1 data 039h
        Servo data 031h
        ServoLowTH0 data 032h
        ServoLowTL0 data 033h
        ServoHighTH0 data 034h
        ServoHighTL0 data 035h
        
        ShortBitServo bit 00h
        LongBitServo bit 01h
        ShortBitMotor bit 02h
        LongBitMotor bit 03h
        
        code at 0
		ljmp init
        
        code at 003h
        ljmp exInt0
        
        code at 00Bh
        ljmp TimeInt0
        
        code at 013h
        ljmp exInt1
        
init:	mov A,#0
        mov P1,#0
        mov P3,#0
        mov P2,#0
        mov Motor,#128
        mov Servo,#128
        setb EA
        setb EX0
        setb IT0
        setb EX1
        setb IT1
        setb ET0
        setb TR0
        setb ShortBitServo
        setb ShortBitMotor
        ljmp main
        
        
        
main:   ljmp main


exInt0: mov Motor,P1
        reti
        
exInt1: mov Servo,P1
        reti
        
RefillMotor: mov DPTR,#MotLowTL
             mov A,Servo
             movc A,@A+DPTR
             mov MotorLowTL1,A
             mov DPTR,#MotLowTH
             mov A,Servo
             movc A,@A+DPTR
             mov MotorLowTH1,A
             mov DPTR,#MotHighTL
             mov A,Servo
             movc A,@A+DPTR
             mov MotorHighTL1,A
             mov DPTR,#MotHighTH
             mov A,Motor
             movc A,@A+DPTR
             mov MotorHighTH1,A
             ret

RefillServo: mov DPTR,#SerLowTL
             mov A,Servo
             movc A,@A+DPTR
             mov ServoLowTL0,A
             mov DPTR,#SerLowTH
             mov A,Servo
             movc A,@A+DPTR
             mov ServoLowTH0,A
             mov DPTR,#SerHighTL
             mov A,Servo
             movc A,@A+DPTR
             mov ServoHighTL0,A
             mov DPTR,#SerHighTH
             mov A,Servo
             movc A,@A+DPTR
             mov ServoHighTH0,A
             ret
        
TimeInt0:   

TimeInt1:


ServoLow:

SerLowTL: db 068h,06Ch,070h,074h,078h,07Ch,080h,084h,088h,08Ch,090h,094h,098h,09Ch,0A0h,0A4h,0A8h,0ACh,0B0h,0B4h,0B8h,0BCh,0C0h,0C4h,0C8h,0CCh,0D0h,0D4h,0D8h,0DCh,0E0h,0E4h,0E8h,0ECh,0F0h,0F4h,0F8h,0FCh,000h,004h,008h,00Ch,010h,014h,018h,01Ch,020h,024h,028h,02Ch,030h,034h,038h,03Ch,040h,044h,048h,04Ch,050h,054h,058h,05Ch,060h,064h,068h,06Ch,070h,074h,078h,07Ch,080h,084h,088h,08Ch,090h,094h,098h,09Ch,0A0h,0A4h,0A8h,0ACh,0B0h,0B4h,0B8h,0BCh,0C0h,0C4h,0C8h,0CCh,0D0h
SerLowTH: db 001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h
SerHighTL:db 0A8h,0A4h,0A0h,09Ch,098h,094h,090h,08Ch,088h,084h,080h,07Ch,078h,074h,070h,06Ch,068h,064h,060h,05Ch,058h,054h,050h,04Ch,048h,044h,040h,03Ch,038h,034h,030h,02Ch,028h,024h,020h,01Ch,018h,014h,010h,00Ch,008h,004h,000h,0FCh,0F8h,0F4h,0F0h,0ECh,0E8h,0E4h,0E0h,0DCh,0D8h,0D4h,0D0h,0CCh,0C8h,0C4h,0C0h,0BCh,0B8h,0B4h,0B0h,0ACh,0A8h,0A4h,0A0h,09Ch,098h,094h,090h,08Ch,088h,084h,080h,07Ch,078h,074h,070h,06Ch,068h,064h,060h,05Ch,058h,054h,050h,04Ch,048h,044h,040h
SerHighTH:db 025h,025h,025h,025h,025h,025h,025h,025h,025h,025h,025h,025h,025h,025h,025h,025h,025h,025h,025h,025h,025h,025h,025h,025h,025h,025h,025h,025h,025h,025h,025h,025h,025h,025h,025h,025h,025h,025h,025h,025h,025h,025h,025h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h

MotLowTL: db 010h,0C2h,074h,026h,0D8h,08Ah,03Ch,0EEh,0A0h,052h,004h,0B6h,068h,01Ah,0CCh,07Eh,030h,0E2h,094h,046h,0F8h,0AAh,05Ch,00Eh,0C0h,072h,024h,0D6h,088h,03Ah,0ECh,09Eh,050h,002h,0B4h,066h,018h,0CAh,07Ch,02Eh,0E0h,092h,044h,0F6h,0A8h,05Ah,00Ch,0BEh,070h,022h,0D4h,086h,038h,0EAh,09Ch,04Eh,000h,0B2h,064h,016h,0C8h,07Ah,02Ch,0DEh,090h,042h,0F4h,0A6h,058h,00Ah,0BCh,06Eh,020h,0D2h,084h,036h,0E8h,09Ah,04Ch,0FEh,0B0h,062h,014h,0C6h,078h,02Ah,0DCh,08Eh,040h,0F2h,0A4h,056h,008h,0BAh,06Ch,01Eh,0D0h,082h,034h,0E6h,098h,04Ah,0FCh,0AEh,060h,0C4h,076h,028h,0DAh,08Ch,03Eh,0F0h,0A2h,054h,006h,0B8h,06Ah,01Ch,0CEh,080h,032h,0E4h,096h,048h,0FAh,0ACh,05Eh,000h
MotLowTH: db 027h,026h,026h,026h,025h,025h,025h,024h,024h,024h,024h,023h,023h,023h,022h,022h,022h,021h,021h,021h,020h,020h,020h,020h,01Fh,01Fh,01Fh,01Eh,01Eh,01Eh,01Dh,01Dh,01Dh,01Dh,01Ch,01Ch,01Ch,01Bh,01Bh,01Bh,01Ah,01Ah,01Ah,019h,019h,019h,019h,018h,018h,018h,017h,017h,017h,016h,016h,016h,016h,015h,015h,015h,014h,014h,014h,013h,013h,013h,012h,012h,012h,012h,011h,011h,011h,010h,010h,010h,00Fh,00Fh,00Fh,00Eh,00Eh,00Eh,00Eh,00Dh,00Dh,00Dh,00Ch,00Ch,00Ch,00Bh,00Bh,00Bh,00Bh,00Ah,00Ah,00Ah,009h,009h,009h,008h,008h,008h,007h,007h,007h,006h,006h,006h,005h,005h,005h,004h,004h,004h,004h,003h,003h,003h,002h,002h,002h,001h,001h,001h,000h,000h,000h,000h
MotHighTL: db 00h,
MotHighTH: db 00h,


end
        
