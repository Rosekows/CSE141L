import definitions::*;
module top(
  input        clk,
               reset,
  output logic done);

  wire[19:0] inst;  //lut_instr->dec
  wire[8:0] iptr;   //imem->lut_instr
  wire[7:0] PC,     //pc->imem 
			dm_out,       //dmem->rf_mux
//	  rf_di,        //rf_mux->rf
			in_a,         //rf->alu
      in_b,         //rf->alu
			rslt,         //alu->dmem, alu->rf_mux
      store_val,    //rf->dmem
      ptr_b;        //lut_const->rf
  wire[14:0] bamt;  //dec->pc
  wire[4:0] op;	    //????????
  wire[4:0] ptr_a,  //dec->rf
            rt,     //dec->lut_const
			      ptr_w;  //dec->rf
  wire      z;      //alu->pc
  wire 		  co;     //alu->rf
  wire      lt;     //alu->pc
  wire      we_rf;  //dec->rf
  wire      we_dmem;  //dec->dmem
  wire      const_flag;   //lut_const->rf

  assign  op = inst[19:15];
  assign  done = iptr==9'b000_000_000;
  
  alu alu1(
	 .op, 
	 .in_a,
	 .in_b,
	 .rslt,
	 .co,
	 .lt,
	 .z  
  );
  
  pc pc1(
   .clk,
	 .reset, 
	 .op,
	 .bamt,
	 .z,
	 .lt,
	 .PC 
  );

  imem im1(
     .PC,
	   .iptr
  );
  
  assign load_instr = op == 12;
  assign rf_di = load_instr ? dm_out : rslt;

  rf rf1(
   .clk,
	 .di(rf_di),   
	 .we(we_rf),
	 .ptr_w,
	 .ptr_a,
	 .ptr_b,
   .r_overflow(co),
   .const_flag,
	 .do_a(in_a),
	 .do_b(in_b),
   .store_value(store_val)
  );

  dmem dm1(
   .clk,
	 .we(we_dmem),
	 .addr(rslt),
	 .di(store_val),
	 .dout(dm_out)
  );
  
  lut_instr luti (
  	.iptr,
  	.inst
  );
  
  dec dec1 (
     .op,
     .inst,
     .rs(ptr_a),
     .rt,
     .rd(ptr_w),
     .bamt, 
     .we_rf,
     .we_dmem
  );

//  rf_mux rf_mux1 (
//    .op,
//    .dmem_out(dm_out),
//    .alu_result(rslt), 
//    .rf_din(rf_di)
//  );

  lut_const lut_const1 (
    .ptr(rt),
    .constant(ptr_b),
    .const_flag
  );

endmodule