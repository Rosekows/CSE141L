/* Program 3. Closest pair -- 
Write a program to find the least distance between all pairs 
of values in an array of 20 bytes.  
Assume all values are signed 8-bit integers.  
The array of integers starts at location 128. 
Write the minimum distance in location 127.
*/
module program_3(
  input        clk,
               init,
  output logic done);
  logic signed[7:0] data_ram[256];         // raw data 
  logic       [7:0] data_ram1[256];		   // abs value of diffs
  logic       [7:0] cycle_ct;

  always @(posedge clk)
    if(init) begin
	  done        = 0;
      cycle_ct    = 0;
	  data_ram1[126] = 255;
	  data_ram1[127] = 255;
    end 
    else begin							   // triangular search pattern
      for(int k=129;k<148;k++) begin
	    for(int j=128;j<k;j++) begin
		  cycle_ct = cycle_ct + 1;
		  if(data_ram[k]>data_ram[j])
		    data_ram1[126]    = data_ram[k]-data_ram[j];
		  else 
		    data_ram1[126] = data_ram[j]-data_ram[k];
		  if(data_ram1[126]<data_ram1[127])
		    data_ram1[127] = data_ram1[126]; 
//          $display(data_ram[j],,data_ram[k],,data_ram1[126],,data_ram1[127]);
		end
	  end
      done = 1;
	end



endmodule