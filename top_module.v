module top_module (
    input clk,
    input rst,
    input ins_mem_WE,                     // Write enable for instruction memory (for programming)
    input [18:0] instr_data_in,           // Instruction to be loaded when ins_mem_WE is high
    input [18:0] instr_addr_in            // Address to load the instruction at
);

    // Internal wires
    wire [18:0] instruction;
    wire [4:0] opcode;
    wire [3:0] rs1, rs2, rd;
    wire [13:0] addr_imm;
    wire [5:0] branch_offset;
    wire [4:0] alu_opcode;
    wire [1:0] pc_sel;
    wire [18:0] reg_data1, reg_data2;
  wire [18:0] alu_result;
    wire [18:0] mem_read_data;
    wire mem_read, mem_write, reg_write, load_IR, pc_enable;

    wire [18:0] pc_value;
    wire [18:0] target_addr;

    // Assign target address for PC based on branch_offset or addr_imm
    assign target_addr = (pc_sel == 2'b01) ? (pc_value + {{13{branch_offset[5]}}, branch_offset}) : addr_imm;

    // Program Counter
    program_counter PC (
        .clk(clk),
        .rst(rst),
        .pc_enable(pc_enable),
        .pc_sel(pc_sel),
        .target_addr(target_addr),
        .pc(pc_value)
    );

    // Instruction Memory
    Ins_mem IM (
        .clk(clk),
        .ins_mem_WE(ins_mem_WE),
        .address_IM(instr_addr_in ),
        .data_IM(instr_data_in),
        .out_IM(instruction)
    );

    // Instruction Register
    inst_reg IR (
        .clk(clk),
        .load_IR(load_IR),
        .ins(instruction),
        .opcode(opcode),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .addr_imm(addr_imm),
        .branch_offset(branch_offset)
    );

    // Control Unit
    control_unit CU (
        .clk(clk),
        .rst(rst),
        .opcode(opcode),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .reg_write(reg_write),
        .load_IR(load_IR),
        .pc_enable(pc_enable),
        .ALU_op(alu_opcode),
        .pc_sel(pc_sel)
    );

    // Register File
    reg_file RF (
        .clk(clk),
        .rst(rst),
        .reg_write(reg_write),
        .read_reg1(rs1),
        .read_reg2(rs2),
        .write_reg(rd),
        .write_data(alu_result[18:0]),
        .read_data1(reg_data1),
        .read_data2(reg_data2)
    );

    // ALU
    alu ALU (
        .a(reg_data1),
        .b(reg_data2),
        .opcode(alu_opcode),
        .outau(alu_result)
    );

    // Data Memory
    data_memory DM (
        .clk(clk),
      	.addr(addr_imm[13:0]),                
        .write_data(reg_data2),
        .mem_write(mem_write),
        .mem_read(mem_read),
        .read_data(
        
        
        
        
        
        )
    );

endmodule