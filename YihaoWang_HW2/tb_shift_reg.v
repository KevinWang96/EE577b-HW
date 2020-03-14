`timescale 1ns/1ps
module tb_shift_reg;
    reg clk, rst, shift, load, dir, ser_in;
    reg[7:0] data_in;
    wire [7:0] q;
    
    parameter CLK_CYCLE = 2; //clock cycle: 2ns(500MHz)

    // Instantiation of DUT:
    shift_register shift_reg_dut (
        .clk(clk),
        .rst(rst),
        .shift(shift),
        .load(load),
        .dir(dir),
        .data(data_in),
        .ser_in(ser_in),
        .q(q)
    );

    // clock generation
    always #(CLK_CYCLE / 2) clk = ~ clk;
    initial 
    fork
        clk = 1;
        rst = 1;
        #2.2 rst = 0;
        #9 rst = 1;
        #10.2 rst = 0;
        load = 1;
        #4.2 load = 0;
        shift = 1;
        #8.2 shift = 0;
        data_in = 8'b10101010;
        dir = 0;
        #6.2 dir = 1;
        ser_in = 0;
        #6.2 ser_in = 1;
        #12 $finish;
    join

    // Monitors outputs and generates output file
    reg [31:0] the_file;
    initial 
    begin
        the_file = $fopen("shift_reg.out");
        $fmonitor(the_file, "At time %d ns, clk=%b, rst=%b, load=%b, shift=%b, data=%b, dir=%b, ser_in=%b, q=%b", 
            $time, clk, rst, load, shift, data_in, dir, ser_in, q);
        #12 $fclose(the_file);
    end

endmodule


            