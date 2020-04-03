/*
 * @Author: Yihao Wang
 * @Date: 2020-02-14 00:37:45
 * @LastEditTime: 2020-03-14 01:30:00
 * @LastEditors: Please set LastEditors
 * @Description: 1-bit full adder implemented by gate level 
 * @FilePath: /EE577b_HW/YihaoWang-HW3/2_SMD/fa.v
 */
module fa (a, b, ci, sum, carry);
    input a, b, ci;
    output carry, sum;

    wire w1, w2, w3;// intermediate wires

    xor (w1, a, b);
    xor (sum, w1, ci);

    nand (w2, w1, ci);
    nand (w3, a, b);
    nand (carry, w2, w3);
endmodule




