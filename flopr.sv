
//
// flopr.sv : registrador flip-flop c/ reset
//
// Simulação: Waverform5.vwf
//


module flopr #(parameter WIDTH = 8)
				(input logic clk, reset,
				input logic [WIDTH-1:0] d,
				output logic [WIDTH-1:0] q);
				
	always_ff @(posedge clk, posedge reset)
	//Reset subiu q = 0
		if (reset) q <= 0;
	//Caso contrário, q = d 
		else q <= d;
		
endmodule