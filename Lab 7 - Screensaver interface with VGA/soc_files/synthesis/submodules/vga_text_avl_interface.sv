/************************************************************************
Avalon-MM Interface VGA Text mode display

Register Map:
0x000-0x0257 : VRAM, 80x30 (2400 byte, 600 word) raster order (first column then row)
0x258        : control register

VRAM Format:
X->
[ 31  30-24][ 23  22-16][ 15  14-8 ][ 7    6-0 ]
[IV3][CODE3][IV2][CODE2][IV1][CODE1][IV0][CODE0]

IVn = Draw inverse glyph
CODEn = Glyph code from IBM codepage 437

Control Register Format:
[[31-25][24-21][20-17][16-13][ 12-9][ 8-5 ][ 4-1 ][   0    ] 
[[RSVD ][FGD_R][FGD_G][FGD_B][BKG_R][BKG_G][BKG_B][RESERVED]

VSYNC signal = bit which flips on every Vsync (time for new frame), used to synchronize software
BKG_R/G/B = Background color, flipped with foreground when IVn bit is set
FGD_R/G/B = Foreground color, flipped with background when Inv bit is set

************************************************************************/
// NOT USING THEE REGISTERS ANYMORE:
//`define NUM_REGS 601 //80*30 characters / 4 characters per register
//`define CTRL_REG 600 //index of control register

module vga_text_avl_interface (
	// Avalon Clock Input, note this clock is also used for VGA, so this must be 50Mhz
	// We can put a clock divider here in the future to make this IP more generalizable
	input logic CLK,
	
	// Avalon Reset Input
	input logic RESET,
	
	// Avalon-MM Slave Signals
	input  logic AVL_READ,					// Avalon-MM Read
	input  logic AVL_WRITE,					// Avalon-MM Write
	input  logic AVL_CS,					// Avalon-MM Chip Select
	input  logic [3:0] AVL_BYTE_EN,			// Avalon-MM Byte Enable
	input  logic [11:0] AVL_ADDR,			// Avalon-MM Address
	input  logic [31:0] AVL_WRITEDATA,		// Avalon-MM Write Data
	output logic [31:0] AVL_READDATA,		// Avalon-MM Read Data
	
	// Exported Conduit (mapped to VGA port - make sure you export in Platform Designer)
	output logic [3:0]  red, green, blue,	// VGA color channels (mapped to output pins in top-level)
	output logic hs, vs						// VGA HS/VS
);

// logic [31:0] LOCAL_REG[`NUM_REGS]; // Registers

//put other local variables here

logic [9:0] i;
logic blank, sync, VGA_CLK;
logic [9:0] draw_x, draw_y, Drawx, Drawy; 
logic [11:0] row_major_index;
logic [10:0] row_major_address; 
logic offsetx;
logic [6:0] CHAR1;
logic invert, out;
logic [10:0] fontaddr;
logic [7:0] data;
logic [31:0] READ_A, READ_B;
logic [3:0] FG, BG;

logic [11:0] RGB;

logic [31:0] color_registers [8]; // packed unpacked array of 8 32-bit color registers 

//Declare submodules..e.g. VGA controller, ROMS, etc

vga_controller vga_c1(.Clk(CLK), .Reset(RESET), .vs(vs), .hs(hs), .pixel_clk(VGA_CLK), .blank(blank), .sync(sync), .DrawX(Drawx), .DrawY(Drawy));

font_rom fontROM1(.addr(fontaddr), .data(data));

ONCHIPMEM ramport(.address_a(AVL_ADDR), .address_b(row_major_address), .byteena_a(AVL_BYTE_EN),
						.clock(CLK), .data_a(AVL_WRITEDATA), .data_b(),
						.rden_a(AVL_READ), .rden_b(1), .wren_a(AVL_WRITE), .wren_b(0),
						.q_a(READ_A), .q_b(READ_B));
		

					

