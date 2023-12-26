`timescale 10ns/1ns
`include "CPU.v"
`include "ALU.v"
`include "ALU_CU.v"
`include "Mux2.v"
`include "Mem.v"
`include "CU.v"
`include "Reg.v"
`include "RF.v"
`include "SigExt.v"

module CPU_tb;
    reg clk;
    CPU cpu(.clk(clk));
    always #5 clk = ~clk;

    initial begin
        $readmemh("initial/mem.txt",cpu.mem.mem);
        $readmemh("initial/RF.txt",cpu.rf.RF);
        clk = 1 ;
        #0.1 cpu.PC.Q = 32'h0004;        
        #2000 $finish; 
    end

endmodule