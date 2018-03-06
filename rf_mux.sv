module rf_mux(
	input[4:0] op,
	input[7:0] dmem_out, 
	input[7:0] alu_result,

	output[7:0] rf_din
	);

	always_comb begin
		if (op == 12) begin
			rf_din = dmem_out;
		end
		else begin
			rf_din = alu_result;
		end
	end

endmodule