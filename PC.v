module program_counter (
  input clk,
  input reset,
  input pc_enable,
  input [1:0] pc_sel,           // 00=PC+1, 01=Jump/Call, 10=Branch, 11=Return
  input [15:0] target_addr,     // Target address from instruction or stack
  output reg [15:0] pc
);

  always @(posedge clk or posedge reset) begin
    if (reset)
      pc <= 0;
    else if (pc_enable) begin
      case (pc_sel)
        2'b00: pc <= pc + 1;           // Default increment
        2'b01: pc <= target_addr;      // JMP or CALL
        2'b10: pc <= target_addr;      // BEQ or BNE
        2'b11: pc <= target_addr;      // RET
        default: pc <= pc + 1;
      endcase
    end
  end
endmodule
