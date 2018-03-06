import definitions::*;
module alu (
  input       [4:0] op,       // 5 bits for opcode
  input       [7:0] in_a,
  input       [7:0] in_b,

  output logic[7:0] rslt,
  output logic      co,
  output logic      lt,       // for cmp, 1 if in_a is < in_b, 0 if in_a > in_b
  output logic      z);

  always_comb begin
     co    = 1'b0;
	  rslt  = 8'b0;
	  z     = 1'b0;
	  lt 	  = 1'b0;
    case(op)
    kADD: {co,rslt} = in_a + in_b;
    kSUB: {co,rslt} = in_a + in_b;
    kAND: rslt = in_a & in_b;
    kXOR: rslt = in_a ^ in_b;
    kSLL: rslt = in_a << 1;
    kSRL: rslt = in_a >> 1;
    kCMP: {z, lt} = {in_a == in_b, in_a < in_b};
    //kCMP: z = in_a == in_b,
    // 		 lt = in_a < in_b;
    kBE:  rslt = in_a;        // branching doesn't use ALU
    kBL:  rslt = in_b;        // branching doesn't use ALU
    kBG:  rslt = in_b;        // branching doesn't use ALU
    kBA:  rslt = in_b;        // branching doesn't use ALU
    kMOV: rslt = in_a;        // moving doesn't use ALU
    kLD:  rslt = in_a + in_b; // calculate the load address
    kST:  rslt = in_a;        // store doesn't use ALU
	 endcase
  end

endmodule