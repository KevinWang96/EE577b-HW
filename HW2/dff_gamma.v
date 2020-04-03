module dff_gamma (clk, rst, en, d, q);
    input clk, rst, en, d;
    output q;
    reg q;

    always @(negedge clk) begin
        if(!rst) q <= 1'b0;
        else 
            if(en) q <= d;
            else q <= q;
    end
endmodule