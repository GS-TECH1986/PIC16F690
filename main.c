//////// Program memory: 4096x14  Data RAM: 253  Stack: 8
//////// I/O: 18   Analog Pins: 12
//////// Data EEPROM: 256
//////// C Scratch area: 20   ID Location: 2000
//////// Fuses: LP,XT,HS,EC_IO,INTRC_IO,INTRC,RC_IO,RC,NOWDT,WDT,PUT,NOPUT
//////// Fuses: NOMCLR,MCLR,PROTECT,NOPROTECT,CPD,NOCPD,NOBROWNOUT
//////// Fuses: BROWNOUT_SW,BROWNOUT_NOSL,BROWNOUT,NOIESO,IESO,NOFCMEN,FCMEN
//////// 



#include <16F690.h>
#use delay(crystal=4MHz)
#fuses NOMCLR,PUT,PROTECT,CPD,INTRC_IO

#device ADC=10


#define LED PIN_A2
#define DELAY 1000
#define PIN_A0 MM5451
#define PIN_A0  40
#define PIN_A1  41
#define PIN_A2  42
#define PIN_A3  43
#define PIN_A4  44
#define PIN_A5  45

#define PIN_B4  52
#define PIN_B5  53
#define PIN_B6  54
#define PIN_B7  55

#define PIN_C0  56
#define PIN_C1  57
#define PIN_C2  58
#define PIN_C3  59
#define PIN_C4  60
#define PIN_C5  61
#define PIN_C6  62
#define PIN_C7 63





INT8

set_adc_channel0(0)
q=read_adc





#int_timer0
void main()
{
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
