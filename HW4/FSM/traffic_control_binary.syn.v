/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP5-5
// Date      : Sat Feb 29 17:57:55 2020
/////////////////////////////////////////////////////////////


module traffic_control_binary ( CLK, reset, ERR, PA, PB, L_A, L_B, RA, RB );
  output [2:0] L_A;
  output [2:0] L_B;
  input CLK, reset, ERR, PA, PB;
  output RA, RB;
  wire   n145, n146, n147, from_3, pa_r, pb_r, n4, n6, n9, n12, n13, n14, n15,
         n16, n17, n18, n19, n20, n21, n22, n23, n24, n26, n27, n28, n29, n30,
         n31, n32, n33, n34, n35, n36, n38, n39, n40, n41, n42, n43, n44, n45,
         n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59,
         n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72, n73,
         n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n86, n87,
         n88, n89, n90, n91, n92, n93, n94, n95, n96, n97, n98, n99, n100,
         n101, n102, n103, n104, n105, n106, n107, n108, n109, n110, n111,
         n112, n116, n117, n118, n119, n120, n121, n122, n123, n124, n125,
         n126, n127, n128, n129, n130, n131, n132, n133, n134, n135, n136,
         n137, n138, n139, n140, n141, n142, n143, n144;
  wire   [2:0] timer;
  wire   [2:0] state;

  DFFPOSX1 pa_r_reg ( .D(n88), .CLK(CLK), .Q(pa_r) );
  DFFPOSX1 state_reg_0_ ( .D(n93), .CLK(CLK), .Q(state[0]) );
  DFFPOSX1 state_reg_1_ ( .D(n94), .CLK(CLK), .Q(state[1]) );
  DFFPOSX1 state_reg_2_ ( .D(n92), .CLK(CLK), .Q(state[2]) );
  DFFPOSX1 timer_reg_0_ ( .D(n85), .CLK(CLK), .Q(timer[0]) );
  DFFPOSX1 timer_reg_1_ ( .D(n84), .CLK(CLK), .Q(timer[1]) );
  DFFPOSX1 timer_reg_2_ ( .D(n83), .CLK(CLK), .Q(timer[2]) );
  DFFPOSX1 from_3_reg ( .D(n87), .CLK(CLK), .Q(from_3) );
  DFFPOSX1 pb_r_reg ( .D(n80), .CLK(CLK), .Q(pb_r) );
  OAI21X1 U32 ( .A(n28), .B(n123), .C(n100), .Y(n80) );
  OAI21X1 U35 ( .A(n132), .B(n27), .C(n117), .Y(n32) );
  AOI22X1 U37 ( .A(n109), .B(n127), .C(n91), .D(state[1]), .Y(n35) );
  NAND3X1 U38 ( .A(n142), .B(n136), .C(n134), .Y(n36) );
  AOI22X1 U40 ( .A(n108), .B(n127), .C(n91), .D(state[0]), .Y(n41) );
  NAND3X1 U41 ( .A(n137), .B(n136), .C(n111), .Y(n42) );
  AOI22X1 U42 ( .A(n9), .B(n18), .C(n13), .D(n24), .Y(n44) );
  OAI21X1 U43 ( .A(n46), .B(n125), .C(n138), .Y(n83) );
  XNOR2X1 U45 ( .A(n139), .B(n20), .Y(n46) );
  OAI21X1 U47 ( .A(n106), .B(n22), .C(n96), .Y(n84) );
  NAND3X1 U48 ( .A(timer[0]), .B(n22), .C(n47), .Y(n51) );
  AOI21X1 U49 ( .A(n47), .B(n23), .C(n31), .Y(n50) );
  OAI21X1 U50 ( .A(timer[0]), .B(n125), .C(n99), .Y(n85) );
  AOI22X1 U54 ( .A(n118), .B(n126), .C(n13), .D(n120), .Y(n54) );
  AOI22X1 U56 ( .A(n107), .B(n127), .C(n91), .D(state[2]), .Y(n59) );
  AOI22X1 U58 ( .A(n19), .B(n126), .C(n13), .D(n21), .Y(n63) );
  NAND3X1 U59 ( .A(timer[0]), .B(n124), .C(n112), .Y(n61) );
  NAND3X1 U61 ( .A(n137), .B(n142), .C(n110), .Y(n60) );
  AOI22X1 U62 ( .A(n14), .B(n18), .C(from_3), .D(n13), .Y(n65) );
  OAI21X1 U63 ( .A(n121), .B(n24), .C(n98), .Y(n87) );
  AOI21X1 U65 ( .A(n105), .B(n143), .C(n31), .Y(n67) );
  NAND3X1 U66 ( .A(n19), .B(n119), .C(n140), .Y(n70) );
  NAND3X1 U67 ( .A(n26), .B(n27), .C(n141), .Y(n66) );
  NAND3X1 U69 ( .A(n23), .B(n20), .C(timer[1]), .Y(n56) );
  OAI21X1 U70 ( .A(n28), .B(n122), .C(n97), .Y(n88) );
  OAI21X1 U73 ( .A(n132), .B(n26), .C(n117), .Y(n75) );
  AOI21X1 U74 ( .A(n21), .B(n13), .C(n4), .Y(n34) );
  NAND3X1 U75 ( .A(timer[0]), .B(n22), .C(timer[2]), .Y(n58) );
  NAND3X1 U77 ( .A(state[1]), .B(state[0]), .C(state[2]), .Y(n62) );
  NAND3X1 U80 ( .A(n142), .B(n136), .C(n71), .Y(n57) );
  NAND3X1 U82 ( .A(n142), .B(n147), .C(n133), .Y(n77) );
  NAND3X1 U84 ( .A(n142), .B(n135), .C(n134), .Y(L_B[0]) );
  NAND3X1 U85 ( .A(n136), .B(n135), .C(n78), .Y(n145) );
  NAND3X1 U86 ( .A(state[0]), .B(n15), .C(state[1]), .Y(n69) );
  NAND2X1 U87 ( .A(n134), .B(n6), .Y(L_A[1]) );
  NAND3X1 U88 ( .A(n142), .B(n135), .C(n79), .Y(n146) );
  NAND3X1 U89 ( .A(state[1]), .B(n17), .C(state[2]), .Y(n45) );
  NAND3X1 U90 ( .A(state[0]), .B(n16), .C(state[2]), .Y(n38) );
  NAND3X1 U91 ( .A(n16), .B(n15), .C(state[0]), .Y(n40) );
  NAND3X1 U92 ( .A(n136), .B(n135), .C(n137), .Y(L_A[0]) );
  NAND3X1 U93 ( .A(n17), .B(n16), .C(state[2]), .Y(n43) );
  NAND3X1 U94 ( .A(n16), .B(n15), .C(n17), .Y(n76) );
  NAND3X1 U95 ( .A(n17), .B(n15), .C(state[1]), .Y(n39) );
  OR2X1 U96 ( .A(n126), .B(n124), .Y(n33) );
  AND2X1 U97 ( .A(n132), .B(n143), .Y(n28) );
  AND2X1 U98 ( .A(pb_r), .B(n116), .Y(RB) );
  AND2X1 U99 ( .A(pa_r), .B(n116), .Y(RA) );
  AND2X1 U100 ( .A(n144), .B(n95), .Y(n47) );
  AND2X1 U101 ( .A(n137), .B(n133), .Y(n79) );
  AND2X1 U102 ( .A(n134), .B(n131), .Y(n78) );
  BUFX2 U103 ( .A(n63), .Y(n89) );
  BUFX2 U104 ( .A(n61), .Y(n90) );
  OR2X1 U105 ( .A(n129), .B(n130), .Y(n127) );
  INVX1 U106 ( .A(n127), .Y(n91) );
  OR2X1 U107 ( .A(n128), .B(n4), .Y(n130) );
  AND2X1 U108 ( .A(n101), .B(n144), .Y(n86) );
  INVX1 U109 ( .A(n86), .Y(n92) );
  AND2X1 U110 ( .A(n103), .B(n144), .Y(n82) );
  INVX1 U111 ( .A(n82), .Y(n93) );
  AND2X1 U112 ( .A(n104), .B(n144), .Y(n81) );
  INVX1 U113 ( .A(n81), .Y(n94) );
  AND2X1 U114 ( .A(n102), .B(n55), .Y(n53) );
  INVX1 U115 ( .A(n53), .Y(n95) );
  BUFX2 U116 ( .A(n51), .Y(n96) );
  AND2X1 U117 ( .A(pa_r), .B(n122), .Y(n74) );
  INVX1 U118 ( .A(n74), .Y(n97) );
  AND2X1 U119 ( .A(n121), .B(n14), .Y(n68) );
  INVX1 U120 ( .A(n68), .Y(n98) );
  AND2X1 U121 ( .A(timer[0]), .B(n31), .Y(n52) );
  INVX1 U122 ( .A(n52), .Y(n99) );
  AND2X1 U123 ( .A(pb_r), .B(n123), .Y(n30) );
  INVX1 U124 ( .A(n30), .Y(n100) );
  BUFX2 U125 ( .A(n59), .Y(n101) );
  BUFX2 U126 ( .A(n54), .Y(n102) );
  BUFX2 U127 ( .A(n41), .Y(n103) );
  BUFX2 U128 ( .A(n35), .Y(n104) );
  BUFX2 U129 ( .A(n70), .Y(n105) );
  BUFX2 U130 ( .A(n50), .Y(n106) );
  BUFX2 U131 ( .A(n60), .Y(n107) );
  BUFX2 U132 ( .A(n42), .Y(n108) );
  BUFX2 U133 ( .A(n36), .Y(n109) );
  BUFX2 U134 ( .A(n65), .Y(n110) );
  BUFX2 U135 ( .A(n44), .Y(n111) );
  OR2X1 U136 ( .A(n22), .B(n20), .Y(n64) );
  INVX1 U137 ( .A(n64), .Y(n112) );
  BUFX2 U138 ( .A(n146), .Y(L_B[2]) );
  BUFX2 U139 ( .A(n145), .Y(L_A[2]) );
  AND2X1 U140 ( .A(n137), .B(n12), .Y(n147) );
  INVX1 U141 ( .A(n147), .Y(L_B[1]) );
  BUFX2 U142 ( .A(n77), .Y(n116) );
  BUFX2 U143 ( .A(n34), .Y(n117) );
  BUFX2 U144 ( .A(n56), .Y(n118) );
  AND2X1 U145 ( .A(n131), .B(n133), .Y(n71) );
  INVX1 U146 ( .A(n71), .Y(n119) );
  BUFX2 U147 ( .A(n58), .Y(n120) );
  BUFX2 U148 ( .A(n67), .Y(n121) );
  AND2X1 U149 ( .A(n144), .B(n75), .Y(n73) );
  INVX1 U150 ( .A(n73), .Y(n122) );
  AND2X1 U151 ( .A(n144), .B(n32), .Y(n29) );
  INVX1 U152 ( .A(n29), .Y(n123) );
  AND2X1 U153 ( .A(n134), .B(n137), .Y(n55) );
  INVX1 U154 ( .A(n55), .Y(n124) );
  INVX1 U155 ( .A(n47), .Y(n125) );
  BUFX2 U156 ( .A(n57), .Y(n126) );
  INVX1 U157 ( .A(n89), .Y(n128) );
  INVX1 U158 ( .A(n90), .Y(n129) );
  BUFX2 U159 ( .A(n69), .Y(n131) );
  INVX1 U160 ( .A(n33), .Y(n132) );
  BUFX2 U161 ( .A(n45), .Y(n133) );
  BUFX2 U162 ( .A(n40), .Y(n134) );
  BUFX2 U163 ( .A(n76), .Y(n135) );
  BUFX2 U164 ( .A(n39), .Y(n136) );
  BUFX2 U165 ( .A(n43), .Y(n137) );
  AND2X1 U166 ( .A(timer[2]), .B(n31), .Y(n48) );
  INVX1 U167 ( .A(n48), .Y(n138) );
  AND2X1 U168 ( .A(timer[1]), .B(timer[0]), .Y(n49) );
  INVX1 U169 ( .A(n49), .Y(n139) );
  BUFX2 U170 ( .A(n66), .Y(n140) );
  OR2X1 U171 ( .A(pb_r), .B(pa_r), .Y(n72) );
  INVX1 U172 ( .A(n72), .Y(n141) );
  BUFX2 U173 ( .A(n38), .Y(n142) );
  BUFX2 U174 ( .A(n62), .Y(n143) );
  OR2X1 U175 ( .A(reset), .B(ERR), .Y(n31) );
  INVX1 U176 ( .A(n31), .Y(n144) );
  INVX1 U177 ( .A(n135), .Y(n13) );
  INVX1 U178 ( .A(L_A[2]), .Y(n12) );
  INVX1 U179 ( .A(L_B[2]), .Y(n6) );
  INVX1 U180 ( .A(n140), .Y(n18) );
  INVX1 U181 ( .A(n143), .Y(n4) );
  INVX1 U182 ( .A(n133), .Y(n9) );
  INVX1 U183 ( .A(n131), .Y(n14) );
  INVX1 U184 ( .A(n120), .Y(n21) );
  INVX1 U185 ( .A(n118), .Y(n19) );
  INVX1 U186 ( .A(state[2]), .Y(n15) );
  INVX1 U187 ( .A(state[0]), .Y(n17) );
  INVX1 U188 ( .A(state[1]), .Y(n16) );
  INVX1 U189 ( .A(PB), .Y(n27) );
  INVX1 U190 ( .A(PA), .Y(n26) );
  INVX1 U191 ( .A(timer[2]), .Y(n20) );
  INVX1 U192 ( .A(timer[1]), .Y(n22) );
  INVX1 U193 ( .A(timer[0]), .Y(n23) );
  INVX1 U194 ( .A(from_3), .Y(n24) );
endmodule

