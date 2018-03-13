/* 18. String match -- Write a program that finds the number of entries 
in an array  which contain a 4-bit string.  For example, if the 4-bit string 
is 0101, then 11010110 and 01010101 would both count (the latter would count 
once, even though the string occurs 3 times), while 00111011 would not.  

The array starts at position 32 and is 64 bytes long.  
The string you search for will be in the lower 4 bits of memory address 6.  
The result shall be written in location 7.
*/

module program_2(
  input clk,
        init,
  output logic done);
  logic[7:0] data_ram[96];
  logic[7:0] cycle_ct;
  logic mat;

  always_ff @(posedge clk)
    if(init) begin
	  done        <= 0;
      cycle_ct    <= 0;
	  data_ram[7] <= 0;		   // clear result position in memory
	  mat         <= 0;	       // handles OR across any byte
    end 
    else begin
// outer loop -- check each of the 64 bytes
      for(int i=32;i<96;i++) begin
	    mat = 0;	         // used to avoid double counting
// inner loop -- 5 positions for 4 bits into 8
	    for(int j=0;j<5;j++) begin
		  cycle_ct = cycle_ct + 1;
          if(data_ram[i][3:0]==data_ram[6][3:0]) begin
//		    $display(i);
		    mat = 1;  
		  end
		  data_ram[i] = data_ram[i]>>1;
		  end
// increment match count if match found in data_ram[i]
		 data_ram[7] = data_ram[7]+mat;
	  end
      done <= 1;
	end

endmodule