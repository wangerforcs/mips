module RAM(R_data,W_data,Addr,MemRd,MemWr);
input [31:0] W_data,Addr;
input MemWr, MemRd;
output [31:0] R_data;

reg [31:0] M [255:0];

assign R_data = MemRd? M[Addr>>2]: 32'hzzzz;

always @(posedge MemWr) 
begin
    M[Addr] <= W_data;
end
endmodule