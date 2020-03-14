/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP5-5
// Date      : Sat Feb 29 15:18:07 2020
/////////////////////////////////////////////////////////////


module ham_74_encoder ( d, c );
  input [3:0] d;
  output [7:0] c;
  wire   n1, n2;
  assign c[6] = d[3];
  assign c[5] = d[2];
  assign c[4] = d[1];
  assign c[2] = d[0];

  XOR2X1 U1 ( .A(c[4]), .B(n1), .Y(c[7]) );
  XOR2X1 U2 ( .A(c[5]), .B(n2), .Y(c[3]) );
  XOR2X1 U3 ( .A(c[6]), .B(n1), .Y(c[1]) );
  XOR2X1 U4 ( .A(c[2]), .B(c[5]), .Y(n1) );
  XOR2X1 U5 ( .A(c[2]), .B(n2), .Y(c[0]) );
  XOR2X1 U6 ( .A(c[4]), .B(c[6]), .Y(n2) );
endmodule

