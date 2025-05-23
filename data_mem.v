module memory (
    input clk,
    input [18:0] addr,
    input [18:0] write_data,
    input mem_write,
    input mem_read,
    output reg [18:0] read_data
);

  reg [18:0] mem [0:511]; // Small memory

  always @(posedge clk) begin
    if (mem_write)
      mem[addr] <= write_data;
    if (mem_read)
      read_data <= mem[addr];
  end
endmodule