import definitions::*;
module pc (
  input        [4:0] op, // changed from [2:0]
  input              z,
  input              lt,
  input      [14:0] bamt, // orig [7:0]
  input              clk,
  input              reset,
  output logic [7:0] PC);


//  logic[1:0] state = 0;     // state 0 = PRODUCT, 1 = STRING MATCH, 2 = CLOSEST PAIR

  assign brel = op==BA || (lt && op==BL) || (!lt && op==BG) || (z && op==BE);


//  always @(posedge reset) begin    // TODO: Not sure if syntax is correct
//    if (state == 0) begin   
//      PC <= 'b0;                 // START OF PRODUCT
//      state <= 1;
//    end
//    else if (state == 1) begin
//      PC <= 25;                  // START OF STRING MATCH
//      state <= 2;
//    end
//    else begin
//      PC <= 44;                  // START OF CLOSEST PAIR
//      state <= 0;
//    end
//  end

  always_ff @(posedge clk) 
    if (reset)
      PC <= 0;
    else if (brel) begin
	  // if (brel && !reset)          // only increment if reset is not on TODO: this is a little sketchy...
	    PC <= PC + bamt;
    end
	 else begin 
	  // else if (!reset)
	    PC <= PC + 'b1;
    end
endmodule