module dmem(
  input      clk,
             we,
  input[7:0] addr,
  input[7:0] di,
  output logic[7:0] dout);

  logic[7:0] guts[256];
  always_ff @(posedge clk) if (we) begin
    guts[addr] <= di;
    //$display("wrote %d, to %d", di, addr);
  end

  always_comb begin
    dout = guts[addr];
    /*
    $display("dmem dout %d", dout);
    $display("addr is %d", addr);
    $display("guts addr %d", guts[addr]);
    */
  end

endmodule