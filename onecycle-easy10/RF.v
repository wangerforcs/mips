module RF(R_Reg1,R_Reg2,W_Reg,W_data,R_data1,R_data2,clk,RegWr);
input [4:0] R_Reg1, R_Reg2, W_Reg;
input [31:0] W_data;
input clk, RegWr;
output [31:0] R_data1, R_data2;

reg [31:0] RF [31:0];

assign  R_data1 = RF[R_Reg1];
assign  R_data2 = RF[R_Reg2];

always @(posedge clk ) 
begin
    if(RegWr)
        RF[W_Reg] <= W_data;
end

endmodule