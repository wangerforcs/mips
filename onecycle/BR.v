module BR(BranchOp,Zero,Sign,Branch);
input [2:0] BranchOp;
input Zero,Sign;
output reg Branch;
always @(*) begin
    case(BranchOp)
        3'b000: Branch <= 0;
        3'b001: Branch <= Zero;
        3'b010: Branch <= ~Sign;
        3'b011: Branch <= ~(Zero | Sign);
        3'b100: Branch <= Zero | Sign;
        3'b101: Branch <= ~Zero;
    endcase
end
endmodule