;--------------------------------------------------------------------------------------------------------------
;ENCABEZADO
;

         ;NOMBRE CARGADOR TOTALIFT 36V

      ;FECHA: 01/12/17

;DEVICE: PIC16F690

;
;
;
;
;
;--------------------------------------------------------------------------------------------------------------
;DECLARACION DE VARIABLES Y CONSTANTES



__CONFIG   _CP_OFF & _DATA_CP_OFF & _LVP_OFF & _BOREN_OFF & _MCLRE_ON & _WDT_OFF & _PWRTE_ON & _INTOSC_OSC_NOCLKOUT
 INCLUDE

List p=16f690

RADIX hex

RETARDOS.INC
             








       

8_DIG     EQU B'XXXXXXXX'
S_GIG     EQU B'XXXXXXXX'
T_DIG     EQU B'XXXXXXXX'
O_DIG     EQU B'XXXXXXXX'
P_DIG     EQU B'XXXXXXXX'
C_DIG     EQU B'XXXXXXXX'
H_DIG     EQU B'XXXXXXXX'
R_DIG     EQU B'XXXXXXXX'
G_DIG     EQU B'XXXXXXXX'
             
RL1_BIT
RL2_BIT
DS1_1
DS1_2
DS1_3
DS1_4
CN6_2
CN6_3
CN6_4
MM5451_CLK
MM5451_DATA
#define RL1     PORTA,0 ; C3, 1KHZ, ACTIVACION RL1
#define RL2     PORTA,1 ; C4, 1KHZ, ACTIVACION RL2
#define STOP_SW PORTA,2 ;
#define STOP_SW PORTA,3 ;
#define STOP_SW PORTA,4 ;
#define STOP_SW PORTA,5 ;
#define STOP_SW PORTB,4 ;
#define STOP_SW PORTB,5 ;
#define STOP_SW PORTB,6 ;
#define STOP_SW PORTB,7 ;
#define STOP_SW PORTC,0 ;
#define STOP_SW PORTC,1 ;
#define STOP_SW PORTC,2 ;
#define STOP_SW PORTC,3 ;
#define STOP_SW PORTC,4 ;
#define STOP_SW PORTC,5 ;
#define STOP_SW PORTC,6 ;
#define STOP_SW PORTC,7 ;


            
            
            #define STOP_SW PORT
       
       
       #define STOP_SW PORT
             #define STOP_SW PORT
             #define STOP_SW PORT
             #define STOP_SW PORT
             #define STOP_SW PORT
             #define STOP_SW PORT
             #define STOP_SW PORT
             #define STOP_SW PORT
             #define STOP_SW PORT

CBLOCK
DIG

END





;-------------------------------------------------------------------------------------------------------------
;INICIO






;-------------------------------------------------------------------------------------------------------------
;CONFIGURACION DE PUERTOS
CONFIG_PUERTOS

 bsf STATUS,RP0 ; pongo rp0 a 1 y paso al banco1

movlw b'11111' ; cargo W con 11111

movwf trisa ; y paso el valor a trisa movlw b'00000000' ; cargo W con 00000000

movwf trisb ; y paso el valor a trisb

movlw b'11111'

movwf ADCON

bcf estado,5 ; pongo rp0 a 0 y regreso al banco0

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
;----------------------------------------------------------------------------------------------------------
ISR
GIE PEIE T0IE PIE1 PIE2
ISR
movwf W_REG
btfsc INTCON, ADCINT
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
;----------------------------------------------------------------------------------------------------------
;DESPLIEGUE    ;enviar bit, generar relog, tomar digito



return






;--------------------------------------------------------------------------------------------------------------
RETARDO
RLYOFF
SOP_WORD
RLYON







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



SET_STOP
bcf RLY
bcf INTCON,TMR0
call STOPWORD
call DESPLIEGUE



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


STOP_WORD
movlw S_DIG
movwf DIG0
movlw S_DIG
movwf DIG0
movlw S_DIG
movwf DIG0
movlw S_DIG
movwf DIG0
return
CHRG_WORD
movlw S_DIG
movwf DIG0
movlw S_DIG
movwf DIG0
movlw S_DIG
movwf DIG0
movlw S_DIG
movwf DIG0

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

ORG 0H

 goto inicio

ORG 4H
goto isr

inicio

 call DPY

 

call STOP

 

call CHRG 

call LEDTEST

 

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

ENVIAR_LETRA

return

DESPLIEGUE

return



;


INICIO
GOTO
CALL DPY
SEND_STOP
SEND_CHRG
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

