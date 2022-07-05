module halfadder(
  input a,
  input b,
  output c,
  output s
);
  xor x1(s,a,b);
  and a1(c,a,b);
endmodule

module fulladder(
  input a,
  input b,
  input cin,
  output s,
  output cout
);
  wire carryg ,carryp,sum1;
  halfadder
    ha0(.a(a), .b(b), .c(carryg), .s(sum1)),
    ha1(.a(sum1), .b(cin), .c(carryp), .s(s));
  or o1(cout,carryg,carryp);
endmodule

module ripplecarry(
  input cin,
  input [3:0] a,
  input [3:0] b,
  output [3:0] s,
  output cout
);
