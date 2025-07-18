

module top(input  logic        clk, reset, 
           output logic [31:0] WriteData, DataAdr, 
           output logic        MemWrite,
			  output logic [31:0] PC_DBG,	//novos sinais de saída
			  output logic [31:0] Instr_DBG	//novo sinal de saida
			  );

  logic [31:0] PC, Instr, ReadData;
  
  // instantiate processor and memories
  riscvsingle rvsingle(clk, reset, PC, Instr, MemWrite, DataAdr, 
                       WriteData, ReadData);
					  
  imem imem(PC, Instr);
  
  dmem dmem(clk, MemWrite, DataAdr, WriteData, ReadData);
  
  assign PC_DBG = PC;
  assign Instr_DBG = Instr;
    
endmodule

