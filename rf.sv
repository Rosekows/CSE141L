module rf(
  input             clk,
  input  [7:0]      di,
  input             we,
  input  [4:0]      ptr_w,
                    ptr_a,
			              ptr_b,
  input       r_overflow,
  input				const_flag,
  
  output logic[7:0] do_a,
                    do_b
                    store_in);

  logic  [7:0] core[4];
  always_ff @(posedge clk) if(we)
	core[ptr_w] <= di;

  always_comb begin        // if one of the pointers == 0, we should always output 0
    do_a = core[ptr_a];    // should happen by default, but not currently checking
    do_b = core[ptr_b];
    store_in = core[ptr_w];
    core[8] = r_overflow;
  end

endmodule