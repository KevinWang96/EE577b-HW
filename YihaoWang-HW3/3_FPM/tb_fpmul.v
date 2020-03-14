`timescale 1ns/100ps
`define NULL 0
module tb_fpmul;
    reg [31:0] oprA, oprB;
    wire [31:0] result;

    parameter CYCLE_TIME = 5;// clock cycle

    // Instantiaton of DUT: fpmul
    fpmul fpmul_dut(
        .oprA(oprA),
        .oprB(oprB),
        .Result(result)
    );

    integer in_file_a, in_file_b, out_file;
    initial
    begin : label
        integer count;
        in_file_a = $fopen("oprA", "r");
        in_file_b = $fopen("oprB", "r");
        out_file = $fopen("fpmul.out");
        #(CYCLE_TIME)

        count = 1;

        // if the last case duplicates in out log, it may becasue the input file(oprA, oprB) has a blank line before EOF.
        while((!$feof(in_file_a) && (!$feof(in_file_b)))) //stop testing when it reaches the end of file
        begin : test
            #(CYCLE_TIME)
            begin 
                $fdisplay(out_file, "----- Test Case %1d -----", count);
                $fdisplay(out_file, "oprA:  %1b %8b %23b", oprA[31], oprA[30-:8], oprA[22-:23]);
                $fdisplay(out_file, "oprB:  %1b %8b %23b", oprB[31], oprB[30-:8], oprB[22-:23]);
                $fdisplay(out_file, "Result:  %1b %8b %23b", result[31], result[30-:8], result[22-:23]);          
                count = count + 1;
            end
            #(CYCLE_TIME);
        end

        $fdisplay(out_file, "All test cases finished!");
        #(CYCLE_TIME)
        $fclose(in_file_a | in_file_b | out_file);
        $finish;
    end

endmodule
`undef NULL