/*
 * @Author: Yihao Wang
 * @Date: 2020-02-12 17:35:22
 * @LastEditTime: 2020-03-14 01:36:55
 * @LastEditors: Please set LastEditors
 * @Description: Traffic light controller
 * @FilePath: /EE577b_HW/YihaoWang-HW3/4_TLC/traffic.v
 */
module traffic_control(CLK, reset, ERR, PA, PB, L_A, L_B, RA, RB);
    output [2:0] L_A, L_B;
    output RA, RB;
    input CLK, reset, ERR, PA, PB;

    reg [2:0] L_A, L_B;
    reg RA, RB;
    reg [2:0] timer, state;

    // from_3 is a flag that indicates whether the state enters state0 from state3 or not
    // pa_r and pb_r are FFs used to register button pushing signal and hold it till state0
    reg from_3, pa_r, pb_r;
    
    // Traffic signal type:
    localparam  GREEN = 3'b110,
                GREEN_LEFT_ARROW = 3'b101,
                YELLOW = 3'b100,
                RED = 3'b011,
                GREEN_RIGHT_ARROW = 3'b010,
                FLASHING_RED = 3'b111,
                FLASHING_YELLOW = 3'b000;

    // Definition of states:
    localparam  STATE0 = 3'b000,
                STATE1 = 3'b001,
                STATE2 = 3'b010,
                STATE3 = 3'b011,
                STATE4 = 3'b100,
                STATE5 = 3'b101,
                STATE6 = 3'b110,
                STATE7 = 3'b111;

    // Timing for each (# of clocks)
    localparam  T_S0 = 6,
                T_S1 = 8,
                T_S2 = 3,
                T_S3 = 3,
                T_S4 = 8,
                T_S5 = 3,
                T_S6 = 3;

    // Sequential logic: 
    // Next state logic + state memory
    // Sequential part of output logic
    always @(posedge CLK)
    begin
        if(ERR) state <= STATE7;
        else 
            if(reset) state <= STATE7;
            else
                case(state)
                    STATE0 :
                    begin
                        if(timer == T_S0 - 1)
                        begin
                            pa_r <= 0;
                            pb_r <= 0;
                            timer <= 0;
                            if(from_3) state <= STATE4;
                            else state <= STATE1;
                        end
                        else
                            timer <= timer + 1;
                    end
                    STATE1 :
                    begin
                        if(PA) pa_r <= 1;
                        if(PB) pb_r <= 1;

                        if(timer == T_S1 - 1) 
                        begin
                            timer <= 0;
                            state <= STATE2;
                        end
                        else 
                            timer <= timer + 1;
                    end
                    STATE2 :
                    begin
                        if(PA) pa_r <= 1;
                        if(PB) pb_r <= 1;

                        if(timer == T_S2 - 1)
                        begin
                            timer <= 0;
                            state <= STATE3;
                        end
                        else
                            timer <= timer + 1;
                    end
                    STATE3 :
                    begin   
                        if(PA) pa_r <= 1;
                        if(PB) pb_r <= 1;
                        if(timer == T_S3 - 1)
                        begin
                            timer <= 0;
                            if(PA || PB || pa_r || pb_r)
                            begin
                                from_3 <= 1;// make sure system will return to state 4 as the end of state 0
                                state <= STATE0;
                            end
                            else
                                state <= STATE4;
                        end
                        else
                            timer <= timer + 1;
                    end
                    STATE4 :
                    begin
                        if(PA) pa_r <= 1;
                        if(PB) pb_r <= 1;

                        if(timer == T_S4 - 1)
                        begin
                            timer <= 0;
                            state <= STATE5;
                        end
                        else
                            timer <= timer + 1;
                    end
                    STATE5 :
                    begin
                        if(PA) pa_r <= 1;
                        if(PB) pb_r <= 1;

                        if(timer == T_S5 - 1)
                        begin
                            timer <= 0;
                            state <= STATE6;
                        end
                        else
                            timer <= timer + 1;
                    end
                    STATE6 :
                    begin
                        if(PA) pa_r <= 1;
                        if(PB) pb_r <= 1;
                        if(timer == T_S6 - 1)
                        begin
                            timer <= 0;
                            if(PA || PB || pa_r || pb_r)
                            begin
                                from_3 <= 0;// make sure system will return to state 1 as the end of state 0
                                state <= STATE0;
                            end
                            else 
                                state <= STATE1;
                        end
                        else 
                            timer <= timer + 1;
                    end
                    STATE7 :
                    begin
                        timer <= 0;

                        // In order to make sure both RA and RB is activated in state 0 after reset or external error
                        pa_r <= 1;
                        pb_r <= 1;

                        from_3 <= 0;
                        if((!ERR) && (!reset))
                            state <= STATE0;
                    end
                endcase
    end

    // Combinational logic:
    // Combinational logic part of output logic
    always @(*)
    begin
        RA = 0;
        RB = 0;
        case(state)
            STATE0 :
            begin
                L_A = FLASHING_RED;
                L_B = FLASHING_RED;
                if(pa_r) RA = 1;// if PA is registered (pa_r == 1), I will activate RA
                if(pb_r) RB = 1;// if PB is registered (pb_r == 1), I will activate RB
            end
            STATE1 :
            begin
                L_A = GREEN;
                L_B = RED;
                if(pa_r) RA = 1;
                if(pb_r) RB = 1;
            end
            STATE2 :
            begin
                L_A = GREEN_LEFT_ARROW;
                L_B = GREEN_RIGHT_ARROW;
                if(pa_r) RA = 1;
                if(pb_r) RB = 1;
            end
            STATE3 :
            begin
                L_A = YELLOW;
                L_B = GREEN_RIGHT_ARROW;
                if(pa_r) RA = 1;
                if(pb_r) RB = 1;
            end
            STATE4 :
            begin
                L_A = RED;
                L_B = GREEN;
                if(pa_r) RA = 1;
                if(pb_r) RB = 1;
            end
            STATE5 :
            begin
                L_A = GREEN_RIGHT_ARROW;
                L_B = GREEN_LEFT_ARROW;
                if(pa_r) RA = 1;
                if(pb_r) RB = 1;
            end
            STATE6 :
            begin
                L_A = GREEN_RIGHT_ARROW;
                L_B = YELLOW;
                if(pa_r) RA = 1;
                if(pb_r) RB = 1;
            end
            STATE7 :
            begin
                L_A = FLASHING_YELLOW;
                L_B = FLASHING_YELLOW;
            end
        endcase
    end

endmodule
            



            
                


                

