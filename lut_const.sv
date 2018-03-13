module lut_const(
  input       [4:0] ptr,
  output logic[7:0] constant,
  output logic const_flag);

  always_comb begin            // TODO: not sure about syntax
	 case(ptr)
      5'b10000: constant = 8'b0111_1111; // 127
      5'b10001: constant = 8'b0000_0001; // 1
      5'b10010: constant = 8'b0000_0010; // 2
      5'b10011: constant = 8'b1000_0000; // 128
      5'b10100: constant = 8'b0000_1000; // 8
      5'b10101: constant = 8'b0000_0011; // 3
      5'b10110: constant = 8'b0000_0100; // 4
      5'b10111: constant = 8'b0000_0101; // 5
      5'b11000: constant = 8'b0010_0000; // 32
      5'b11001: constant = 8'b0000_0110; // 6
      5'b11010: constant = 8'b0000_1111; // 15
      5'b11011: constant = 8'b0100_0000; // 64
      5'b11100: constant = 8'b0000_0111; // 7
      5'b11101: constant = 8'b1111_1111; // 255
      //5'b11110: constant = 8'b0001_0011; // 19
      5'b11110: constant = 8'b0001_0000; // 16
      5'b11111: constant = 8'b0001_0100; // 20  
    endcase
    if (ptr < 5'b10000) begin            // if ptr doesn't start with 1 pass it through
      constant = {3'b000, ptr};          // since it's a ptr to a register, not constant   
      const_flag = 0;
    end
    else const_flag = 1;
  end
endmodule