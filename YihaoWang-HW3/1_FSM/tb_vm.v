`timescale 1ns/1ps
`define TRUE 1'b1
`define FALSE 1'b0
module tb_vm;
    reg clk, reset, start, avail_B, avail_Q, avail_D, avail_N, avail_P;
    reg [9:0] money, price;

    wire disp_B, disp_Q, disp_D, disp_N, disp_P, done;

    wire [2:0] state;
    assign state = coin_return_dut.state;

    parameter NUM_OF_TEST = 40;//number of test
    parameter MAX_MONEY = 500;//maximum value of money
    parameter MIN_MONEY = 10;//minimum value of money

    // Number of coins left in stock
    parameter BILL_LEFT = 100000;
    parameter QUARTER_LEFT = 100000;
    parameter DIME_LEFT = 100000;
    parameter NICKLE_LEFT = 100000;
    parameter PENNY_LEFT = 100000;

    parameter CLK_CYCLE = 10;//clock cycle

    //Instantiation of DUT
    coin_return coin_return_dut
    (
        .clk(clk), .start(start), .reset(reset), .money(money), .price(price), .done(done),
        .avail_B(avail_B), .avail_Q(avail_Q), .avail_D(avail_D), .avail_N(avail_N), .avail_P(avail_P),
        .disp_B(disp_B), .disp_Q(disp_Q), .disp_D(disp_D), .disp_N(disp_N), .disp_P(disp_P)
    );

    // Testing clock
    always #(CLK_CYCLE / 2) clk = ~ clk;     

    // Coins storage logic///////////////////////////////////////////////////////
    reg rst_storage;
    integer bill_left, quarter_left, dime_left, nickle_left, penny_left;
    always @(posedge clk)
    begin   
        if(rst_storage) 
        begin
            bill_left <= BILL_LEFT;
            quarter_left <= QUARTER_LEFT;
            dime_left <= DIME_LEFT;
            nickle_left <= NICKLE_LEFT;
            penny_left <= PENNY_LEFT;
        end
        else
            #(0.1 * CLK_CYCLE) 
            casex({disp_B, disp_Q, disp_D, disp_N, disp_P})
                5'b1xxxx : bill_left <= bill_left - 1;
                5'bx1xxx : quarter_left <= quarter_left - 1;
                5'bxx1xx : dime_left <= dime_left - 1;
                5'bxxx1x : nickle_left <= nickle_left - 1;
                5'bxxxx1 : penny_left <= penny_left - 1;
            endcase
    end
    always @(*)
    begin   
        if(bill_left > 0) avail_B = 1; else avail_B = 0;
        if(quarter_left > 0) avail_Q = 1; else avail_Q = 0;
        if(dime_left > 0) avail_D = 1; else avail_D = 0;
        if(nickle_left > 0) avail_N = 1; else avail_N = 0;
        if(penny_left > 0) avail_P = 1; else avail_P = 0;
    end
    //////////////////////////////////////////////////////////////////////////////


    // Counter used to counts the number of each type of coin //////////////////////////////////
    integer bill_counter, quarter_counter, dime_counter, nickle_counter, penny_counter;
    reg rst_counter;
    always @(posedge clk, posedge rst_counter) 
    begin
        if(rst_counter) 
        begin
            bill_counter <= 0;
            quarter_counter <= 0;
            dime_counter <= 0;
            nickle_counter <= 0;
            penny_counter <= 0;
        end
        else
        begin
            casex({disp_B, disp_Q, disp_D, disp_N, disp_P})
                5'b1xxxx: bill_counter <= bill_counter + 1;
                5'bx1xxx: quarter_counter <= quarter_counter + 1;
                5'bxx1xx: dime_counter <= dime_counter + 1;
                5'bxxx1x: nickle_counter <= nickle_counter + 1;
                5'bxxxx1: penny_counter <= penny_counter + 1;
            endcase
        end
    end
    ////////////////////////////////////////////////////////////////////////////////////////
    
    // initial block used to generate input signals
    initial
    begin : random_test
        integer count, random_money, random_price;
        clk = 1;
        reset = 1;

        // {avail_B, avail_Q, avail_D, avail_N, avail_P} = 5'b11111;// coins are always available
        #(3.1 * CLK_CYCLE) 
        reset = 0;
        begin : random_test_loop
            for(count = 0; count < NUM_OF_TEST; count = count + 1) 
            begin
                #(0.1 * CLK_CYCLE) 
                if(~&({avail_B, avail_Q, avail_D, avail_N, avail_P})) 
                    disable random_test_loop;
                start = 1'b1;
                random_money = MIN_MONEY + ({$random} % (MAX_MONEY - MIN_MONEY));
                random_price = MIN_MONEY + ({$random} % (MAX_MONEY - MIN_MONEY));

                // Constraints: money >= price
                while(random_money <= random_price) 
                begin   
                    random_money = MIN_MONEY + ({$random} % (MAX_MONEY - MIN_MONEY));
                    random_price = MIN_MONEY + ({$random} % (MAX_MONEY - MIN_MONEY));   
                end
                money = random_money;
                price = random_price; 
                #(CLK_CYCLE);
                start = 1'b0;
                wait (done);
            end
        end
        #(CLK_CYCLE)
        
        $fclose(out_file);
        $finish;
    end

    // Monitors and displays each case 
    reg [31:0] out_file;   
    initial 
    begin : case_display
        integer case_num;
        case_num = 1;
        out_file = $fopen("vm.out", "w");
        
        rst_counter = 1;
        rst_storage = 1;
        #(3.1 * CLK_CYCLE)
        rst_counter = 0;
        rst_storage = 0;

        $timeformat(-9, 0.1, "ns", 2);
        forever @(posedge clk)
        begin : case_check_loop
            #(0.05 * CLK_CYCLE)
            rst_counter = 0;
			if(done) 
			begin
				$fdisplay(out_file, "############################## Case #%1d ##############################", case_num);
				$fdisplay(out_file, "At time %t :", $time);
				$fdisplay(out_file, "Money = %1.2f, Price = %1.2f, Change = %1.2f", money / 100.0, price / 100.0, (money - price) / 100.0);
				$fdisplay(out_file, "Coin return:");
				$fdisplay(out_file, "Dollar bill: %1d", bill_counter);
				$fdisplay(out_file, "Quarter: %1d", quarter_counter);
				$fdisplay(out_file, "Dime: %1d", dime_counter);
				$fdisplay(out_file, "Nickle: %1d", nickle_counter);
				$fdisplay(out_file, "Penny: %1d", penny_counter);
				$fdisplay(out_file, "Coins left: dollar %1d, quarter %1d, dime %1d, nickle %1d, penny %1d", bill_left, quarter_left, dime_left, nickle_left, penny_left);
				if(check_results(money, price, bill_counter, quarter_counter, dime_counter, nickle_counter, penny_counter))
					$fdisplay(out_file, "(Case Passed!)");
				else
				begin
					$fdisplay(out_file, "(Case Failed!)");
					// disable case_check_loop;  
				end
                case_num = case_num + 1;
				rst_counter = 1;
            end
        end
    end

    // Checks the results of each cases
    // Returns true if coins dispersed matched with the value of change
    function automatic check_results;
        input [9:0] money, price;
        input [32:0] dollar_bill, quarter, dime, nickle, penny;

        if((money - price) == (dollar_bill * coin_return_dut.DOLLAR_BILL 
        + quarter * coin_return_dut.QUARTER + dime * coin_return_dut.DIME 
        + nickle * coin_return_dut.NICKLE + penny * coin_return_dut.PENNY))
            check_results = `TRUE;
        else
            check_results = `FALSE;
    endfunction

endmodule
`undef TRUE
`undef FALSE