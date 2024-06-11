module top_level_tb;

  // Parameters
  parameter D = 12;
  parameter A = 3;

  // Inputs
  reg clk;
  reg reset;
  reg req;

  // Outputs
  wire done;

  // Instantiate the top-level module
  top_level D1(
    .clk(clk), 
    .reset(reset), 
    .req(req), 
    .done(done)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk; // 10 time units period
  end

  // Test sequence
  initial begin
    // Initialize inputs
    reset = 1;
    req = 0;
    D1.dm.core[0] = 3;

    // Wait for a few clock cycles
    #20;

    // Deassert reset
    reset = 0;

    // Apply test inputs
    req = 1;
    #10 req = 0;

    // Wait for a while to observe the behavior
    #100;

    // Finish the simulation
    $stop;
  end
      
endmodule