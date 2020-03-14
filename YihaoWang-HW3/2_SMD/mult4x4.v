/* 
    4-bit 2's compliment multiplier using Baugh-Wooley carry save algorithm
*/
module mult4x4(
    input [3:0] InA, InB,
    output [7:0] Product
);
    wire [3:0] pp [3:0];// 4 rows of partial products, each row has 4 bits
    
    //generates 4 rows of partial products using AND gates
    and and_array_0 [3:0] (pp[0], InA, InB[0]);
    and and_array_1 [3:0] (pp[1], InA, InB[1]);
    and and_array_2 [3:0] (pp[2], InA, InB[2]);
    and and_array_3 [3:0] (pp[3], InA, InB[3]);

    //carry and sum of 1st row
    wire [3:0] carry_0, sum_0;
    assign carry_0 = 0;
    assign sum_0[2:0] = pp[0][2:0];
    not (sum_0[3], pp[0][3]);

    //carry and sum of 2nd row
    wire [4:1] carry_1, sum_1;
    ha ha_array_1 [2:0] (
        .a(sum_0[3:1]),
        .b(pp[1][2:0]),
        .carry(carry_1[3:1]),
        .sum(sum_1[3:1])
    );
    not (sum_1[4], pp[1][3]);
    assign carry_1[4] = 0;

    //carry and sum of 3rd row
    wire [5:2] sum_2, carry_2;
    fa fa_arrya_2 [2:0] (
        .a(pp[2][2:0]),
        .b(sum_1[4:2]),
        .ci(carry_1[3:1]),
        .carry(carry_2[4:2]),
        .sum(sum_2[4:2])
    );
    assign carry_2[5] = 0;
    not (sum_2[5], pp[2][3]);

    //carry and sum of 4th row
    wire [6:3] carry_3, sum_3;
    wire [2:0] pp3_i;//the inverse value of pp[3][2:0]
    not not_array [2:0] (pp3_i[2:0], pp[3][2:0]);
    fa fa_array_3 [2:0] (
        .a(pp3_i[2:0]),
        .b(carry_2[4:2]),
        .ci(sum_2   
        [5:3]),
        .carry(carry_3[5:3]),
        .sum(sum_3[5:3])
    );
    assign carry_3[6] = 0;
    assign sum_3[6] = pp[3][3];

    //last row of carry save adder and generates product
    assign Product[0] = sum_0[0];
    assign Product[1] = sum_1[1];
    assign Product[2] = sum_2[2];
    assign Product[3] = sum_3[3];
    fa fa_4_4 (.a(sum_3[4]), .b(carry_3[3]), .ci(1'b1), .carry(c1), .sum(Product[4]));
    fa fa_4_5 (.a(sum_3[5]), .b(carry_3[4]), .ci(c1), .carry(c2), .sum(Product[5]));
    fa fa_4_6 (.a(sum_3[6]), .b(carry_3[5]), .ci(c2), .carry(c3), .sum(Product[6]));
    not (Product[7], c3);

endmodule
