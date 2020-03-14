/* 
    Negative triggered dff with asynchronous hign active reset and low active enable
*/ 
module dff_beta (clk, rst, en, d, q);
    input clk, rst, en, d;
    output q;
    reg q;

    always @(negedge clk, posedge rst) begin
        if(rst) q <= 1'b0;
        else 
            if(!en) q <= d;
            else q <= q;
    end
endmodule