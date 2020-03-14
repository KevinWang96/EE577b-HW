`timescale 1ns/1ps
module tb;
    reg TCLK, TMS, TRST;
    wire [3:0] STATE;

    parameter TCLK_CYCLE = 2; //clock cycle: 2ns(500MHz)
    parameter NUM_OF_TEST = 64; //number of test

    // Instantiation of DUT:
    tap_controller tap_controller_dut (
        .TCK(TCLK),
        .TMS(TMS),
        .TRST(TRST),
        .STATE(STATE)
    );

    // Generates the test clock:
    always #(TCLK_CYCLE / 2) TCLK = ~ TCLK;

    // Initial value of signal:
    initial 
    begin
        TCLK = 1;
        TMS = 0;
        TRST = 1;
    end
    
    // //Tests the design using fixed test patterns:
    // initial fork 
    //     #3  TRST = 0;//STATE 0
    //     #2.1  TMS = 0;//STATE 1
    //     #4.1  TMS = 1;//STATE 2
    //     #6.1  TMS = 0;//STATE 3
    //     #8.1  TMS = 0;//STATE 4
    //     #10.1  TMS = 1;//STATE 5
    //     #12.1  TMS = 0;//STATE 6
    //     #14.1  TMS = 1;//STATE 7
    //     #16.1  TMS = 1;//STATE 8
    //     #18.1  TMS = 1;//STATE 2
    //     #20.1  TMS = 1;//SATTE 9
    //     #22.1  TMS = 0;//STATE A
    //     #24.1  TMS = 0;//STATE B
    //     #26.1  TMS = 1;//STATE C
    //     #28.1  TMS = 0;//STATE D
    //     #30.1  TMS = 1;//STATE E
    //     #32.1  TMS = 1;//STATE F
    //     #34.1  TMS = 1;//STATE 2
    //     #36.1  TMS = 1;//STATE 9
    //     #38.1  TMS = 1;
    //     #40.1  TMS = 1;//STATE 0
    //     #42.1  TMS = 1;//STATE 0
    //     #44.1  TMS = 0;//STATE 1
    //     #46.1  TMS = 0;//STATE 1
    //     #48.1  TMS = 1;//STATE 2
    //     #50.1  TMS = 0;//STATE 3
    //     #52.1  TMS = 1;//STATE 5
    //     #54.1  TMS = 0;//STATE 6
    //     #56.1  TMS = 0;//STATE 6
    //     #58.1  TMS = 1; //STATE 7
    //     #60.1  TMS = 0; //STATE 4
    //     #62.1  TMS = 0;//STATE 4
    //     #64.1  TMS = 1;//STATE 5
    //     #66.1  TMS = 1;//STATE 8
    //     #68.1  TMS = 1;//STATE 2
    //     #70.1  TMS = 1;//STATE 9
    //     #72.1  TMS = 0;//STATE A
    //     #74.1  TMS = 1;//STATE C
    //     #76.1  TMS = 0;//STATE D
    //     #78.1  TMS = 0;//STATE D
    //     #80.1  TMS = 1;//STATE E
    //     #82.1  TMS = 0;//STATE B
    //     #84.1  TMS = 0;//STATE B
    //     #86.1  TMS = 1;//STATE C
    //     #88.1  TMS = 0;//STATE D
    //     #90.1  TMS = 1;//STATE E
    //     #92.1  TMS = 1;//STATE F
    //     #94.1  TMS = 0;//STATE 1
    //     #95    TRST = 1;
    //     #96    ;//STATE 0
    //     #100  $fclose();
    //     #100  $finish;
    // join

    //Tests the desigh using random test patterns:
    integer count;
    initial
    begin 
        #(4*TCLK_CYCLE + 0.1) TRST = 0; // reset for 4 clocks

        // Gives TMS with random value in each clock cycle
        for(count = 0; count < NUM_OF_TEST; count = count + 1)
            #(TCLK_CYCLE) TMS = ({$random} % 2);

        $fclose(the_file);
        $finish;
    end

    // Monitors relavant signals and outputs to files:
    reg [31:0] the_file;
    initial 
    begin
        the_file = $fopen("tap_controller.out", "w");
        //the unit of time returned by $time is ps, so we need to divide it by 1000:
        $fmonitor(the_file, "At time %d ns, TMS = %b, STATE(hex) = %H", $time, TMS, STATE);
    end

endmodule        


    
