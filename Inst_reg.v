module inst_reg (
    input clk,
    input load_IR,
    input [18:0] ins,              // input instruction from instruction memory

    output reg [4:0] opcode,       // opcode [18:14]
    output reg [3:0] rs1, rs2, rd, // register fields for R-type or load/store
    output reg [13:0] addr_imm,    // address or immediate field
    output reg [5:0] branch_offset // branch offset
);

    // Define opcodes for readability
    localparam OPC_ADD   = 5'd0,
               OPC_SUB   = 5'd1,
               OPC_MUL   = 5'd2,
               OPC_DIV   = 5'd3,
               OPC_INC   = 5'd4,
               OPC_DEC   = 5'd5,
               OPC_AND   = 5'd6,
               OPC_OR    = 5'd7,
               OPC_XOR   = 5'd8,
               OPC_NOT   = 5'd9,
               OPC_LD    = 5'd10,
               OPC_ST    = 5'd11,
               OPC_BEQ   = 5'd12,
               OPC_BNE   = 5'd13,
               OPC_JMP   = 5'd14,
               OPC_CALL  = 5'd15;

    always @(posedge clk) begin
        if (load_IR) begin
            // Extract opcode
            opcode <= ins[18:14];

            // Clear outputs by default
            rs1 <= 4'd0;
            rs2 <= 4'd0;
            rd <= 4'd0;
            addr_imm <= 14'd0;
            branch_offset <= 6'd0;

            case (ins[18:14])
                // Arithmetic and logic instructions
                OPC_ADD, OPC_SUB, OPC_MUL, OPC_DIV,
                OPC_INC, OPC_DEC, OPC_AND, OPC_OR,
                OPC_XOR, OPC_NOT: begin
                    rs1 <= ins[13:10];
                    rs2 <= ins[9:6];
                    rd  <= ins[5:2];
                end

                // Load and store
                OPC_LD, OPC_ST: begin
                    rs1 <= ins[13:10];            // base register
                    rs2 <= ins[9:6];              // source/dest register
                    addr_imm <= {8'd0, ins[5:0]}; // 6-bit offset zero-extended
                end

                // Branch instructions
                OPC_BEQ, OPC_BNE: begin
                    rs1 <= ins[13:10];           // operand 1
                    rs2 <= ins[9:6];             // operand 2
                    branch_offset <= ins[5:0];   // branch offset
                end

                // Immediate jump or call
                OPC_JMP, OPC_CALL: begin
                    addr_imm <= ins[13:0];       // 14-bit address/immediate
                end

                // Default: outputs are already zeroed
                default: begin
                    // No action needed
                end
            endcase
        end
    end

endmodule
