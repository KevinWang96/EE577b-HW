`timescale 1ns/100ps
module tb_ha;
    // input <=> {a, b}
    reg [1:0] inputs;

    // output <=> {sum, carry}
    wire [1:0] outputs;

    ha ha_dut(.a(inputs[1]), .b(inputs[0]), .sum(outputs[1]), .carry(outputs[0]));

    integer count;
    parameter TIME_INTERVAL = 5;
    parameter NUM_OF_INPUT_PATTERN = 2 ** 2;

    integer out_file;
    initial
    begin
        out_file = $fopen("ha.out", "w");
        $fdisplay(out_file, "a, b : sum, carry");
        for(count = 0; count < NUM_OF_INPUT_PATTERN; count = count + 1)
        begin : for_loop
            integer i;
            inputs = count;
            for(i = 1; i >= 0; i = i - 1)
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