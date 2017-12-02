
__CONFIG   _CP_OFF & _DATA_CP_OFF & _LVP_OFF & _BOREN_OFF & _MCLRE_ON & _WDT_OFF & _PWRTE_ON & _INTOSC_OSC_NOCLKOUT

;Datasheet, instruction set, pin diagram, block diagram, file map, bank0, directivas, flowchart, easyeda, device list

;arduino, ccs c, pic simulator, proteus, mplab, programmer, P16F690 LIST, Retardos.inc, partsim, piccompileronline

; mpasm, picsimlab, tablas, cloud,

 

         ;NOMBRE CARGADOR TOTALIFT

      ;FECHA: 01/12/17

;DEVICE: PIC16F690

 INCLUDE

List p=16f877a

RADIX hex

;-------------------------------------------------------------------------------------------------------------------------------

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





EQU

CBLOCK

END

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
RETARDOS.INC
ADRESH
ADRESL

