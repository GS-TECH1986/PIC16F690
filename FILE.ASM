;--------------------------------------------------------------------------------------------------------------
;ENCABEZADO
;
;NOMBRE CARGADOR TOTALIFT 36V BA30R0 5376R1
;FECHA: 01/12/17
;DEVICE: PIC16F690
;--------------------------------------------------------------------------------------------------------------
;DECLARACION DE VARIABLES Y CONSTANTES



__CONFIG   _CP_OFF & _DATA_CP_OFF & _LVP_OFF & _BOREN_OFF & _MCLRE_ON & _WDT_OFF & _PWRTE_ON & _INTOSC_OSC_NOCLKOUT
 INCLUDE

List p=16f690

RADIX hex
#include	<p16f690.inc>
RETARDOS.INC
             
8_DIG     EQU B'11111111' ; BIT0=A BIT1=B BIT2=C BIT3=D BIT4=E BIT5=F  BIT6=G BIT7=(.)
S_GIG     EQU B'10110110' ; PART NUMB: SA52-11EWA  KB 14-46 M
T_DIG     EQU B'00011110' ;
O_DIG     EQU B'11111100' ;
P_DIG     EQU B'11001111' ;
C_DIG     EQU B'10011100' ;
H_DIG     EQU B'01101110' ;
R_DIG     EQU B'11101110' ;
G_DIG     EQU B'11110101' ;
             
;DS1_3

#define           RL1                PORTA,0          ; C3, 1KHZ, ACTIVACION RL1          (OUT)            PIN
#define           RL2                PORTA,1          ; C4, 1KHZ, ACTIVACION RL2          (OUT)            PIN
#define           NC1                PORTA,2          ; NO CONNECTION                     (IN/OUT)         PIN
#define           XT1_1                      PORTA,3          ; C16,XT1                           (IN)             PIN
#define           XT1_2                PORTA,4          ; C15,XT1                           (IN)             PIN           
#define           STOP_SW            PORTA,5          ; R12                               (IN)             PIN
#define           DS1_2              PORTB,4          ;DS1_2                              (IN)             PIN
#define           STOP_SW            PORTB,5          ; INPUT                             (IN)              PIN
#define           DS1_4              PORTB,6          ; DS1_4                             (X)               PIN      
#define           CN6_2_OP1            PORTB,7          ; CN6_2, OP1                        (X)               PIN
#define           DS1_1              PORTC,0          ; DS1_1                             (IN)              PIN
#define           MM5451_CLK         PORTC,1          ;MM5451_                            (OUT)             PIN
#define           MM5451_DATA        PORTC,2          ;MM5451_                            (OUT)             PIN
#define           STOP_SW            PORTC,3          ; C17                               (X)               PIN
#define           STOP_SW            PORTC,4          ;GND                                (X)               PIN
#define           STOP_SW            PORTC,5          ;R11                                (X)               PIN
#define           CN6_4            PORTC,6          ;CN6_4                              (X)               PIN
#define            CN6_3             PORTC,7          ;CN6_3                              (X)               PIN


CBLOCK 0x20
W_REG
RLY_BITS
AUX
DIG1
DIG2
DIG3
DIG4
END


ORG 0H

 goto INICIO

ORG 4H
goto ISR



;-------------------------------------------------------------------------------------------------------------
;INICIO
call  CONFIG_PUERTOS
call  LEDTEST
call  DPY
WAIT call MUESTREO
 GOTO WAIT
END


;-------------------------------------------------------------------------------------------------------------
;CONFIGURACION DE PUERTOS

movlw b'00000110'  ;sets 4 sec cycle
   movwf OPTION_REG

movlw b'10100000'  ;sets up the TMR0 interrupt
         movwf INTCON 

BCF		STATUS,RP1
			BSF		STATUS,RP0		;BANK 1
			MOVLW	06H
			MOVWF	ADCON1
			MOVLW	B'00000001'
			MOVWF	OPTION_REG			
			BCF		STATUS,RP0		;BANK 0
			BSF		INTCON,TMR0IE
			BSF		INTCON,GIE

CONFIG_PUERTOS

 bsf STATUS,RP0 ; pongo rp0 a 1 y paso al banco1

movlw b'11111111' ; cargo W con 11111

movwf trisa ; y paso el valor a trisa movlw b'00000000' ; cargo W con 00000000
movlw b'11111111'
movwf trisb ; y paso el valor a trisb

movlw b'11111111'
movwf trisc
movlw b'11111111'
movwf ADCON

bcf estado,5 ; pongo rp0 a 0 y regreso al banco0
clrf PORTA
clrf PORTB
clrf PORTC
return

