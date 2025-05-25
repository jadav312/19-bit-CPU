module reg_file (
    input clk,
    input rst,
    input reg_write,                 // Write enable signal
    input [4:0] read_reg1,           // Address of first register to read
    input [4:0] read_reg2,           // Address of second register to read
    input [4:0] write_reg,           // Address of register to write
    input [18:0] write_data,         // Data to write (19-bit data width)
    output [18:0] read_data1,        // Output of first register
    output [18:0] read_data2         // Output of second register
);

    // 32 general-purpose 19-bit registers
    reg [18:0] registers [0:31];

    // Read ports 
    assign read_data1 = registers[read_reg1];
    assign read_data2 = registers[read_reg2];

    // Write port 
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            integer i;
            for (i = 0; i < 32; i = i + 1)
                registers[i] <= 19'd0;
        end else if (reg_write) begin
                        registers[write_reg] <= write_data;
        end
    end

endmodule
