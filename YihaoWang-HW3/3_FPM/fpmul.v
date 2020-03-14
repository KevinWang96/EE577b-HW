/*
    Single precision floating point number multiplier
*/
module fpmul (oprA, oprB, Result);
    input [31:0] oprA, oprB;
    output [31:0] Result;

    wire s_a, s_b;
    wire [7:0] exp_a, exp_b;
    wire [22:0] frac_a, frac_b;

    reg s_z; 
    reg [7:0] exp_z;
    reg [22:0] frac_z;

    // Divides 31bits fp number into three parts: SIGN, EXP, FRAC
    // Operand formatter
    assign {s_a, exp_a, frac_a} = oprA;
    assign {s_b, exp_b, frac_b} = oprB;
    // Result formatter
    assign Result = {s_z, exp_z, frac_z};

    // Generates sign bit:
    always @(*)
        if(s_a == s_b) s_z = 1'b0;
        else s_z = 1'b1;
    
    // Generates frac_z:
    reg [47:0] frac_z_i;
    reg inc_1; // signal to tell ths incrementer if increment exp_z_2i by 1
    always @(*)
    begin
        frac_z_i = {1'b1, frac_a} * {1'b1, frac_b};
        if(frac_z_i[47])
        begin
            inc_1 = 1'b1;
            frac_z = frac_z_i[46-:23];
        end
        else
        begin
            inc_1 = 1'b0;
            frac_z = frac_z_i[45-:23];
        end
    end

    // Generates exp_z:
    reg [7:0] exp_z_2i;
    always @(*)
    begin
        exp_z_2i = (exp_a + exp_b) - 127;
        if(inc_1) exp_z = exp_z_2i + 1;
        else exp_z = exp_z_2i;
    end

endmodule

        