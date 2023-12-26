module Reg(clk,data,Wr,Q);
    input clk, Wr;
    input [31:0] data;
    output reg [31:0] Q;

    always @(posedge clk ) begin
        if(Wr)
            Q <=  data;
    end
endmodule