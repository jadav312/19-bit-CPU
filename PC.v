        module program_counter (input clk,
                                input rst,
                                input pc_enable,
                                input[1:0] pc_sel,              // to select the jump/call, return
                                input [15:0] targer_addr,       // target address from ins
                                output reg [15:0] pc
                                );
                                    
                                always @(posedge clk or posedge rst) begin
                                    if(rst) begin
                                    pc <= 0;
                                    
                                    end else if (pc_enable ) begin
                                    
                                        case (pc_sel )
                                            2'b00 : pc <= pc + 1;                       // JMP, Call
                                            2'b01: pc  <= targer_addr ;                 // target addr for BRQ, BNE
                                            2'b10: pc <= targer_addr ;
                                            2'b11 : pc <= targer_addr ;
                                            
                                            
                                            default : pc <= pc +1;                      // pc will incremet and point next memory address                                    
                                        endcase
                                            end
                                end
     endmodule
