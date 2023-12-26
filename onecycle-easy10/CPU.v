// `include "ALU.v"
// `include "ALU_CU.v"
// `include "Add.v"
// `include "Mux2.v"
// `include "ROM.v"
// `include "CU.v"
// `include "PC.v"
// `include "RAM.v"
// `include "RF.v"
// `include "SigExt.v"
module CPU(clk);
input clk;

//主控单元
wire RegDst, RegWr, ALUSrc, MemRd, MemWr, MemtoReg, Branch, Jump;
//ALU控制单元
wire [1:0] ALUOp;
wire [2:0] ALUCtrl;

//RF上接的线,图中用蓝色标识
wire [31:0] W_data, R_data1, R_data2;
wire [4:0] W_Reg;

//指令存储器的输出线
wire [31:0] Inst;
//数据存储器的输出线
wire [31:0] R_data;

//PC输入输出线
wire [31:0] pc_in, pc_out;
//ALU结果输出线和第二个操作数输入线
wire [31:0] ALU_result, ALU_b;
wire Zero, O;

wire [31:0] SigExt_out;
//PC+4的输出线
wire [31:0] Addr1;
//PC+4+SignExt的输出线
wire [31:0] Addr2;
//选择上面两个输出线后的输出线
wire [31:0] Addr_mid;

//PC
PC pc (.clk(clk), .in(pc_in), .out(pc_out));
//指令存储器
ROM Inst_mem (.Addr(pc_out), .R_data(Inst));
//控制单元
CU MCU (.OP_Code(Inst[31:26]), .RegDst(RegDst), .RegWr(RegWr), .ALUSrc(ALUSrc), .MemRd(MemRd), .MemWr(MemWr), .MemtoReg(MemtoReg), .Branch(Branch), .Jump(Jump), .ALUOp(ALUOp));
ALU_CU alu_cu (.ALUOp(ALUOp), .func(Inst[5:0]), .ALUCtrl(ALUCtrl));
//寄存器
RF RegFile (.R_Reg1(Inst[25:21]), .R_Reg2(Inst[20:16]), .W_Reg(W_Reg), .W_data(W_data), .R_data1(R_data1), .R_data2(R_data2), .clk(clk), .RegWr(RegWr));
//数据存储器
RAM Data_mem (.R_data(R_data), .W_data(R_data2), .Addr(ALU_result), .MemRd(MemRd), .MemWr(MemWr));

//符号扩展器
SigExt sigext (.in(Inst[15:0]), .out(SigExt_out));
//ALU运算
ALU alu (.A(R_data1), .B(ALU_b), .ALUCtrl(ALUCtrl), .Zero(Zero), .O(O), .result(ALU_result));
// PC+4
Add Add_1 (.A(32'h0004), .B(pc_out), .result(Addr1));
// PC+4+SignExt
Add Add_2 (.A(Addr1), .B(SigExt_out<<2), .result(Addr2));

//多路选择器连线
//选择写入的寄存器
Mux2 mux_1 (.in0(Inst[20:16]), .in1(Inst[15:11]), .out(W_Reg), .src(RegDst));
//选择第二个操作数
Mux2 mux_2 (.in0(R_data2), .in1(SigExt_out), .out(ALU_b), .src(ALUSrc));
//选择写入寄存器的数据
Mux2 mux_3 (.in0(ALU_result), .in1(R_data), .out(W_data), .src(MemtoReg));
//I型指令
Mux2 mux_4 (.in0(Addr1), .in1(Addr2), .out(Addr_mid), .src(Zero & Branch));
//J型指令
Mux2 mux_5 (.in0(Addr_mid), .in1({Addr1[31:28],Inst[25:0],2'b00}), .out(pc_in), .src(Jump));

endmodule