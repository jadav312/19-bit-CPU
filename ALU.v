module alu (
    input  [18:0] a,
    input  [18:0] b,
    input  [4:0]  opcode,
    output reg [37:0] outau
);

always @(*) begin
    case (opcode)
        5'b00000: outau = {19'b0, a + b};        // Addition
        5'b00001: outau = {19'b0, a - b};        // Subtraction
        5'b00010: outau = a * b;                 // Multiplication
        5'b00011: outau = (b != 0) ? {19'b0, a / b} : 38'b0; // Division (avoid div by 0)
        5'b00100: outau = {19'b0, a + 19'd1};    // Increment
        5'b00101: outau = {19'b0, a - 19'd1};    // Decrement
        5'b00110: outau = {19'b0, a & b};        // Bitwise AND
        5'b00111: outau = {19'b0, a | b};        // Bitwise OR
        5'b01000: outau = {19'b0, a ^ b};        // Bitwise XOR
        5'b01001: outau = {19'b0, ~a};           // Bitwise NOT
        default : outau = 38'b0;                 // Default: zero output
    endcase
end

endmodule
