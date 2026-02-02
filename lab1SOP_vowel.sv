`default_nettype none

module lab1SOP_vowel (
    input logic A, B, C, D, E, F,
    output logic vowel);

    logic nA, nB, nC, nD, nE, nF;
    not (nA, A);
    not (nB, B);
    not (nC, C);
    not (nD, D);
    not (nE, E);
    not (nF, F);

    //A'C'D'EF'
    logic na1, na2, na3;
    logic na4, na5, na6;

    //BCD'EF'
    nand (na4, nA, nC, nD, E);
    nand (na4, na4, na4);
    nand (na1, na4, nF);

    //AB'D'E'F
    nand (na5, B, C, nD, E);
    nand (na5, na5, na5);
    nand (na2, na5, nF);

    nand (na6, A, nB, nD, nE);
    nand (na6, na6, na6);
    nand (na3, na6, F);

    nand (vowel, na1, na2, na3);

endmodule
