module slsr(
  input  logic sl,        // shift left control
  input  logic sr,        // shift right control
  input  logic din,       // serial data input
  input  logic clk,       // clock
  input  logic reset,     // synchronous reset
  output logic [7:0] Q    // 8-bit output register
);
  logic [7:0] next_Q;

  always_ff @(posedge clk) begin
    if (reset)
      Q = 8'b0;
    else begin
      next_Q = Q;
      if (sl) begin
        next_Q = {Q[6:0], din};
      end
      else if (sr) begin
        next_Q = {din, Q[7:1]};
      end
      Q <= next_Q;
    end
  end
endmodule



module testslsr;
  logic sl, sr, din, clk, reset;
  logic [7:0] Q;
  int errors = 0;

  slsr dut (.sl(sl), .sr(sr), .din(din), .clk(clk), .reset(reset), .Q(Q));

  // Clock generation
  initial begin
    clk = 1;
    forever #5 clk = ~clk;
  end

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, testslsr);
  end

  initial begin
    sl = 0; sr = 0; din = 0; reset = 1;
    repeat (1) @(posedge clk);
    reset = 0;

    // Shift left test
    din = 1; sl = 1;
    repeat (2) @(posedge clk);
    sl = 0;
    $display("Q = %b", Q);
    
    if (Q === 8'b0000011)
      $display("TEST PASSED!");
    else begin
      $display("TEST FAILED. Expected 0000011, got %b", Q);
      errors++;
    end

    // Shift right test
    sr = 1; din = 1;
    repeat (1) @(posedge clk);
    sr = 0;
    $display("Q = %b", Q);
    
    if (Q === 8'b10000001)
      $display("TEST PASSED!");
    else begin
      $display("TEST FAILED. Expected 10000001, got %b", Q);
      errors++;
    end
    
    // More tests
    sr = 1; din = 1;
    repeat (1) @(posedge clk);
    $display("Q = %b", Q);
    
    sl = 1; sr = 1; din = 1;
    repeat (1) @(posedge clk);
    sl = 0; sr = 0;
    $display("Q = %b", Q);
    
    sl = 1; sr = 1; din = 0;
    repeat (3) @(posedge clk);
    sl = 0; sr = 0;
    $display("Q = %b", Q);
    
    reset = 1;
    repeat (3) @(posedge clk);
    sl = 0; sr = 0;
    $display("Q = %b", Q);

    $display("Number of errors = %0d", errors);
    $finish;
  end
endmodule