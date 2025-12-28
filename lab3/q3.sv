// Q3:  Model D-FlipFlop using Assign Procedural Statements.
 
// Procedure:
// 1.	Open the EDA playground by clicking on https://www.edaplayground.com.
// 2.	In the Left Side Menu in Tools & Simulators choose Synopsys VSC 2020.03
// or Cadence Xcelium 20.09 to simulate the design + Testbench.
// 3.	Writing a SystemVerilog code that describes the D-FlipFlop
// a.	In the design side create a new module called DFF. 
// 4.	Click Save and Run to simulate.
// 5.	Debug your code as required, until you are happy that the design is verified.

// Specification:
// •	d, clear, preset, clock are inputs.
// •	q output.


// D Flip-Flop with Asynchronous Clear and Preset using Procedural Assignment
module DFF (
  input  logic d,         // Data input
  input  logic clear,     // Asynchronous clear (active high)
  input  logic preset,    // Asynchronous preset (active high)
  input  logic clock,     // Clock input
  output logic q          // Output
);
  // Procedural block for sequential behavior
  always_ff @(posedge clock ) begin
    if (!clear)
      q <= 1'b0;
    else if (!preset)
      q <= 1'b1;
    else
      q <= d;
  end
endmodule

// Testbench for D Flip-Flop

module test_DFF;
  logic d, clear, preset, clock;
  logic q;

  DFF dut (.d(d), .clear(clear), .preset(preset), .clock(clock), .q(q));

  initial begin
    clock = 0;
    forever #5 clock = ~clock;
  end

  

  initial begin
    $monitor("%4t |  %b  | %b |   %b   |   %b   | %b",
             $time, clock, d, clear, preset, q);
  end

  initial begin
    $display("Time | clk | d | clear | preset | q");
    $display("--------------------------------------");
    
    clear = 1; preset = 1; d = 0;

    // Normal operation
    #5  d = 1;
    #5 d = 0;
    #5 d = 1;

    // Apply asynchronous clear
    #10  clear = 0;
    #10  clear = 1;

    // Normal operation
    #5  d = 0;     // rising edge -> q = 1
    #10 d = 1;     // next rising edge -> q = 0
    #10 d = 0;     // next rising edge -> q = 1

    // Apply preset
    #10  preset = 0;
    #10  preset = 1;
    

    // More cycles
    #10 d = 0;
    #10 d = 1;

    #20 $display("--------------------------------------");
    $display("Simulation Completed!");
    $finish;
  end
endmodule
