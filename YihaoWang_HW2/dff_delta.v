/* 
    Negative triggered dff with asynchronous low active reset and low active enable
*/ 
module dff_delta (clk, rst, en, d, q);
    input clk, rst, en , d;
    output q;
    reg q;

    always @(negedge clk, negedge rst) begin
        if(!rst) q <= 1'b0;
        else 
            if(!en) q <= d;
            else q <= q; 
    end
endmodule