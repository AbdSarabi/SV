

class Calculator;

  // Constructor
  function new();
    $display("Calculator object created at time %0t", $time);
  endfunction

  // Addition
  task automatic add(input real a, b, output real result);
    #2; // simulate small processing delay
    result = a + b;
    $display("[%0t] add() done: %0f + %0f = %0f", $time, a, b, result);
  endtask

  // Subtraction
  task automatic sub(input real a, b, output real result);
    #2;
    result = a - b;
    $display("[%0t] sub() done: %0f - %0f = %0f", $time, a, b, result);
  endtask

  // Multiplication
  task automatic multi(input real a, b, output real result);
    #3;
    result = a * b;
    $display("[%0t] multi() done: %0f * %0f = %0f", $time, a, b, result);
  endtask

  // Division
  task automatic div(input real a, b, output real result);
    #3;
    if (b == 0) begin
      $display("[%0t] Warning: Division by zero!", $time);
      result = 0;
    end
    else begin
      result = a / b;
      $display("[%0t] div() done: %0f / %0f = %0f", $time, a, b, result);
    end
  endtask

  // Power
  static task automatic power(input real base, input int exp, output real result);
    result = 1;
    repeat (exp) begin
      #1; // simulate 1 ns per multiplication
      result *= base;
    end
    $display("[%0t] power() done: base=%0f exp=%0d result=%0f", $time, base, exp, result);
  endtask

endclass

module test;
  Calculator calc;
  real a = 12.0, b = 4.0, result;

  initial begin
    calc = new();

    $display("\n--- Calculator Operations (Task-based) ---");
    $display("Inputs: a = %0f, b = %0f\n", a, b);

    // Call each task
    calc.add(a, b, result);
    calc.sub(a, b, result);
    calc.multi(a, b, result);
    calc.div(a, b, result);

    // Call static task
    $display("\n--- Static Power Task ---");
    Calculator::power(2, 5, result);
    $display("Result of Power(2,5) = %0f", result);

    $finish;
  end
endmodule
