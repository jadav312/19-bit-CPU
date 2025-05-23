
module alu( input [18:0]a,
           input [18:0] b,
           input [4:0] opcode,
        output reg [37:0] outau
       );
 
  always @(a,b, opcode) begin
    case(opcode)
      5'b00000 : outau = {19'b0 , a + b};
      5'b00001 : outau = {19'b0 , a - b};
      5'b00010 : outau = a * b;
      5'b00011 : outau = (b != 0) ? {19'b0, a/b} : 38'b0;
      5'b00100 : outau =  { 19'b0 , a + 1};
      5'b00101 : outau =  { 19'b0 , a - 1};
      5'b00110 : outau =  { 19'b0 , a & b};
      5'b00111 : outau =  { 19'b0 , a | b};
      5'b01000 : outau =  { 19'b0 , a ^ b};
      5'b01001 : outau =  { 19'b0 , ~a};
      
      
      default : outau = 38'b0;
    endcase
  end
endmodule





//testbench

// Code your testbench here
// or browse Examples
module alu_tb;

  reg [18:0] a;
  reg [18:0] b;
  reg [4:0] opcode;
  wire [37:0] outau;

  // Instantiate the ALU using named port connections
  alu DUT (
    .a(a),
    .b(b),
    .opcode(opcode),
    .outau(outau)
  );

  initial begin
    $display("Time\tOpcode\tA\tB\tOutput");
    $monitor("%0t\t%0b\t%0b\t%0b\t%0b", $time, opcode, a, b, outau);

    // Test Addition
    a = 19'd1; b = 19'd2; opcode = 5'd0; #10;

    // Test Subtraction
    a = 19'd5; b = 19'd3; opcode = 5'd1; #10;

    // Test Multiplication
    a = 19'd3; b = 19'd4; opcode = 5'd2; #10;

    // Test Division (non-zero)
    a = 19'd9; b = 19'd3; opcode = 5'd3; #10;

    // Test Division by Zero
    a = 19'd9; b = 19'd0; opcode = 5'd3; #10;

    // Test Increment
    a = 19'd100; b = 19'd0; opcode = 5'd4; #10;

    // Test Bitwise NOT
    a = 19'd3; b = 19'd0; opcode = 5'd9; #10;

    $finish;
  end

endmodule

      