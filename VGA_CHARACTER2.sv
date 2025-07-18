// Copyright (C) 1991-2013 Altera Corporation
// Your use of Altera Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License 
// Subscription Agreement, Altera MegaCore Function License 
// Agreement, or other applicable license agreement, including, 
// without limitation, that your use is for the sole purpose of 
// programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the 
// applicable agreement for further details.

// PROGRAM		"Quartus II 64-Bit"
// VERSION		"Version 13.0.1 Build 232 06/12/2013 Service Pack 1 SJ Web Edition"
// CREATED		"Tue Aug 15 14:16:45 2023"

module VGA_CHARACTER2(
	Clock_50Mhz,
	VGA_Red,
	VGA_Green,
	VGA_HSync,
	VGA_VSync,
	VGA_Blue,
	MemWrite_Recebido,
	PC_Recebido,
	Inst_Recebido);


input wire	Clock_50Mhz;
output wire	VGA_Red;
output wire	VGA_Green;
output wire	VGA_HSync;
output wire	VGA_VSync;
output wire	VGA_Blue;
input wire MemWrite_Recebido;
input wire[31:0] PC_Recebido;
input wire[31:0] Inst_Recebido;


wire	[9:0] Pixel_column;
wire	[9:0] Pixel_row;
wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_4;
wire	SYNTHESIZED_WIRE_3;


							
							

assign	SYNTHESIZED_WIRE_0 = 1;

wire [6:0] charAdressRecebido;
//wire	[9:0] Pixel_row_fixed;
//assign Pixel_row_fixed= 10'b0000010000;

VGA_SYNC	b2v_1(
	.red(SYNTHESIZED_WIRE_0),
	.green(SYNTHESIZED_WIRE_4),
	.blue(SYNTHESIZED_WIRE_4),
	.clock_50Mhz(Clock_50Mhz),
	.red_out(VGA_Red),
	.green_out(VGA_Green),
	.blue_out(VGA_Blue),
	.horiz_sync_out(VGA_HSync),
	.vert_sync_out(VGA_VSync),
	
	.pixel_clock(SYNTHESIZED_WIRE_3),
	.pixel_column(Pixel_column),
	.pixel_row(Pixel_row));


Char_ROM	b2v_inst(
	.clock(SYNTHESIZED_WIRE_3),
	.character_address(charAdressRecebido),
	.font_col(Pixel_column[3:1]),
	.font_row(Pixel_row[3:1]),
	.rom_mux_output(SYNTHESIZED_WIRE_4));


riscv_output saida(.pixelRow(Pixel_row),
						 .pixelColumn(Pixel_column), 
						 .characterAddress(charAdressRecebido),
						 .MW_IN(MemWrite_Recebido),
						 .PC_IN(PC_Recebido),
						 .INST_IN(Inst_Recebido));  
	
endmodule

