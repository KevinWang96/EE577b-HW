/*
    4-bit to 8-bit Extended Hamming Code encoder
*/
module ham_74_encoder (
d, // [3:0] input data word 
c // [7:0] output code word 
);
    input [3:0] d;
    output [7:0] c;

    // The Generator Matrix
    localparam  G_MATRIX_0 = 4'b1101,
                G_MATRIX_1 = 4'b1011,
                G_MATRIX_2 = 4'b1000,
                G_MATRIX_3 = 4'b0111,
                G_MATRIX_4 = 4'b0100,
                G_MATRIX_5 = 4'b0010,
                G_MATRIX_6 = 4'b0001;

    // Generate the word code
    assign c[0] = (G_MATRIX_0[3] & d[0]) ^ (G_MATRIX_0[2] & d[1]) ^ (G_MATRIX_0[1] & d[2]) ^ (G_MATRIX_0[0] & d[3]);
    assign c[1] = (G_MATRIX_1[3] & d[0]) ^ (G_MATRIX_1[2] & d[1]) ^ (G_MATRIX_1[1] & d[2]) ^ (G_MATRIX_1[0] & d[3]);    
    assign c[2] = (G_MATRIX_2[3] & d[0]) ^ (G_MATRIX_2[2] & d[1]) ^ (G_MATRIX_2[1] & d[2]) ^ (G_MATRIX_2[0] & d[3]);
    assign c[3] = (G_MATRIX_3[3] & d[0]) ^ (G_MATRIX_3[2] & d[1]) ^ (G_MATRIX_3[1] & d[2]) ^ (G_MATRIX_3[0] & d[3]);
    assign c[4] = (G_MATRIX_4[3] & d[0]) ^ (G_MATRIX_4[2] & d[1]) ^ (G_MATRIX_4[1] & d[2]) ^ (G_MATRIX_4[0] & d[3]);
    assign c[5] = (G_MATRIX_5[3] & d[0]) ^ (G_MATRIX_5[2] & d[1]) ^ (G_MATRIX_5[1] & d[2]) ^ (G_MATRIX_5[0] & d[3]);
    assign c[6] = (G_MATRIX_6[3] & d[0]) ^ (G_MATRIX_6[2] & d[1]) ^ (G_MATRIX_6[1] & d[2]) ^ (G_MATRIX_6[0] & d[3]);
    
    // the MSB is even parity bit
    assign c[7] = ^ c[6:0];

endmodule