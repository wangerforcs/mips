module CPU(clk);
input clk;

//控制信号
wire PCWr,PCWrCond,IorD,MemRd,MemWr,IRWr,MemtoReg,RegWr,RegDst;
wire [1:0] PCSrc;
wire [3:0] ALUOp;
wire [1:0] ALUSrcB,ALUSrcA;
wire [3:0] ALUCtrl;
wire Zero,O,Sign;

//指令存储器的输出线
wire [31:0] Inst;
//PC输入输出线
wire [31:0] pc_in, pc_out;

// ALU线和ALUOut线
wire [31:0] ALU_a, ALU_b, ALU_result;
wire [31:0] ALUOut_out;

// 存储器线
wire [31:0] Addr, R_data, W_data;

// RF线
wire [31:0] RFR_data1, RFR_data2, RFW_data;
wire [4:0] RFW_Reg;

wire [31:0] SigExt_out;
wire [31:0] MDR_out;
wire [31:0] A_out;

//控制器
CU cu(.PCWr(PCWr), .PCWrCond(PCWrCond), .IorD(IorD), .MemRd(MemRd), .MemWr(MemWr), .IRWr(IRWr), .MemtoReg(MemtoReg), .PCSrc(PCSrc), .ALUOp(ALUOp), .ALUSrcB(ALUSrcB), .ALUSrcA(ALUSrcA), .RegWr(RegWr), .RegDst(RegDst), .Op(Inst[31:26]), .clk(clk),.func(Inst[5:0]));
ALU_CU alu_cu(.ALUOp(ALUOp), .func(Inst[5:0]), .ALUCtrl(ALUCtrl));
//符号扩展
SigExt sigext (.in(Inst[15:0]), .out(SigExt_out));
//运算器
ALU alu(.A(ALU_a), .B(ALU_b), .ALUCtrl(ALUCtrl), .Zero(Zero), .O(O), .Sign(Sign), .result(ALU_result));
//存储器
Mem mem(.R_data(R_data), .W_data(W_data), .Addr(Addr), .MemRd(MemRd), .MemWr(MemWr));
//寄存器堆
RF rf(.R_Reg1(Inst[25:21]), .R_Reg2(Inst[20:16]), .W_Reg(RFW_Reg), .W_data(RFW_data), .R_data1(RFR_data1), .R_data2(RFR_data2), .clk(clk), .RegWr(RegWr));

//PC寄存器
Reg PC(.clk(clk), .data(pc_in), .Wr(PCWr||(PCWrCond&&Zero)), .Q(pc_out));
//指令寄存器
Reg IR(.clk(clk), .data(R_data), .Wr(IRWr), .Q(Inst));
//数据寄存器
Reg MDR(.clk(clk), .data(R_data), .Wr(1'b1), .Q(MDR_out));
//临时寄存器
Reg A(.clk(clk), .data(RFR_data1), .Wr(1'b1), .Q(A_out));
Reg B(.clk(clk), .data(RFR_data2), .Wr(1'b1), .Q(W_data));
Reg ALU_Out(.clk(clk), .data(ALU_result), .Wr(1'b1), .Q(ALUOut_out));

//多路选择器
//指令和数据地址选择器
Mux2 mux1(.in0(pc_out), .in1(ALUOut_out), .out(Addr), .src(IorD));
//寄存器堆写入数据选择器
Mux2 mux2(.in0(ALUOut_out), .in1(MDR_out), .out(RFW_data), .src(MemtoReg));
//选择写入的寄存器
Mux2 mux3(.in0(Inst[20:16]), .in1(Inst[15:11]), .out(RFW_Reg), .src(RegDst));
//选择ALU的操作数: PC 或者 A 或者移位shamt
Mux4 mux43(.in0(pc_out), .in1(A_out), .in2({27'b0,Inst[10:6]}), .in3(32'hzzzz), .out(ALU_a), .src(ALUSrcA));


//选择ALU的操作数: B, 4, 符号扩展, 符号扩展左移2位 
Mux4 mux41(.in0(W_data), .in1(32'h00000004), .in2(SigExt_out), .in3(SigExt_out<<2), .out(ALU_b), .src(ALUSrcB));
//选择PC的输入: PC+4 PC+4+符号扩展 j型指令
Mux4 mux42(.in0(ALU_result), .in1(ALUOut_out), .in2({pc_out[31:28],Inst[25:0],2'b00}), .in3(32'hzzzz), .out(pc_in), .src(PCSrc));

endmodule