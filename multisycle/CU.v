module CU (PCWr,PCWrCond,IorD,MemRd,MemWr,IRWr,MemtoReg,PCSrc,ALUOp,ALUSrcB,ALUSrcA,RegWr,RegDst,Op,clk,func);
input [5:0] func;
input [5:0] Op;
input clk;
output reg [1:0] ALUSrcB, PCSrc, ALUSrcA;
output reg [3:0] ALUOp;
output reg PCWrCond, PCWr , IorD, MemRd, MemWr, MemtoReg, IRWr, RegWr, RegDst; 
parameter S0=0, S1=1, S2=2, S3=3, S4=4, S5=5, S6=6, S7=7, S8=8, S9=9, 
    S10=10, //addi
    S11=11, //addiu
    S12=12, //andi
    S13=13, //lui
    S14=14, //ori
    S15=15, //slti
    S16=16, //sltiu
    S17=17, //xori
    S18=18; 
parameter R = 6'b000000,
          lw = 6'b100011,
          sw = 6'b101011,
          j = 6'b000010,
          addi = 6'b001000,
          addiu = 6'b001001,
          andi = 6'b001100,
          lui =6'b001111,
          ori = 6'b001101,
          slti = 6'b001010,
          sltiu = 6'b001011,
          xori = 6'b001110,
          beq = 6'b000100;

reg [4:0] S, NS; 
initial S=0;
always@(posedge clk) begin 
    S <= NS;
