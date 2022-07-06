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


module adder8(
  input cin,
  input [7:0] a,
  input [7:0] b,
  output [7:0] s,
  output cout
);
  wire cout3;
  ripplecarry
  ra0(cin,a[3:0], b[3:0], s[3:0],cout3),
  ra1(cout3,a[7:4], b[7:4], s[7:4],cout);
endmodule

module subtractor8(
  input bin,
  input [7:0] a,
  input [7:0] b,
  output [7:0] diff,
  output bout
);
  wire [7:0] e;
  xor 
    x0(e[0],b[0],bin),
    x1(e[1],b[1],bin),
    x2(e[2],b[2],bin),
    x3(e[3],b[3],bin),
    x4(e[4],b[4],bin),
    x5(e[5],b[5],bin),
    x6(e[6],b[6],bin),
    x7(e[7],b[7],bin);
  adder8
     add8(bin,a[7:0],e,diff[7:0],bout);
endmodule

module and8(
  input [7:0] a,b,
  output [7:0] y
);
  
  and
    a0(y[0],a[0],b[0]),
    a1(y[1],a[1],b[1]),
    a2(y[2],a[2],b[2]),
    a3(y[3],a[3],b[3]),
    a4(y[4],a[4],b[4]),
    a5(y[5],a[5],b[5]),
    a6(y[6],a[6],b[6]),
    a7(y[7],a[7],b[7]);
endmodule

module or8(
  input [7:0] a,b,
  output [7:0] y
);
  
  or
    o0(y[0],a[0],b[0]),
    o1(y[1],a[1],b[1]),
    o2(y[2],a[2],b[2]),
    o3(y[3],a[3],b[3]),
    o4(y[4],a[4],b[4]),
    o5(y[5],a[5],b[5]),
    o6(y[6],a[6],b[6]),
    o7(y[7],a[7],b[7]);
endmodule

module mux8(
  input [7:0] d0,d1,d2,d3,d4,d5,d6,d7,
  input [2:0] s,
  output reg [7:0] y
);
  
  always @ (*)
    begin
      case (s)
        3'b000: y = d0 ;
        3'b001: y = d1 ;
        3'b010: y = d2 ;
        3'b011: y = d3 ;
        3'b100: y = d4 ;
        3'b101: y = d5 ;
        3'b110: y = d6 ;
        3'b111: y = d7 ;
        default: y = 8'bx;
      endcase
    end
endmodule


module alu(
  input [7:0] a,
  input [7:0] b,
  output [2:0] select,
  output zeroflag,
  output [7:0] result
);
  wire andab,orab,addab,subab;
  and8 And (a,b,andab);
  or8  Or (a,b,orab);
  adder8 Add (1'b0,a,b,addab);
  subtractor8 Sub (1'b1,a,b,subab);
  
  mux8 Mux (andab,orab,addab,subab,8'bx,8'bx,8'bx,8'bx,select,result);
  nor nor8 (zeroflag, result[0],result[1],result[2],result[3],result[4],result[5],result[6],result[7]);
  
endmodule

        
  
  
  
  
  



  
  
