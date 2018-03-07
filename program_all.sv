module program_all(
  input clk,
        init,
  output logic done);

  wire dones[4]; // why 4 dones instead of 3?

  logic[7:0] data_ram_all[256];
  logic[1:0] rotator = 0;

// DUT core
  top top1(.clk, .init, .done(dones[1]));   // why dones[1] and not dones[0]?

// load the data memories of the core
  always @(posedge init) begin
    if(rotator==3) rotator <= 1;            // why not rotator <= 0?
    else           rotator <= rotator + 1;  
    for(int i=1; i<4; i++) 
	    top1.dmem.guts[i] <= data_ram_all[i];
	  top1.dmem.guts[6] <= data_ram_all[6];
	  for(int j=32; j<96; j++)
	    top1.dmem.guts[j] <= data_ram_all[j];
	  for(int k=128; k<148; k++)
	    top1.dmem.guts[k] <= data_ram_all[k];     
  end
    
  assign done = dones[rotator];

endmodule