// Q4: Parametrized Classes

// Now we will try and optimize our code. By applying the parametrized class concept into our code. 
// 9.	Update the Register class header to define a parameter of type int called DATA_WIDTH 
// and give it a default value of 8.
// 10.	Instead of using logic [7:0] for data in the Register class, update the code to be 
// flexible with any size of data that we pass to it using DATA_WIDTH.
// 11.	Update the testbench.sv to check if your code is working.
// 12.	Simulate, observe what the output is and debug as needed.

// Base Register class (Parameterized)
class Register #(parameter int DATA_WIDTH = 8);
  logic [DATA_WIDTH-1:0] data;
  static int count = 0;  // Shared across all instances

  // Constructor
  function new(logic [DATA_WIDTH-1:0] init_val = '0);
    data = init_val;
    count++;
  endfunction

  // Load method
  function void load(logic [DATA_WIDTH-1:0] new_val);
    data = new_val;
  endfunction

  // Getter method
  function logic [DATA_WIDTH-1:0] get_data();
    return data;
  endfunction

  // Static method to return instance count
  static function int get_count();
    return count;
  endfunction
endclass

// Derived Class: Shift Left Register
class shiftLeftRegister #(parameter int DATA_WIDTH = 8) extends Register #(DATA_WIDTH);
  function new(logic [DATA_WIDTH-1:0] init_val = '0);
    super.new(init_val);
  endfunction

  // Shift left by one bit
  function void shiftLeft();
    data = data << 1;
  endfunction
endclass

// Derived Class: Shift Right Register
class shiftRightRegister #(parameter int DATA_WIDTH = 8) extends Register #(DATA_WIDTH);
  function new(logic [DATA_WIDTH-1:0] init_val = '0);
    super.new(init_val);
  endfunction

  // Shift right by one bit
  function void shiftRight();
    data = data >> 1;
  endfunction
endclass

// Testbench
module test;
  // Create 8-bit registers
  shiftLeftRegister #(8)  sl1, sl2;
  shiftRightRegister #(8) sr1;

  // Create 4-bit register to show flexibility
  shiftLeftRegister #(4)  sl_small;

  initial begin
    // Instantiate 8-bit registers
    sl1 = new(8'b00001111);
    sl2 = new(8'b11110000);
    sr1 = new(8'b10101010);

    // Instantiate 4-bit register
    sl_small = new(4'b1010);

    // Display initial values
    $display("Initial Data Values:");
    $display("ShiftLeft1 (8-bit) = %b", sl1.get_data());
    $display("ShiftLeft2 (8-bit) = %b", sl2.get_data());
    $display("ShiftRight (8-bit) = %b", sr1.get_data());
    $display("ShiftLeftSmall (4-bit) = %b", sl_small.get_data());

    // Perform shifts
    sl1.shiftLeft();
    sr1.shiftRight();
    sl_small.shiftLeft();

    // Display results
    $display("\nAfter Shifting:");
    $display("ShiftLeft1 (<<1) = %b", sl1.get_data());
    $display("ShiftRight (>>1) = %b", sr1.get_data());
    $display("ShiftLeftSmall (4-bit <<1) = %b", sl_small.get_data());

    // Show instance count (shared)
    $display("\nInstance Count per Parameter Type:");
    $display("Register #(8)::get_count() = %0d", Register#(8)::get_count());
    $display("Register #(4)::get_count() = %0d", Register#(4)::get_count());

    $finish;
  end
endmodule
