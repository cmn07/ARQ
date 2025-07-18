
//
// imem.sv : memoria de instrucoes
//
// Simulacao: Waverform7.vwf
//
// Funciona como memora ROM (read-only), 
//  sendo inicializado com as instrucoes contidas 
//  no arquivo riscvtes.txt (apenas p/ simulacao)
//
// Capacidade de armazenamento: 64 posicoes de 32 bits.)
//

module imem(input logic [31:0] a,
				output logic [31:0] rd);
	
	logic [31:0] RAM[63:0];
	
	//initial
	//	$readmemh("riscvtest.txt",RAM);
	

initial begin
    RAM[0]  = 32'h00a00093; // addi x1, x0, 10
    RAM[1]  = 32'h01400113; // addi x2, x0, 20
    RAM[2]  = 32'h002081b3; // add x3, x1, x2
    RAM[3]  = 32'h40110233; // sub x4, x2, x1
    RAM[4]  = 32'h0020f2b3; // and x5, x1, x2
    RAM[5]  = 32'h06400313; // addi x6, x0, 100
    RAM[6]  = 32'h00332023; // sw x3, 0(x6)
    RAM[7]  = 32'h00032383; // lw x7, 0(x6)
    RAM[8]  = 32'h00338463; // beq x7, x3, +12 bytes (para RAM[11])
    RAM[9]  = 32'h06300413; // addi x8, x0, 99 (não executa se branch funcionar)
    RAM[11] = 32'h00100493; // addi x9, x0, 1 (label)
    RAM[12] = 32'h0080006f; // jal x0, +4 bytes (para RAM[14])
    RAM[13] = 32'h3e700513; // addi x10, x0, 999 (não executa)
    RAM[14] = 32'h04d00593; // addi x11, x0, 77 (end)
    RAM[15] = 32'h00000063; // beq x0, x0, loop (loop infinito)
end



  
    
	
	assign rd = RAM[a[31:2]]; // word aligned

endmodule

/*
module imem(input logic [31:0] a,
            output logic [31:0] rd);
    
    logic [31:0] RAM[63:0];
    /*
    // ---------------------
    // TESTE BNE
    // ---------------------
    initial begin
		RAM[0]  = 32'h00100093; // addi x1, x0, 1
		RAM[1]  = 32'h00200113; // addi x2, x0, 2
		RAM[2]  = 32'h00000193; // addi x3, x0, 0
		RAM[3]  = 32'h00209463; // bne  x1, x2, +2
		RAM[4]  = 32'h06318193; // addi x3, x3, 99 (não executa)
		RAM[5]  = 32'h02a18193; // addi x3, x3, 42  (pular:)
		RAM[6]  = 32'h00000063; // beq  x0, x0, loop (loop infinito)

    end
	 
	 
	 
	 
    // ---------------------
    // TESTE LB
    // ---------------------
    initial begin
		RAM[0] = 32'h06400093; // addi x1, x0, 100
		RAM[1] = 32'h07F00113; // addi x2, x0, 127
		RAM[2] = 32'h00208023; // sb   x2, 0(x1)
		RAM[3] = 32'h00008183; // lb   x3, 0(x1)
		RAM[4] = 32'h08000213; // addi x4, x0, 128
		RAM[5] = 32'h004080A3; // sb   x4, 1(x1)
		RAM[6] = 32'h00108283; // lb   x5, 1(x1)
		RAM[7] = 32'h00000063; // beq  x0, x0, loop (loop infinito)


    end
    
    
    // ---------------------
    // TESTE 1: MUL, XOR, LB, BNE
    // ---------------------
    initial begin
	 
        RAM[0]  = 32'h00500093; // addi x1, x0, 5
        RAM[1]  = 32'h00300113; // addi x2, x0, 3
        RAM[2]  = 32'h022181b3; // mul  x3, x1, x2
        RAM[3]  = 32'h0011c233; // xor  x4, x3, x1
        RAM[4]  = 32'h06400293; // addi x5, x0, 100
        RAM[5]  = 32'h0042a023; // sw   x4, 0(x5)
        RAM[6]  = 32'h00028303; // lb   x6, 0(x5)
        RAM[7]  = 32'h00031463; // bne  x6, x0, +2
        RAM[8]  = 32'h06300393; // addi x7, x0, 99 (não executa)
        RAM[9]  = 32'h02a00393; // addi x7, x0, 42 (pular:)
        RAM[10] = 32'h0072a223; // sw   x7, 4(x5)
        RAM[11] = 32'h00428403; // lb   x8, 4(x5)
        RAM[12] = 32'h006444b3; // xor  x9, x8, x6
        RAM[13] = 32'h02148533; // mul  x10, x9, x1
        RAM[14] = 32'h00a2a423; // sw   x10, 8(x5)
        RAM[15] = 32'h00000063; // loop: beq x0, x0, loop
    end
	

    
    // ---------------------
    // TESTE 2: VARIAÇÃO
    // ---------------------
    initial begin
		 RAM[0]  = 32'h00800093; // addi x1, x0, 8
		 RAM[1]  = 32'h00400113; // addi x2, x0, 4
		 RAM[2]  = 32'h022081b3; // mul  x3, x1, x2  
		 RAM[3]  = 32'h0011c233; // xor  x4, x3, x1
		 RAM[4]  = 32'h0c000293; // addi x5, x0, 200
		 RAM[5]  = 32'h0042a023; // sw   x4, 0(x5)
		 RAM[6]  = 32'h00028303; // lb   x6, 0(x5)
		 RAM[7]  = 32'h00031463; // bne  x6, x0, +? (offset para 0x24)
		 RAM[8]  = 32'h06300393; // addi x7, x0, 99 (não executa)
		 RAM[9]  = 32'h002343b3; // xor  x7, x6, x2 (salta:)
		 RAM[10] = 32'h0072a223; // sw   x7, 4(x5)
		 RAM[11] = 32'h00428403; // lb   x8, 4(x5)
		 RAM[12] = 32'h022404b3; // mul  x9, x8, x2
		 RAM[13] = 32'h0092a423; // sw   x9, 8(x5)
		 RAM[14] = 32'h0014c533; // xor  x10, x9, x1
		 RAM[15] = 32'h00a2a623; // sw   x10, 12(x5)
		 RAM[16] = 32'h00000063; // loop: beq x0, x0, loop
	end
    
	 
	 

    assign rd = RAM[a[31:2]]; // word aligned

endmodule

*/
