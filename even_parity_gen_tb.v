`include "even_parity_gen.v"

module even_parity_gen_tb();

  // Inputs
  reg clk;
  reg reset;
  reg i_x;

  // Outputs
  wire o_parity;

  // Instantiate the Unit Under Test (UUT)
  even_parity_gen dut (
    .clk(clk),
    .reset(reset),
    .i_x(i_x),
    .o_parity(o_parity)
  );

  // Clock generation
  initial clk = 1;
  always #5 clk = ~clk; // 10 ns clock period

  // Testbench logic
  initial begin
    // assert reset
    reset = 1;

    #10 
    reset = 0;
    i_x=1'b0; //

    #10
    i_x=1'b0;// 

    #10
    i_x=1'b1; //

   #10 $finish; 
    
  end

  // Monitor output
  initial begin
    $monitor("Time: %0t | reset = %b | i_x = %b | o_parity = %b",
             $time, reset, i_x, o_parity);
  end

  initial
  begin
  $dumpfile("output.vcd");
  $dumpvars(1);
  end

endmodule