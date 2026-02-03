module ChipInterface
    (output logic [15:0] LD,
     input logic [15:0] SW);

    lab1SOP Z(.A(SW[5]), .B(SW[4]), .C(SW[3]),
              .D(SW[2]), .E(SW[1]), .F(SW[0]),
              .valid(LD[15]), .vowel(LD[14]));

endmodule: ChipInterface
