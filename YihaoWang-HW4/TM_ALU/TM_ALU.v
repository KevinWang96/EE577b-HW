module TM_ALU (clk, reset,
AvgTxLen, // 8-bit input
InstExed, // 8-bit input 
CurTxLen, // 8-bit input 
AvgTxLen_new, // 8-bit output
InstExed_new // 8-bit output
);
    parameter WIDTH = 8;// Width of inputs

    input clk, reset;
    input [WIDTH - 1:0] AvgTxLen, CurTxLen;
    input [WIDTH - 1:0] InstExed;

    output [WIDTH - 1:0] AvgTxLen_new;
    output [WIDTH - 1:0] InstExed_new;

    // four stage registers
    reg [3 * WIDTH - 1:0] stage_0;
    reg [4 * WIDTH - 1:0] stage_1;
    reg [4 * WIDTH - 1:0] stage_2;
    reg [2 * WIDTH - 1:0] stage_3;

    // Generates the output
    assign {AvgTxLen_new, InstExed_new} = stage_3;

    // Stage 1
    always @(posedge clk, posedge reset)
    begin
        if(reset) {stage_0, stage_1} <= 0;
        else
        begin
            //stage 0: launch the input into stage_0 register
            stage_0 <= {AvgTxLen, InstExed, CurTxLen};

            //stage 1: Multiplication
            stage_1[4 * WIDTH - 1:2 * WIDTH] <= stage_0[3 * WIDTH - 1:2 * WIDTH] * stage_0[2 * WIDTH - 1:WIDTH];
            stage_1[2 * WIDTH - 1:0] <= {stage_0[WIDTH - 1:0], stage_0[2 * WIDTH - 1:WIDTH]};
        end
    end

    // Stage 2

    always @(posedge clk, posedge reset)
    begin
        if(reset) stage_2 <= 0;
        else
        begin
            stage_2[4 * WIDTH - 1:2 * WIDTH] <= stage_1[4 * WIDTH - 1: 2 * WIDTH] + stage_1[2 * WIDTH - 1:WIDTH];
            stage_2[2 * WIDTH - 1:WIDTH] <= stage_1[WIDTH - 1:0] + 1;
            stage_2[WIDTH - 1:0] <= stage_1[WIDTH - 1:0] + 1;
        end
    end

    // Stage 3
    always @(posedge clk, posedge reset)
    begin   
        if(reset) stage_3 <= 0;
        else
        begin
            stage_3[2 * WIDTH - 1:WIDTH] <= (stage_2[4 * WIDTH - 1:2 * WIDTH]) / (stage_2[2 * WIDTH - 1:WIDTH]);
            stage_3[WIDTH - 1:0] <= stage_2[WIDTH - 1:0];
        end
    end

endmodule

