/*
    Generates a 10-bit number with odd parity
*/
module parity_function(in, out);
    input [8:0] in;
    output [9:0] out;
    reg [9:0] out;

    function odd_parity_bit;
        input [8:0] in;
    begin
        odd_parity_bit = ~(^in); 
    end
    endfunction

    always @(*)
        out = {in, odd_parity_bit(in)};
        
endmodule
