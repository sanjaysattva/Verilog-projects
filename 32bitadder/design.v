module bitadder(S,C,A,B,Ci);
  
  input [31:0] A;
  input [31:0] B;
  input  Ci;
  output [31:0] S;
  output C;
   wire [32:0] Sum;
  assign Sum  = A+B+Ci;
  assign S=  Sum[31:0];
  assign C = Sum[32] ;
  
endmodule
