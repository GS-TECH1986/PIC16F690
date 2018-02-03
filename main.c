#include <16F690.h>
#use delay(crystal=4MHz)
#fuses

#device ADC=10


#define LED PIN_A2
#define DELAY 1000
#define PIN_A0 MM5451






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
