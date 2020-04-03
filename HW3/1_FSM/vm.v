/*
 * @Author: Yihao Wang
 * @Date: 2020-02-11 16:14:21
 * @LastEditTime: 2020-03-14 01:28:39
 * @LastEditors: Please set LastEditors
 * @Description: Coin return state machine for vending machine
 * @FilePath: /EE577b_HW/YihaoWang-HW3/1_FSM/vm.v
 */
module coin_return (disp_B, disp_Q, disp_D, disp_N, disp_P, done, 
    money, price, start, clk, reset, avail_B, avail_Q, avail_D, avail_N, avail_P);

    output disp_B, disp_Q, disp_D, disp_N, disp_P, done;
    reg done;

    input [8:0] money, price;
    input start, clk, reset, avail_B, avail_Q, avail_D, avail_N, avail_P;

    // Definition of states:
    localparam  IDLE = 3'b000,
                DISP_BILL = 3'b001,
                DISP_QUARTER = 3'b010,
                DISP_DIME = 3'b011,
                DISP_NICKLE = 3'b100,
                DISP_PENNY = 3'b101;
    
    // Face value of currency (unit: cent)
    localparam  DOLLAR_BILL = 100,
                QUARTER = 25,
                DIME = 10,
                NICKLE = 5,
                PENNY = 1;

    wire [4:0] avail;
    assign avail = {avail_B, avail_Q, avail_D, avail_N, avail_P};

    reg [4:0] disp;
    assign {disp_B, disp_Q, disp_D, disp_N, disp_P} = disp;

    // Output code (control signal)
    localparam  DONT_DISP = 5'b00000,
                PLEASE_DISP_B = 5'b10000,
                PLEASE_DISP_Q = 5'b01000,
                PLEASE_DISP_D = 5'b00100,
                PLEASE_DISP_N = 5'b00010,
                PLEASE_DISP_P = 5'b00001;

    reg [8:0] change;// counter to indicate how much money left need to dispense
    reg [2:0] state;//current state 

    // Next state logic + state memory
    always @(posedge clk)
    begin
        // synchronous hign active reset
        if(reset) state <= IDLE;
        else 
        begin
            case(state) 
                IDLE :
                begin
                    change <= money - price; //change the counter
                    if(start)
                        if(((money - price) >= DOLLAR_BILL) && avail_B) state <= DISP_BILL;
                        else
                            if(((money - price) >= QUARTER) && avail_Q) state <= DISP_QUARTER;
                            else
                                if(((money - price) >= DIME) && avail_D) state <= DISP_DIME;
                                else
                                    if(((money - price) >= NICKLE) && avail_N) state <= DISP_NICKLE;
                                    else
                                        if(((money - price) >= PENNY) && avail_P) state <= DISP_PENNY;
                end
                DISP_BILL :
                begin
                    // update of counter
                    if((change >= DOLLAR_BILL) && avail_B) change <= change - DOLLAR_BILL;
                    // state transition
                    if(((change - DOLLAR_BILL) < DOLLAR_BILL) || !avail_B)
                        if(((change - DOLLAR_BILL) >= QUARTER) && avail_Q) state <= DISP_QUARTER;
                        else 
                            if(((change - DOLLAR_BILL) >= DIME) && avail_D) state <= DISP_DIME;
                            else
                                if(((change - DOLLAR_BILL) >= NICKLE)) state <= DISP_NICKLE;
                                else
                                    if(((change - DOLLAR_BILL) >= PENNY) && avail_P) state <= DISP_PENNY;
                                    else state <= IDLE;
                end
                DISP_QUARTER :
                begin
                    // update of counter
                    if((change >= QUARTER) && avail_Q) change <= change - QUARTER;
                    // state transition
                    if(((change - QUARTER) < QUARTER) || !avail_Q)  
                        if(((change - QUARTER) >= DIME) && avail_D) state <= DISP_DIME;
                        else 
                            if(((change - QUARTER) >= NICKLE) && avail_N) state <= DISP_NICKLE;
                            else
                                if(((change - QUARTER) >= PENNY) && avail_P) state <= DISP_PENNY;
                                else state <= IDLE;
                end
                DISP_DIME :
                begin
                    // update of counter
                    if((change >= DIME) && avail_D) change <= change - DIME;
                    // state transition
                    if(((change - DIME) < DIME) || !avail_D)
                        if(((change - DIME) >= NICKLE) && avail_N) state <= DISP_NICKLE;
                        else 
                            if(((change - DIME) >= PENNY) && avail_P) state <= DISP_PENNY;
                            else state <= IDLE;
                end
                DISP_NICKLE :
                begin
                    // update of counter
                    if((change >= NICKLE) && avail_N) change <= change - NICKLE;
                    // state transition
                    if(((change - NICKLE) < NICKLE) || !avail_N)
                        if(((change - NICKLE) >= PENNY) && avail_P) state <= DISP_PENNY;
                        else state <= IDLE;
                end
                DISP_PENNY :
                begin
                    // update of counter
                    if((change >= PENNY) && avail_P) change <= change - PENNY;
                    // state transition
                    if(((change - PENNY) < PENNY) || !avail_P) state <= IDLE;
                end
            endcase
        end
    end
    
    // Output function logic (combinational logic)
    always @(*) 
    begin
        disp = DONT_DISP;
        done = 1'b0;
        case(state) 
            IDLE :
                done = 1'b1;
            DISP_BILL :
                if((change >= DOLLAR_BILL) && avail_B) disp = PLEASE_DISP_B;
            DISP_QUARTER :
                if((change >= QUARTER) && avail_Q) disp = PLEASE_DISP_Q;
            DISP_DIME :
                if((change >= DIME) && avail_D) disp = PLEASE_DISP_D;
            DISP_NICKLE :
                if((change >= NICKLE) && avail_N) disp = PLEASE_DISP_N;
            DISP_PENNY :
                if((change >= PENNY) && avail_P) disp = PLEASE_DISP_P;
        endcase
    end
endmodule



