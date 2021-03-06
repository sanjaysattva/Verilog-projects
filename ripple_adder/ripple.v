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
  
  wire cout0,cout1,cout2;
  fulladder
    fa0(a[0], b[0],cin, s[0],cout0),
    fa1(a[1], b[1], cout0, s[1],cout1),
    fa2(a[2], b[2], cout1, s[2],cout2),
    fa3(a[3], b[3], cout2, s[3],cout);
endmodule
