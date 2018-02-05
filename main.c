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
#define   RL1	PIN_A0 //; C3, 1KHZ, ACTIVACION RL1          (OUT)            PIN 19
#define   RL2	PIN_A1//; C4, 1KHZ, ACTIVACION RL2          (OUT)            PIN 18
#define   NC1	PIN_A2//; NO CONNECTION                     (IN/OUT)         PIN 17
#define   XT1_1	 PIN_A3//; C16,XT1                           (IN)             PIN 4
#define   XT1_2	PIN_A4//; C15,XT1                           (IN)             PIN     3  
#define   STOP_SW PIN_A5	//; R12                               (IN)             PIN 2

#define   DS1_2	PIN_B4 //;DS1_2                              (IN)             PIN 13
#define   INPUT	PIN_B5 //; INPUT                             (IN)              PIN 12
#define   DS1_4	 PIN_B6//; DS1_4                             (X)               PIN  11 
#define   CN6_2_OP1 PIN_B7	// ; CN6_2, OP1                        (X)               PIN 10

#define   DS1_1	PIN_C0	//; DS1_1                             (IN)              PIN 16
#define   MM5451_CLK	PIN_C1 //;MM5451_                            (OUT)             PIN 15
#define   MM5451_DATA PIN_C2	//;MM5451_                            (OUT)             PIN 14
#define  C17		PIN_C3 //; C17                               (X)               PIN 7
#define   PORTGND	PIN_C4	//;GND                                (X)               PIN 6
#define  R11		PIN_C5 //;R11                                (X)               PIN 5
#define   CN6_4		PIN_C6 //;CN6_4                              (X)               PIN 8
#define  	FULL	PIN_C7 //;CN6_3                              (IN)               PIN 9       
//;1-VCC,20-GND




INT8

set_adc_channel0(0)
q=read_adc

#include <18F46K22.h> 
#fuses INTRC_IO, NOWDT, BROWNOUT, PUT, NOPBADEN 
#use delay(clock=4M) 
#use rs232(baud=9600, UART1, ERRORS) 

//====================================== 
void main() 
{      
int8 i; 
int8 my_array[] = 0x12,0x34,0x56,0x78; 

for(i=0; i < sizeof(my_array); i++) 
    printf("%x ", my_array[sizeof(my_array) -1 -i]); 
  
while(TRUE); 
}




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
