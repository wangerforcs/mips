module ALU_tb;
reg [31:0] A;
reg [31:0] B;
reg [2:0] operation;
wire [31:0] result;
wire Zero,O;
 
ALU ALUtest(A,B,operation,Zero,O,result);
initial 
    begin
        A<=0000;B<=0000;operation <= 000;       //initial
        #10   A<=0001;B<=0001;operation <= 000; //A + B 0010
        #10   A<=0001;B<=0001;operation <= 001; //A - B 0000
        #10   A<=0001;B<=0001;operation <= 010; //B + 1 0010
        #10   A<=0001;B<=0001;operation <= 011; //B - 1 0000
        #10   A<=1001;B<=0001;operation <= 100; //NOT A 0110
        
        #10   A<=0001;B<=0010;operation <= 101; //A XOR B 
        
        #10   A<=0001;B<=0001;operation <= 110; //A AND B 
        #10   A<=0001;B<=0000;operation <= 110; //A AND B
        
        #10   A<=0001;B<=0000;operation <= 111; //A OR B 
        #10   A<=0000;B<=0000;operation <= 111; //A OR B
        #10   $stop;    
    end
endmodule