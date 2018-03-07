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
                    store_value);

  logic  [7:0] core[4];

  always_ff @(posedge clk) if(we)
	  core[ptr_w] <= di;

  always_comb begin        
    if (ptr_a == 0)           // if one of the pointers == 0, always output 0
      do_a = 0;
    else
      do_a = core[ptr_a];    
    if (const_flag)           // if b is a constant, pass value through 
      do_b = ptr_b;
    else if (ptr_b == 0)
      do_b = 0;
    else
      do_b = core[ptr_b];
    store_value = core[ptr_w];
    core[8] = r_overflow;
  end

endmodule