// input	[10:0]  address_a;
//	input	[10:0]  address_b;
//	input	[3:0]  byteena_a;
//	input	  clock;
//	input	[31:0]  data_a;
//	input	[31:0]  data_b;
//	input	  rden_a;
//	input	  rden_b;
//	input	  wren_a;
//	input	  wren_b;
//	output	[31:0]  q_a;
//	output	[31:0]  q_b;
//                    
	

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////   
// AVALON BUS SELECT LOGIC

always_ff @(posedge CLK) begin 
			
if (AVL_CS) begin 
	
			if (AVL_READ) begin 
			
				if (AVL_ADDR[11] == 1)				
					AVL_READDATA <= color_registers[AVL_ADDR[2:0]];
					
				else 
					AVL_READDATA <= READ_A;
				
			end
				
				
			if (AVL_WRITE) begin 
			
				if (AVL_ADDR[11] == 1)				
					color_registers[AVL_ADDR[2:0]] <= AVL_WRITEDATA;
					
				// else 
					
			end
			
		end // AVL_CS end

end // for always_ff block
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		


//handle drawing (may either be combinational or sequential - or both).

always_comb
begin
	draw_x = Drawx >> 3; // number of possible glyphs you can have as each register contains 4 glyphs on one row
	draw_y = Drawy >> 4; // depends on position of electron gun
	row_major_index = (draw_y*80 + draw_x); 
	row_major_address = row_major_index >> 1; // got index, now we divide by 2... which is SHIFTING BY 1... which gets rid of the offset and only keeps the address
	// so now we are sending this address to PORT 2 in order to read from it
	
	// regval = LOCAL_REG[row_major_address]; // 10 bit value
	offsetx = row_major_index[0];// row_major_index % 2; // this will keep the lower 1 BIT.... as a binary mod 2^n keeps the maintains the lower n bits and erases everything else to 0
	
	if(offsetx == 1'b0)
	begin
		invert = READ_B[15];
		CHAR1 = READ_B[14:8];
		FG = READ_B[7:4];
		BG = READ_B[3:0];
	end
	
	
	else // else if(offsetx == 1'b1)
	begin
		invert = READ_B[31];
		CHAR1 = READ_B[30:24]; // this is the FONTROM CODE... 7 BITS, 1 BIT FOR INVERT
		FG = READ_B[23:20];
		BG = READ_B[19:16];
	end
	
	// fontRom is another row major thing... 16 pixels per glyph
	
	fontaddr = (CHAR1 * 16 + (Drawy[3:0]));
	// glyph changes every 16 pixels on the y axis

	out = data[7 - Drawx[2:0]]; // this data comes back from the fontrom after sending in the fontaddr
	
	// glyph changes every 8 pixels on the x axis
	// this out is a single bit
	
	// only care about lower bits... since they act as counter... even if Drawx and Drawy keep increasing
	// until their upper bound of 640 and 480, we only care about the lower 4 bits as Drawy dynamically 
	// increases (every 16 rows) and the lower 3 bits as Drawx dynamically increases (every 8 columns)
	
end 

////////////////////////////////////////////////////////////////RGB SETTING BLOCK
//
//logic offset1;
//logic offset2;
//assign offset1 = BG[0];
//assign offset2 = FG[0];

always_ff @(posedge VGA_CLK) begin

// default cases
	red <= 4'b0000;
	blue <= 4'b0000;
	green <= 4'b0000;
	
	if (blank) begin 
	
		if (out ^ invert == 1'b0) begin
			//RGB <= color_registers[BG[3:1]][12 + (offset1*8): 1 + offset1*12]; // setting background colors
			if (BG[0] == 0)  
				RGB <= color_registers[BG[3:1]][12:1];

			else
				RGB <= color_registers[BG[3:1]][24:13];
		end
			
			
		else begin
			//RGB <= color_registers[FG[3:1]][12 + (offset2*8): 1 + offset2*12]; // setting foreground colors
			if (FG[0] == 0)  
				RGB <= color_registers[FG[3:1]][12:1];

			else
				RGB <= color_registers[FG[3:1]][24:13];
			
		end
		
// will this cause a clock cycle of delay since always_ff blocks are sequential?
		red <= RGB[11:8]; 
		green <= RGB[7:4];
		blue <= RGB[3:0];
		
	end
	

end

		
endmodule

