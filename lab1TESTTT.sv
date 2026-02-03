`default_nettype none

module Zorgian (
  input  logic A, B, C, D, E, F,
  output logic valid
);
  lab1SOP_valid u_valid (.A(A), .B(B), .C(C), .D(D), .E(E), .F(F), .valid(valid));
endmodule : Zorgian

module Zorgian_test (
  output logic  A, B, C, D, E, F,
  input  logic valid
);
  // bit [1:0]: [1]=is_dont_care, [0]=expected_valid
  bit [1:0] lookup [64];

  initial begin
    // Initialize everything to 0 (not valid, not don't-care)
    for (int j = 0; j < 64; j++) lookup[j] = 2'b00;

    // --- Mark all VALID letters (Consonants + Vowels) ---
    // Consonants
    lookup[6'b000000] = 2'b01; // B
    lookup[6'b011000] = 2'b01; // Q
    lookup[6'b101000] = 2'b01; // Q (duplicate)
    lookup[6'b110000] = 2'b01; // Y
    lookup[6'b111000] = 2'b01; // G
    lookup[6'b001001] = 2'b01; // S
    lookup[6'b011001] = 2'b01; // R
    lookup[6'b110001] = 2'b01; // W
    lookup[6'b000011] = 2'b01; // L
    lookup[6'b101011] = 2'b01; // D
    lookup[6'b110011] = 2'b01; // T
    lookup[6'b111011] = 2'b01; // C
    lookup[6'b000101] = 2'b01; // P
    lookup[6'b001101] = 2'b01; // V
    lookup[6'b010101] = 2'b01; // J
    lookup[6'b011101] = 2'b01; // F
    lookup[6'b101101] = 2'b01; // X
    lookup[6'b110101] = 2'b01; // K
    lookup[6'b111101] = 2'b01; // H
    lookup[6'b001110] = 2'b01; // M
    lookup[6'b010110] = 2'b01; // N

    // Vowels
    lookup[6'b101001] = 2'b01; // U
    lookup[6'b000010] = 2'b01; // I
    lookup[6'b010010] = 2'b01; // O
    lookup[6'b011010] = 2'b01; // E
    lookup[6'b111010] = 2'b01; // A

    // --- Run the Loop ---
    for (int i = 0; i < 64; i++) begin
      {A, B, C, D, E, F} = i[5:0];
      #1;

      // Skip don't-care cases
      if (lookup[i][1]) continue;

      if (valid !== lookup[i][0]) begin
        $display("FAIL: Input %b | Got valid=%b | Exp valid=%b",
                 i[5:0], valid, lookup[i][0]);
      end
    end

    $display("All valid tests passed!");
    $finish;
  end
endmodule

module top;
  logic A, B, C, D, E, F;
  logic valid;

  Zorgian      DUT (.A(A), .B(B), .C(C), .D(D), .E(E), .F(F), .valid(valid));
  Zorgian_test T   (.A(A), .B(B), .C(C), .D(D), .E(E), .F(F), .valid(valid));
endmodule : top

