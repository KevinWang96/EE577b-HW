module seq_detect (D_IN, CLK, RST, MATCH);
    input CLK, RST, D_IN;
    output MATCH;
    wire [7:0] out;

    parameter TARGET_PATTERN = 8'b11010101; //Target pattern

    // Instantiation of DUT
    shift_register shift_reg_dut (
        .clk(CLK), 
        .rst(RST), 
        .load(1'b0), 
        .shift(1'b1), 
        .dir(1'b0), 
        .ser_in(D_IN),
        .q(out)
    );

    // Generates MATCH signal using continuous assignment
    assign MATCH = (out === TARGET_PATTERN) ? 1'b1 : 1'b0;

    // Equavilent implementation using always block
    // always @(*) begin
    //     if(out === TARGET_PATTERN)
    //         MATCH = 1'b1;
    //     else
    //         MATCH = 1'b0; 
    // end

endmodule

