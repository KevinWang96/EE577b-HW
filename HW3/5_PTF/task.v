/*
 * @Author: Yihao Wang
 * @Date: 2020-02-15 16:31:44
 * @LastEditTime: 2020-03-14 01:37:35
 * @LastEditors: Please set LastEditors
 * @Description: Generates a 10-bit number with even parity
 * @FilePath: /EE577b_HW/YihaoWang-HW3/5_PTF/task.v
 */
module parity_task(in, out);
    inout [8:0] in;
    output [9:0] out;
    reg [9:0] out;
    reg temp;
    
    task even_parity_bit;
        input [8:0] in;
        output parity_bit;
    begin
        parity_bit = ^in;
    end
    endtask

    always @(*)
    begin
        even_parity_bit(in, temp);
        out = {in, temp};
    end
endmodule
    
    