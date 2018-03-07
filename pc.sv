import definitions::*;
module pc (
  input        [4:0] op, // changed from [2:0]
  input              z,
  input              lt,
  input      [14:0] bamt, // orig [7:0]
  input              clk,
  input              reset,
  output logic [7:0] PC);


  logic[1:0] state = 0;     // state 0 = PRODUCT, 1 = STRING MATCH, 2 = CLOSEST PAIR

  assign brel = op==BA || (lt && op==BL) || (!lt && op==BG) || (z && op==BE);
  
  always @(posedge reset) begin
    if (state == 2) state <= 1;
    else state <= state + 1;
  end

  always_ff @(posedge clk) 
    if (reset && state == 0)        
      PC <= 0;                      // START OF PRODUCT
    else if (reset && state == 1)
      PC <= 25;                     // START OF STRING MATCH
    else if (reset)
      PC <= 44;                     // START OF CLOSEST PAIR
    else if (brel)
	    PC <= PC + bamt;
    else 
	    PC <= PC + 'b1;

endmodule