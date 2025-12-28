// Create a simple calculator that will includes these methods summation, subtract, multiply, 
// and division. 

// Procedure:

// 	Part A: Calculator Function Example
// 1.	Open a new EDAPlayGround
// 2.	Create a new file calculator.sv inside it define 4 functions and each function takes two input 
// arguments of type real and return one output of type real.
// a.	Task add(), which calculate the summation of two numbers 
// b.	Task sub(), which calculate the subtraction of two numbers 
// c.	Task div(), which calculate the division of two numbers
// d.	Task multi(), which calculate the multiplications of two numbers.
// 3.	Define you own constructor.
// 4.	Create testbench.sv file and inside it defines an instance of class calculator and write 
// your own testbench to check the functionality of the calculator.
// 5.	Simulate, observe what the output is and debug as needed.
// 6.	Try to update the code by applying static methods concepts.
// 7.	Define a new static function named power() this function takes two input parameters the 
// base value and exponent and return the power value for base. (Don’t use $pow())
// 8.	Inside the testbench call the static function power() and check it’s functionality.
// 9.	Try to add simulation time consuming elements (#, @, fork-join, wait, expect) inside the function.
// And rerun the code. What happened? Did the code run? Why?

class Calculator;
  // Constructor
  function new();
    $display("Calculator object created at time %0t", $time);
  endfunction

  // Addition
  function real add(real a, real b);
    return a + b;
  endfunction

  // Subtraction
  function real sub(real a, real b);
    return a - b;
  endfunction

  // Multiplication
  function real multi(real a, real b);
    return a * b;
  endfunction

  // Division
  function real div(real a, real b);
    if (b == 0)
      $display("Warning: Division by zero!");
    return (b != 0) ? (a / b) : 0;
  endfunction

  // Power
  static function real power(real base, int exp);
    real result = 1;
    for (int i = 0; i < exp; i++)
      result *= base;
    return result;
  endfunction
endclass

module test;
  Calculator calc;
  real a = 12.0, b = 4.0;

  initial begin
    calc = new();

    $display("\n--- Calculator Operations ---");
    $display("a = %0f, b = %0f", a, b);

    $display("Add:      %0f", calc.add(a, b));
    $display("Subtract: %0f", calc.sub(a, b));
    $display("Multiply: %0f", calc.multi(a, b));
    $display("Divide:   %0f", calc.div(a, b));

    // Call static function directly
    $display("\n--- Static Power Function ---");
    $display("Power(2, 5) = %0f", Calculator::power(2, 5));

    $finish;
  end
endmodule
