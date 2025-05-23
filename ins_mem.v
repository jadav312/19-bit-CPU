module ins_mem (input clk,
		input ins_mem_WE,
		input [18:0] data_IM,
		input [15:0] address_IM,
		output reg [18:0] out_IM 
		);


		reg [18:0] mem [0:65535];

		always@(posedge clk) begin
		if(ins_mem_WE == 1) begin
			mem[address_IM] <= data_IM;

		end else begin
			out_IM <= mem[address_IM];
		end
		end


endmodul