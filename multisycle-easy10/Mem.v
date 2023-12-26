module Mem(R_data,W_data,Addr,MemRd,MemWr);
input [31:0] W_data,Addr;
input MemWr, MemRd;
output [31:0] R_data;

reg [31:0] mem [255:0];

assign R_data = MemRd? mem[Addr>>2]: 32'hzzzz;

always @(posedge MemWr) 
begin
    mem[Addr] <= W_data;
end
endmodule