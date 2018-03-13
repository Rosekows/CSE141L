import definitions::*;
module alu (
  input       [4:0] op,       // 5 bits for opcode
  input       [7:0] in_a,
  input       [7:0] in_b,

  output logic[7:0] rslt,
  output logic      co,
  output logic      lt,       // for cmp, 1 if in_a is < in_b, 0 if in_a > in_b
  output logic      z
  );

  always_comb begin
    case(op)
    kADD: {co,rslt} = in_a + in_b;
    kSUB: rslt = in_a - in_b;
    kAND: rslt = in_a & in_b;
    kXOR: rslt = in_a ^ in_b;
    kSLL: rslt = in_a << 1;
    kSRL: rslt = in_a >> 1;
    kCMP: {z, lt} = {in_a == in_b, in_a < in_b}; //$display("compare, in_a is %d, in_b is %d", in_a, in_b);
    kBE:  rslt = in_b;        // branching doesn't use ALU
    kBL:  rslt = in_b;        // branching doesn't use ALU
    kBG:  rslt = in_b;        // branching doesn't use ALU
    kBA:  rslt = in_b;        // branching doesn't use ALU
    kMOV: rslt = in_b;        // moving doesn't use ALU (NEEDS TO BE IN_B)
    kLD:  rslt = in_a + in_b; // calculate the load address
    kST:  rslt = in_b;        // store doesn't use ALU
    default: $display("hitting default case!");
	 endcase
	 
	/*
	if (op == kCMP) begin
		$display("compare, in_a is %d, in_b is %d", in_a, in_b);
	end
	if (op == kADD && in_b == 1) begin
		$display("looping compare: counter is %d", in_a);
	end
	$display("alu bullshit %d", rslt);
	*/
  end

endmodule