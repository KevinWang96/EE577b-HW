/*
 * @Author: Yihao Wang
 * @Date: 2020-02-18 02:20:51
 * @LastEditTime: 2020-03-14 01:37:51
 * @LastEditors: Please set LastEditors
 * @Description: Testbench for traffic light controller
 * @FilePath: /EE577b_HW/YihaoWang-HW3/4_TLC/tb_traffic.v
 */
`timescale 1ns/1ps
module tb_traffic;
    reg CLK, reset, ERR, PA, PB;
    wire [2:0] L_A, L_B, state;
    wire RA, RB;
    wire pa_r, pb_r;

    assign {pa_r, pb_r} = {traffic_control_dut.pa_r, traffic_control_dut.pb_r};

    assign state = traffic_control_dut.state;

    parameter CLK_CYCLE = 10;// clock cycle = 5ns

    // state code
    localparam  STATE0 = 3'b000,
                STATE1 = 3'b001,
                STATE2 = 3'b010,
                STATE3 = 3'b011,
                STATE4 = 3'b100,
                STATE5 = 3'b101,
                STATE6 = 3'b110,
                STATE7 = 3'b111;


    // Instantiation of DUT
    traffic_control traffic_control_dut(
        .CLK(CLK),
        .reset(reset),
        .ERR(ERR),
        .PA(PA),
        .PB(PB),
        .L_A(L_A),
        .L_B(L_B),
        .RA(RA),
        .RB(RB)
    );

    // Generates system clock
    always #(0.5 * CLK_CYCLE) CLK = ~ CLK;

    reg [31:0] out_file;
    initial
    begin
        out_file = $fopen("traffic.out", "w");
        $timeformat(-9, 0.1, "ns", 2);
        $fmonitor(out_file, "At time %t, CLK=%b, reset=%b, ERR=%b, PA=%b, PB=%b, L_A=%b, L_B=%b, state=%b, RA=%b, RB=%b",
                    $time, CLK, reset, ERR, PA, PB, L_A, L_B, state, RA, RB);
    end

    initial
    begin
        CLK = 1;
        PA = 0;
        PB = 0;
        ERR = 0;
        reset = 1;
        #(3.1 * CLK_CYCLE)
        reset = 0;
        
        // push button when controller steps into state 0
        // pushing button in state 0 has no effects
        wait (state == STATE0)
        PA = 1;
        #(1.5 * CLK_CYCLE)
        PA = 0;

        // wait for a round and push button in state 1
        wait (state == STATE2);
        wait (state == STATE1)
        PB = 1;
        #(1.5 * CLK_CYCLE) 
        PB = 0;

        // wait for a round and push button in state 2
        wait (state == STATE0);
        wait (state == STATE2)
        PA = 1;
        #(1.5 * CLK_CYCLE) 
        PA = 0;

        // wait for a round and push button in state 3
        wait (state == STATE0);
        wait (state == STATE3);
        PB = 1;
        #(1.5 * CLK_CYCLE)
        PB = 0;

        // wait for a round and push button in state 4
        wait (state == STATE0);
        wait (state == STATE4)
        PA = 1;
        #(1.5 * CLK_CYCLE)
        PA = 0;

        // wait for a round and push button in state 5
        wait (state == STATE0);
        wait (state == STATE5)
        PB = 1;
        #(1.5 * CLK_CYCLE)
        PB = 0;

        // wait for a round and push button in state 6
        wait (state == STATE0);
        wait (state == STATE6);
        PA = 1;
        #(1.5 * CLK_CYCLE)
        PA = 0;

        // Test the priority among reset, ERR and PA(PB)
        wait (state == STATE0);
        wait (state == STATE1)
        #(0.1 * CLK_CYCLE)
        reset = 1;
        ERR = 1;
        PB = 1;
        #(4 * CLK_CYCLE)
        reset = 0;
        ERR = 0;
        PB = 0;

        wait (state == STATE3)
        $fclose(out_file);
        $finish;
    end
endmodule




