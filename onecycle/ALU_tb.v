`timescale 10ns/1ns
`include "ALU.v"
module ALU_tb;
    reg [31:0] A,B;
    wire [31:0] result;
    reg [3:0] ALUCtrl;
    wire Zero, O, Sign;
    ALU alu(.A(A),.B(B),.ALUCtrl(ALUCtrl),.Zero(Zero),.O(O),.Sign(Sign),.result(result));
initial 
    begin
    A<=32'b1; B<=32'b10; ALUCtrl <= 4'b0000;       //add
    #5 A<=32'h40000000; B<=32'h40000000; ALUCtrl <= 4'b0000;       //add
    #5 A<=32'b1; B<=32'b10; ALUCtrl <= 4'b0010;       //sub
    #5 A<=32'b1; B<=32'b10; ALUCtrl <= 4'b0001;       //addu
    #5 A<=32'b1; B<=32'b10; ALUCtrl <= 4'b0011;       //subu
    #5 A<=32'b1; B<=32'b10; ALUCtrl <= 4'b0100;       //and
    #5 A<=32'b1; B<=32'b10; ALUCtrl <= 4'b0101;       //or
    #5 A<=32'b1; B<=32'b10; ALUCtrl <= 4'b0110;       //nor
    #5 A<=32'b1; B<=32'b10; ALUCtrl <= 4'b0111;       //xor
    #5 A<=32'b1; B<=32'b10; ALUCtrl <= 4'b1001;       //sltu
    #5 A<=32'b1; B<=32'b10; ALUCtrl <= 4'b1000;       //slt
    #5 A<=32'b1; B<=32'hffffffff; ALUCtrl <= 4'b1010;       //sll
    #5 A<=32'b1; B<=32'hffffffff; ALUCtrl <= 4'b1011;       //srl
    #5 A<=32'b1; B<=32'hffffffff; ALUCtrl <= 4'b1100;       //sra
    #5 A<=32'b1; B<=32'b10; ALUCtrl <= 4'b1101;       //lui
    end

endmodule