		code at 0
		include 5131.inc
        
        mov SCON,#0x9a; Setup of UART
        
received:
        jnb ri,received
        mov a,sbuf
        
send:   mov sbuf,a
        jnb ti,send
        
        mov p2,a
        clr ri
        sjmp received
        ret
        
        
end
        
