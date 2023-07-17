//------------------------------------------------------------------------------
// Company: 		 UIUC ECE Dept.
// Engineer:		 Stephen Kempf
//
// Create Date:    
// Design Name:    ECE 385 Lab 5 Given Code - SLC-3 top-level (Physical RAM)
// Module Name:    SLC3
//
// Comments:
//    Revised 03-22-2007
//    Spring 2007 Distribution
//    Revised 07-26-2013
//    Spring 2015 Distribution
//    Revised 09-22-2015 
//    Revised 06-09-2020
//	  Revised 03-02-2021
//------------------------------------------------------------------------------


module slc3(
	input logic [9:0] SW,
	input logic	Clk, Reset, Run, Continue,
	output logic [9:0] LED,
	input logic [15:0] Data_from_SRAM,
	output logic OE, WE,
	output logic [6:0] HEX0, HEX1, HEX2, HEX3,
	output logic [15:0] ADDR,
	output logic [15:0] Data_to_SRAM
);

// An array of 4-bit wires to connect the hex_drivers efficiently to wherever we want
// For Lab 1, they will direclty be connected to the IR register through an always_comb circuit
// For Lab 2, they will be patched into the MEM2IO module so that Memory-mapped IO can take place
logic [3:0] hex_4[3:0]; 

// never changed this?
HexDriver hex_drivers[3:0] (hex_4, {HEX3, HEX2, HEX1, HEX0});
// batch converting 16 bits to hex displays (4 7 bit vectors - 7 segment display, takes hex values and converts them to something on the board)
// This works thanks to http://stackoverflow.com/questions/1378159/verilog-can-we-have-an-array-of-custom-modules


// Internal connections
logic LD_MAR, LD_MDR, LD_IR, LD_BEN, LD_CC, LD_REG, LD_PC, LD_LED;
logic GatePC, GateMDR, GateALU, GateMARMUX; // when are they becoming 1/0; if they are they can be used as control signals ?
logic SR2MUX, ADDR1MUX, MARMUX; // control signals
logic BEN, MIO_EN, DRMUX, SR1MUX; // control signals
logic [1:0] PCMUX, ADDR2MUX, ALUK;
logic [15:0] MDR_In;
logic [15:0] MAR, MDR, IR;


//                      LOCAL VARIABLES
//////////////////////////////////////////////////////////////////////////////////////////////////////

logic [15:0] BUS;
logic [15:0] PC_Output, MARMUX_Output, MDR_Output, ALU_Result; // output coming through each tri-state buffer 
logic [15:0] PCREG_IN, MARREG_IN, MDRREG_IN;
logic [15:0] address1, address2;
logic [2:0] DRMUX_Output, SR1MUX_Output;
logic [15:0] SR2MUX_Output;
logic [15:0] SR1, SR2;



//                      TRI STATE MUX LOGIC WITHOUT USING A MUX
///////////////////////////////////////////////////////////////////////////////////////////////////////

always_comb
begin

if (GatePC) 
	BUS = PC_Output;


else if (GateMARMUX) 
	BUS = address1 + address2; 
	

else if (GateMDR) 
	BUS = MDR;
	
	
else if (GateALU) 
	BUS = ALU_Result;

else
	BUS = 16'hxxxx;
	
			
end


//                                     MUXES
/////////////////////////////////////////////////////////////////////////////////////////////////////////

