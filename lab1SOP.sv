`default_nettype none

module lab1_SOP (
    input logic A, B, C, D, E, F,
    output logic h);

    logic nA, nB, nC, nD, nE, nF;
    not (nA, A);
    not (nB, B);
    not (nC, C);
    not (nD, D);
    not (nE, E);
    not (nF, F);

    logic na1, na2, na3, na4, na5, na6;
    logic na7, na8, na9, na10, na11;

    //DE'
    nand (na1, D, nE);

    //AC'E'
    nand (na2, A, nC, nE);

    //BCD'F'
    nand (na3, B, C, nD, nF);

    //AD'EF
    nand (na4, A, nD, E, F);

    //A'CD'E'F
    logic na12;

    nand (na12, nA, C, nD, nE);
    nand (na12, na12, na12);
    nand (na5, na12, F);

    //AB'D'E'
    nand (na6, A, nB, nD, nE);

    //B'C'DF'
    nand (na7, nB, nC, D, nF);

    //A'B'CDF'
    logic na13;
    nand (na13, nA, nB, C, D);
    nand (na13, na13, na13);
    nand (na8, na13, nF);

    //B'C'D'E
    nand (na9, nB, nC, nD, E);

    //A'BC'EF'
    logic na14;
    nand (na14, nA, B, nC, E);
    nand (na14, na14, na14);
    nand (na10, na14, nF);

    //B'C'E'F'
    nand (na11, nB, nC, nE, nF);

    logic na15, na16, na17;

    nand (na15, na1, na2, na3, na4);
    nand (na16, na5, na6, na7, na8);
    nand (na17, na9, na10, na11);

    nand (na15, na15, na15);
    nand (na16, na16, na16);
    nand (na17, na17, na17);

    nand (h, na15, na16, na17);

endmodule : lab1_SOP
