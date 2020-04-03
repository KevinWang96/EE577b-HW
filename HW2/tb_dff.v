`timescale 1ns/1ps
module tb_dff;
    reg common_clk;
    reg d_alpha, rst_alpha, en_alpha;
    wire d_beta, rst_beta, en_beta, d_gamma, rst_gamma, en_gamma, d_delta, rst_delta, en_delta;
    wire q_alpha, q_beta, q_gamma, q_delta;

    parameter CLK_CYCLE = 10; // clock cycle: 10ns (100MHz)

    // Instantiation of DUT:
    dff_alpha dff_alpha_dut(.clk(common_clk), .rst(rst_alpha), .en(en_alpha), .d(d_alpha), .q(q_alpha));
    dff_beta dff_beta_dut(.clk(common_clk), .rst(rst_beta), .en(en_beta), .d(d_beta), .q(q_beta));
    dff_gamma dff_gamma_dut(.clk(common_clk), .rst(rst_gamma), .en(en_gamma), .d(d_gamma), .q(q_gamma));
    dff_delta dff_delta_dut(.clk(common_clk), .rst(rst_delta), .en(en_delta), .d(d_delta), .q(q_delta));

    // Generates the clock signal with 100MHz:
    always #(CLK_CYCLE / 2) common_clk = ~ common_clk;

    assign d_beta = d_alpha;
    assign rst_beta = rst_alpha;
    assign en_beta = ~ en_alpha;

    assign d_gamma = d_alpha;
    assign rst_gamma = ~ rst_alpha;
    assign en_gamma = en_alpha;

    assign d_delta = d_alpha;
    assign rst_delta = ~ rst_alpha;
    assign en_delta = ~ en_alpha;

    // Generates the stimulus:
    initial 
    fork
        common_clk = 0;

        //initialization of stimulus for dff_alpha:
        rst_alpha = 1;
        #(5.2 * CLK_CYCLE) rst_alpha = 0;
        #(9.5 * CLK_CYCLE) rst_alpha = 1;
        en_alpha = 0;
        #(7.2 * CLK_CYCLE) en_alpha = 1;
        #(9.2 * CLK_CYCLE) en_alpha = 0;
        #(11.2 * CLK_CYCLE) en_alpha = 1;
        d_alpha = 0;
        #(5.5 * CLK_CYCLE) d_alpha = 0;
        #(6.5 * CLK_CYCLE) d_alpha = 1;
        #(7.5 * CLK_CYCLE) d_alpha = 0;
        #(8.5 * CLK_CYCLE) d_alpha = 1;
        #(9.5 * CLK_CYCLE) d_alpha = 0;
        #(10.5 * CLK_CYCLE) d_alpha = 1;
        #(11.5 * CLK_CYCLE) d_alpha = 0;
        #(12.5 * CLK_CYCLE) d_alpha = 1;
        #(13.5 * CLK_CYCLE) $finish;
    join
   
    // Monitors the outputs and generates output log files
    //initialization of system tasks:
    reg [31:0] the_file_alpha, the_file_beta, the_file_gamma, the_file_delta;
    initial 
    begin
    the_file_alpha = $fopen("dff_alpha.out", "w");
    $fdisplay(the_file_alpha, "The simulation reports for dff_alpha: ");
    $fmonitor(the_file_alpha, "At time %d ns, clk = %b, rst = %b, en = %b, d = %b, q = %b", $time, common_clk, rst_alpha, en_alpha, d_alpha, q_alpha);
    
    the_file_beta = $fopen("dff_beta.out", "w");
    $fdisplay(the_file_beta, "The simulation reports for dff_beta: ");
    $fmonitor(the_file_beta, "At time %d ns, clk = %b, rst = %b, en = %b, d = %b, q = %b", $time, common_clk, rst_beta, en_beta, d_beta, q_beta);   
    
    the_file_gamma = $fopen("dff_gamma.out", "w");
    $fdisplay(the_file_gamma, "The simulation reports for dff_gamma: ");
    $fmonitor(the_file_gamma, "At time %d ns, clk = %b, rst = %b, en = %b, d = %b, q = %b", $time, common_clk, rst_gamma, en_gamma, d_gamma, q_gamma);    
    
    the_file_delta = $fopen("dff_delta.out", "w");
    $fdisplay(the_file_delta, "The simulation reports for dff_delta: ");
    $fmonitor(the_file_delta, "At time %d ns, clk = %b, rst = %b, en = %b, d = %b, q = %b", $time, common_clk, rst_delta, en_delta, d_delta, q_delta);
    
    #(13.5 * CLK_CYCLE) $fclose(the_file_alpha | the_file_beta | the_file_gamma | the_file_delta);
    end

endmodule



