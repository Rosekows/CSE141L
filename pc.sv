import definitions::*;
module pc (
  input        [4:0] op, // changed from [2:0]
  input              z,
  input              lt,
  input      [14:0] bamt, // orig [7:0]
  input              clk,
  input              reset,
  output logic [7:0] PC);


  logic[1:0] state = 3;     // state 0 = PRODUCT, 1 = STRING MATCH, 2 = CLOSEST PAIR

  assign brel = op==BA || (lt && op==BL) || (!lt && !z && op==BG) || (z && op==BE);
  
  always @(posedge reset) begin
    if (state >= 2) state = 0; 
    else state = state + 1;
  end

  always_ff @(posedge clk) 
    if (reset && state == 0)begin            
      PC <= 0;						// START OF PRODUCT
   	end
    else if (reset && state == 1) begin
      PC <= 28;                     // START OF STRING MATCH
    end
    else if (reset)begin
      PC <= 48;                     // START OF CLOSEST PAIR
    end
    else if (brel)begin
	    PC <= PC + bamt;
    end
    else begin
	    PC <= PC + 'b1;
    end
endmodule