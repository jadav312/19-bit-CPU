module inst_reg ( 	input clk, 
			input load_IR,
			input [18:0] ins,
			output reg [13:0] address,
			output reg [4:0] opcode
			);
			
		always@(posedge clk) begin
			if(load_IR) begin 
				
				opcode <= ins[18:14];
				address <= ins[13:0];				 
					end
			end
endmodule



module inst_reg (
  input clk, 
  input load_IR,
  input [18:0] ins,
  output reg [4:0] opcode,
  output reg [3:0] rs1, rs2, rd
output reg [13:0] addr_imm,   // For JMP, CALL
output reg [5:0]  branch_offset // For BEQ/BNE
);

  always @(posedge clk) begin
    if (load_IR) begin 
      opcode <= ins[18:14];
      rs1 <= ins[13:10];
      rs2 <= ins[9:6];
      rd  <= ins[5:2];
    end
  end

endmodule

module inst_reg (
  input clk, 
  input load_IR,
  input [18:0] ins,

  output reg [4:0] opcode,
  output reg [3:0] rs1, rs2, rd,
  output reg [13:0] addr_imm,        // For JMP, CALL, etc.
  output reg [5:0]  branch_offset    // For BEQ/BNE
);

  always @(posedge clk) begin
    if (load_IR) begin
      opcode <= ins[18:14];

      // Default zero
      rs1 <= 4'd0;
      rs2 <= 4'd0;
      rd  <= 4'd0;
      addr_imm <= 14'd0;
      branch_offset <= 6'd0;

      case (ins[18:14])
        // ALU/Arithmetic/Logical Ops
        5'b00000, 5'b00001, 5'b00010, 5'b00011,
        5'b00100, 5'b00101, 5'b00110, 5'b00111,
        5'b01000, 5'b01001: begin
          rs1 <= ins[13:10];
          rs2 <= ins[9:6];
          rd  <= ins[5:2];
        end

        // LOAD / STORE
        5'b01010, 5'b01011: begin
          rs1 <= ins[13:10];          // Base address reg
          rd  <= ins[9:6];            // Destination reg (LOAD) or Source reg (STORE)
          addr_imm <= ins[5:0];       // Offset (e.g., for load/store)
        end

        // Branch: BEQ, BNE
        5'b01110, 5'b01111: begin
          rs1 <= ins[13:10];
          rs2 <= ins[9:6];
          branch_offset <= ins[5:0];
        end

        // JMP, CALL
        5'b01101, 5'b10000: begin
          addr_imm <= ins[13:0];      // Target address
        end

        // RET — no fields needed
        5'b10001: begin
          // All outputs zeroed (handled by default above)
        end

        default: ; // Do nothing
      endcase
    end
  end

endmodule
