module pwm_driver
#(
	parameter pwm_bits = 12
)
(
	input wire clk_inc,
	input wire clk_pwm,
	input wire btn0,
	output reg led,
	output wire [pwm_bits-1:0] data_out
);

reg overflow;
reg [pwm_bits-1:0] brightness_ctr;
reg [pwm_bits-1:0] compare_reg;
reg [pwm_bits-1:0] pwm_ctr;

always @(posedge clk_inc) begin
	{overflow, brightness_ctr} <= {overflow, brightness_ctr} + 1'b1;
	compare_reg <= brightness_ctr ^ {pwm_bits{overflow}};
end

assign data_out = compare_reg;

always @(posedge clk_pwm) begin
	pwm_ctr <= pwm_ctr + 1'b1;
	if(pwm_ctr < compare_reg)
		led <= 1'b0;
	else
		led <= 1'b1;
end

endmodule
