
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
   if(b == 0.0) begin
    $display("WARNING: Division by zero, returning 0.0");
    return 0.0;
  end
  return a / b;
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

