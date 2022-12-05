module PWM_LED
(
	input wire clk_osc,
	input wire btn0,
	output wire led0
);

assign button_pos = ~btn0;

wire pwm_clk;
wire inc_clk;

pll0 main_clk_pll
(
	.areset (button_pos),
	.inclk0 (clk_osc),
	.c0 (pwm_clk),
	.c1 (inc_clk)
);

parameter pwm_bits = 12;

pwm_driver
#(
	.pwm_bits(pwm_bits)
) pd0
(
	.clk_inc(inc_clk),
	.clk_pwm(pwm_clk),
	.btn0(button_pos),
	.led(led0),
//	.data_out()
);

endmodule
