module program_counter (
    input clk,
    input rst,
    input pc_enable,
    input [1:0] pc_sel,           // Select signal for PC control
    input [18:0] target_addr,     // Target address (from instruction)
    output reg [18:0] pc
);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        pc <= 19'd0;
    end 
    else if (pc_enable) begin
        case (pc_sel)
            2'b00: pc <= pc + 1;        // Normal sequential execution
            2'b01: pc <= target_addr;       // Branch (BEQ/BNE)
            2'b10: pc <= target_addr;       // JMP or CALL
            2'b11: pc <= target_addr;       // RET or interrupt
        endcase
    end
end

endmodule
