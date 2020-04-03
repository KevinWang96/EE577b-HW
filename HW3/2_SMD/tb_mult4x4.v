/*
 * @Author: Yihao Wang
 * @Date: 2020-02-14 15:28:14
 * @LastEditTime: 2020-03-14 01:34:04
 * @LastEditors: Please set LastEditors
 * @Description: Testbench for 4-bit Booth Wooley 2's complement multiplier
 * @FilePath: /EE577b_HW/YihaoWang-HW3/2_SMD/tb_mult4x4.v
 */
`timescale 1ns/100ps
`define TRUE 1'b1
`define FALSE 1'b0
module tb_mult4x4;
    reg signed [3:0] InA, InB;
    wire signed [7:0] Product;

    parameter TIME_INTERVAL = 1;// Time interval between two test cases

    //Instantiation of DUT
    mult4x4 mult4x4_dut (
        .InA(InA),
        .InB(InB),
        .Product(Product)
    );

    integer in, out_file;// integer in is used to give exhaustive input test pattern
    initial
    begin : test
        integer expected; // local variable must be declared before all statements
        
        reg is_all_passed;// thsi flag is used to indicate if all test cases passed
        is_all_passed = `TRUE;

        out_file = $fopen("mult4x4.out", "w");
        for(in = 0; in < 2 ** 8; in = in + 1)
        begin : test_for_loop
            #(TIME_INTERVAL)
            {InA, InB} = in; // exhaustive test patterns
            #(0.1 * TIME_INTERVAL)
            expected = InA * InB;
            $fwrite(out_file, "\n<InA = %0d, InB = %0d, Product = %0d, Expected = %0d>", InA, InB, Product, expected);
            if(Product != expected)
            begin
                is_all_passed = `FALSE;
                $fwrite(out_file, " Test case failed!");
            end
        end
    if(is_all_passed) $fwrite(out_file, "\nAll %1d test cases successfully passed!", 2 ** 8); // check if all cased passed based on flag is_all_passed
    #(TIME_INTERVAL)
    $fclose(out_file);
    $finish;
    end
endmodule
`undef TRUE
`undef FALSE