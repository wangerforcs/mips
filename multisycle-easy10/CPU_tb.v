`timescale 10ns/1ns
`include "ALU_CU.v"
`include "ALU.v"
`include "CU.v"
`include "Mem.v"
`include "Mux2.v"
`include "Mux4.v"
`include "Reg.v"
`include "RF.v"
`include "SigExt.v"
`include "CPU.v"

module CPU_tb;
    reg clk;
    parameter clk_period = 10;

    initial begin
        $readmemh("file/run1.txt",cpu.mem.mem);//设置存储器初值
        $readmemh("file/run1_RF.txt",cpu.rf.RF);//设置RF初值,$0寄存器的值恒为0
        
        clk <= 1 ;
        #0.1 cpu.PC.Q <= 32'h0;
        cpu.cu.S <= 4'b0000;

        #6000 $finish; 
    end

    always #(clk_period/2) clk = ~clk;

    CPU cpu(.clk(clk));

endmodule