MUESTREO

return
TRISA
TRISB
TRISC
;CONFIGURAR ADC
;CONFIGURAR TMR0
;CLARIFICAR PUERTOS
;BANK1
;CONFIGURAR TRIS
;BANK0
STATUS
PORTA
PORTB
PORTC
;------------------------------------------------------------------------------------------------------------
;ENVIARLETRA
ENVIAR_LETRA
movf DIG0,w
movwf DIG
call DESPLIEGUE
movf DIG1,w
movwf DIG
call DESPLIEGUE
movf DIG2,w
movwf DIG
call DESPLIEGUE
movf DIG3,w
movwf DIG
call DESPLIEGUE
return
;------------------------------------------------------------------------------------------------------------
;PROBAR DISPLAY 8888

LEDTEST

call 8888_WORD
call ENVIAR_WORD
call retardo 2 seg
call CLR_WORD
return





;----------------------------------------------------------------------------------------------------------
ISR
GIE PEIE T0IE PIE1 PIE2
ISR
movwf W_REG
btfsc INTCON, ADCINT
call TIMER_0
call TIMER_1
call ADC_SENSE
btfsc INTCON,TMR0
call COMP_RLY
swapwf W_REG,F
swapf W_REG,w
retfie
retfie
;-------------------------------------------------------------------------------------------------------------


;MUESTREO
btfsc STOP_SW
goto SET_CHRG
goto SET_STOP




;---------------------------------------------------------------------------------------------------------
;COMPARAR ADC
movf ADRESSLOW,w
subwf ADRESSLOW,W
btfss STATUS,C
goto SET_CHRG
goto SET_STOP

SET_STOP
bcf RLY
bcf INTCON,TMR0
call STOPWORD
call DESPLIEGUE



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

rrf DIG,f
btfss DIG,0h
goto 
bcf MM5451_DAT
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
8888_WORD
movlw DIG_8
movwf DIG1
movwf DIG2
movwf DIG3
movwf DIG4
return
;---------------------------------------------------------------------------------------------------------------





RETARDO
RLYOFF
SOP_WORD
RLYON




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
CARGAR DIGITO
ENVIAR_BIT
ROTACION1-8



TMR0
PCL
INTCON

ADCON0
ADRESH
ADRESL
ADCON1
ANSEL










movlw  b'11111111'
movwf ADCON






COMP_RLY
btfss RLYCHRG
goto RLYSET
goto RLYCLEAR
RLYSET bsf RLYCHRG
return
RLYCLEAR bcf RLYCHRG
return
DESPLIEGUE
btfss DIG,0h
goto CLRCLOCK
goto SETCLOCK
SETCLOCK
bsf DATABIT
bsf CLK
return
SETPOINT
AUX

;---------------------------------------------------------------------------------------------------------------------------
STOP_WORD
movlw S_DIG
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
ENVIAR_LETRA ;ENVIAR_BIT
movwf DIG
movlw 0x07
movwf AUX
subwf
btfss

bsf MM5414_DT
bcf MM5414_DT

bsf MM5414_CK
bcf MM5414_CK
call retardo
return
;------------------------------------------------------------------------------------------------------------------------------












;Datasheet, instruction set, pin diagram, block diagram, file map, bank0, directivas, flowchart, easyeda, device list

;arduino, ccs c, pic simulator, proteus, mplab, programmer, P16F690 LIST, Retardos.inc, partsim, piccompileronline

; mpasm, picsimlab, tablas, cloud,

 




;-------------------------------------------------------------------------------------------------------------------------------


STOP_SW
SET_CRGH
SET_STOP

RLYA

RLYB

STOP

 SENSE

EQU

#DEFINE

;------------------------------------------------------------------------------------------------------------------------------------

__CONFIG _INTRC_OSC_NOCLKOUT 

__CONFIG   _CP_OFF & _DATA_CP_OFF & _LVP_OFF & _BOREN_OFF & _MCLRE_ON & _WDT_OFF & _PWRTE_ON & _INTOSC_OSC_NOCLKOUT

CBLOCK    ;DECLARACION DE VARIABLE Y CONSTANTES

ENDC


inicio

 

 

call STOP

 

call CHRG 



 

DPY

bsf

call retardo

bcf

return

 STOP

call retardo

call dpy

return

DT

end



return

DESPLIEGUE

return



;


 
GOTO
CALL DPY

PRUEBA DPY


ADRESH
ADRESL
ADCON
ANSEL







NOMBRE

btfsc
b'11111111'

movlw
movwf

PORTA
PORTB
PORTC

TRISA
TRISB
TRISC

ADCON

ADRESH
ADRESL

