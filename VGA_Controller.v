`timescale 1ns / 1ps

module VGA_Controller(
    input clk25MHz,
    output reg hsync,
    output reg vsync,
    output reg [2:0] rgb
    );

parameter
	SCREEN_WIDTH = 640,
	SCREEN_HEIGHT = 480,
	IMAGE_WIDTH = 124,
	IMAGE_HEIGHT = 90,
	X_POS = (SCREEN_WIDTH - IMAGE_WIDTH)/2,
	Y_POS = (SCREEN_HEIGHT - IMAGE_HEIGHT)/2;

reg [9:0] hcount;
reg [9:0] vcount;

reg [13:0] current_address;
wire [2:0] data;
Image_ROM samus(.address(current_address), .data(data));

always @ (posedge clk25MHz)
begin
	if(hcount == 799)
	begin
		hcount <= 0;
		if(vcount == 524)
			vcount <= 0;
		else
			vcount <= vcount + 1;
	end
	else
		hcount <= hcount + 1;
	
	if(vcount >= 490 && vcount < 492)
		vsync <= 0;
	else
		vsync <= 1;
		
	if(hcount >= 656 && hcount < 752)
		hsync <= 0;
	else
		hsync <= 1;
		
	if(hcount < 640 && vcount < 480)
	begin
		if((hcount >= X_POS && hcount < X_POS + IMAGE_WIDTH) && (vcount >= Y_POS && vcount < Y_POS + IMAGE_HEIGHT))
		begin
			if(current_address < 11159)
				current_address <= current_address + 1;
			else
				current_address <= 0;
			
			rgb <= data;
		end
		else
		begin
			rgb <= 3'b000;
		end
	end
	else
	begin
		rgb <= 3'b000;
	end
end

initial
begin
	hcount = 0;
	vcount = 0;
	current_address = 0;
end

endmodule
