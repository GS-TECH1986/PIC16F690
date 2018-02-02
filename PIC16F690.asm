;--------------------------------------------------------------------------------------------------------------;:;
;NOMBRE CARGADOR TOTALIFT 36V BA30R0 5376R1
;FECHA: 01/12/17
;DEVICE: PIC16F690
;https://github.com/GS-TECH1986/PIC16F690/wiki
;--------------------------------------------------------------------------------------------------------------

;CN3: 1-GND, 2-36V, 3-JP3, 4-R15, 5-JP2, 6-JP1
;ICSP: VPP-4(C16,XT), VDD-1, GND-20, PDT-19, PCK,18





;DECLARACION DE VARIABLES Y CONSTANTES

;INSTRUCTION SET, SFR

Title "PIC16F690"
List p=16f690

 



RADIX hex
#include	<p16f690.inc>

__CONFIG   _CP_OFF & _BOR_OFF & _MCLRE_OFF & _WDT_OFF & _PWRTE_ON & _INTRC_OSC_NOCLKOUT
     CBLOCK 0x20
W_REG
STATUS_REG
RLY_BITS
COUNTER
AUX
DIGAUX
DIG0
DIG1
DIG2
DIG3
DIG4
ENDC
 

        
_8_DIG     EQU B'11111111' ; BIT0=A BIT1=B BIT2=C BIT3=D BIT4=E BIT5=F  BIT6=G BIT7=(.)
S_GIG     EQU B'10110110' ; PART NUMB: SA52-11EWA  KB 14-46 M
T_DIG     EQU B'00011110' ;
O_DIG     EQU B'11111100' ;
P_DIG     EQU B'11001111' ;
C_DIG     EQU B'10011100' ;
H_DIG     EQU B'01101110' ;
R_DIG     EQU B'11101110' ;
G_DIG     EQU B'11110101' ;
TIME_LIT   EQU  D'256' 
ANALOGH     EQU B'00000000' ;
ANALOGL     EQU B'00000000' ;        
;DS1_3

#define           RL1                PORTA,0          ; C3, 1KHZ, ACTIVACION RL1          (OUT)            PIN 19
#define           RL2                PORTA,1          ; C4, 1KHZ, ACTIVACION RL2          (OUT)            PIN 18
#define           NC1                PORTA,2          ; NO CONNECTION                     (IN/OUT)         PIN 17
#define           XT1_1                      PORTA,3          ; C16,XT1                           (IN)             PIN 4
#define           XT1_2                PORTA,4          ; C15,XT1                           (IN)             PIN     3      
#define           STOP_SW            PORTA,5          ; R12                               (IN)             PIN 2
#define           DS1_2              PORTB,4          ;DS1_2                              (IN)             PIN 13
#define           INPUT            PORTB,5          ; INPUT                             (IN)              PIN 12
#define           DS1_4              PORTB,6          ; DS1_4                             (X)               PIN  11    
#define           CN6_2_OP1            PORTB,7          ; CN6_2, OP1                        (X)               PIN 10
#define           DS1_1              PORTC,0          ; DS1_1                             (IN)              PIN 16
#define           MM5451_CLK         PORTC,1          ;MM5451_                            (OUT)             PIN 15
#define           MM5451_DATA        PORTC,2          ;MM5451_                            (OUT)             PIN 14
#define           C17           PORTC,3          ; C17                               (X)               PIN 7
#define           PORTGND            PORTC,4          ;GND                                (X)               PIN 6
#define           R11            PORTC,5          ;R11                                (X)               PIN 5
#define           CN6_4            PORTC,6          ;CN6_4                              (X)               PIN 8
#define            CN6_3             PORTC,7          ;CN6_3                              (X)               PIN 9      
;1-VCC,20-GND

	

org 0x00
goto INICIO

ORG 4H
;goto ISR
movwf W_REG
swapf STATUS,w
movwf STATUS_REG
btfsc INTCON,T0IF
goto TMR0_FLAG
btfsc PIR1,TMR1IF
call TMR1_FLAG
btfsc PIR1,ADIF
goto AD_FLAG
swapf STATUS_REG,w
movwf STATUS
swapf W_REG,F
swapf W_REG,w


;-------------------------------------------------------------------------------------------------------------
INICIO
call  CONFIG_PUERTOS
CALL Retardo_1ms
COMF PORTA,f
bsf  MM5451_DATA 
CALL Retardo_1ms



bcf     MM5451_CLK
CALL Retardo_1ms
bsf     MM5451_CLK

