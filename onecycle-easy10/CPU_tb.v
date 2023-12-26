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

module CPU_tb;
    reg clk;
    CPU cpu(.clk(clk));
    always #5 clk = ~clk;

    initial begin
        $readmemh("file/run1.txt",cpu.Inst_mem.mem);//设置指令存储器初值
        $readmemh("file/run1_RF.txt",cpu.RegFile.RF);//设置RF初值,$0寄存器的值恒为0
        
        clk = 1 ;
        #2000 $finish; 
    end


endmodule