//`default_nettype none

module lab1SOP (
    input logic A, B, C, D, E, F,
    output logic valid, output logic vowel);

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
    logic na122;

    nand (na12, nA, C, nD, nE);
    nand (na122, na12, na12);
    nand (na5, na122, F);

    //AB'D'E'
    nand (na6, A, nB, nD, nE);

    //B'C'D'F'
    nand (na7, nB, nC, nD, nF);

    //A'B'CDF'
    logic na13;
    logic na132;

    nand (na13, nA, nB, C, D);
    nand (na132, na13, na13);
    nand (na8, na132, nF);

    //B'C'D'E
    nand (na9, nB, nC, nD, E);

    //A'BC'EF'
    logic na14;
    logic na142;

    nand (na14, nA, B, nC, E);
    nand (na142, na14, na14);
    nand (na10, na142, nF);

    //B'C'E'F'
    nand (na11, nB, nC, nE, nF);

    logic na15, na16, na17;
    logic na152, na162, na172;

    nand (na15, na1, na2, na3, na4);
    nand (na16, na5, na6, na7, na8);
    nand (na17, na9, na10, na11);

    nand (na152, na15, na15);
    nand (na162, na16, na16);
    nand (na172, na17, na17);

    nand (valid, na152, na162, na172);

    //vowels
    //A'C'D'EF'
    logic na18, na19, na20;
    logic na21, na22, na23;
    logic na212, na222, na232;

    //BCD'EF'
    nand (na21, nA, nC, nD, E);
    nand (na212, na21, na21);
    nand (na18, na212, nF);

    //AB'D'E'F
    nand (na22, B, C, nD, E);
    nand (na222, na22, na22);
    nand (na19, na222, nF);

    nand (na23, A, nB, nD, nE);
    nand (na232, na23, na23);
    nand (na20, na232, F);

    nand (vowel, na18, na19, na20);


endmodule : lab1SOP

module lab1SOP_test
    (output logic A, B, C, D, E, F,
     input logic valid, vowel);

    initial begin
        $monitor($time,,
            "A = %b, B = %b, C = %b, D = %b, E = %b, F = %b, valid = %b, vowel = %b", A, B, C, D,  E, F, valid, vowel);

        // if d e f = 1 0 1, should always be valid but not vowel

             D = 1; E = 0; F = 1;

        #10 A = 0; B = 0; C = 0;

        #10 if (!(valid == 1 && vowel == 0))
                 $display("FAIL: def = 101, abc = 000");

        #10 A = 1; B = 1; C = 1;

        #10 if (!(valid == 1 && vowel == 0))
                $display("FAIL: def = 101, abc = 111");

        #10 A = 1; B = 0; C = 1;

        #10 if (!(valid == 1 && vowel == 0))
                $display("FAIL: def = 101, abc = 101");

        // if d e f = 0 1 0 and valid then its a vowel

        #10 A = 0; B = 0; C = 0; D = 0; E = 1; F = 0;

        #10 if (!(valid == 1 && vowel == 1))
                $display("FAIL: def = 010, abc = 000");

        #10 A = 0; B = 1; C = 1; // valid and vowel

        #10 if (!(valid == 1 && vowel == 1))
                $display("FAIL: def = 010, abc = 011");

        #10 A = 0; B = 1; C = 0; // valid and vowel
        #10

        #10 if (!(valid == 1 && vowel == 1))
                $display("FAIL: def = 010, abc = 010");

        // vowel u

        #10 A = 1; B = 0; C = 1; D = 0; E = 0; F = 1; // valid and vowel

        // rest of letters that are not in def 101 or 010
        $display("Valids and not vowels below");
        #10 A = 0; B = 0; C = 0; D = 0; E = 0; F = 0; // valid and not vowel
        #10 A = 0; B = 1; C = 1; D = 0; E = 0; F = 0; // valid and not vowel
        #10 A = 1; B = 0; C = 1; D = 0; E = 0; F = 0; // valid and not vowel
        #10 A = 1; B = 1; C = 0; D = 0; E = 0; F = 0; // valid and not vowel
        #10 A = 1; B = 1; C = 1; D = 0; E = 0; F = 0; // valid and not vowel
        #10 A = 0; B = 0; C = 1; D = 0; E = 0; F = 1; // valid and not vowel
        #10 A = 0; B = 1; C = 1; D = 0; E = 0; F = 1; // valid and not vowel
        #10 A = 1; B = 1; C = 0; D = 0; E = 0; F = 1; // valid and not vowel
        #10 A = 0; B = 0; C = 0; D = 0; E = 1; F = 1; // valid and not vowel
        #10 A = 1; B = 0; C = 1; D = 0; E = 1; F = 1; // valid and not vowel
        #10 A = 1; B = 1; C = 0; D = 0; E = 1; F = 1; // valid and not vowel
        #10 A = 1; B = 1; C = 1; D = 0; E = 1; F = 1; // valid and not vowel
        #10 A = 0; B = 0; C = 1; D = 1; E = 1; F = 0; // valid and not vowel
        #10 A = 0; B = 1; C = 0; D = 1; E = 1; F = 0; // valid and not vowel
        #10

        // invalids
        $display("Invalids");
        #10 A = 0; B = 0; C = 0; D = 0; E = 0; F = 1;
        #10 A = 1; B = 0; C = 1; D = 1; E = 1; F = 0;
        #10 A = 0; B = 1; C = 1; D = 0; E = 1; F = 1;
        #10 $finish;

    end

endmodule : lab1SOP_test

module top();
    logic valid, vowel, A, B, C, D, E ,F;

    lab1SOP     DUT(.A, .B, .C, .D, .E, .F, .valid, .vowel);

    lab1SOP_test T(.A, .B, .C, .D, .E, .F, .valid, .vowel);

endmodule : top

