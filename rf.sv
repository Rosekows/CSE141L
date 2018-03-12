module rf(
  input           clk,
  input[7:0]      di,
  input           we,
  input[4:0]      ptr_w,
                  ptr_a,
	input[7:0] 		  ptr_b,
  input       r_overflow,
  input				const_flag,
  
  output logic[7:0] do_a,
                    do_b,
                    store_value);

  logic  [7:0] core[9];
  
  //always_ff @(posedge clk) begin
  always_comb begin
    if (ptr_a == 0)           // if one of the pointers == 0, always output 0
      assign do_a = 0;
    else begin
      assign do_a = core[ptr_a];
      //if (ptr_a == 7) begin
      //	$display("reading regfile-- ptr_a: %d, do_a: %d, core[7]: %d", ptr_a, do_a, core[7]); 
      //end
    end   
    if (const_flag)           // if b is a constant, pass value through 
      assign do_b = ptr_b;
    else if (ptr_b == 0)
      assign do_b = 0;
    else
      assign do_b = core[ptr_b[4:0]];    
   end 
   
    //if (we) begin   //always_ff @(posedge clk) if(we) <- we think this is wrong
    always_ff @ (posedge clk)
  	 if (we) begin 
      core[ptr_w] <= di;       // CHANGED FROM <=
      //$display("writing %d to %d in rf", di, ptr_w);
      store_value <= core[ptr_w];
      core[8] <= r_overflow;
	 end
	 else begin
    	store_value <= core[ptr_w];
        core[8] <= r_overflow;
	 end
endmodule