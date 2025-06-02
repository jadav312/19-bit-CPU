`timescale 1ns / 1ps

module top_tb;

    reg clk;
    reg rst;
    reg ins_mem_WE;
    reg [18:0] instr_data_in;
    reg [18:0] instr_addr_in;

    // Instantiate the top module
    top_module uut (
        .clk(clk),
        .rst(rst),
        .ins_mem_WE(ins_mem_WE),
        .instr_data_in(instr_data_in),
        .instr_addr_in(instr_addr_in)
    );

    // Clock generation
    always #5 clk = ~clk; // 10ns period

    initial begin
        $display("Starting Simulation...");
        $dumpfile("top_tb.vcd");     
        $dumpvars(0, top_tb);

        // Initialize signals
        clk = 0;
        rst = 1;
        ins_mem_WE = 0;
        instr_data_in = 19'd0;
        instr_addr_in = 19'd0;

        #10 rst = 0;
       
      // PRELOAD register values via direct memory modification (Option 1 recommended)
    uut.RF.registers[2] = 19'd7;
    uut.RF.registers[3] = 19'd5;
    uut.RF.registers[6] = 19'd10;
    uut.RF.registers[5] = 19'd99;
    uut.RF.registers[6] = 19'd20;        // R6 = 20
	
      uut.DM.mem[32] = 19'd20;            // MEM[20 + 12] = MEM[32] = 99

        // Load instruction into instruction memory
        // Example: ADD R1 = R2 + R3 (opcode = 5'b00000, rs1=2, rs2=3, rd=1)
        write_instruction(19'b00000_0010_0011_0001_00); // ADD
      	#30;

        // Example: SUB R4 = R1 - R2 (opcode = 5'b00001, rs1=1, rs2=2, rd=4)
        write_instruction(19'b00001_0001_0010_0100_00); // SUB
		#30;
        // Example: LD R5 <- MEM[R6 + offset] (opcode = 5'b01010, rs1=6, rs2=5, offset=6'b001100)
        write_instruction(19'b01010_0110_0101_001100);
		#30;
        // Example: ST MEM[R6 + offset] <- R5 (opcode = 5'b01011, rs1=6, rs2=5, offset=6'b001100)
        write_instruction(19'b01011_0110_0101_001100);
		#30;
        // Done writing instructions
        ins_mem_WE = 0;
        // Run simulation for some cycles
        #200 $finish;
    end

    task write_instruction(input [18:0] instr);
        begin
            @(posedge clk);
            ins_mem_WE = 1;
            instr_data_in = instr;
            instr_addr_in = instr_addr_in + 1;
            @(posedge clk);
            ins_mem_WE = 0;
        end
    endtask

endmodule
