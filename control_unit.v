module ControlUnit(
    input clk,
    input reset,
    input [4:0] opcode,         // opcode from IR[18:14]
    output reg mem_read,
    output reg mem_write,
    output reg reg_write,
    output reg load_IR,
    output reg pc_enable,
    output reg [4:0] ALU_op,    // ALU operation
    output reg [1:0] pc_sel     // PC control: 00=PC+1, 01=Jump/Call, 10=Branch, 11=Return
);

    // FSM States

	parameter  FETCH   = 3'b000,DECODE  = 3'b001,EXECUTE = 3'b010,MEMORY  = 3'b011,WRITEBK = 3'b100,CONTROL = 3'b101;
	reg[1:0] state_t;




  
    // State Transition Logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= FETCH;
        else
            state <= next_state;
    end

    // Next State Logic
    always @(*) begin
        case (state)
            FETCH:   next_state = EXECUTE;
            EXECUTE: begin
                case (opcode)
                    5'b01010, 5'b01011: next_state = MEMORY;  // LOAD/STORE
                    5'b01101, 5'b01110, 5'b01111, 5'b10000, 5'b10001: next_state = CONTROL;  // JMP, BEQ, BNE, CALL, RET
                    default: next_state = WRITEBK;  // ALU or others
                endcase
            end
            MEMORY: begin
                if (opcode == 5'b01010)  // LOAD
                    next_state = WRITEBK;
                else                     // STORE
                    next_state = FETCH;
            end
            WRITEBK: next_state = FETCH;
            CONTROL: next_state = FETCH;
            default: next_state = FETCH;
        endcase
    end

    // Output Logic
    always @(*) begin
        // Default values
        mem_read   = 0;
        mem_write  = 0;
        reg_write  = 0;
        load_IR    = 0;
        pc_enable  = 0;
        ALU_op     = 5'b00000;
        pc_sel     = 2'b00;

        case (state)
            FETCH: begin
                mem_read = 1;
                load_IR  = 1;
                pc_enable = 1;
                pc_sel = 2'b00;  // PC + 1
            end
            EXECUTE: begin
                ALU_op = opcode;
            end
            MEMORY: begin
                if (opcode == 5'b01010)
                    mem_read = 1;
                else if (opcode == 5'b01011)
                    mem_write = 1;
            end
            WRITEBK: begin
                if (opcode != 5'b01011)
                    reg_write = 1;
            end
            CONTROL: begin
                pc_enable = 1;
                case (opcode)
                    5'b01101, 5'b10000: pc_sel = 2'b01;  // JMP or CALL
                    5'b01110, 5'b01111: pc_sel = 2'b10;  // BEQ or BNE
                    5'b10001:           pc_sel = 2'b11;  // RET
                endcase
            end
        endcase
    end

endmodule
