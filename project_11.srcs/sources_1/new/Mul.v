`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.04.2024 20:44:49
// Design Name: 
// Module Name: Mul
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module A(Ra,L,d,Sa,clk);
input Sa,L,clk;
input [15:0]d;
output reg [15:0]Ra;
always @(posedge clk)
begin
if(L==1) Ra<=d;
if(Sa==1) Ra<={Ra[14:0],Ra[15]};
end
endmodule

module B(Q,L,d,Sa,clk);
input L,clk,Sa;
input [15:0]d;
 reg [15:0]Ra;
output Q;
assign Q=Ra[0];
always @(posedge clk)
begin
if(L==1) Ra<=d;
if(Sa==1) Ra<={Ra[0],Ra[15:1]};
end
endmodule

module ALU(Y,X,Z);
input [15:0]X;
input [15:0]Z;
output [15:0]Y;
assign Y=X+Z;
endmodule

module X(Ra,L,d,clk,S);
input L,clk,S;
input [15:0]d;
output reg [15:0]Ra;
always @(posedge clk)
begin
if (S==1) Ra<=0;
if(L==1) Ra<=d;
end
endmodule

module count(S,set,D,clk);
output reg [7:0]S;
input D,set,clk;
always @(posedge clk)
begin
if(set) S<=8;
 if (D==1) S<=S-1;
end
endmodule

module comp(E, P);
input  [7:0]P;
output E;
assign E=~|P;
endmodule

module mul_data(Data,K,E,data,La,Lb,Lx,clk,CS,De,Sa,Sb,Sx  );
input La,Lb,Lx,clk,CS,De,Sa,Sb,Sx;
input [15:0]data;
output [15:0]Data;
output E,K;
wire [15:0]J;
wire [15:0]L;
wire [15:0]M;
wire [7:0]O;
assign Data=L;
A p(J,La,data,Sa,clk);
B e(K,Lb,data,Sb,clk);
X n(L,Lx,M,clk,Sx);
ALU h(M,J,L);
count d(O,CS,De,clk);
comp t(E,O);
endmodule


 module mul_con(Sx,ST,done,Sa,Sb,La,Lb,Lx,CS,De,clk,K,E,St);
 input K,E,clk,St;
 output reg Sx,La,Lb,Lx,CS,De,Sa,Sb,done;
 output [2:0]ST;
 reg [2:0]state;
 assign ST=state;
 always @(posedge clk)
 begin
 case (state)
 0:if(St) state<=1;
 1: state<=2;
  2: begin 
  if(K==1)state<=3;
    else state<=4;
    end
   3: state<=4;
    4: state<=5;
     5: begin if(E==1)state<=6; 
      else state<=2;
      end
      6: state<=6;
       default: state<=0;
 endcase
 end
 always @(state)
 begin
 case(state)
 0:begin CS=1; La=1;Lb=0;Lx=0;De=0; Sa=0;Sb=0;Sx=1;end
 1:begin Lb=1;La=0;Lx=0;CS=0;De=0; Sa=0;Sb=0; Sx=0;end
 2:begin Lb=0;La=0;Lx=0;CS=0;De=0; Sa=0;Sb=0;Sx=0;end
 3:begin Lb=0;La=0;Lx=1;CS=0;De=0;Sa=0;Sb=0;Sx=0; end
 4:begin Lb=0;La=0;Lx=0;CS=0;De=1;Sa=1;Sb=1;Sx=0; end
 5:begin Lb=0;La=0;Lx=0;CS=0;De=0;Sa=0;Sb=0; Sx=0;end
 6:begin Lb=0;La=0;Lx=0;CS=0;De=0; Sa=0;Sb=0;done=1;Sx=0;end
 7:begin Lb=0;La=0;Lx=0;CS=0;De=0;Sa=0;Sb=0;done=0;Sx=0; end
 endcase
 end
 endmodule