PCMUX PCM(.select_bits(PCMUX), // REPEATED VAR
			 .incremented_PC(PC_Output + 16'b0000000000000001), .BUS_input(BUS), .ADDED_addr_input(address1 + address2),
		    .output_PCMUX(PCREG_IN));
		 
MIOMUX MIOM(.BUS_input(BUS), .Data_CPU_In(MDR_In), // REPEATED VAR
		      .MIO_en(MIO_EN),
		      .output_MIOMUX(MDRREG_IN));
				
ADDR1MUX ADDR1M(.input_PC(PC_Output), .input_SR1(SR1),
					 .ADDR1MUXselect(ADDR1MUX),
					 .output_ADDR1MUX(address1));
					  
ADDR2MUX ADDR2M(.input_IRSEXT6( {{10{IR[5]}}, IR[5:0]} ), .input_IRSEXT9( {{7{IR[8]}}, IR[8:0]} ), 
					 .input_IRSEXT11({{5{IR[10]}}, IR[10:0]} ),
					 .ADDR2MUXselect(ADDR2MUX),
					 .output_ADDR2MUX(address2));
					  
DRMUX DRM(.input_IR11to9(IR[11:9]),
			 .DRMUXselect(DRMUX),
			 .output_DRMUX(DRMUX_Output));
			 
SR1MUX SR1M(.input_IR11to9(IR[11:9]), .input_IR8to6(IR[8:6]),
			   .SR1MUXselect(SR1MUX),
			   .output_SR1MUX(SR1MUX_Output));	 

SR2MUX SR2M(.input_SR2(SR2), .input_IRSEXT5( {{11{IR[4]}}, IR[4:0]} ),
		      .SR2MUXselect(IR[5]),
		      .output_SR2MUX(SR2MUX_Output));

						
//                                     REGISTERS
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		  
REGISTER PC_REGISTER(.Clk(Clk), .Reset(Reset), .Load(LD_PC), // DO WE SEND CLK AND RESET IN FROM OUR SYNCHRONIZER OR MAIN MODULE?
                     .D(PCREG_IN),
                     .Data_Out(PC_Output));
							
REGISTER MAR_REGISTER(.Clk(Clk), .Reset(Reset), .Load(LD_MAR),
                      .D(BUS),
                      .Data_Out(MAR)); // NO ZEXT IN SLC3
							 
REGISTER MDR_REGISTER(.Clk(Clk), .Reset(Reset), .Load(LD_MDR),
                      .D(MDRREG_IN),
                      .Data_Out(MDR)); 
		  
REGISTER IR_REGISTER(.Clk(Clk), .Reset(Reset), .Load(LD_IR),
                     .D(BUS),
                     .Data_Out(IR)); 

REGISTER_FILE  REGFILE_MAIN(.input_fromBUS(BUS), 
									 .DR_info(DRMUX_Output), .SR2_info(IR[2:0]), .SR1_info(SR1MUX_Output),
									 .reset_registerfile(Reset), .load_registerfile(LD_REG), .Clk(Clk),
								    .SR1OUT(SR1), .SR2OUT(SR2));
					

//                                  COMPUTATIONAL UNITS		
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

ALU ALUmain(.ALUcontrolpins(ALUK),
				.A(SR1), .B(SR2MUX_Output),
				.ALU_output(ALU_Result));
				
				
BEN ben(.Clk(Clk), .Reset(Reset), .LD_CC(LD_CC), .LD_BEN(LD_BEN), .bus_in(BUS), .IR(IR[11:9]), .Dout(BEN));
																		 
// 							 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////		 
									 
							
									 
// Connect MAR to ADDR, which is also connected as an input into MEM2IO
//	MEM2IO will determine what gets put onto Data_CPU (which serves as a potential
//	input into MDR)
assign ADDR = MAR; 
assign MIO_EN = OE;
// Connect everything to the data path (you have to figure out this part)

//datapath d0 (.*);


// Our SRAM and I/O controller (note, this plugs into MDR/MAR)

//logic [3:0] hexa,hexb,hexc,hexd;

Mem2IO memory_subsystem(
    .*, .Reset(Reset), .ADDR(ADDR), .Switches(SW),
    .HEX0(hex_4[0][3:0]), .HEX1(hex_4[1][3:0]), .HEX2(hex_4[2][3:0]), .HEX3(hex_4[3][3:0]),
//  .HEX0(), .HEX1(), .HEX2(), .HEX3(), ONLY USED FOR 5.1
    .Data_from_CPU(MDR), .Data_to_CPU(MDR_In),
    .Data_from_SRAM(Data_from_SRAM), .Data_to_SRAM(Data_to_SRAM)
);


// State machine, you need to fill in the code here as well
ISDU state_controller(
	.*, .Reset(Reset), .Run(Run), .Continue(Continue),
	.Opcode(IR[15:12]), .IR_5(IR[5]), .IR_11(IR[11]),
   .Mem_OE(OE), .Mem_WE(WE)
);


// loading LEDs with right values
///////////////////////////////////////////////////////////

always_comb 
begin 
	//LED = IR[9:0];
	case(LD_LED)
	1'b0: LED = 10'b0;
	1'b1: LED = IR[9:0];
	endcase
end


// SRAM WE register
//logic SRAM_WE_In, SRAM_WE;
//// SRAM WE synchronizer
//always_ff @(posedge Clk or posedge Reset_ah)
//begin
//	if (Reset_ah) SRAM_WE <= 1'b1; //resets to 1
//	else 
//		SRAM_WE <= SRAM_WE_In;
//end
//
//assign _4 [0] = IR[3:0];
//assign hex_4 [1] = IR[7:4];
//assign hex_4 [2] = IR[11:8];
//assign hex_4 [3] = IR[15:12];

	
endmodule
