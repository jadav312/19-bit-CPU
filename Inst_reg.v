module inst_reg ( input clk,
                  input load_IR,
                  input [18:0] ins,                                                                     // input from instruction mem
                  output reg [4:0] opcode,
                  output reg [3:0] rs1, rs2, rd,                                                        // to store the R type instruction
                  output reg [13:0] addr_imm,                                                           // for immediate instrucion like JMP,addr_imm
                  output reg [5:0] branch_offset                                                        // for BEW/BNE
                  
                  );
                  
                  
                  
                  always @(posedge clk) begin
                        if(load_IR == 1) begin
                            opcode <= ins[18:14];                                                       //opcode decode
                            
                            rs1 <= 4'd0;
                            rs2 <= 4'd0;
                            rd <= 4'd0;
                            addr_imm <= 14'd0;
                            branch_offset <= 6'd0;
                            
                            case (ins[18:14])
                            
                            5'd0, 5'b1, 5'd2, 5'd3, 5'd4, 5'd5, 5'd6, 5'd7, 5'd8, 5'd9: begin           //arithmetic and logic operation   
                            
                                rs1 <= ins[13:10];
                                rs2 <= ins[9:6];
                                rd <= ins[5:2];
                        end
                    
                    
                            5'd10, 5'd11: begin                                                         // load store 
                            rs1 <= ins[13:10];
                            rs <= ins [9:6];
                            addr_imm <= ins [5:0];
                          
                        end 
                        
                            5'd12, 5'd13 : begin                                                        // immediate ins
                            rs1 <= ins[13:10];
                            rs <= ins [9:6];
                            branch_offset  <= ins [5:0];
                            
                       end 
                       
                       
                            5'd14, 5'd15: begin
                            addr_imm <= ins[13:0];
                       end
                       //default: 5'd0, 5'b1, 5'd2, 5'd3, 5'd4, 5'd5, 5'd6, 5'd7, 5'd8, 5'd9;
                       
                       
                       endcase 
                        end
                  end
        
        endmodule
                  
                