end
always @(S, Op) begin
case(S)
    S0: begin
    MemRd=1'b1; 
    ALUSrcA=2'b00; 
    IorD=1'b0; 
    IRWr=1'b1; 
    ALUSrcB=2'b01; 
    ALUOp=4'b0000; 
    PCWr=1'b1; 
    PCSrc=2'b00; 
    NS=S1; 
    RegWr=1'b0; 
    RegDst=1'b0;
    MemWr=1'b0; 
    PCWrCond= 1'b0; 
    MemtoReg=1'b0;
    end

    S1: begin 
    MemRd=1'b0;
    IRWr=1'b0;
    ALUSrcA=2'b00;
    ALUSrcB=2'b11;
    PCWr =1'b0;
    ALUOp= 4'b0000;
    case(Op)
    lw: NS=S2;
    sw: NS=S2;
    R: NS=S6;
    beq: NS=S8;
    j: NS=S9;
    addi: NS=S10;
    addiu: NS=S11;
    andi: NS=S12;
    lui: NS=S13;
    ori: NS=S14;
    slti: NS=S15;
    sltiu: NS=S16;
    xori: NS=S17;
    endcase
    end

    S2: begin
    ALUSrcA = 2'b01;
    ALUSrcB= 2'b10; 
    ALUOp = 4'b0000;
    case(Op)
    lw: NS=S3;
    sw: NS=S5;
    endcase
    end

    S3: begin 
    MemRd=1'b1;
    IorD = 1'b1; 
    NS=S4;
    end

    S4: begin
    RegDst = 1'b0;
    RegWr = 1'b1; 
    MemtoReg= 1'b1; 
    MemRd=1'b0;
    NS=S0; 
    end

    S5: begin 
    MemWr=1'b1;
    IorD= 1'b1; 
    NS=S0;
    end

    S6: begin
    if(func == 6'b000000 || func == 6'b000010 || func == 6'b000011) ALUSrcA= 2'b10;
    else ALUSrcA= 2'b01;
    ALUSrcB= 2'b00; 
    ALUOp = 4'b1100; 
    NS = S7;
    end

    S7: begin
    RegDst= 1'b1;
    RegWr = 1'b1; 
    MemtoReg = 1'b0; 
    NS= S0;
    end

    S8: begin
    ALUSrcA= 2'b01;
    ALUSrcB= 2'b00; 
    ALUOp=4'b0001; 
    PCWrCond= 1'b1; 
    PCSrc = 2'b01; 
    NS= S0;
    end

    S9: begin
    PCWr = 1'b1;
    PCSrc= 2'b10;
    NS= S0; 
    end

    // addi
    S10: begin
    ALUSrcA = 2'b01;
    ALUSrcB= 2'b10; 
    ALUOp = 4'b0000;
    NS = S18;
    end

    //addiu
    S11: begin
    ALUSrcA = 2'b01;
    ALUSrcB= 2'b10; 
    ALUOp = 4'b0001;
    NS = S18;
    end

    //andi
    S12: begin
    ALUSrcA = 2'b01;
    ALUSrcB= 2'b10; 
    ALUOp = 4'b0011;
    NS = S18;
    end

    //lui
    S13: begin
    ALUSrcA = 2'b01;
    ALUSrcB= 2'b10; 
    ALUOp = 4'b0100;
    NS = S18;
    end

    //ori
    S14: begin
    ALUSrcA = 2'b01;
    ALUSrcB= 2'b10; 
    ALUOp = 4'b0101;
    NS = S18;
    end

    //slti
    S15: begin
    ALUSrcA = 2'b01;
    ALUSrcB= 2'b10; 
    ALUOp = 4'b0110;
    NS = S18;
    end

    //sltiu
    S16: begin
    ALUSrcA = 2'b01;
    ALUSrcB= 2'b10; 
    ALUOp = 4'b0111;
    NS = S18;
    end

    //xori
    S17: begin
    ALUSrcA = 2'b01;
    ALUSrcB= 2'b10; 
    ALUOp = 4'b1000;
    NS = S18;
    end

    S18: begin
    RegDst= 1'b0;
    RegWr= 1'b1;
    MemtoReg= 1'b0;
    NS = S0;
    end

endcase 
end
endmodule


// module CU(PCWr,PCWrCond,IorD,MemRd,MemWr,IRWr,MemtoReg,PCSrc,ALUOp,ALUSrcB,ALUSrcA,RegWr,RegDst,Op,clk);
//     input [5:0] Op;
//     input clk;

//     output PCWr,PCWrCond,IorD,MemRd,MemWr,IRWr,MemtoReg,ALUSrcA,RegWr,RegDst;
//     output [1:0] PCSrc;
//     output [1:0] ALUOp;
//     output [1:0] ALUSrcB;

//     reg [3:0] S;
//     wire [3:0] NS;
//     wire [19:0] P;
//     // parameter R = 6'b000000,
//     //       lw = 6'b100011,
//     //       sw = 6'b101011,
//     //       beq = 6'b000100,
//     //       j = 6'b000010,
//     //       addiu = 6'b001001;
//     assign P[0] = ~S[3] && ~S[2] && ~S[1] && ~S[0]; //0000
//     assign P[1] = ~S[3] && ~S[2] && ~S[1] &&  S[0]; //0001
//     assign P[2] = ~S[3] && ~S[2] &&  S[1] && ~S[0]; //0010
//     assign P[3] = ~S[3] && ~S[2] &&  S[1] &&  S[0]; //0011
//     assign P[4] = ~S[3] &&  S[2] && ~S[1] && ~S[0]; //0100
//     assign P[5] = ~S[3] &&  S[2] && ~S[1] &&  S[0]; //0101
//     assign P[6] = ~S[3] &&  S[2] &&  S[1] && ~S[0]; //0110
//     assign P[7] = ~S[3] &&  S[2] &&  S[1] &&  S[0]; //0111  
//     assign P[8] =  S[3] && ~S[2] && ~S[1] && ~S[0]; //1000
//     assign P[9] =  S[3] && ~S[2] && ~S[1] &&  S[0]; //1001
//     //000010 0001  j
//     assign P[10] = ~Op[5] && ~Op[4] && ~Op[3] && ~Op[2] &&  Op[1] && ~Op[0] && ~S[3] && ~S[2] && ~S[1] &&  S[0]; 
//     //000100 0001  beq 
//     assign P[11] = ~Op[5] && ~Op[4] && ~Op[3] &&  Op[2] && ~Op[1] && ~Op[0] && ~S[3] && ~S[2] && ~S[1] &&  S[0]; 
//     //000000 0001  R
//     assign P[12] = ~Op[5] && ~Op[4] && ~Op[3] && ~Op[2] && ~Op[1] && ~Op[0] && ~S[3] && ~S[2] && ~S[1] &&  S[0]; 
//     //100011 0010  lw
//     assign P[13] =  Op[5] && ~Op[4] && ~Op[3] && ~Op[2] &&  Op[1] &&  Op[0] && ~S[3] && ~S[2] &&  S[1] && ~S[0];
//     //101011 0001  sw
//     assign P[14] =  Op[5] && ~Op[4] &&  Op[3] && ~Op[2] &&  Op[1] &&  Op[0] && ~S[3] && ~S[2] && ~S[1] &&  S[0];
//     //100011 0001  lw
//     assign P[15] =  Op[5] && ~Op[4] && ~Op[3] && ~Op[2] &&  Op[1] &&  Op[0] && ~S[3] && ~S[2] && ~S[1] &&  S[0];
//     //101011 0010  sw
//     assign P[16] =  Op[5] && ~Op[4] &&  Op[3] && ~Op[2] &&  Op[1] &&  Op[0] && ~S[3] && ~S[2] &&  S[1] && ~S[0];
//     //addiu指令新增的
//     //001001 0001  addiu
//     assign P[17] = ~Op[5] && ~Op[4] &&  Op[3] && ~Op[2] && ~Op[1] &&  Op[0] && ~S[3] && ~S[2] && ~S[1] &&  S[0];
//     //001001 0010  addiu
//     assign P[18] = ~Op[5] && ~Op[4] &&  Op[3] && ~Op[2] && ~Op[1] &&  Op[0] && ~S[3] && ~S[2] &&  S[1] && ~S[0];
//     //1010 S=10
//     assign P[19] = S[3] && ~S[2] &&  S[1] && ~S[0];


//     //组合逻辑下方或门
//     assign PCWr = P[0] || P[9];
//     assign PCWrCond = P[8];
//     assign IorD = P[3] || P[5];
//     assign MemRd = P[0] || P[3];
//     assign MemWr =P[5];
//     assign IRWr = P[0];
//     assign MemtoReg = P[4];
//     assign PCSrc = {P[9],P[8]};
//     assign ALUOp = {P[6],P[8]};
//     assign ALUSrcB = {P[1]||P[2],P[0]||P[1]};
//     assign ALUSrcA = P[2] || P[6] || P[8];
//     assign RegWr = P[4] || P[7] || P[19];
//     assign RegDst = P[7];
//     assign NS[3] = P[10] || P[11] || P[18];
//     assign NS[2] = P[3] || P[6] || P[12] || P[16];
//     assign NS[1] = P[6] || P[12] || P[13] || P[14] || P[15] || P[17] || P[18];
//     assign NS[0] = P[0] || P[6] || P[10] || P[13] || P[16];
//     // 十条指令
//     // assign #0.1 RegWr = P[4] || P[7];
//     // assign #0.1 NS[3] = P[10] || P[11];
//     // assign #0.1 NS[2] = P[3] || P[6] || P[12] || P[16];
//     // assign #0.1 NS[1] = P[6] || P[12] || P[13] || P[14] || P[15];
//     // assign #0.1 NS[0] = P[0] || P[6] || P[10] || P[13] || P[16];

//     always @(posedge clk) begin
//         S <= NS;
//     end

// endmodule
