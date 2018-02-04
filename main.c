//////// Program memory: 4096x14  Data RAM: 253  Stack: 8
//////// I/O: 18   Analog Pins: 12
//////// Data EEPROM: 256
//////// C Scratch area: 20   ID Location: 2000
//////// Fuses: LP,XT,HS,EC_IO,INTRC_IO,INTRC,RC_IO,RC,NOWDT,WDT,PUT,NOPUT
//////// Fuses: NOMCLR,MCLR,PROTECT,NOPROTECT,CPD,NOCPD,NOBROWNOUT
//////// Fuses: BROWNOUT_SW,BROWNOUT_NOSL,BROWNOUT,NOIESO,IESO,NOFCMEN,FCMEN
//////// 
;--------------------------------------------------------------------------------------------------------------;:;
;NOMBRE CARGADOR TOTALIFT 36V BA30R0 5376R1
;FECHA: 01/12/17
;DEVICE: PIC16F690
;https://github.com/GS-TECH1986/PIC16F690/wiki
;--------------------------------------------------------------------------------------------------------------

;CN3: 1-GND, 2-36V, 3-JP3, 4-R15, 5-JP2, 6-JP1
;ICSP: VPP-4(C16,XT), VDD-1, GND-20, PDT-19, PCK,18




#include <16F690.h>
#use delay(crystal=4MHz)
#fuses NOMCLR,PUT,PROTECT,CPD,INTRC_IO

#device ADC=10


#define LED PIN_A2
#define DELAY 1000
#define PIN_A0  RL1	//; C3, 1KHZ, ACTIVACION RL1          (OUT)            PIN 19
#define PIN_A1  RL2	//; C4, 1KHZ, ACTIVACION RL2          (OUT)            PIN 18
#define PIN_A2  NC1	//; NO CONNECTION                     (IN/OUT)         PIN 17
#define PIN_A3  XT1_1	 //; C16,XT1                           (IN)             PIN 4
#define PIN_A4  XT1_2	//; C15,XT1                           (IN)             PIN     3  
#define PIN_A5  STOP_SW	//; R12                               (IN)             PIN 2

#define PIN_B4  DS1_2	//;DS1_2                              (IN)             PIN 13
#define PIN_B5  INPUT	//; INPUT                             (IN)              PIN 12
#define PIN_B6  DS1_4	//; DS1_4                             (X)               PIN  11 
#define PIN_B7  CN6_2_OP1	// ; CN6_2, OP1                        (X)               PIN 10

#define PIN_C0  DS1_1		//; DS1_1                             (IN)              PIN 16
#define PIN_C1  MM5451_CLK	//;MM5451_                            (OUT)             PIN 15
#define PIN_C2  MM5451_DATA	//;MM5451_                            (OUT)             PIN 14
#define PIN_C3  C17		//; C17                               (X)               PIN 7
#define PIN_C4  PORTGND		//;GND                                (X)               PIN 6
#define PIN_C5  R11		//;R11                                (X)               PIN 5
#define PIN_C6  CN6_4		 //;CN6_4                              (X)               PIN 8
#define PIN_C7 CN6_3		 //;CN6_3                              (X)               PIN 9        
//;1-VCC,20-GND




INT8

set_adc_channel0(0)
q=read_adc





#int_timer0
void main()
{
	while(TRUE)    // Endless loop
   {
     if(input(PIN_B0) == 0)
     {
       output_toggle(PIN_A0);
       delay_ms(500);
     }
     if(input(PIN_B1) == 0)
     {
       output_toggle(PIN_A1);
       delay_ms(500);
     }
   }
	SET_TRIS_A(0b00000000); 
	SET_TRIS_B(0b00000000); 
	SET_TRIS_C(0b00000000); 
	setup_adc_ports(sAN0);
	setup_adc(ADC_CLOCK_INTERNAL);
	setup_timer_0(RTCC_INTERNAL|RTCC_DIV_1|RTCC_8_BIT);		//256 us overflow


	while(TRUE)
	{

		//Example blinking LED program
		output_low(LED);
		delay_ms(DELAY);
		output_high(LED);
		delay_ms(DELAY);

		//TODO: User Code
	}

}