bcf     MM5451_CLK
CALL Retardo_1ms
COMF PORTA,f

 asi nop
GOTO asi
call  LEDTEST
WAIT call MUESTREO
 GOTO WAIT



;-------------------------------------------------------------------------------------------------------------
;CONFIGURACION DE PUERTOS



;movlw b'11100000'  ;sets up the TMR0 interrupt
         movwf INTCON 


			BSF		STATUS,RP0		;BANK 1
			MOVLW	06H
			MOVWF	ADCON1
			MOVLW	B'00000111'
			MOVWF	OPTION_REG			
			BCF		STATUS,RP0		;BANK 0
			BSF		INTCON,T0IE
			BSF		INTCON,GIE

CONFIG_PUERTOS
bcf		STATUS,RP1
bsf STATUS,RP0 ; pongo rp0 a 1 y paso al banco1

movlw b'11111100' ; cargo W con 11111

movwf TRISA ; y paso el valor a trisa movlw b'00000000' ; cargo W con 00000000
movlw b'11111111'
movwf TRISB ; y paso el valor a trisb

movlw b'11111001'
movwf TRISC


movlw b'00000110'  ;sets 4 sec cycle
movwf ADCON1
movlw b'00000110'  ;sets 4 sec cycle
movwf OPTION_REG
movlw b'10100000'  ;sets up the TMR0 interrupt
movwf INTCON 
movlw b'10000000'  ;sets 4 sec cycle
movwf PIE1
movlw b'00000000'  ;sets 4 sec cycle
movwf PIE2
;movwf ADCON
bsf		STATUS,RP1
bcf STATUS,RP0 
;clrf ANSEL
;clrf ANSELH
movlw ANALOGL  ;ENTRADAS ANALOGICAS
movwf ANSEL
movlw ANALOGH  ;
movwf ANSELH
bcf		STATUS,RP1
bcf STATUS,RP0 
COMF PORTA,F; pongo rp0 a 0 y regreso al banco0
movlw b'00000110'  ;sets 4 sec cycle
movwf ADCON0
clrf PORTA
clrf PORTB
clrf PORTC
return

MUESTREO
btfsc STOP_SW
call	SW_ON
return



SW_ON
;	call retardo
btfsc STOP_SW
	call SET_STOP
	return
;TRISA
;TRISB
;TRISC
;CONFIGURAR ADC
;CONFIGURAR TMR0
;CLARIFICAR PUERTOS
;BANK1
;CONFIGURAR TRIS
;BANK0
;STATUS
;PORTA
;PORTB
;PORTC
;------------------------------------------------------------------------------------------------------------

ENVIAR_LETRA
;movf DIG1,w
movlw 7h
movwf AUX
movwf DIGAUX
;call DESPLIEGUE
;movf DIG2,w
;movwf DIGAUX
;call DESPLIEGUE
;movf DIG3,w
;movwf DIGAUX
;call DESPLIEGUE
;movf DIG4,w
;movwf DIGAUX
;call DESPLIEGUE

again btfss DIGAUX,0h
goto CLRDATA
goto SETDATA
SETDATA
rrf DIGAUX,f
bsf MM5451_DATA
;call retardo
;bsf CLK
;call retardo
;bcf CLK

decf AUX,F
btfss STATUS,Z
goto again
RETURN

CLRDATA
rrf DIGAUX,f
bcf MM5451_DATA
;bcf CLK
return
SETPOINT
;AUX

return
;------------------------------------------------------------------------------------------------------------
;PROBAR DISPLAY 8888

LEDTEST

call _8888_WORD
call ENVIAR_WORD
;call retardo 2 seg
;call CLR_WORD
return





;----------------------------------------------------------------------------------------------------------
ISR
;GIE PEIE T0IE PIE1 PIE2
;ISR
movwf W_REG
;movlw b'00000000'
;movwf INTCON
bcf INTCON,GIE
;btfsc INTCON, ADCINT
btfsc INTCON, T0IF
bcf INTCON, T0IF
bcf     MM5451_CLK
CALL Retardo_1ms
bsf     MM5451_CLK

;bcf     MM5451_CLK
;CALL Retardo_1ms
;goto TIMER0
;call TIMER_0
;call TIMER_1
;call ADC_SENSE
btfsc INTCON,TMR0
call COMP_RLY
swapf W_REG,F
swapf W_REG,w
retfie
retfie
;-------------------------------------------------------------------------------------------------------------


;MUESTREO
btfsc STOP_SW
;goto SET_CHRG
goto SET_STOP




