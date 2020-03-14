/*
    one bit full adder using gate level modelinhg
*/
module fa (a, b, ci, sum, carry);
    input a, b, ci;
    output carry, sum;

    wire w1, w2, w3;// intermediate wires

    xor (w1, a, b);
    xor (sum, w1, ci);

    nand (w2, w1, ci);
    nand (w3, a, b);
    nand (carry, w2, w3);
endmodule




