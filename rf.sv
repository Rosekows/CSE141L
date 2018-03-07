module rf(
  input             clk,
  input  [7:0]      di,
  input             we,
  input  [1:0]      ptr_w,
                    ptr_a,
			        ptr_b,
  input				const_flag,
  
  output logic[7:0] do_a,
                    do_b
                    store_in);

  logic  [7:0] core[4];
  always_ff @(posedge clk) if(we)
	core[ptr_w] <= di;

  always_comb do_a = core[ptr_a];
  always_comb do_b = core[ptr_b];
  always_comb store_in = core[ptr_w];

endmodule