import definitions::*;
module pc (
  input        [4:0] op, // changed from [2:0]
  input              z,
  input              lt,
  input      [14:0] bamt, // orig [7:0]
  input              clk,
  input              reset,
  output logic [7:0] PC);

  assign brel = op==BA || (lt && op==BL) || (!lt && op==BG) || (z && op==BE);

  always_ff @(posedge clk) 
    if(reset)
	  PC <= 'b0;
	else if (brel)
	  PC <= PC + bamt;
	else
	  PC <= PC + 'b1;

endmodule