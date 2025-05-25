module Ins_mem (
    input clk,
    input ins_mem_WE,
    input [18:0] address_IM,
    input [18:0] data_IM,
    output reg [18:0] out_IM
);

       reg [18:0] mem [0:524287];	

    always @(posedge clk) begin
        if (ins_mem_WE) begin
            mem[address_IM] <= data_IM;    // Write operation
        end else begin
            out_IM <= mem[address_IM];     // Read operation	
        end
    end

endmodule
