//`default_nettype none

module Zorgian
  (input logic a, b, c, d, e, f,
   output logic valid, vowel);

   logic a_not, b_not, c_not, d_not, e_not, f_not;
   logic nt1, nt2, nt2a, nt2b, nt3a, nt3b, nt3,
        nt4, nt4a, nt4b, nt4c, nt4d, nt5, nt5a, nt5b, nt6, nt7,
        nt8, nt9, nt10, nt11, nt12,
        nt13, nt14, nt15, nt16,
        nt17, nt18;
    logic at1, at2, at3, at4, at5;

    not (a_not, a),
        (b_not, b),
        (c_not, c),
        (d_not, d),
        (e_not, e),
        (f_not, f);

    // (d' + e' + f')
    nor (nt1, d_not, e_not, f_not);

    // (a + b + c' + d + f)
    nor (nt2a, a, b, c_not, d),
        (nt2b, nt2a, nt2a),
        (nt2, f, nt2b);

    // (a + c + d + e + f')
    nor (nt3a, a, c, d, e),
        (nt3b, nt3a, nt3a), //0
        (nt3, f_not, nt3b); //

    // (a' + b' + c' + d + e + f')
    nor (nt4a, a_not, b_not, c_not),
        (nt4b, nt4a, nt4a),
        (nt4c, d, e, f_not),
        (nt4d, nt4c, nt4c),
        (nt4, nt4d, nt4b);

    // (a+b'+c+e+f)
    nor (nt5a, a, b_not, c, e),
        (nt5b, nt5a, nt5a),
        (nt5, f, nt5b);

    // (b' + c' + d' + e')
    nor (nt6, b_not, c_not, d_not, e_not);

    // (a + c' + e' + f')
    nor (nt7, a, c_not, e_not, f_not);

    // (a' + c + e' + f)
    nor (nt8, a_not, c, e_not, f);

    // (a' + b + e' + f)
    nor (nt9, a_not, b, e_not, f);

    // (b + c + d' + e')
    nor (nt10, b, c, d_not, e_not);

    // (a + b' + e' + f')
    nor (nt11, a, b_not, e_not, f_not);


    nor (at1, nt1, nt2, nt3, nt4),
        (at2, nt5, nt6, nt7, nt8),
        (at3, nt9, nt10, nt11);
    logic ft1, ft2, ft3;
    nor (ft1, at1, at1);
    nor (ft2, at2, at2);
    nor (ft3, at3, at3);
    nor (valid, ft1, ft2, ft3);

    // (e + f)
    nor (nt12, e, f);

    // d' + e' + f
    nor (nt13, d_not, e_not, f);

    // b + c' + d + e'
    nor (nt14, b, c_not, d, e_not);

    // a + f'
    nor (nt15, a, f_not);

    // a' + d' + f'
    nor (nt16, a_not, d_not,f_not);

    // b' + c' + d + f'
    nor (nt17, b_not, c_not, d, f_not);

    // a' + c + d
    nor (nt18, a_not, c, d);

    logic ft4, ft5;

    nor (at4, nt12, nt13, nt14),
        (at5, nt15, nt16, nt17, nt18);
    nor (ft4, at4, at4);
    nor (ft5, at5, at5);
    nor (vowel, ft4, ft5);

endmodule : Zorgian

module Zorgian_test
    (output logic a, b, c, d, e, f,
     input logic valid, vowel);

    initial begin
        $monitor($time,,
            "a = %b, b = %b, c = %b, d = %b, e = %b, f = %b, valid = %b, vowel = %b", a, b, c, d, e, f, valid, vowel);

        // if d e f = 1 0 1, should always be valid but not vowel

             d = 1; e = 0; f = 1;

        #10 a = 0; b = 0; c = 0;

        #10 if (!(valid == 1 && vowel == 0))
                 $display("FAIL: def = 101, abc = 000");

        #10 a = 1; b = 1; c = 1;

        #10 if (!(valid == 1 && vowel == 0))
                $display("FAIL: def = 101, abc = 111");

        #10 a = 1; b = 0; c = 1;

        #10 if (!(valid == 1 && vowel == 0))
                $display("FAIL: def = 101, abc = 101");

        // if d e f = 0 1 0 and valid then its a vowel

        #10 a = 0; b = 0; c = 0; d = 0; e = 1; f = 0;

        #10 if (!(valid == 1 && vowel == 1))
                $display("FAIL: def = 010, abc = 000");

        #10 a = 0; b = 1; c = 1; // valid and vowel

        #10 if (!(valid == 1 && vowel == 1))
                $display("FAIL: def = 010, abc = 011");

        #10 a = 0; b = 1; c = 0; // valid and vowel

        #10 if (!(valid == 1 && vowel == 1))
                $display("FAIL: def = 010, abc = 010");

        // vowel u

        #10 a = 1; b = 0; c = 1; d = 0; e = 0; f = 1; // valid and vowel

        // rest of letters that are not in def 101 or 010
        $display("Valids and not vowels below");
        #10 a = 0; b = 0; c = 0; d = 0; e = 0; f = 0; // valid and not vowel
        #10 a = 0; b = 1; c = 1; d = 0; e = 0; f = 0; // valid and not vowel
        #10 a = 1; b = 0; c = 1; d = 0; e = 0; f = 0; // valid and not vowel
        #10 a = 1; b = 1; c = 0; d = 0; e = 0; f = 0; // valid and not vowel
        #10 a = 1; b = 1; c = 1; d = 0; e = 0; f = 0; // valid and not vowel
        #10 a = 0; b = 0; c = 1; d = 0; e = 0; f = 1; // valid and not vowel
        #10 a = 0; b = 1; c = 1; d = 0; e = 0; f = 1; // valid and not vowel
        #10 a = 1; b = 1; c = 0; d = 0; e = 0; f = 1; // valid and not vowel
        #10 a = 0; b = 0; c = 0; d = 0; e = 1; f = 1; // valid and not vowel
        #10 a = 1; b = 0; c = 1; d = 0; e = 1; f = 1; // valid and not vowel
        #10 a = 1; b = 1; c = 0; d = 0; e = 1; f = 1; // valid and not vowel
        #10 a = 1; b = 1; c = 1; d = 0; e = 1; f = 1; // valid and not vowel
        #10 a = 0; b = 0; c = 1; d = 1; e = 1; f = 0; // valid and not vowel
        #10 a = 0; b = 1; c = 0; d = 1; e = 1; f = 0; // valid and not vowel
        #10
        
        // invalids
        $display("Invalids");
        #10 a = 0; b = 0; c = 0; d = 0; e = 0; f = 1; 
        #10 a = 1; b = 0; c = 1; d = 1; e = 1; f = 0;
        #10 a = 0; b = 1; c = 1; d = 0; e = 1; f = 1;
        #10 $finish;

    end

endmodule : Zorgian_test

module top();
    logic valid, vowel, a, b, c, d, e ,f;

    Zorgian     DUT(.a, .b, .c, .d, .e, .f, .valid, .vowel);

    Zorgian_test T(.a, .b, .c, .d, .e, .f, .valid, .vowel);

endmodule : top
