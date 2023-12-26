module CU(OP_Code, RegDst, RegWr, ALUSrc, MemRd, MemWr, MemtoReg, Branch, Jump, ALUOp);
input [5:0] OP_Code;
output reg RegDst, RegWr, ALUSrc, MemRd, MemWr, MemtoReg, Branch, Jump;
output reg [1:0] ALUOp;

parameter R = 6'b000000,
          lw = 6'b100011,
          sw = 6'b101011,
          beq = 6'b000100,
          j = 6'b000010,
          addiu = 6'b001001;
always @(OP_Code) 
begin
    case(OP_Code)
        R: {RegDst, RegWr, ALUSrc, MemRd, MemWr, MemtoReg, Branch, Jump, ALUOp} <= 10'b1100000010;
        lw: {RegDst, RegWr, ALUSrc, MemRd, MemWr, MemtoReg, Branch, Jump, ALUOp} <= 10'b0111010000;
        sw: {RegDst, RegWr, ALUSrc, MemRd, MemWr, MemtoReg, Branch, Jump, ALUOp} <= 10'bx0101x0000;
        beq: {RegDst, RegWr, ALUSrc, MemRd, MemWr, MemtoReg, Branch, Jump, ALUOp} <= 10'bx0000x1001;
        j: {RegDst, RegWr, ALUSrc, MemRd, MemWr, MemtoReg, Branch, Jump, ALUOp} <= 10'bx0x00x01xx;
        addiu:{RegDst, RegWr, ALUSrc, MemRd, MemWr, MemtoReg, Branch, Jump, ALUOp} <= 10'b0110000000;
    endcase
end
endmodule