module Mux2(in0,in1,out,src);
input [31:0] in0, in1;
input src;
output [31:0] out;

assign out = src? in1 : in0;
endmodule