// nearest pair (signed arithmetic, not Hamming distance!)
module program3_tb;

  bit         clk, 
              init = 1;
  int         seed = 23;			   // for random gen.
  wire        done;
// we shall use elements 128-147 for raw data
  logic signed[ 7:0] dat_ram[148];
  logic signed[ 8:0] dist1,dist2;
  logic[ 7:0] ct;
  
// DUT
  program_3 dist3(.*);

  initial begin	
    ct           = 0;
    dist1        = 0;				 // latest distance
	dist2        = 255;				 // minimum so far
// initialize DUT array and bench copy thereof
	for(int i=128;i<148;i++) begin
	  dat_ram[i]        =  $random(seed);
	  dist3.data_ram[i] =  dat_ram[i];
	  $display(i,,dat_ram[i]);
	end
    for(int k=128; k<148; k++)
	  for(int j=128; j<k; j++) begin
		ct++;
		if(k!=j) dist1 = dat_ram[k]-dat_ram[j];
// need abs(dist1)
		if(dist1[8]) dist1 = dat_ram[j]-dat_ram[k];
//		$display(dist2,,,dist1,,,k,,,j,,,dat_ram[k],,,dat_ram[j],,,ct);
		if(dist1<dist2) begin
		  dist2 = dist1;
		end
//           $display("bench",,,ct,,,i);      
	  end
	#20ns init = 0;
//    wait(done);
    #20ns $display("math=%d circuit=%d",dist2,dist3.data_ram1[127]);
          $display("cycle count = %d",dist3.cycle_ct);
    #20ns init = 1;
	for(int i=128;i<148;i++) begin
	  dat_ram[i]        =  $random(seed);
	  dist3.data_ram[i] =  dat_ram[i];
	  $display(i,,dat_ram[i]);
	end
    for(int k=128; k<148; k++)
	  for(int j=128; j<k; j++) begin
		ct++;
		if(k!=j) dist1 = dat_ram[k]-dat_ram[j];
// need abs(dist1)
		if(dist1[8]) dist1 = dat_ram[j]-dat_ram[k];
//		$display(dist2,,,dist1,,,k,,,j,,,dat_ram[k],,,dat_ram[j],,,ct);
		if(dist1<dist2) begin
		  dist2 = dist1;
		end
//           $display("bench",,,ct,,,i);      
	  end
	#20ns init = 0;
//    wait(done);
    #20ns $display("math=%d circuit=%d",dist2,dist3.data_ram1[127]);
          $display("cycle count = %d",dist3.cycle_ct);

    #10ns $stop;
//	end
  end
  always begin
    #5ns clk = 1;
	#5ns clk = 0;
  end  

endmodule 