module ALU(A,B,ALUCtrl,Zero,O,Sign,result);
input [31:0] A,B;
input [3:0] ALUCtrl;
output reg [31:0] result;
output reg Zero, O, Sign;

parameter ADD=4'b0000,
          ADDU=4'b0001,
          SUB=4'b0010,
          SUBU=4'b0011,
          AND=4'b0100,
          OR =4'b0101,
          NOR=4'b0110,
          XOR=4'b0111,
          SLT=4'b1000,
          SLTU=4'b1001,
          SLL=4'b1010,
          SRL=4'b1011,
          SRA=4'b1100,
          LUI=4'b1101;
always @(*) 
begin
    case(ALUCtrl)
        ADD: begin 
            result <= A + B;
            O <= (A[31] == B[31] && result[31] != A[31])? 1:0;
        end
        ADDU: result <= A + B;
        SUB: begin 
            result <= A - B;
            O <= (A[31] != B[31] && result[31] != A[31])? 1:0;
        end
        SUBU: result <= A - B;
        AND : result <= A & B;
        OR: result <= A | B;
        NOR:result <= ~(A | B);
        XOR:result <= A ^ B;
        SLT: begin       
            if(A[31] > B[31] || A < B) result <= 1;
            else result <= 0;
        end
        SLTU:result <= (A < B)? 1:0;
        SLL:result <= (B << A);
        SRL:result <= (B >> A);
        SRA:result <= ($signed(B) >>> A);
        LUI:result <= {B[15:0],16'b0};
    endcase
end

always @(result) begin
    if (result == 0)
        Zero <= 1;
    else 
        Zero <= 0;
    if(result[31] == 1)
        Sign <= 1;
    else 
        Sign <= 0;
    if(ALUCtrl != ADD && ALUCtrl != SUB)
        O <= 0;
end

endmodule