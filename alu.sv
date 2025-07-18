
//
// alu.sv : unidade logica-aritmetica p/ algumas instrucoes
//
// Simulação: 


module alu(input  logic [31:0] a, b,
           input  logic [2:0]  alucontrol,
           output logic [31:0] result,
           output logic        zero);//flag de zero

  logic [31:0] condinvb, sum;
  logic        v;              // overflow - considera num com sinal
  logic        isAddSub;       // true when is add or subtract operation

  assign condinvb = alucontrol[0] ? ~b : b;//condivb = se o bit 0 do sinal de controle for 1 o b é invertido
  assign sum = a + condinvb + alucontrol[0];//soma e subtração
  assign isAddSub = ~alucontrol[2] & ~alucontrol[1] |//testando para saber qual operação está sendo feita
                    ~alucontrol[1] & alucontrol[0];

  always_comb
    case (alucontrol)
      3'b000:  result = sum;         // add
      3'b001:  result = sum;         // subtract
      3'b010:  result = a & b;       // and
      3'b011:  result = a | b;       // or
		3'b100:	result = a ^ b;		//xor
		3'b110:	result = a * b;		//mul
      3'b101:  result = sum[31] ^ v; // slt
      default: result = 32'bx;
    endcase

  assign zero = (result == 32'b0);
  assign v = ~(alucontrol[0] ^ a[31] ^ b[31]) & (a[31] ^ sum[31]) & isAddSub;//se retornar v = 1 deu overflow
  
endmodule
