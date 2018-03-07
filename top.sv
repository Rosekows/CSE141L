import definitions::*;
module top(
  input        clk,
               reset,
  output logic done);

  wire[19:0] inst;
  wire[8:0] iptr;
  wire[7:0] PC,     
			dm_out,
      dm_in,
			dm_addr,
			rf_di,
			in_a,
      in_b,
			rslt,
      store_in;
  wire[14:0] bamt;
  wire[4:0] op;	
  wire[1:0] ptr_a,
            ptr_b,
			      ptr_w;
  wire      z;
  wire 		  co;
  wire      lt; 

  assign  op = inst[19:15];
  assign  done = iptr==9'b000_000_000;
  
  alu au1(
	.op ,
	.in_a ,
	.in_b ,
	.rslt ,
	.co ,
	.lt ,
	.z  
  );
  
  pc pc1(
    .clk,
	.reset, 
	.op   ,
	.bamt ,
	.z    ,
	.lt   ,
	.PC );

  imem im1(
     .PC   ,
	 .iptr
  );
  
  rf rf1(
    .clk       ,
	.di (rf_di), // data output from either dmem or alu
	.we   (),
	.ptr_w()   ,
	.ptr_a()   ,
	.ptr_b()   ,
	.do_a(in_a),
	.do_b(in_b),
  .store_in
  );

  dmem dm1(
    .clk         ,
	.we  ()   ,
	.addr(dm_addr),
	.di  (store_in) ,
	.dout(dm_out)
  );
  
  lut_instr luti (
  	.iptr 	,
  	.inst
  );
  
  dec dec1 (
     .op,
     .inst,
     .rs(ptr_a),
     .rt(ptr_b),
     .rd(),
     .const_flag(),
     .we_rf(),
     .we_dmem()
  );

  rf_mux rf_mux1 (
    .op,
    .dmem_out(dm_out),
    .alu_result(rslt), 
    .rf_din(rf_di)
  );

endmodule