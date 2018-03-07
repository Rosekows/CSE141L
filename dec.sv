module dec(
  input[4:0] op,
  input[19:0] inst,
  
  // R-types and I-types
  output logic[4:0] rs,
  output logic[4:0] rd,
  output logic[4:0] rt,
  
  // J-types
  output logic[14:0] bamt,
  
  output logic we_rf,
  output logic we_dmem
 );

  always_comb begin
      rs = 5'b0;
	  rd = 5'b0;
	  rt = 5'b0;
	  bamt = 15'b0;
	  we_rf = 1'b0;
	  we_dmem = 1'b0;
  
	  // R - type
	  if (op < 7 || op == 11) begin
	    rd = inst[14:10];
	  	rs = inst[9:5];
	  	rt = inst[4:0];
	  	we_rf = 1;
	  	we_dmem = 0;
	  end
	  
	  // I - type: load
	  else if (op == 12) begin
	  	rd = inst[14:10];   //register to load into, so rd->ptr_w (written into 
	  						//   when write enabled)
	  	rt = inst[9:5];		//constant to add to reg value, so rt->ptr_b->do_b->in_b					//   ->rslt->addr
	  	rs = inst[4:0];		//reg value to base address from, so rs->ptr_a->do_a->						//   in_a->rslt->addr
	  	we_rf = 0;
	  	we_dmem = 0;
	  end
	  
	  // I - type: store
	  else if (op == 13) begin
	  	rs = inst[14:10];	//address of dmem location to write to, so rs->ptr_a->
	  						//  do_a->in_a->rslt->addr
	  	rd = inst[9:5]; 	//data to be written into dmem, so rd->ptr_w->store_val
	  	we_rf = 0;
	  	we_dmem = 1;
	  end
	  
	  // J - type:
	  else begin
	  	bamt = inst[14:0];
	  	we_rf = 0;
	  	we_dmem = 0;
	  end
   end
endmodule