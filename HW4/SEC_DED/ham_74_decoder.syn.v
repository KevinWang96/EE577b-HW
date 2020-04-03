/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP5-5
// Date      : Sat Feb 29 15:18:08 2020
/////////////////////////////////////////////////////////////


module ham_74_decoder ( c, qc, qd, x );
  input [7:0] c;
  output [7:0] qc;
  output [3:0] qd;
  output x;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28;
  assign qd[3] = qc[6];
  assign qd[2] = qc[5];
  assign qd[1] = qc[4];
  assign qd[0] = qc[2];

  XNOR2X1 U5 ( .A(c[6]), .B(n27), .Y(qc[6]) );
  XNOR2X1 U7 ( .A(c[3]), .B(n24), .Y(qc[3]) );
  XNOR2X1 U9 ( .A(c[1]), .B(n22), .Y(qc[1]) );
  XNOR2X1 U11 ( .A(c[0]), .B(n26), .Y(qc[0]) );
  AOI21X1 U13 ( .A(n28), .B(n2), .C(n12), .Y(x) );
  XNOR2X1 U14 ( .A(qc[7]), .B(c[7]), .Y(n12) );
  FAX1 U15 ( .A(qc[2]), .B(qc[4]), .C(qc[5]), .YS(qc[7]) );
  XNOR2X1 U16 ( .A(n20), .B(c[5]), .Y(qc[5]) );
  XNOR2X1 U19 ( .A(n21), .B(c[4]), .Y(qc[4]) );
  XNOR2X1 U21 ( .A(n23), .B(c[2]), .Y(qc[2]) );
  FAX1 U23 ( .A(c[4]), .B(n18), .C(c[3]), .YS(n5) );
  FAX1 U25 ( .A(c[2]), .B(n18), .C(c[1]), .YS(n16) );
  XOR2X1 U26 ( .A(c[5]), .B(c[6]), .Y(n18) );
  FAX1 U27 ( .A(c[2]), .B(n19), .C(c[0]), .YS(n14) );
  XOR2X1 U28 ( .A(c[6]), .B(c[4]), .Y(n19) );
  AND2X1 U29 ( .A(n25), .B(n5), .Y(n13) );
  INVX1 U30 ( .A(n13), .Y(n20) );
  AND2X1 U31 ( .A(n11), .B(n5), .Y(n15) );
  INVX1 U32 ( .A(n15), .Y(n21) );
  AND2X1 U33 ( .A(n2), .B(n25), .Y(n8) );
  INVX1 U34 ( .A(n8), .Y(n22) );
  AND2X1 U35 ( .A(n4), .B(n2), .Y(n17) );
  INVX1 U36 ( .A(n17), .Y(n23) );
  AND2X1 U37 ( .A(n28), .B(n5), .Y(n6) );
  INVX1 U38 ( .A(n6), .Y(n24) );
  OR2X1 U39 ( .A(n14), .B(n1), .Y(n9) );
  INVX1 U40 ( .A(n9), .Y(n25) );
  AND2X1 U41 ( .A(n2), .B(n11), .Y(n10) );
  INVX1 U42 ( .A(n10), .Y(n26) );
  AND2X1 U43 ( .A(n4), .B(n5), .Y(n3) );
  INVX1 U44 ( .A(n3), .Y(n27) );
  OR2X1 U45 ( .A(n14), .B(n16), .Y(n7) );
  INVX1 U46 ( .A(n7), .Y(n28) );
  INVX1 U47 ( .A(n5), .Y(n2) );
  INVX1 U48 ( .A(n16), .Y(n1) );
  AND2X1 U49 ( .A(n1), .B(n14), .Y(n11) );
  AND2X1 U50 ( .A(n14), .B(n16), .Y(n4) );
endmodule

