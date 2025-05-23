module Ins_mem( input clk,
                input ins_mem_WE,
                input [16:0] address_IM,
                input [18:0] data_IM,
                output reg [18:0] out_IM
                );
                
                
                reg [18:0] mem [0:65535] ;      // 19 bit reg to store address and data
                
                always @(posedge clk) begin
                
                        if(ins_mem_WE == 1) begin
                            mem[address] <= data_IM ;
                            
                        end else begin
                            out_IM <= mem[address];
                            
                            
                            
                            
                            
                 end    
                        end 
endmodule
