/*
    8-bit to 4-bit Extended Hamming Code decoder
*/
module ham_74_decoder (
c, // [6:0] input codeword 
qc, // [6:0] corrected code word 
qd, // [3:0] corrected data word 
x // 1-bit double error flag 
);
    input [7:0] c;
    output [7:0] qc;
    output [3:0] qd;
    output x;
    reg [7:0] qc;
    reg x;

    // data word before correction
    wire [2:0] syndrome_vec;

    // The Parity-check Matrix
    localparam  H_MATRIX_0 = 7'b1010101,
                H_MATRIX_1 = 7'b0110011,
                H_MATRIX_2 = 7'b0001111;

    // Generate the syndrome code       
    assign  syndrome_vec[0] = (H_MATRIX_0[6] & c[0]) ^ (H_MATRIX_0[5] & c[1]) ^ (H_MATRIX_0[4] & c[2]) ^
                (H_MATRIX_0[3] & c[3]) ^ (H_MATRIX_0[2] & c[4]) ^ (H_MATRIX_0[1] & c[5]) + (H_MATRIX_0[0] & c[6]);
    assign  syndrome_vec[1] = (H_MATRIX_1[6] & c[0]) ^ (H_MATRIX_1[5] & c[1]) ^ (H_MATRIX_1[4] & c[2]) ^
                (H_MATRIX_1[3] & c[3]) ^ (H_MATRIX_1[2] & c[4]) ^ (H_MATRIX_1[1] & c[5]) + (H_MATRIX_1[0] & c[6]);
    assign  syndrome_vec[2] = (H_MATRIX_2[6] & c[0]) ^ (H_MATRIX_2[5] & c[1]) ^ (H_MATRIX_2[4] & c[2]) ^
                (H_MATRIX_2[3] & c[3]) ^ (H_MATRIX_2[2] & c[4]) ^ (H_MATRIX_2[1] & c[5]) + (H_MATRIX_2[0] & c[6]);

    // Single error correction
    always @(*) 
    begin
        qc[6:0] = c[6:0];
        case(syndrome_vec)
            3'b001: qc[0] = ~ c[0];
            3'b010: qc[1] = ~ c[1];
            3'b011: qc[2] = ~ c[2];
            3'b100: qc[3] = ~ c[3];
            3'b101: qc[4] = ~ c[4];
            3'b110: qc[5] = ~ c[5];
            3'b111: qc[6] = ~ c[6];
        endcase

        qc[7] = ^qc[6:0]; // Generates the even parity bit for new corrected word code

        // Report double errors
        if((syndrome_vec != 0) && (qc[7] != c[7]))
            x = 1;
        else 
            x = 0;
    end

    // Derive the original data word based on corrected word code if x = 0;
    // p0 = x2, p1 = x4, p2 = x5, p3 = x6;
    assign qd = {qc[6], qc[5], qc[4], qc[2]};

endmodule


    
            
