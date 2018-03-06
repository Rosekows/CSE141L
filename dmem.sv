module dmem(
  input      clk,
             we,
  input[7:0] addr,
  input[7:0] di,
  output logic[7:0] dout);

  logic[7:0] guts[256];
  always_ff @(posedge clk) if (we)
    guts[addr] <= di;

  always_comb
    dout = guts[addr];

endmodule