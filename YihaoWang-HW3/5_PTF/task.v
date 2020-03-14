/*
    Generates a 10-bit number with even parity
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
    
    