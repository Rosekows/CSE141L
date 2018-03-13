// testbench for A*B*C
// CSE141L  Win 2018  Program 1 
module program1_tb;
  bit         clk, 				 // to DUT
              init = 1;
  wire        done;				 // done flag from DUT
  logic[ 7:0] a,
              b,
              c;
  logic[15:0] p;				 // p = a*b*c
  
  program_1 mpy(.*);   			 // DUT -- connects clk, init, done

  initial begin
// start first of two problems
    a               =  5;
	b               = 15;
	c               =  2;
	mpy.data_ram[1] =  a;        // initialize DUT data memory
	mpy.data_ram[2] =  b;
	mpy.data_ram[3] =  c;
// compute what the product should be
// under Verilog rules, only the lower 16 bits will be retained
	$display(" %d*%d*%d",a,b,c);
	p = mpy.data_ram[1]	* mpy.data_ram[2] * mpy.data_ram[3];
	#20ns init = 0;
    wait(done);
// diagnostics: compare a*b*c against what the DUT computes 
	$display ("prod= %d  %d",p,{mpy.data_ram[4],mpy.data_ram[5]});
    $displayh("prod=0x%h 0x%h",p,{mpy.data_ram[4],mpy.data_ram[5]});
    $display("cycle_count = %d",mpy.cycle_ct);
// start a second problem -- we could/should randomize in future runs
	a = 12;
	b = 3;
	c = 4;
	mpy.data_ram[1] =  a;
	mpy.data_ram[2] =  b;
	mpy.data_ram[3] =  c;
	init = 1;
	$display(" %d*%d*%d",a,b,c);
	p = mpy.data_ram[1]	* mpy.data_ram[2] * mpy.data_ram[3];
	#20ns init = 0;
    wait(done);
	$display ("prod= %d  %d",p,{mpy.data_ram[4],mpy.data_ram[5]});
    $displayh("prod=0x%h 0x%h",p,{mpy.data_ram[4],mpy.data_ram[5]});
    $display("cycle_count = %d",mpy.cycle_ct);
    $stop;
  end
// irrespective of what you read in textbooks and online, this is the preferred clock syntax
  always begin
    #5ns clk = 1;
	#5ns clk = 0;
  end

endmodule 