module control_unit( input clk, rst,
                     input [4:0] opcode,                                                                     // opcode from inst_reg
                     output reg mem_read,
                     output reg mem_write,
                     output reg reg_write,
                     output reg load_IR,
                     output reg pc_enable,
                     output reg [4:0] ALU_op,
                     output reg [1:0] pc_sel
                     );
                     
                     
                     // FSM declaration
        parameter FETCH = 3'b000, EXECUTE = 3'B001, MEMORY = 3'b010,    WRITBK = 3'b011, CONTROL = 3'b100;
        reg [ 1:0] state;
        
        
        
        
                    //state trabsition logic
                    
                    always @(posedge clk or posedge rst) begin
                                    if(rst) begin
                                        state<= FETCH ;
                                    end else begin
                                        state <= next_state;
                                        end
                   
                   
                    end
                    
                    
                    //output transition logic  
                    always @(*) begin
                        case (state) 
                        
                        FETCH :  next_state = EXECUTE ;
                        EXECUTE : begin
                                case(opcode )
                                    5'b01010, 5'b01011: next_state = MEMORY ;                               // LOAD/ STORE
                                    5'b01101, 5'b01110, 5'b01111, 5'b10001: next_state = CONTROL ;          // Immediate ALU_op
                                    default : next_state = WRITBK ;                                         // ALU_op
                                    endcase
                                         end
                        
                        MEMORY : begin
                                if(opcode == 5'b01010) begin
                                    next_state <= WRITBK ;
                                    
                                    end else begin 
                                    next_state <= FETCH ;
                                    end
                                 end
                     
                    
                    WRITBK : next_state <= FETCH ;
                    CONTROL : next_sttae <= FETCH ;
                    
                    default : next_state <= FETCH ;
                    endcase
                
                    end
                    
                    //output ALU_op
                    always @(*) begin 
                    mem_read <= 0;
                    mem_write <= 0;
                    reg_write <= 0;
                    load_IR <= 0;
                    pc_enable <= 0;
                    ALU_op <= 0;
                    pc_sel <=0;
                    
                                 case(state)    
                             FETCH : begin
                                mem_read <= 1'b1;                                                           // fetching instruction by initialising memory  
                                load_IR <= 1'b1;                                                            // triggring ins_reg   
                                pc_enable <= 1'b1;                                                          // trigring pc  
                                pc_sel <= 2'b00;
                             end
                             
                             EXECUTE : begin 
                                ALU_op <= opcode ;                            
                             end
                             
                             MEMORY : begin
                                if(opcode == 5'b01010) begin
                                    mem_read <= 1'b1;                                                       // load ins
                                end else begin
                                    mem_write <= 1'b1;                                                      //store ins
                                end
                                
                             WRITBK : begin
                                    if(opcode != 5'b01011)
                                    reg_write <= 1'b1;
                             end
                             
                             CONTROL : begin
                             pc_enable <= 1'b1;
                             
                                case(opcode )
                                    5'b01101, 5'b10000: pc_sel = 2'b01;
                                    5'b01110, 5'b01111: pc_sel = 2'b10;
                                    5'b10001 :          pc_sel = 2'b11;
                                     endcase 
                             end
                             end 
                                 endcase 
                            
                    end
                    
                            
                            

endmodule 
