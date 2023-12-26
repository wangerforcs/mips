module ALU_CU (ALUOp,func,ALUCtrl);
input [5:0] func;
input [3:0] ALUOp;
output reg [3:0] ALUCtrl;
always @(func or ALUOp) begin
    casex(ALUOp) 
        4'b0000:ALUCtrl <= 4'b0000;   //lw or sw
        4'b0001:ALUCtrl <= 4'b0010;   //beq
        4'b0010:ALUCtrl <= 4'b0001;   //addiu
        4'b0011:ALUCtrl <= 4'b0100;   //andi
        4'b0100:ALUCtrl <= 4'b1101;   //lui
        4'b0101:ALUCtrl <= 4'b0101;   //ori
        4'b0110:ALUCtrl <= 4'b1000;   //slti
        4'b0111:ALUCtrl <= 4'b1001;   //sltiu
        4'b1000:ALUCtrl <= 4'b0111;   //xori
        4'b11xx: begin
          case (func)
            6'b100000: ALUCtrl <= 4'b0000; //add
            6'b100001: ALUCtrl <= 4'b0001; //addu
            6'b100010: ALUCtrl <= 4'b0010; //sub
            6'b100011: ALUCtrl <= 4'b0011; //subu
            6'b100100: ALUCtrl <= 4'b0100; //and
            6'b100101: ALUCtrl <= 4'b0101; //or
            6'b100110: ALUCtrl <= 4'b0111; //xor
            6'b100111: ALUCtrl <= 4'b0110; //nor
            6'b101010: ALUCtrl <= 4'b1000; //slt
            6'b101011: ALUCtrl <= 4'b1001; //sltu
            6'b000000: ALUCtrl <= 4'b1010; //sll
            6'b000010: ALUCtrl <= 4'b1011; //srl
            6'b000011: ALUCtrl <= 4'b1100; //sra
            6'b000100: ALUCtrl <= 4'b1010; //sllv
            6'b000110: ALUCtrl <= 4'b1011; //srlv
            6'b000111: ALUCtrl <= 4'b1100; //srav
          endcase
        end
    endcase
end
endmodule