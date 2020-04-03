`timescale 1ns/1ps
module tb;
    reg CLK, RST, D_IN;
    wire MATCH;

    parameter CLK_CYCLE = 2;// clock cycle
    parameter WIDTH_OF_TEST_STREAM = 128; // num of test patterns in test stream file (pattern.in)

    reg data_stream [WIDTH_OF_TEST_STREAM - 1:0]; // Stores the data stream read from pattern.in

    // Instantiation of DUT
    seq_detect seq_detect_dut (
        .D_IN(D_IN),
        .CLK(CLK),
        .RST(RST),
        .MATCH(MATCH)
    );

    // Generates clock signal
    always #(CLK_CYCLE / 2) CLK = ~ CLK;

    // Initial value for clock and reset
    initial 
    fork
        CLK = 1;
        RST = 1;
        #(4 * CLK_CYCLE + 0.2) RST = 0;
    join

    reg [31:0] in_file, out_file;
    integer count;
    initial 
    begin 
        // Generates pattern.in file with random test stream
        // Inserts target pattern(8'b11010101) into random location of pattern.in
        begin : in_file_gen
            integer i, insert_pos;
            reg random_bit;
            in_file = $fopen("pattern.in", "w");
            insert_pos = ({$random} % (WIDTH_OF_TEST_STREAM - 8)); // Geneartes an random location to insert the target pattern
            for(count = 0; count < ((WIDTH_OF_TEST_STREAM - 8) + 1); count = count + 1)
            begin
                if(count == insert_pos)
                begin  
                    for(i = 7; i >= 0; i = i - 1)
                        $fdisplay(in_file, seq_detect_dut.TARGET_PATTERN[i]);
                end
                else 
                begin
                    random_bit = {$random} % 2;
                    $fdisplay(in_file, "%b", random_bit);
                end
            end
            $fclose(in_file);
        end

        // Reads one bit from pattern.in as the serial input for DUT
        #(CLK_CYCLE * 3 + 0.01)
        out_file = $fopen("seq.out", "w");
        $readmemb("pattern.in", data_stream);
        $fmonitor(out_file, "At time %d ns, CLK=%b, RST=%b, D_IN=%b, MATCH=%b", $time, CLK, RST, D_IN, MATCH);
        for(count = 0; count < WIDTH_OF_TEST_STREAM; count = count + 1)
            #(CLK_CYCLE) D_IN = data_stream[count];
        #(CLK_CYCLE) 
        $fclose(out_file);
        $finish;
    end

endmodule


    