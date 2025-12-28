// Q3: Static properties and static methods (Define Derived Classes)

// To have only one version of a variable shared across all instances we use a static keyword.
// This applies to the class properties and methods. We will implement in this part a static method
// and property to count the number of instances of the class that have been created. Static methods
// and properties can be called without a class instance.

// 3.	Start with creating a static property for Register class to count the number of instances. 
// 4.	Increment the value in the Register constructor.
// 5.	 Add a static method to get and return the static property.
// 6.	Update the testbench.sv to check and call static method to return the value. 
// Hint: Don’t forget to use the scope resolution operator:: to call the static method. 
// 7.	Simulate, observe what the output is and debug as needed.
// 8.	Optional: Try and call in testbench.sv the following: shiftLeftRegister::<static_method_name> 
// shiftRightRegister::<static_method_name> 
// What is the count result for the static properties, do they have the same value? And why?

// Base Register class
class Register;
  logic [7:0] data;
  static int count = 0;  // Static property shared by all instances

  // Constructor
  function new(logic [7:0] init_val = 8'd0);
    data = init_val;
    count++;  // Increment count for every new object
  endfunction

  // Load method
  function void load(logic [7:0] new_val);
    data = new_val;
  endfunction

  // Getter method
  function logic [7:0] get_data();
    return data;
  endfunction

  // Static method to return instance count
  static function int get_count();
    return count;
  endfunction
endclass


// Derived class: Shift Left Register
class shiftLeftRegister extends Register;
  function new(logic [7:0] init_val = 8'd0);
    super.new(init_val);
  endfunction

  function void shiftLeft();
    data = data << 1;
  endfunction
endclass


// Derived class: Shift Right Register
class shiftRightRegister extends Register;
  function new(logic [7:0] init_val = 8'd0);
    super.new(init_val);
  endfunction

  function void shiftRight();
    data = data >> 1;
  endfunction
endclass

// Testbench
module test;
  shiftLeftRegister  sl1, sl2;
  shiftRightRegister sr1;

  initial begin
    // Create instances
    sl1 = new(8'b00001111);
    sl2 = new(8'b11110000);
    sr1 = new(8'b10101010);

    // Display values
    $display("Initial Data Values:");
    $display("ShiftLeft1 = %b", sl1.get_data());
    $display("ShiftLeft2 = %b", sl2.get_data());
    $display("ShiftRight = %b", sr1.get_data());

    // Perform shift operations
    sl1.shiftLeft();
    sr1.shiftRight();

    // Display updated values
    $display("\nAfter Shift:");
    $display("ShiftLeft  (<<1) = %b", sl1.get_data());
    $display("ShiftRight (>>1) = %b", sr1.get_data());

    // Display count using static method
    $display("\nInstance Count:");
    $display("Register::get_count()        = %0d", Register::get_count());
    $display("shiftLeftRegister::get_count()  = %0d", shiftLeftRegister::get_count());
    $display("shiftRightRegister::get_count() = %0d", shiftRightRegister::get_count());

    $finish;
  end
endmodule
