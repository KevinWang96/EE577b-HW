/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP5-5
// Date      : Sat Feb 29 18:38:56 2020
/////////////////////////////////////////////////////////////


module traffic_control_1hot ( CLK, reset, ERR, PA, PB, L_A, L_B, RA, RB );
  output [2:0] L_A;
  output [2:0] L_B;
  input CLK, reset, ERR, PA, PB;
  output RA, RB;
  wire   n190, n191, n192, from_3, pa_r, pb_r, n4, n6, n8, n10, n11, n15, n16,
         n19, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33,
         n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47,
         n49, n50, n52, n53, n54, n56, n58, n60, n61, n62, n64, n65, n66, n67,
         n69, n70, n71, n72, n73, n74, n75, n76, n77, n78, n79, n80, n81, n82,
         n83, n84, n86, n87, n88, n89, n90, n91, n92, n93, n94, n95, n96, n97,
         n98, n99, n100, n101, n102, n103, n104, n105, n106, n107, n108, n109,
         n110, n111, n112, n113, n114, n115, n116, n117, n118, n119, n120,
         n121, n122, n123, n124, n125, n126, n127, n128, n129, n130, n131,
         n132, n133, n134, n135, n136, n137, n141, n142, n143, n144, n145,
         n146, n147, n148, n149, n150, n151, n152, n153, n154, n155, n156,
         n157, n158, n159, n160, n161, n162, n163, n164, n165, n166, n167,
         n168, n169, n170, n171, n172, n173, n174, n175, n176, n177, n178,
         n179, n180, n181, n182, n183, n184, n185, n186, n187, n188, n189;
  wire   [2:0] timer;
  wire   [7:0] state;

  DFFPOSX1 pa_r_reg ( .D(n114), .CLK(CLK), .Q(pa_r) );
  DFFPOSX1 from_3_reg ( .D(n101), .CLK(CLK), .Q(from_3) );
  DFFPOSX1 state_reg_1_ ( .D(n105), .CLK(CLK), .Q(state[1]) );
  DFFPOSX1 timer_reg_1_ ( .D(n102), .CLK(CLK), .Q(timer[1]) );
  DFFPOSX1 state_reg_7_ ( .D(n113), .CLK(CLK), .Q(state[7]) );
  DFFPOSX1 state_reg_2_ ( .D(n106), .CLK(CLK), .Q(state[2]) );
  DFFPOSX1 state_reg_4_ ( .D(n108), .CLK(CLK), .Q(state[4]) );
  DFFPOSX1 state_reg_3_ ( .D(n107), .CLK(CLK), .Q(state[3]) );
  DFFPOSX1 state_reg_5_ ( .D(n109), .CLK(CLK), .Q(state[5]) );
  DFFPOSX1 state_reg_6_ ( .D(n110), .CLK(CLK), .Q(state[6]) );
  DFFPOSX1 state_reg_0_ ( .D(n111), .CLK(CLK), .Q(state[0]) );
  DFFPOSX1 timer_reg_0_ ( .D(n103), .CLK(CLK), .Q(timer[0]) );
  DFFPOSX1 timer_reg_2_ ( .D(n112), .CLK(CLK), .Q(timer[2]) );
  DFFPOSX1 pb_r_reg ( .D(n104), .CLK(CLK), .Q(pb_r) );
  OAI21X1 U34 ( .A(n8), .B(n28), .C(n129), .Y(n101) );
  OAI21X1 U36 ( .A(n33), .B(n149), .C(n186), .Y(n32) );
  NOR3X1 U37 ( .A(n24), .B(n23), .C(n64), .Y(n33) );
  OAI21X1 U38 ( .A(n134), .B(n26), .C(n119), .Y(n102) );
  NAND3X1 U39 ( .A(timer[0]), .B(n26), .C(n6), .Y(n36) );
  AOI21X1 U40 ( .A(n6), .B(n27), .C(n37), .Y(n35) );
  OAI21X1 U41 ( .A(timer[0]), .B(n38), .C(n181), .Y(n103) );
  OAI21X1 U43 ( .A(n74), .B(n148), .C(n128), .Y(n104) );
  OAI21X1 U46 ( .A(n161), .B(n30), .C(n142), .Y(n42) );
  OAI21X1 U47 ( .A(n132), .B(n188), .C(n127), .Y(n105) );
  AOI22X1 U49 ( .A(n23), .B(n117), .C(n16), .D(n28), .Y(n45) );
  OAI21X1 U50 ( .A(n188), .B(n173), .C(n126), .Y(n106) );
  OAI21X1 U52 ( .A(n188), .B(n166), .C(n125), .Y(n107) );
  OAI21X1 U54 ( .A(n131), .B(n188), .C(n124), .Y(n108) );
  AOI22X1 U56 ( .A(n23), .B(n116), .C(n16), .D(from_3), .Y(n53) );
  OAI21X1 U57 ( .A(n188), .B(n169), .C(n123), .Y(n109) );
  OAI21X1 U59 ( .A(n188), .B(n179), .C(n122), .Y(n110) );
  OAI21X1 U61 ( .A(n133), .B(n188), .C(n121), .Y(n111) );
  AOI21X1 U64 ( .A(n143), .B(n184), .C(n149), .Y(n61) );
  NAND3X1 U65 ( .A(n29), .B(n30), .C(n185), .Y(n56) );
  OAI21X1 U67 ( .A(n66), .B(n38), .C(n182), .Y(n112) );
  AOI22X1 U71 ( .A(n162), .B(n24), .C(n16), .D(n187), .Y(n69) );
  OAI21X1 U72 ( .A(n16), .B(n144), .C(n186), .Y(n37) );
  XOR2X1 U73 ( .A(n183), .B(timer[2]), .Y(n66) );
  OAI21X1 U75 ( .A(n4), .B(n154), .C(n186), .Y(n113) );
  AOI21X1 U77 ( .A(n73), .B(n162), .C(n78), .Y(n77) );
  OAI21X1 U78 ( .A(n135), .B(n136), .C(n150), .Y(n78) );
  NOR3X1 U81 ( .A(timer[0]), .B(timer[2]), .C(n26), .Y(n73) );
  OAI21X1 U83 ( .A(n74), .B(n147), .C(n120), .Y(n114) );
  OAI21X1 U86 ( .A(n161), .B(n29), .C(n142), .Y(n84) );
  AOI21X1 U87 ( .A(n16), .B(n25), .C(n149), .Y(n44) );
  NAND3X1 U88 ( .A(timer[0]), .B(n26), .C(timer[2]), .Y(n72) );
  NAND3X1 U91 ( .A(state[7]), .B(n151), .C(n137), .Y(n81) );
  NAND3X1 U95 ( .A(n179), .B(n166), .C(n64), .Y(n71) );
  NAND3X1 U97 ( .A(n163), .B(n192), .C(n179), .Y(n88) );
  NAND3X1 U99 ( .A(n179), .B(n177), .C(n173), .Y(L_B[0]) );
  NAND3X1 U100 ( .A(n177), .B(n157), .C(n89), .Y(n190) );
  NAND2X1 U103 ( .A(n173), .B(n11), .Y(L_A[1]) );
  NAND3X1 U104 ( .A(n177), .B(n163), .C(n92), .Y(n191) );
  NAND3X1 U111 ( .A(n166), .B(n177), .C(n169), .Y(L_A[0]) );
  NAND3X1 U114 ( .A(n22), .B(n21), .C(n153), .Y(n95) );
  NAND3X1 U120 ( .A(n170), .B(n19), .C(n152), .Y(n99) );
  OR2X1 U122 ( .A(n162), .B(n160), .Y(n43) );
  AND2X1 U123 ( .A(n186), .B(n154), .Y(n46) );
  AND2X1 U124 ( .A(pb_r), .B(n141), .Y(RB) );
  AND2X1 U125 ( .A(pa_r), .B(n141), .Y(RA) );
  OR2X1 U126 ( .A(n146), .B(state[5]), .Y(n86) );
  OR2X1 U127 ( .A(n145), .B(state[1]), .Y(n90) );
  AND2X1 U128 ( .A(n169), .B(n179), .Y(n92) );
  AND2X1 U129 ( .A(n173), .B(n166), .Y(n89) );
  BUFX2 U130 ( .A(n77), .Y(n115) );
  OR2X1 U131 ( .A(n34), .B(n156), .Y(n154) );
  OR2X1 U132 ( .A(n155), .B(n76), .Y(n156) );
  OR2X1 U133 ( .A(n158), .B(n159), .Y(n157) );
  INVX1 U134 ( .A(n157), .Y(n116) );
  OR2X1 U135 ( .A(n91), .B(n90), .Y(n159) );
  OR2X1 U136 ( .A(n164), .B(n165), .Y(n163) );
  INVX1 U137 ( .A(n163), .Y(n117) );
  OR2X1 U138 ( .A(n96), .B(n86), .Y(n165) );
  OR2X1 U139 ( .A(n167), .B(n168), .Y(n166) );
  OR2X1 U140 ( .A(n100), .B(n90), .Y(n168) );
  OR2X1 U141 ( .A(n93), .B(n171), .Y(n169) );
  OR2X1 U142 ( .A(n170), .B(n86), .Y(n171) );
  OR2X1 U143 ( .A(n97), .B(n176), .Y(n175) );
  INVX1 U144 ( .A(n175), .Y(n118) );
  OR2X1 U145 ( .A(n98), .B(state[0]), .Y(n176) );
  OR2X1 U146 ( .A(n90), .B(n178), .Y(n177) );
  OR2X1 U147 ( .A(n22), .B(n97), .Y(n178) );
  OR2X1 U148 ( .A(n19), .B(n180), .Y(n179) );
  OR2X1 U149 ( .A(n94), .B(n93), .Y(n180) );
  OR2X1 U150 ( .A(state[3]), .B(state[0]), .Y(n100) );
  OR2X1 U151 ( .A(n145), .B(n21), .Y(n98) );
  OR2X1 U152 ( .A(state[7]), .B(state[4]), .Y(n96) );
  OR2X1 U153 ( .A(state[4]), .B(n146), .Y(n94) );
  OR2X1 U154 ( .A(state[2]), .B(state[0]), .Y(n91) );
  AND2X1 U155 ( .A(n25), .B(n16), .Y(n76) );
  BUFX2 U156 ( .A(n36), .Y(n119) );
  AND2X1 U157 ( .A(pa_r), .B(n147), .Y(n83) );
  INVX1 U158 ( .A(n83), .Y(n120) );
  AND2X1 U159 ( .A(n10), .B(state[0]), .Y(n62) );
  INVX1 U160 ( .A(n62), .Y(n121) );
  AND2X1 U161 ( .A(n10), .B(state[6]), .Y(n60) );
  INVX1 U162 ( .A(n60), .Y(n122) );
  AND2X1 U163 ( .A(n10), .B(state[5]), .Y(n58) );
  INVX1 U164 ( .A(n58), .Y(n123) );
  AND2X1 U165 ( .A(n10), .B(state[4]), .Y(n54) );
  INVX1 U166 ( .A(n54), .Y(n124) );
  AND2X1 U167 ( .A(n10), .B(state[3]), .Y(n52) );
  INVX1 U168 ( .A(n52), .Y(n125) );
  AND2X1 U169 ( .A(n10), .B(state[2]), .Y(n50) );
  INVX1 U170 ( .A(n50), .Y(n126) );
  AND2X1 U171 ( .A(n10), .B(state[1]), .Y(n47) );
  INVX1 U172 ( .A(n47), .Y(n127) );
  AND2X1 U173 ( .A(pb_r), .B(n148), .Y(n41) );
  INVX1 U174 ( .A(n41), .Y(n128) );
  AND2X1 U175 ( .A(n8), .B(n116), .Y(n31) );
  INVX1 U176 ( .A(n31), .Y(n129) );
  BUFX2 U177 ( .A(n69), .Y(n130) );
  BUFX2 U178 ( .A(n53), .Y(n131) );
  BUFX2 U179 ( .A(n45), .Y(n132) );
  BUFX2 U180 ( .A(n61), .Y(n133) );
  BUFX2 U181 ( .A(n35), .Y(n134) );
  AND2X1 U182 ( .A(timer[1]), .B(n160), .Y(n79) );
  INVX1 U183 ( .A(n79), .Y(n135) );
  AND2X1 U184 ( .A(timer[2]), .B(timer[0]), .Y(n80) );
  INVX1 U185 ( .A(n80), .Y(n136) );
  OR2X1 U186 ( .A(state[6]), .B(state[4]), .Y(n87) );
  INVX1 U187 ( .A(n87), .Y(n137) );
  BUFX2 U188 ( .A(n191), .Y(L_B[2]) );
  BUFX2 U189 ( .A(n190), .Y(L_A[2]) );
  AND2X1 U190 ( .A(n169), .B(n15), .Y(n192) );
  INVX1 U191 ( .A(n192), .Y(L_B[1]) );
  BUFX2 U192 ( .A(n88), .Y(n141) );
  BUFX2 U193 ( .A(n44), .Y(n142) );
  AND2X1 U194 ( .A(n157), .B(n163), .Y(n64) );
  INVX1 U195 ( .A(n64), .Y(n143) );
  AND2X1 U196 ( .A(n161), .B(n150), .Y(n74) );
  INVX1 U197 ( .A(n74), .Y(n144) );
  BUFX2 U198 ( .A(n99), .Y(n145) );
  BUFX2 U199 ( .A(n95), .Y(n146) );
  AND2X1 U200 ( .A(n186), .B(n84), .Y(n82) );
  INVX1 U201 ( .A(n82), .Y(n147) );
  AND2X1 U202 ( .A(n186), .B(n42), .Y(n40) );
  INVX1 U203 ( .A(n40), .Y(n148) );
  INVX1 U204 ( .A(n150), .Y(n149) );
  BUFX2 U205 ( .A(n81), .Y(n150) );
  INVX1 U206 ( .A(n86), .Y(n151) );
  OR2X1 U207 ( .A(state[7]), .B(state[6]), .Y(n93) );
  INVX1 U208 ( .A(n93), .Y(n152) );
  OR2X1 U209 ( .A(state[3]), .B(state[2]), .Y(n97) );
  INVX1 U210 ( .A(n97), .Y(n153) );
  INVX1 U211 ( .A(n115), .Y(n155) );
  INVX1 U212 ( .A(state[3]), .Y(n158) );
  AND2X1 U213 ( .A(n173), .B(n169), .Y(n70) );
  INVX1 U214 ( .A(n70), .Y(n160) );
  INVX1 U215 ( .A(n43), .Y(n161) );
  BUFX2 U216 ( .A(n71), .Y(n162) );
  INVX1 U217 ( .A(state[6]), .Y(n164) );
  INVX1 U218 ( .A(state[2]), .Y(n167) );
  INVX1 U219 ( .A(state[4]), .Y(n170) );
  INVX1 U220 ( .A(n174), .Y(n172) );
  INVX1 U221 ( .A(n172), .Y(n173) );
  BUFX2 U222 ( .A(n49), .Y(n174) );
  INVX1 U223 ( .A(n118), .Y(n49) );
  AND2X1 U224 ( .A(timer[0]), .B(n37), .Y(n39) );
  INVX1 U225 ( .A(n39), .Y(n181) );
  AND2X1 U226 ( .A(timer[2]), .B(n37), .Y(n67) );
  INVX1 U227 ( .A(n67), .Y(n182) );
  AND2X1 U228 ( .A(timer[0]), .B(timer[1]), .Y(n75) );
  INVX1 U229 ( .A(n75), .Y(n183) );
  BUFX2 U230 ( .A(n56), .Y(n184) );
  OR2X1 U231 ( .A(pb_r), .B(pa_r), .Y(n65) );
  INVX1 U232 ( .A(n65), .Y(n185) );
  OR2X1 U233 ( .A(reset), .B(ERR), .Y(n34) );
  INVX1 U234 ( .A(n34), .Y(n186) );
  BUFX2 U235 ( .A(n72), .Y(n187) );
  INVX1 U236 ( .A(n46), .Y(n188) );
  OR2X1 U237 ( .A(n37), .B(n189), .Y(n38) );
  AND2X1 U238 ( .A(n130), .B(n70), .Y(n189) );
  INVX1 U239 ( .A(n154), .Y(n10) );
  INVX1 U240 ( .A(L_B[2]), .Y(n11) );
  INVX1 U241 ( .A(n32), .Y(n8) );
  INVX1 U242 ( .A(L_A[2]), .Y(n15) );
  INVX1 U243 ( .A(n184), .Y(n23) );
  INVX1 U244 ( .A(n177), .Y(n16) );
  INVX1 U245 ( .A(n73), .Y(n24) );
  INVX1 U246 ( .A(n187), .Y(n25) );
  INVX1 U247 ( .A(state[5]), .Y(n19) );
  INVX1 U248 ( .A(state[7]), .Y(n4) );
  INVX1 U249 ( .A(n38), .Y(n6) );
  INVX1 U250 ( .A(state[0]), .Y(n22) );
  INVX1 U251 ( .A(state[1]), .Y(n21) );
  INVX1 U252 ( .A(PB), .Y(n30) );
  INVX1 U253 ( .A(PA), .Y(n29) );
  INVX1 U254 ( .A(timer[1]), .Y(n26) );
  INVX1 U255 ( .A(timer[0]), .Y(n27) );
  INVX1 U256 ( .A(from_3), .Y(n28) );
endmodule

