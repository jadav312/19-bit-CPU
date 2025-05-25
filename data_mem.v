module data_memory (
    input clk,
    input [8:0] addr,                 	
    input [18:0] write_data,
    input mem_write,
    input mem_read,
    output reg [18:0] read_data
);

    reg [18:0] mem [0:511];           )

    always @(posedge clk) begin
        if (mem_write) begin
            mem[addr] <= write_data;  // Write operation
        
       end else if (mem_read) begin
            read_data <= mem[addr];   // Read operation
        end
    end

endmodule