;---------------------------------------------------------------------------------------------------------
;COMPARAR ADC
;movf ADRESSLOW,w
;subwf ADRESSLOW,W
btfss STATUS,C
;goto SET_CHRG
goto SET_STOP

SET_STOP
;bcf RLY
bcf INTCON,TMR0
call STOP_WORD
call ENVIAR_LETRA



;----------------------------------------------------------------------------------------------------------
CHRG_WORD
movlw C_DIG
movwf DIG1
movlw H_DIG
movwf DIG2
movlw R_DIG
movwf DIG3
movlw G_DIG
movwf DIG4
return
;------------------------------------------------------------------------------------------------------------------------------
SEND_STOP
call STOP_WORD
movfw DIG1
call ENVIAR_LETRA
movfw DIG2
call ENVIAR_LETRA
movfw DIG3
call ENVIAR_LETRA
movfw DIG4
call ENVIAR_LETRA
return
;---------------------------------------------------------------------------------------------------------------------------
SEND_CHRG
call CHRG_WORD
movfw DIG1
call ENVIAR_LETRA
movfw DIG2
call ENVIAR_LETRA
movfw DIG3
call ENVIAR_LETRA
movfw DIG4
call ENVIAR_LETRA
return




;DESPLIEGUE    ;enviar bit, generar relog, tomar digito

comf MM5451_CLK

;rrf DIG,f
;btfss DIG,0h
;goto 
;bcf MM5451_DAT
return




;-----------------------------------------------------------------------------------------------------------------
;complementar relevadores 1khz
COMP_RLY
COMF RL1
COMF RL2
return
goto SET_RLY
bcf RL1
bcf RL2
return
SET_RLY
bsf RL1
bsf RL2

return


;--------------------------------------------------------------------------------------------------------------
_8888_WORD
movlw _8_DIG
movwf DIG1
movwf DIG2
movwf DIG3
movwf DIG4
return
;---------------------------------------------------------------------------------------------------------------





;---------------------------------------------------------------------------------------------------------------------------------
ENVIAR_WORD
movfw DIG1
call ENVIAR_LETRA
movfw DIG2
call ENVIAR_LETRA
movfw DIG3
call ENVIAR_LETRA
movfw DIG4
call ENVIAR_LETRA
return

;----------------------------------------------------------------------------------------------------------------------------------
;CARGAR DIGITO
ENVIAR_BIT
;ROTACION1-8



;TMR0
;PCL
;INTCON

;ADCON0
;ADRESH
;ADRESL
;ADCON1
;ANSEL






retfie

COMPLETE





movlw  b'11111111'
;movwf ADCON
;--------------------------------------------------------------------------------------
TMR0_FLAG
nop
movlw TIME_LIT
movwf COUNTER
clrf      STATUS
decf   COUNTER,F
btfss STATUS,Z
;goto COMPLETE
return
nop
return
;---------------------------------------------------------------------------------

bcf INTCON,GIE
bcf INTCON,T0IF

retfie




;COMP_RLY
;btfss RLYCHRG
;goto RLYSET
;goto RLYCLEAR
;RLYSET bsf RLYCHRG
return
;RLYCLEAR bcf RLYCHRG
return

;-----------------------------------------------------------------------------------------------------

;---------------------------------------------------------------------------------------------------------------------------
STOP_WORD
;movlw S_DIG
movwf DIG1
movlw T_DIG
movwf DIG2
movlw O_DIG
movwf DIG3
movlw P_DIG
movwf DIG4
return
;---------------------------------------------------------------------------------------------------------------------------


;------------------------------------------------------------------------------------------------------------------------------
;ENVIAR_LETRA ;ENVIAR_BIT
;movwf DIG
movlw 0x07
movwf AUX
;subwf
;btfss

;bsf MM5414_DT
;bcf MM5414_DT

;bsf MM5414_CK
;bcf MM5414_CK
;call retardo
return
;------------------------------------------------------------------------------------------------------------------------------










;-------------------------------------------------------------------------------------------------------------------------------


;STOP_SW
SET_CRGH
;SET_STOP

RLYA

RLYB

STOP

 SENSE

;EQU

;#DEFINE

;------------------------------------------------------------------------------------------------------------------------------------




inicio

 

 

call STOP

 ;-----------------------------------------------------------------------------------------
AD_FLAG
nop
return
;----------------------------------------------------------------------------------------
TMR1_FLAG
nop
return
;---------------------------------------------------------------------------------------


; STOP

;call retardo_1seg

;call dpy

return

;DT





return

;DESPLIEGUE

return



;


 











#INCLUDE <RETARDOS.INC>
end