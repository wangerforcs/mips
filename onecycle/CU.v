module CU(OP_Code,RegDst, RegWr, ALUSrcB, MemRd, MemWr, MemtoReg, BranchOp, Jump, ALUOp);
input [5:0] OP_Code;
output reg RegDst, RegWr, ALUSrcB, MemRd, MemWr, MemtoReg, Jump;
output reg [2:0] BranchOp;
output reg [3:0] ALUOp;

parameter R = 6'b000000,
          lw = 6'b100011,
          sw = 6'b101011,
          j = 6'b000010,
          addi = 6'b001000,
          addiu = 6'b001001,
          andi = 6'b001100,
          lui =6'b001111,
          ori = 6'b001101,
          slti = 6'b001010,
          sltiu = 6'b001011,
          xori = 6'b001110,
          beq = 6'b000100,
          bgez = 6'b000001,
          bgtz = 6'b000111,
          blez = 6'b000110,
          bne =  6'b000101;
          
always @(OP_Code) 
begin
    case(OP_Code)
        R: {RegDst, RegWr, ALUSrcB, MemRd, MemWr, MemtoReg, BranchOp, Jump, ALUOp} <= 14'b11000000001100;
        lw:{RegDst, RegWr, ALUSrcB, MemRd, MemWr, MemtoReg, BranchOp, Jump, ALUOp} <= 14'b01110100000000;
        sw: {RegDst, RegWr, ALUSrcB, MemRd, MemWr, MemtoReg, BranchOp, Jump, ALUOp} <= 14'bx0101x00000000;
        j:{RegDst, RegWr, ALUSrcB, MemRd, MemWr, MemtoReg, BranchOp, Jump, ALUOp} <= 14'bx0x00x0001xxxx;
        
        addi:{RegDst, RegWr, ALUSrcB, MemRd, MemWr, MemtoReg, BranchOp, Jump, ALUOp}  <= 14'b01100000000000;
        addiu:{RegDst, RegWr, ALUSrcB, MemRd, MemWr, MemtoReg, BranchOp, Jump, ALUOp} <= 14'b01100000000010;
        andi:{RegDst, RegWr, ALUSrcB, MemRd, MemWr, MemtoReg, BranchOp, Jump, ALUOp} <= 14'b01100000000011;
        lui:{RegDst, RegWr, ALUSrcB, MemRd, MemWr, MemtoReg, BranchOp, Jump, ALUOp} <= 14'b01100000000100;
        ori:{RegDst, RegWr, ALUSrcB, MemRd, MemWr, MemtoReg, BranchOp, Jump, ALUOp} <= 14'b01100000000101;
        slti:{RegDst, RegWr, ALUSrcB, MemRd, MemWr, MemtoReg, BranchOp, Jump, ALUOp} <= 14'b01100000000110;
        sltiu:{RegDst, RegWr, ALUSrcB, MemRd, MemWr, MemtoReg, BranchOp, Jump, ALUOp} <= 14'b01100000000111;
        xori:{RegDst, RegWr, ALUSrcB, MemRd, MemWr, MemtoReg, BranchOp, Jump, ALUOp} <= 14'b01100000001000;

        beq:{RegDst, RegWr, ALUSrcB, MemRd, MemWr, MemtoReg, BranchOp,Jump, ALUOp} <= 14'bx0000x00100001;
        bgez:{RegDst, RegWr, ALUSrcB, MemRd, MemWr, MemtoReg, BranchOp,Jump, ALUOp} <= 14'bx0000x01000001;
        bgtz:{RegDst, RegWr, ALUSrcB, MemRd, MemWr, MemtoReg, BranchOp, Jump, ALUOp} <= 14'bx0000x01100001;
        blez:{RegDst, RegWr, ALUSrcB, MemRd, MemWr, MemtoReg, BranchOp,Jump, ALUOp} <= 14'bx0000x10000001;
        bne:{RegDst, RegWr, ALUSrcB, MemRd, MemWr, MemtoReg, BranchOp,Jump, ALUOp} <= 14'bx0000x10100001;
    endcase
end
endmodule