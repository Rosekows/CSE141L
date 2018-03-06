// Create Date:    17:44:49 2012.16.02 
// Latest rev:     2017.10.26
// Design Name:    CSE141L
// Module Name:    IF 

// generic program counter
module IF(
  input              Rel_Jump,		// branch by "offset"
  input signed[14:0] Offset,
  input Reset,
  input Halt,
  input CLK,
  output logic[8:0] PC             // pointer to insr. mem
  );
	 
  always @(posedge CLK)
	if(Reset)                       // reset to 0 and hold there
	  PC <= 0;
	else if(Halt)					// freeze
	  PC <= PC;						
	else if(Rel_Jump)				// jump by specified amount
	  PC <= PC + Offset;
	else							// normal advance thru program
	  PC <= PC+1;

endmodule
