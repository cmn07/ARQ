// aludec.sv : Decodificador da ALU
//

module aludec(input  logic       opb5,
              input  logic [2:0] funct3,
              input  logic       funct7b5, 
              input  logic [1:0] ALUOp,
              output logic [2:0] ALUControl);

  logic  RtypeSub;
  assign RtypeSub = funct7b5 & opb5;  // TRUE se for subtração do tipo R
  //aqui
  logic  RtypeMul;
  assign RtypeMul = (funct7b5 == 7'b0000001) && (funct3 == 3'b000);// se for multiplicação = TRUE

  always_comb
    case(ALUOp)
      2'b00:                ALUControl = 3'b000; // addition para load
      2'b01:                ALUControl = 3'b001; // subtraction para beq
      default: case(funct3) // R-type or I-type ALU
          3'b000:if (RtypeSub) 
							ALUControl = 3'b001; // sub para tipo R e I
						else if (RtypeMul)
							ALUControl = 3'b110; //mul
                  else          
							ALUControl = 3'b000; // add, addi para tipo R e I
			3'b010:    ALUControl = 3'b101; // slt, slti
			3'b100:	  ALUControl = 3'b100;//xor
			3'b110:    ALUControl = 3'b011; // or, ori
			3'b111:    ALUControl = 3'b010; // and, andi
       default:   ALUControl = 3'bxxx; // ???
       endcase
    endcase
endmodule