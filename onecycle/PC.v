module PC(clk,in,out);
input clk;
input [31:0] in;
output reg [31:0] out;

initial #0.1 out <= 32'h0000;
always @(posedge clk) 
begin
    out <=  in;
end
endmodule