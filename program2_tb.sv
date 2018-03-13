module program2_tb;
  bit         clk, 
              init = 1;
  wire        done;
  logic[ 7:0] dat_ram[96];	         
  logic[ 7:0] ct;
  
  program_2 strm(.*);

  initial begin
    ct              = 0;
    dat_ram[6]      = 4'b1101;			// pattern to match
	strm.data_ram[6] = dat_ram[6];
	for(int i=32;i<96;i++) begin
	  dat_ram[i]      =  $random;
	  strm.data_ram[i] =  dat_ram[i];
//	  for(int j=0;j<5;j++) begin
      if(dat_ram[i][3:0]==dat_ram[6] ||
         dat_ram[i][4:1]==dat_ram[6] ||
         dat_ram[i][5:2]==dat_ram[6] ||
         dat_ram[i][6:3]==dat_ram[6] ||
         dat_ram[i][7:4]==dat_ram[6])
		 begin
           ct++;
           $display("bench",,,ct,,,i);      
	     end
	end
	#20ns init = 0;
    wait(done);
    #20ns $display(ct,,,strm.data_ram[7],,,strm.cycle_ct);
	#20ns init      = 1;
    ct              = 0;
    dat_ram[6]      = 4'b1101;			// pattern to match
	strm.data_ram[6] = dat_ram[6];
	for(int i=32;i<96;i++) begin
	  dat_ram[i]      =  $random>>8;
	  strm.data_ram[i] =  dat_ram[i];
//	  for(int j=0;j<5;j++) begin
      if(dat_ram[i][3:0]==dat_ram[6] ||
         dat_ram[i][4:1]==dat_ram[6] ||
         dat_ram[i][5:2]==dat_ram[6] ||
         dat_ram[i][6:3]==dat_ram[6] ||
         dat_ram[i][7:4]==dat_ram[6])
		 begin
           ct++;
           $display("bench",,,ct,,,i);      
	     end
	end
	#20ns init = 0;
    wait(done);
    #20ns $display(ct,,,strm.data_ram[7],,,strm.cycle_ct);
    #10ns $stop;
  end
  always begin
    #5ns clk = 1;
	#5ns clk = 0;
  end

endmodule 