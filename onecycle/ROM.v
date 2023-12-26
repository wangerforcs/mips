module ROM(Addr, R_data);
input [31:0] Addr;
output [31:0] R_data;

reg [31:0] M [255:0];

assign R_data = M[Addr>>2];
endmodule