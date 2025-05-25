module control_unit (
    input clk, rst,
    input [4:0] opcode,                     	// opcode from inst_reg
    output reg mem_read,			// triggers data mem
    output reg mem_write,			// triggers data mem
    output reg reg_write,			//tiggers reg file
    output reg load_IR,				// triggers inst_reg
    output reg pc_enable,			//triggers PC
    output reg [4:0] ALU_op,			// AlU Opcode selection
    output reg [1:0] pc_sel			//triggers PC operation condition
);

    // FSM states
    parameter FETCH = 3'b000, EXECUTE = 3'b001, MEMORY = 3'b010,
              WRITBK = 3'b011, CONTROL = 3'b100;

    reg [2:0] state, next_state;

    // State transition logic
    always @(posedge clk or posedge rst) begin
        if (rst)
            state <= FETCH;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            FETCH: next_state = EXECUTE;

            EXECUTE: begin
                case (opcode)
                    5'b01010, 5'b01011: next_state = MEMORY;   				// LOAD/STORE
                    5'b01101, 5'b01110, 5'b01111, 5'b10001: next_state = CONTROL;	//BRANCH, JMP, CALL
                    default: next_state = WRITBK;
                endcase
            end

            MEMORY: begin
                if (opcode == 5'b01010)
                    next_state = WRITBK;	 // LOAD goes to writeback
                else
                    next_state = FETCH;  	// STORE ends here
            end

            WRITBK: next_state = FETCH;

            CONTROL: next_state = FETCH;

            default: next_state = FETCH;
        endcase
    end

    // Output logic
    always @(*) begin
        // Default all outputs to 0
        mem_read = 0;
        mem_write = 0;
        reg_write = 0;
        load_IR = 0;
        pc_enable = 0;
        ALU_op = 5'b00000;
        pc_sel = 2'b00;

        case (state)
            FETCH: begin
                mem_read = 1;
                load_IR = 1;
                pc_enable = 1;
                pc_sel = 2'b00;
            end

            EXECUTE: begin
                ALU_op = opcode;
            end

            MEMORY: begin
                if (opcode == 5'b01010)
                    mem_read = 1;       // LOAD
                else
                    mem_write = 1;      // STORE
            end

            WRITBK: begin
                if (opcode != 5'b01011) // If not STORE
                    reg_write = 1;
            end

            CONTROL: begin
                pc_enable = 1;
                case (opcode)
                    5'b01100, 5'b01101: pc_sel = 2'b01; // BRANCH
                    5'b01110, 5'b01111: pc_sel = 2'b10; // JMP/CALL
                    5'b10001: pc_sel = 2'b11;           // RETURN
                endcase
            end
        endcase
    end

endmodule
