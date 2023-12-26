`timescale 10ns/1ns
`include "CPU.v"
`include "ALU.v"
`include "ALU_CU.v"
`include "Add.v"
`include "Mux2.v"
`include "ROM.v"
`include "CU.v"
`include "PC.v"
`include "RAM.v"
`include "RF.v"
`include "SigExt.v"
`include "BR.v"

module CPU_tb;
    reg clk;
    CPU cpu(.clk(clk));
    always #5 clk = ~clk;

    initial begin
        $readmemh("initial/inst.txt",cpu.instm.M);
        $readmemh("initial/RF.txt",cpu.rf.RF);
        $readmemh("initial/data.txt",cpu.datam.M);
        
        clk = 1 ;
        #2000 $finish; 
    end

endmodule