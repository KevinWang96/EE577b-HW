/*
    An 8-bit shift register with a synchronous load, serial input 
    and reset control mechanism operating at the POSITIVE edge of 
    the clock signal “clk”
*/
module shift_register (
    output reg [7:0] q,
    input [7:0] data,
    input clk, rst, shift, load, dir, ser_in
);

    always @(posedge clk) begin
    if(rst) 
        q <= 0;
    else 
        if(load) 
            q <= data;
        else
            if(shift) begin
                if(dir) begin
                    q <= q >> 1;
                    q[7] <= ser_in;
                end 
                else begin
                    q <= q << 1;
                    q[0] <= ser_in;
                end
            end
            else
                q <= q;
    end

endmodule