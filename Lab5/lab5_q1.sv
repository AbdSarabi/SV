// Q1:  Create a simple register design using SystemVerilog classes and declare two 
// subclasses (shift right and shift left registers) with the following specification:
 
// •	new (logic [7:0]) is a user defined constructor. This constructor takes one 
// argument logic [7:0] to set the initial value of data. Set the argument default value to 0.
// •	load () is a method that sets the data value.
// •	get_data() is a method that gets and returns the value of data.

// Procedure:
// 1.	Open the EDA playground by clicking on https://www.edaplayground.com.
// 2.	In the Left Side Menu in Tools & Simulators choose Synopsys VSC 2020.03
// or Cadence Xcelium 20.09 to simulate the design + Testbench.
// 3.	Writing a SystemVerilog code that describes the register design.
// a.	In the design declare a register class as described in the UML diagram above. 
// 4.	In testbench side, create an instance of class register and use the methods that you 
// define in register class. Simulate, observe what the output is and debug as needed.
// 5.	Click Save and Run to simulate.

// Base Register class
class Register;
  logic [7:0] data;

  function new(logic [7:0] init_val = 8'd0);
    data = init_val;
  endfunction

  function void load(logic [7:0] new_val);
    data = new_val;
  endfunction

  function logic [7:0] get_data();
    return data;
  endfunction
endclass

// Subclass: Shift Right Register
class ShiftRightRegister extends Register;
  function void shift_right();
    data = data >> 1;
  endfunction
endclass

// Subclass: Shift Left Register
class ShiftLeftRegister extends Register;
  function void shift_left();
    data = data << 1;
  endfunction
endclass
