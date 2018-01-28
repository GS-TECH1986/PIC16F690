INT8

set_adc_channel0(0)
q=read_adc
#define PIN_A0 MM5451

#fuses
#use delay
#include <main2.h>
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
