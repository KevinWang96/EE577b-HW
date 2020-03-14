/*
 * @Author: Yihao Wang
 * @Date: 2020-02-14 00:48:55
 * @LastEditTime: 2020-03-14 01:30:28
 * @LastEditors: Please set LastEditors
 * @Description: 1-bit half adder using gate level modeling
 * @FilePath: /EE577b_HW/YihaoWang-HW3/2_SMD/ha.v
 */
module ha (a, b, sum, carry);
    input a, b;
    output sum, carry;

    xor (sum, a, b);
    and (carry, a, b);
endmodule