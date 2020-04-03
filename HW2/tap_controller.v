/*
 * @Author: Yihao Wang
 * @Date: 2020-02-10 16:43:52
 * @LastEditTime: 2020-04-03 00:48:19
 * @LastEditors: Please set LastEditors
 * @Description: FSM design: Tap Controller
 * @FilePath: /EE577b_HW/HW2/tap_controller.v
 */
module tap_controller (
    output reg [3:0] STATE,
    input TCK, TRST, TMS
);
    // Definition of states
    parameter TEST_LOGIC_RESET = 4'b0000;
    parameter RUN_TEST_IDLE = 4'b0001;
    parameter SELECT_DR_SCAN = 4'b0010;
    parameter CAPTURE_DR = 4'b0011;
    parameter SHIFT_DR = 4'b0100;
    parameter EXIT1_DR = 4'b0101; 
    parameter PAUSE_DR = 4'b0110; 
    parameter EXIT2_DR = 4'b0111;
    parameter UPDATE_DR = 4'b1000;
    parameter SELECT_IR_SCAN = 4'b1001; 
    parameter CAPTURE_IR = 4'b1010; 
    parameter SHIFT_IR = 4'b1011; 
    parameter EXIT1_IR = 4'b1100; 
    parameter PAUSE_IR = 4'b1101; 
    parameter EXIT2_IR = 4'b1110; 
    parameter UPDATE_IR = 4'b1111;


    // State transition:
    always @(posedge TCK) begin
        //synchronous high active reset
        if(TRST) 
            STATE <= TEST_LOGIC_RESET;
        else 
            case (STATE) 
            TEST_LOGIC_RESET : 
                if (TMS == 0) STATE <= RUN_TEST_IDLE;
            RUN_TEST_IDLE :
                if (TMS == 1) STATE <= SELECT_DR_SCAN;
            SELECT_DR_SCAN :
                if (TMS == 0) STATE <= CAPTURE_DR;
                else STATE <= SELECT_IR_SCAN;
            CAPTURE_DR :
                if (TMS == 0) STATE <= SHIFT_DR;
                else STATE <= EXIT1_DR;
            SHIFT_DR :
                if (TMS == 1) STATE <= EXIT1_DR;
            EXIT1_DR :
                if (TMS == 0) STATE <= PAUSE_DR;
                else STATE <= UPDATE_DR;
            PAUSE_DR :
                if (TMS == 1) STATE <= EXIT2_DR;
            EXIT2_DR :
                if (TMS == 0) STATE <= SHIFT_DR;
                else STATE <= UPDATE_DR;
            UPDATE_DR :
                if (TMS == 0) STATE <= RUN_TEST_IDLE;
                else STATE <= SELECT_DR_SCAN;
            SELECT_IR_SCAN :
                if (TMS == 0) STATE <= CAPTURE_IR;
                else STATE <= TEST_LOGIC_RESET;
            CAPTURE_IR :
                if (TMS == 0) STATE <= SHIFT_IR;
                else STATE <= EXIT1_IR;
            SHIFT_IR :
                if (TMS == 1) STATE <= EXIT1_IR;
            EXIT1_IR :
                if (TMS == 0) STATE <= PAUSE_IR;
                else STATE <= UPDATE_IR;
            PAUSE_IR :
                if (TMS == 1) STATE <= EXIT2_IR;
            EXIT2_IR :
                if (TMS == 1) STATE <= UPDATE_IR;
                else STATE <= SHIFT_IR;
            UPDATE_IR :
                if (TMS == 1) STATE <= SELECT_DR_SCAN;
                else STATE <= RUN_TEST_IDLE;
            endcase
    end
    
endmodule 