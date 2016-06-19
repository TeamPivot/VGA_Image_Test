`timescale 1ns / 1ps

module main(
    input clk,
	 output wire hsync,
	 output wire vsync,
	 output wire [2:0] rgb
    );

	wire vga_clk;
	// synthesis attribute CLKFX_DIVIDE of vga_clock_dcm is 4
	// synthesis attribute CLKFX_MULTIPLY of vga_clock_dcm is 2
	DCM vga_clock_dcm (.CLKIN(clk), .CLKFX(vga_clk));
	VGA_Controller vga(.clk25MHz(vga_clk), .hsync(hsync), .vsync(vsync), .rgb(rgb));

endmodule
