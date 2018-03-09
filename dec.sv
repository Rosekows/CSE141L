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
      // rs = 5'b0;
	  // rd = 5'b0;
	  // rt = 5'b0;
	  // bamt = 15'b0;
	  // we_rf = 1'b0;
	  // we_dmem = 1'b0;
  
	  // R - type
	  if (op < 7 || op == 11) begin
	    rd = inst[14:10];
	  	rt = inst[9:5];
	  	rs = inst[4:0];
	  	we_rf = 1;
	  	we_dmem = 0;
	  end
	  
	  // I - type: load
	  else if (op == 12) begin
	  	rd = inst[14:10];
	  	rt = inst[9:5];
	  	rs = inst[4:0];
	  	we_rf = 1;
	  	we_dmem = 0;
	  end
	  
	  // I - type: store
	  else if (op == 13) begin
	  	rd = inst[14:10]; 
	  	rt = inst[9:5]; // used to be rs
	  	we_rf = 0;
	  	we_dmem = 1;
	  end
	  
	  // J - type:
	  else begin
	  	bamt = inst[14:0];
	  	we_rf = 0;
	  	we_dmem = 0;
	  end
	  
	  $display("rd is %d", rd);
	  $display("rs is %d", rs);
	  $display("rt is %d", rt);
	  $display("we_rf is %d\n", we_rf);
   end
endmodule