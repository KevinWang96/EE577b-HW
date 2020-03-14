/*
 * @Author: Yihao Wang
 * @Date: 2020-02-15 16:40:09
 * @LastEditTime: 2020-03-14 01:37:06
 * @LastEditors: Please set LastEditors
 * @Description: Generates a 10-bit number with odd parity
 * @FilePath: /EE577b_HW/YihaoWang-HW3/5_PTF/function.v
 */
module parity_function(in, out);
    input [8:0] in;
    output [9:0] out;
    reg [9:0] out;

    function odd_parity_bit;
        input [8:0] in;
    begin
        odd_parity_bit = ~(^in); 
    end
    endfunction

    always @(*)
        out = {in, odd_parity_bit(in)};
        
endmodule
