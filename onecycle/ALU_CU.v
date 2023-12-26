module ALU_CU (ALUOp,func,ALUCtrl,ALUSrcA);
input [5:0] func;
input [3:0] ALUOp;
output reg [3:0] ALUCtrl;
output reg ALUSrcA;
always @(func or ALUOp) begin
    casex(ALUOp) 
        4'b0000:{ALUCtrl, ALUSrcA} <= 5'b0000_0;   //lw or sw
        4'b0001:{ALUCtrl, ALUSrcA} <= 5'b0010_0;   //branch
        4'b0010:{ALUCtrl, ALUSrcA} <= 5'b0001_0;   //addiu
        4'b0011:{ALUCtrl, ALUSrcA} <= 5'b0100_0;   //andi
        4'b0100:{ALUCtrl, ALUSrcA} <= 5'b1101_0;   //lui
        4'b0101:{ALUCtrl, ALUSrcA} <= 5'b0101_0;   //ori
        4'b0110:{ALUCtrl, ALUSrcA} <= 5'b1000_0;   //slti
        4'b0111:{ALUCtrl, ALUSrcA} <= 5'b1001_0;   //sltiu
        4'b1000:{ALUCtrl, ALUSrcA} <= 5'b0111_0;   //xori
        4'b11xx: begin
          case (func)
            6'b100000: {ALUCtrl, ALUSrcA} <= 5'b0000_0; //add
            6'b100001: {ALUCtrl, ALUSrcA} <= 5'b0001_0; //addu
            6'b100010: {ALUCtrl, ALUSrcA} <= 5'b0010_0; //sub
            6'b100011: {ALUCtrl, ALUSrcA} <= 5'b0011_0; //subu
            6'b100100: {ALUCtrl, ALUSrcA} <= 5'b0100_0; //and
            6'b100101: {ALUCtrl, ALUSrcA} <= 5'b0101_0; //or
            6'b100110: {ALUCtrl, ALUSrcA} <= 5'b0111_0; //xor
            6'b100111: {ALUCtrl, ALUSrcA} <= 5'b0110_0; //nor
            6'b101010: {ALUCtrl, ALUSrcA} <= 5'b1000_0; //slt
            6'b101011: {ALUCtrl, ALUSrcA} <= 5'b1001_0; //sltu
            6'b000000: {ALUCtrl, ALUSrcA} <= 5'b1010_1; //sll
            6'b000010: {ALUCtrl, ALUSrcA} <= 5'b1011_1; //srl
            6'b000011: {ALUCtrl, ALUSrcA} <= 5'b1100_1; //sra
            6'b000100: {ALUCtrl, ALUSrcA} <= 5'b1010_0; //sllv
            6'b000110: {ALUCtrl, ALUSrcA} <= 5'b1011_0; //srlv
            6'b000111: {ALUCtrl, ALUSrcA} <= 5'b1100_0; //srav
          endcase
        end
    endcase
end
endmodule