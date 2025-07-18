
//
// regfile.sv : registrador flip-flop c/ reset
//
// Simulação: Waverform6.vwf
//
// Arquivo de registradores de três portas
// -lê duas portas combinacionalmente (a1/rd1, a2/rd2)
// -grava a terceira porta na borda de subida do clock (a3/wd3/we3)
// -registrador 0 conectado a 0 (retorna sempre zero como leitura)
//
// Capacidade de armazenamento: 32 registradores de 32 bits.)
//


module regfile(input logic clk,
					input logic we3,
					input logic [5:0] a1, a2, a3,
					input logic [31:0] wd3,
					output logic [31:0] rd1, rd2);
	
	logic [31:0] rf[31:0];
	
	always_ff @(posedge clk)
		//se we3 subiu salva o valor, pega a referência de a3 e salva no vetor 
		if (we3) 
			rf[a3] <= wd3;
	
	//rd1 corresponde aos valores recebidos em a1 e rd2 aos valores de 2
	assign rd1 = (a1 != 0) ? rf[a1] : 0;
	assign rd2 = (a2 != 0) ? rf[a2] : 0;

endmodule