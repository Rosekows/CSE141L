/* Program 1. Product --Write a program that finds the product of three unsigned 
numbers, ie, A * B * C. 
The operands are found in memory locations 1 (A), 2 (B), and 3 (C).  
The result will be written into locations 4 (high bits) and 5 (low bits).  
There may be overflow, in which case you only store the low 16 bits.  
Your ISA will not have a "multiply" operation, so you'll need some sequence
of shifts and conditional adds. You may use Booth's algorithm, if you like, 
but this is not required. 
*/

module program_1(                           // sample simple hardware implementation
  input clk,
        init,						   // initalization reset, active high
  output logic done);				   // algorithm completion flag
  logic[7:0] data_ram[256];			   // 256x8 data memory
  logic[7:0] cycle_ct;				   // clock cycle counter

  always_ff @(posedge clk)
    if(init) begin
	  done        <= 0;
      cycle_ct    <= 0;
	  for(int i=4; i<8; i++)           // clear results/scratch part of data memory
	    data_ram[i] <= 0;			   // testbench will provide operands 	   
    end 
    else begin
	  case(cycle_ct)		           // takes multiple cycles to do the operation
// A*B
	    1: if(data_ram[1][0])
	         {data_ram[6],data_ram[7]} <= data_ram[2];
	    2,3,4,5,6,7,8: if(data_ram[1][cycle_ct-1])
	         {data_ram[6],data_ram[7]} <= {data_ram[6],data_ram[7]} + (data_ram[2]<<(cycle_ct-1));
// *C
        9: if(data_ram[3][0])
		     {data_ram[4],data_ram[5]} <= {data_ram[6],data_ram[7]}; 
        10,11,12,13,14,15,16: if(data_ram[3][cycle_ct-9])
		     {data_ram[4],data_ram[5]} <= 
		       	{data_ram[4],data_ram[5]} + ({data_ram[6],data_ram[7]}<<(cycle_ct-9)); 
        17: done <= 1;
	  endcase
      cycle_ct <= cycle_ct+1;	  
// diagnostic display, like a diagnostic print statement in C
//	  $display(data_ram[4],,data_ram[5],,data_ram[6],,data_ram[7],,,cycle_ct);
	end

endmodule