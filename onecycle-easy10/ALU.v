module ALU(A,B,ALUCtrl,Zero,O,result);
input [31:0] A,B;
input [2:0] ALUCtrl;
output reg [31:0] result;
output reg Zero;
output reg O;

parameter AND=3'b000,
          OR=3'b001,
          ADD=3'b100,
          SUB=3'b110,
          NOR=3'b011,
          ADDU=3'b101;

always @(A or B or ALUCtrl) 
begin
    case(ALUCtrl)
        AND: result <= A & B;
        OR: result <= A | B;
        ADD: {O,result} <= A + B;
        SUB: {O,result} <= A - B;
        NOR: result <= ~ (A | B);
        ADDU: result <= A + B;
    endcase
end

always @(result) begin
    if (result == 0)
        Zero <= 1;
    else 
        Zero <= 0;
end

endmodule