module datapath(
    input  logic        clk, reset,
    input  logic [1:0]  ResultSrc, 
    input  logic        PCSrc, ALUSrc,
    input  logic        RegWrite,
    input  logic [1:0]  ImmSrc,
    input  logic [2:0]  ALUControl,
    output logic        Zero,
    output logic [31:0] PC,
    input  logic [31:0] Instr,
    output logic [31:0] ALUResult, WriteData,
    input  logic [31:0] ReadData
);

  logic [31:0] PCNext, PCPlus4, PCTarget;
  logic [31:0] ImmExt;
  logic [31:0] SrcA, SrcB;
  logic [31:0] Result;

  // Lógica do próximo PC
  flopr #(32) pcreg(clk, reset, PCNext, PC); 
  adder       pcadd4(PC, 32'd4, PCPlus4);
  adder       pcaddbranch(PC, ImmExt, PCTarget);
  mux2 #(32)  pcmux(PCPlus4, PCTarget, PCSrc, PCNext);
  
  // Banco de registradores
  regfile rf(clk, RegWrite, Instr[19:15], Instr[24:20], 
             Instr[11:7], Result, SrcA, WriteData);
					  
  // Extensão de imediato
  extend ext(Instr[31:7], ImmSrc, ImmExt);

  // ALU
  mux2 #(32) srcbmux(WriteData, ImmExt, ALUSrc, SrcB);
  alu alu(SrcA, SrcB, ALUControl, ALUResult, Zero);

  // Lógica para diferenciar lw e lb
  logic [31:0] ReadDataFinal;
  
  always_comb begin
    case (Instr[14:12]) // funct3 da instrução (lb = 000, lw = 010)
      3'b000: ReadDataFinal = {{24{ReadData[7]}}, ReadData[7:0]}; // lb: extensão de sinal do byte
      3'b010: ReadDataFinal = ReadData;                           // lw: word já pronta
      default: ReadDataFinal = 32'hxxxxxxxx;
    endcase
  end
  
  // Seleção final do dado a ser gravado no registrador
  mux3 #(32) resultmux(ALUResult, ReadDataFinal, PCPlus4, ResultSrc, Result);

endmodule
