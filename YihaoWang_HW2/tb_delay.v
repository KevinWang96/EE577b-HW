`timescale 1ns/100ps
module tb;
    reg A, B;
    wire OUT1, OUT2, OUT3, OUT4, OUT5;
    // Instantiation
    or2_1 or2_1_dut (.A(A), .B(B), .OUT1(OUT1));
    or2_2 or2_2_dut (.A(A), .B(B), .OUT2(OUT2));
    or2_3 or2_3_dut (.A(A), .B(B), .OUT3(OUT3));
    or2_4 or2_4_dut (.A(A), .B(B), .OUT4(OUT4));
    or2_5 or2_5_dut (.A(A), .B(B), .OUT5(OUT5));

    initial 
    fork 
        #0 A = 1;
        #0 B = 1;
        #4 A = 1;
        #4 B = 0;
        #7 A = 0;
        #7 B = 0;
        #11 A = 0;
        #11 B = 1;
        #14 A = 0;
        #14 B = 0;
        #20 $finish;
    join

    // Monitors the outputs
    reg [31:0] the_file;
    initial
    begin
        the_file = $fopen("delay.out");
        $fmonitor(the_file, "At time %d ns, A=%b, B=%b, OUT1=%b, OUT2=%b, OUT3=%b, OUT4=%b, OUT5=%b", $time, A, B, OUT1, OUT2, OUT3, OUT4, OUT5);
        #19 $fclose(the_file);
    end

endmodule


    
    