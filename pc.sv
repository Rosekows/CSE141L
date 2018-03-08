import definitions::*;
module pc (
  input        [4:0] op, // changed from [2:0]
  input              z,
  input              lt,
  input      [14:0] bamt, // orig [7:0]
  input              clk,
  input              reset,
  output logic [7:0] PC);


  logic[1:0] state = -1;     // state 0 = PRODUCT, 1 = STRING MATCH, 2 = CLOSEST PAIR

  assign brel = op==BA || (lt && op==BL) || (!lt && op==BG) || (z && op==BE);
  
  always @(posedge reset) begin
    if (state == 2) state <= 0; //changed from 1 to 0, should start at 0 if state is initalized to -1?? (could use 2?)
    else state <= state + 1;
  end

  always_ff @(posedge clk) 
    if (reset && state == 0)      //TODO: I dont think this was actually happening, because the first time reset is 
                                  //      hit, the state immediately became 1      
      PC <= 0;
      $display("program 1");                     // START OF PRODUCT
    else if (reset && state == 1)
      PC <= 25;                     // START OF STRING MATCH
      $display("program 2");
    else if (reset)
      PC <= 44;                     // START OF CLOSEST PAIR
      $display("program 3");
    else if (brel)
	    PC <= PC + bamt;
      $display("branched, pc = %d", PC);
    else 
	    PC <= PC + 'b1;
      %display("pc = %d", PC);
    end
endmodule