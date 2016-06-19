`timescale 1ns / 1ps

module Image_ROM(
    input [13:0] address,
    output reg [2:0] data
    );

	 reg [2:0] content [0:11159];
	 
	 always @ (address)
	 begin
		data = content[address];
	 end
	 
	 initial
	 begin
		$readmemh("samus.mif", content, 0, 11159);
	 end
endmodule
