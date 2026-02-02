module ChipInterface
    (output logic [15:0] LD,
     input logic [15:0] SW);

    Zorgian Z(.a(SW[5]), .b(SW[4]), .c(SW[3]),
              .d(SW[2]), .e(SW[1]), .f(SW[0]),
              .valid(LD[15]), .vowel(LD[14]));

endmodule: ChipInterface
