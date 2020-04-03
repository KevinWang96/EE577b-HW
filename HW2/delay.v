/* 
OR gate which performs "#4 OUT1 = A | B"
*/
module or2_1(
    input A, B,
    output reg OUT1
);

    always @(*) 
        #4 OUT1 = A | B;
endmodule

/* 
OR gate which performs "#4 OUT2 <= A | B"
*/
module or2_2(
    input A, B,
    output reg OUT2
);
    always @(*) 
        #4 OUT2 <= A | B;
endmodule

/* 
OR gate which performs "OUT3 = #4 A | B"
*/
module or2_3(
    input A, B,
    output reg OUT3
);
    always @(*) 
        OUT3 = #4 A | B;
endmodule

/* 
OR gate which performs "OUT4 <= #4 A | B"
*/
module or2_4(
    input A, B,
    output reg OUT4
);
    always @(*) 
        OUT4 <= #4 A | B;
endmodule

/* 
OR gate which performs "assign #4 OUT5 = A | B"
*/
module or2_5(
    input A, B,
    output OUT5
);
    assign #4 OUT5 = A | B;
endmodule




