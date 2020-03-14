`timescale 1ns/1ps
`define TRUE 1
`define FALSE 0
`include "./include/gscl45nm.v"

/*
    Testbench for TM_ALU system
    Exhautive test all possible cases (2 ** 24 times)
*/
module tb_TM_ALU;

    parameter   WIDTH_OF_TXLEN = 8,
                WIDTH_OF_EXED = 8;

    parameter CLK_CYCLE = 5;

    reg clk, reset;
    reg [WIDTH_OF_EXED - 1:0] InstExed;
    reg [WIDTH_OF_TXLEN - 1:0] AvgTxLen, CurTxLen;
    wire [WIDTH_OF_EXED - 1:0] InstExed_new;
    wire [WIDTH_OF_TXLEN - 1:0] AvgTxLen_new;

    // Design under test
    TM_ALU TM_ALU_DUT (
        .clk(clk),
        .reset(reset),
        .AvgTxLen(AvgTxLen),
        .InstExed(InstExed),
        .CurTxLen(CurTxLen),
        .InstExed_new(InstExed_new),
        .AvgTxLen_new(AvgTxLen_new)
    );

    // Generate clock
    always #(0.5 * CLK_CYCLE) clk = ~ clk;

    integer out_file, log_file;
    initial
    begin
        out_file = $fopen("TM_ALU_syn.out", "w");
        log_file = $fopen("TM_ALU_log_syn.out", "w");
    end

    // Delay the inputs by 4 clocks in order to check the output
    reg [WIDTH_OF_TXLEN - 1:0] AvgTxLen_d0, AvgTxLen_d1, AvgTxLen_d2, AvgTxLen_d3;
    reg [WIDTH_OF_TXLEN - 1:0] CurTxLen_d0, CurTxLen_d1, CurTxLen_d2, CurTxLen_d3;
    reg [WIDTH_OF_EXED - 1:0] InstExed_d0, InstExed_d1, InstExed_d2, InstExed_d3;

    always @(posedge clk, posedge reset)
    begin
        if(reset)
        begin
            {AvgTxLen_d0, AvgTxLen_d1, AvgTxLen_d2, AvgTxLen_d3} <= 0;
            {CurTxLen_d0, CurTxLen_d1, CurTxLen_d2, CurTxLen_d3} <= 0;
            {InstExed_d0, InstExed_d1, InstExed_d2, InstExed_d3} <= 0;
        end
        else
        begin
            AvgTxLen_d0 <= AvgTxLen;
            AvgTxLen_d1 <= AvgTxLen_d0;
            AvgTxLen_d2 <= AvgTxLen_d1;
            AvgTxLen_d3 <= AvgTxLen_d2;

            CurTxLen_d0 <= CurTxLen;
            CurTxLen_d1 <= CurTxLen_d0;
            CurTxLen_d2 <= CurTxLen_d1;
            CurTxLen_d3 <= CurTxLen_d2;

            InstExed_d0 <= InstExed;
            InstExed_d1 <= InstExed_d0;
            InstExed_d2 <= InstExed_d1;
            InstExed_d3 <= InstExed_d2;
        end
    end



    initial
    fork : test
        integer count, num_case;
        
        clk = 1;
        reset = 1;
        #(3.5 * CLK_CYCLE) reset = 0;

        // Generate the input in each clock
        #(3.5 * CLK_CYCLE)
        begin 
            for(count = 0; count < 2 ** (2 * WIDTH_OF_TXLEN + WIDTH_OF_EXED); count = count + 1)
            begin : stimulus_loop

                // if InstExed is 255, it will cause overfow of InstExed + 1 which is 0
                // We don't want to test this illegal case, so we should skip when InstEved is 255
                if(count[(WIDTH_OF_EXED + WIDTH_OF_TXLEN - 1)-:WIDTH_OF_EXED] == 255)
                    count = count + (2 ** WIDTH_OF_TXLEN);

                // launches input 
                {AvgTxLen, InstExed, CurTxLen} = count;
                #(CLK_CYCLE);
            end
            #(5 * CLK_CYCLE) // wait for all results coming out from the pipeline
            $fdisplay(log_file, "All %1d test cases passed!", num_case);
            $fclose(out_file | log_file);
            $finish;
        end
        
        // Monitor and check the output in each clock
        num_case = 1;
        #(7.5 * CLK_CYCLE)
        forever
        begin : display_loop
            // I comment those code to avoid too large out file
            // $fdisplay(out_file, "################# Case #%1d ###################", num_case);
            // $fdisplay(out_file, "At time %1d ns", $time);
            // $fdisplay(out_file, "AvgTxLen = %1d, InstExed = %1d, CurTxLen = %1d", AvgTxLen_d3, InstExed_d3, CurTxLen_d3);
            // $fdisplay(out_file, "AvgTxLen_new = %1d, InstExed_new = %1d", AvgTxLen_new, InstExed_new);
            
            if(check(InstExed_d3, AvgTxLen_d3, CurTxLen_d3, InstExed_new, AvgTxLen_new) == `TRUE)
                $fdisplay(out_file, "(Case Passed!)");
            else 
            begin
                $fdisplay(out_file, "(Case Failed!)");
                $fdisplay(log_file, "Test case %1d failed!", num_case);
                $fclose(log_file | out_file);
                $finish; // if one test case failed, exit simulation
            end
            num_case = num_case + 1;
            #(CLK_CYCLE);
        end
    join

    // Checks the results
    function check;
        input [WIDTH_OF_EXED - 1:0] InstExed;
        input [WIDTH_OF_TXLEN - 1:0] AvgTxLen, CurTxLen;
        input [WIDTH_OF_EXED - 1:0] InstExed_new;
        input [WIDTH_OF_TXLEN - 1:0] AvgTxLen_new;
    begin
        if((AvgTxLen_new == ((AvgTxLen * InstExed + CurTxLen) / (InstExed + 1))) 
            && (InstExed_new == (InstExed + 1)))
            check = `TRUE;
        else
            check = `FALSE;
    end
    endfunction


	initial 
	begin
		$sdf_annotate("./netlist/TM_ALU.sdf", TM_ALU_DUT,,"sdf.log","MAXIMUM","1.0:1.0:1.0", "FROM_MAXIMUM");
		$enable_warnings;
		$log("ncsim.log");//outputs the log in console to file
	end

endmodule

`undef TRUE
`undef FALSE


        


    


    



