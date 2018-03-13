module rf(
  input           clk,
  input[7:0]      di,
  input           we,
  input[4:0]      ptr_w,
                  ptr_a,
	input[7:0] 		  ptr_b,
  input       r_overflow,
  input				const_flag,
  input				reset,
  
  output logic[7:0] do_a,
                    do_b,
                    store_value
  );

  logic [7:0] core[9];
  
  always_comb begin
    if (ptr_a == 0)           // if one of the pointers == 0, always output 0
      assign do_a = 0;
    else begin
      assign do_a = core[ptr_a];
    end 
      
    if (const_flag)           // if b is a constant, pass value through 
      assign do_b = ptr_b;
    else if (ptr_b == 0)
      assign do_b = 0;
    else
      assign do_b = core[ptr_b[4:0]];    
   end
   
   
   assign store_value = core[ptr_w];
   
   /*
   if (reset) begin
   	  // reset core
   	  assign core[0] = 0;
   	  assign core[1] = 0;
   	  assign core[2] = 0;
   	  assign core[3] = 0;
   	  assign core[4] = 0;
   	  assign core[5] = 0;
   	  assign core[6] = 0;
   	  assign core[7] = 0;
   	  assign core[8] = 0;
   end*/
    
   always_ff @ (posedge clk) begin
  	 core[8] <= r_overflow;
  	 if (we) begin 
      core[ptr_w] <= di; 
	 end
	end
endmodule