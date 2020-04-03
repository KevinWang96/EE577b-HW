`timescale 1ns/1ps
`include "./include/gscl45nm.v"

/*
    Testbench for 7_4 Extended Hamming Code encoding and decoding system
*/
module tb_ham;

    parameter CLK_CYCLE = 20;
    parameter NUM_OF_TEST = 100000; // How many time you want to test

    //inputs signals
    reg [3:0] d;
    reg [2:0] e0, e1;

    //outputs signals
    wire [3:0] d_out;
    wire [7:0] q_out;
    wire [3:0] qd_out;
    wire x_out;
    
    // Combinational logic for 3 to 8 decoder
    function automatic [7:0] decoder_3_8;
    input [2:0] in;
    begin
        case(in)
            3'b000: decoder_3_8 = 8'b0000_0001;
            3'b001: decoder_3_8 = 8'b0000_0010;
            3'b010: decoder_3_8 = 8'b0000_0100;
            3'b011: decoder_3_8 = 8'b0000_1000;
            3'b100: decoder_3_8 = 8'b0001_0000;
            3'b101: decoder_3_8 = 8'b0010_0000;
            3'b110: decoder_3_8 = 8'b0100_0000;
            3'b111: decoder_3_8 = 8'b1000_0000;
        endcase
    end
    endfunction

    // Active high asynchronous reset signal and clock
    reg reset, clk;

    // Stage 0 and Stage 1:
    reg[9:0] stage_0; //stage register 0
    reg[27:0] stage_1; //stage register 1
    wire [7:0] c_out; // the output of encoder
    
    assign d_in = stage_0[9:6];

    always @(posedge clk, posedge reset)
    begin
        if(reset) {stage_0, stage_1} <= 0;
        else
        begin
            stage_0 <= {d, e0, e1};
            stage_1 <= {stage_0[9:6], c_out, decoder_3_8(stage_0[5:3]), decoder_3_8(stage_0[2:0])};
        end
    end

    // 4-bit counter
    reg [3:0] count;
    reg [3:0] count_delay;//delay count for one clock and this varible is used for results checking
    always @(posedge clk, posedge reset)
    begin
        if(reset) 
        begin
            count <= 0;
            count_delay <= 3'bx;
        end
        else
        begin
            count_delay <= count;

            if(count == 8) count <= 0;
            else count <= count + 1;
        end
    end

    // Stage 2
    reg [11:0] stage_2;// stage register 2

    always @(posedge clk, posedge reset)
    begin
        if(reset) stage_2 <= 0;
        else
        begin
            if(count[3])
                stage_2[7:0] <= (stage_1[23:16] ^ stage_1[15:8]) ^ stage_1[7:0];
            else
                stage_2[7:0] <= stage_1[23:16] ^ stage_1[15:8];

            stage_2[11:8] <= stage_1[27:24];
        end
    end

    assign d_out = stage_2[11:8];

    // Instantiation of ham encoder
    ham_74_encoder ham_74_encoder_dut (
        .d(stage_0[9:6]),
        .c(c_out)
    );

    // Instantiation of ham decoder
    ham_74_decoder ham_74_decoder_dut (
        .c(stage_2[7:0]),
        .qc(q_out),
        .qd(qd_out),
        .x(x_out)
    );


    //out files:
    integer out_file, out_log_file;// log file is used to indicate if all test cased passed or not
    initial
    begin
        out_file = $fopen("ham_74.out", "w");
        out_log_file = $fopen("ham_74_log.out", "w");
    end

    
    // Generates clock signal
    always #(0.5 * CLK_CYCLE) clk = ~ clk;

    // Generates inputs and monitors the outputs
    initial
    fork : test

        clk = 1;
        reset = 1;
        #(3 * CLK_CYCLE) 
        reset = 0;

        // this block is used to generate input in every clock
        #(3.5 * CLK_CYCLE)
        begin : gen_input
            integer i;
            for(i = 0; i < NUM_OF_TEST; i =  i + 1)
            begin
                d = {$random} % (2 ** 4);
                e0 = {$random} % (2 ** 3);
                e1 = {$random} % (2 ** 3);
                
                // make sure to generate a double error
                while(e1 == e0)
                    e1 = {$random} % (2 ** 3);

                #(CLK_CYCLE);
            end
        end

        // this block is used to display and check the output in every clock
        #(6.9 * CLK_CYCLE) 
        begin : check_output
            integer j;
            for(j = 0; j < NUM_OF_TEST; j = j + 1)
            begin
                $fdisplay(out_file, "##################### Case #%1d ######################", j + 1);
                $fdisplay(out_file, "At time %1d ns:", $time);

                if(count_delay[3])
                    $fdisplay(out_file, "Double errors inserted.");
                else
                    $fdisplay(out_file, "Single errors inserted.");

                $fdisplay(out_file, "d = %b, qd = %b, q = %b, x = %b", d_out, qd_out, q_out, x_out);

                // the results are correct only when:
                // d == dq, x = 0 when single error inserted
                // x = 1 when double errors inserted
                if((count_delay[3] == 0) && (x_out == 0) && (d_out == qd_out) || 
                    (count_delay[3] == 1) && (x_out == 1))
                    $fdisplay(out_file, "(Case Passed!)");
                else
                begin
                    $fdisplay(out_file, "(Case Failed!)");
                    $fdisplay(out_log_file, "Test case #%1d failed!!, counter = %b", j + 1, count - 3'b001);
                    $fclose(out_file | out_log_file);
                    // $finish;
                end
                #(CLK_CYCLE);
            end
            
            $fdisplay(out_log_file, "All %1d test cases passed!", j);

            $fclose(out_file | out_log_file);
            $finish;
        end

    join

	initial 
	begin
		$sdf_annotate("./netlist/ham_74_encoder.sdf", ham_74_encoder_dut,,"encoder_sdf.log","MAXIMUM","1.0:1.0:1.0", "FROM_MAXIMUM");
        $sdf_annotate("./netlist/ham_74_decoder.sdf", ham_74_decoder_dut,,"decoder_sdf.log","MAXIMUM","1.0:1.0:1.0", "FROM_MAXIMUM");
		$enable_warnings;
		$log("ncsim.log");//outputs log in trancript
	end

endmodule








        


        








    
    

