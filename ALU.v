module alu  (input [18:0] a,
             input [18:0] b,
             input [4:0] opcode,
             output reg [37:0] outau                                                // output is twice of input to store the mul ins 
             );
             
             
             
             
             always @(a, b , opcode ) begin
                    case(opcode )
                    5'b00000 : outau = { 19'b0, a+b};                               // concate the 19 bit 0 and aadd ins output to make 38 bits  
                    5'b00001 : outau = { 19'b0, a - b};                             // concate the 19 bit 0 and aadd ins output to make 38 bits 
                    5'b00010 : outau = a * b;
                    5'b00011 : outau = (b != 0) ? {19'b0, a/b} : 38'b0;             // ternary operation for zero flag  
                    5'b00100 : outau = {19'b0, a + 1};
                    5'b00101 : outau = {19'b0, a - 1};
                    5'b00110 : outau = {19'b0, a & 1};
                    5'b00111 : outau = {19'b0, a | 1};
                    5'b01000 : outau = {19'b0, a ^ 1};
                    5'b00101 : outau = {19'b0, ~a};
                    
                    
                    default : outau = 38'b0;
                     
                    endcase 
             
             end

endmodule 
