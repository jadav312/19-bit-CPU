    module data_memory (input clk,
                        input [18:0] addr,
                        input [18:0] write_data,
                        input mem_write,
                        input mem_read,
                        output reg [18:0] read_data
                        );
    
                    reg [18:0] mem [0:511];                 //small data memory to handle internal data while doing decode, execure addr
                    
                    always @(posedge clk ) begin
                            if(mem_write ) begin
                                mem [ addr ] <= write_data ;
                                
                                end else if(mem_read ) begin
                                    read_data <= mem[addr];
                                end
                    
                    end
                    
    
    
    
    
    
    
    endmodule 
