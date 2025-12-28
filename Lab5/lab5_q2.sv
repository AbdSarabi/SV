// Q2:  Extend Register class by defining two subclasses (child's classes).
 
// 1.	Create instantiations of both subclasses and verify them in testbench.sv. 
// Make sure that shift right and shift left mechanism are working correctly.
// 2.	Simulate, observe what the output is and debug as needed.
// Procedure:
// 6.	Open the EDA playground by clicking on https://www.edaplayground.com.
// 7.	In the Left Side Menu in Tools & Simulators choose Synopsys VSC 2020.03 
// or Cadence Xcelium 20.09 to simulate the design + Testbench.
// 8.	Writing a SystemVerilog code for the register as the following: 
// a.	In the design side, shiftLeftRegister and shiftRightRegister are derived classes
// that inherit data property for Register class. 
// b.	shiftLeftRegister and shiftRightRegister have their own constructor with a single 
// argument that has a default value of 0. Both constructors will pass the argument value to 
// the Register constructor to set the data value.
// Hint: Don’t forget to use super keywords.
// c.	shiftLeft() method will shift the data value to the left by one bit.
// d.	shiftRight() method will shift the data value to the right by one bit.
// 9.	Create instantiations of both subclasses and verify them in testbench.sv.
// Make sure that shift right and shift left mechanism are working correctly.
// 10.	Click Save and Run to simulate.
// 11.	Debug your code as required, until you are happy that the design is verified.

// Base Register class
class Register;
  logic [7:0] data;

  // Base constructor
  function new(logic [7:0] init_val = 8'd0);
    data = init_val;
  endfunction

  // Load method
  function void load(logic [7:0] new_val);
    data = new_val;
  endfunction

  // Getter method
  function logic [7:0] get_data();
    return data;
  endfunction
endclass

// Derived class: Shift Left Register
class shiftLeftRegister extends Register;
  // Constructor (calls parent constructor)
  function new(logic [7:0] init_val = 8'd0);
    super.new(init_val);
  endfunction

  // Shift left by one bit
  function void shiftLeft();
    data = data << 1;
  endfunction
endclass

// Derived class: Shift Right Register
class shiftRightRegister extends Register;
  // Constructor (calls parent constructor)
  function new(logic [7:0] init_val = 8'd0);
    super.new(init_val);
  endfunction

  // Shift right by one bit
  function void shiftRight();
    data = data >> 1;
  endfunction
endclass

// Testbench
module test;
  shiftLeftRegister  sl;
  shiftRightRegister sr;

  initial begin
    // Create objects with initial values
    sl = new(8'b00110110);
    sr = new(8'b11001001);

    // Display initial values
    $display("Initial Values:");
    $display("Shift Left Register = %b", sl.get_data());
    $display("Shift Right Register = %b", sr.get_data());

    // Perform shifting
    sl.shiftLeft();
    sr.shiftRight();

    // Display results after shift
    $display("\nAfter Shifting:");
    $display("Shift Left Register  = %b", sl.get_data());
    $display("Shift Right Register = %b", sr.get_data());

    $finish;
  end
endmodule
