`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.04.2024 18:49:22
// Design Name: 
// Module Name: Test
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


module Test();
reg [15:0]Data;
reg Start,clk;
wire done;
wire [15:0] NM;
wire K,E,La,Lb,Lx,CS,De,Sa,Sb,Sx;
wire [2:0]Sta;
 mul_data Q( NM,K,E,Data,La,Lb,Lx,clk,CS,De,Sa,Sb,Sx );
 mul_con P(Sx,Sta,done,Sa,Sb,La,Lb,Lx,CS,De,clk,K,E,Start);
 initial 
 begin
 $monitor(" done=%b, NM=%b,K=%b,E=%b,La=%b,Lb=%b,Lx=%b,CS=%b,De=%b,Sa=%b,Sb=%b,Sta=%b " ,done,NM,K,E,La,Lb,Lx,CS,De,Sa,Sb,Sta);
 end
 initial 
 begin
 clk=0;
forever #5 clk=~clk; 
 end
 initial 
 begin
 #7 Data=40; Start=1;
 #10 Data=30;
  #10 Data=16'hzzzz;
 end
 initial #400 $finish;
endmodule
