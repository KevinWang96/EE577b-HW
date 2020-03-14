`timescale 1ns/100ps
module tb_fa;
    // input <=> {a, b, ci}
    reg [2:0] inputs;

    // output <=> {sum, carry}
    wire [1:0] outputs;
    
    // instantiation of DUT
    fa fa_dut(.a(inputs[2]), .b(inputs[1]), .ci(inputs[0]), .sum(outputs[1]), .carry(outputs[0]));

    integer count;
    parameter TIME_INTERVAL = 5;
    parameter NUM_OF_INPUT_PATTERN = 2 ** 3;

    integer out_file;
    initial
    begin
        out_file = $fopen("fa.out", "w");
        $fdisplay(out_file, "a, b, ci : sum, carry");
        for(count = 0; count < NUM_OF_INPUT_PATTERN; count = count + 1)
        begin : for_loop
            integer i;
            inputs = count;
            for(i = 2; i >= 0; i = i - 1)
                $fwrite(out_file, "%b ", inputs[i]);
            $fwrite(out_file, ": ");
            #(0.1 * TIME_INTERVAL)
            for(i = 1; i >= 0; i = i - 1)
                $fwrite(out_file, "%b ", outputs[i]);
            $fwrite(out_file, "\n");
            #(TIME_INTERVAL);
        end
        $fclose(out_file);
        $finish;
    end
endmodule
    


