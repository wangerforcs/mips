module CPU(clk);
input clk;

//控制信号
wire RegDst, RegWr, ALUSrcB, MemRd, MemWr, MemtoReg, Branch, Jump;
wire [2:0] BranchOp;
//ALU控制单元
wire [3:0] ALUOp;
wire [3:0] ALUCtrl;
wire ALUSrcA;
wire Zero, O ,Sign;


//指令存储器的输出线
wire [31:0] Inst;
//PC输入输出线
wire [31:0] pc_in, pc_out;

//数据存储器的输出线
wire [31:0] R_data;

//RF线
wire [31:0] W_data, R_data1, R_data2;
wire [4:0] W_Reg;

//ALU结果输出线和第二个操作数输入线
wire [31:0] ALU_result, ALU_b, ALU_a;

//符号扩展
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
ROM instm (.Addr(pc_out), .R_data(Inst));
//控制单元
CU cu (.OP_Code(Inst[31:26]), .RegDst(RegDst), .RegWr(RegWr), .ALUSrcB(ALUSrcB), .MemRd(MemRd), .MemWr(MemWr), .MemtoReg(MemtoReg), .BranchOp(BranchOp), .Jump(Jump), .ALUOp(ALUOp));
ALU_CU alu_cu (.ALUOp(ALUOp), .func(Inst[5:0]), .ALUCtrl(ALUCtrl), .ALUSrcA(ALUSrcA));
//寄存器
RF rf (.R_Reg1(Inst[25:21]), .R_Reg2(Inst[20:16]), .W_Reg(W_Reg), .W_data(W_data), .R_data1(R_data1), .R_data2(R_data2), .clk(clk), .RegWr(RegWr));
//数据存储器
RAM datam (.R_data(R_data), .W_data(R_data2), .Addr(ALU_result), .MemRd(MemRd), .MemWr(MemWr));

//符号扩展器
SigExt sigext (.in(Inst[15:0]), .out(SigExt_out));
//ALU运算
ALU alu (.A(ALU_a), .B(ALU_b), .ALUCtrl(ALUCtrl), .Zero(Zero), .O(O), .Sign(Sign), .result(ALU_result));
// PC+4
Add Add1 (.A(32'h0004), .B(pc_out), .result(Addr1));
// PC+4+SigExt
Add Add2 (.A(Addr1), .B(SigExt_out<<2), .result(Addr2));

//多路选择器连线
//选择写入的寄存器
Mux2 mux1 (.in0(Inst[20:16]), .in1(Inst[15:11]), .out(W_Reg), .src(RegDst));
//选择第二个操作数
Mux2 mux2 (.in0(R_data2), .in1(SigExt_out), .out(ALU_b), .src(ALUSrcB));
//选择写入寄存器的数据
Mux2 mux3 (.in0(ALU_result), .in1(R_data), .out(W_data), .src(MemtoReg));
//I型指令
BR br (.BranchOp(BranchOp), .Zero(Zero), .Sign(Sign), .Branch(Branch));
Mux2 mux4 (.in0(Addr1), .in1(Addr2), .out(Addr_mid), .src(Branch));
//J型指令
Mux2 mux5 (.in0(Addr_mid), .in1({Addr1[31:28],Inst[25:0],2'b00}), .out(pc_in), .src(Jump));
//移位指令
Mux2 mux6 (.in0(R_data1), .in1({27'b0,Inst[10:6]}), .out(ALU_a), .src(ALUSrcA));
endmodule