// Q3:  Using Mailbox:
// Write SystemVerilog code for two tasks, task1 which put two values into the 
// mailbox (int value and string name), and task2 get these values and display the result.
// Use mailbox get and put methods to create a way of communication between these two processes.

// Procedure:
// 1.	Open the EDA playground by clicking on https://www.edaplayground.com/ .
// 2.	In the Left Side Menu in Tools & Simulators choose Synopsys VSC 2020.03
// or Cadence Xcelium 20.09 to simulate the design.
// 3.	Read about the tasks in SV.
// 4.	Start writing design:
// a.	Create new module called mailbox_example.
// b.	Create a task1 which use mailbox put method and $display()to print before 
// and after put values.
// c.	Create a task2 which use mailbox get method and $display()to print before 
// and after get values
// d.	Use fork join inside initial block to run the two processes concurrently.
// 5.	Click Save and Run to simulate.
// 6.	Analyze the result.

module mailbox_example;
  // Declare mailbox
  mailbox my_mailbox;

  // Declare variables
  int val;
  string str;

  // Initialize mailbox
  initial begin
    my_mailbox = new();
  end

  // Task1: Puts values into the mailbox
  task automatic task1(input int val, input string str);
    begin
      $display("[%0t] Task1: Before put - value: %0d, name: %s", $time, val, str);
      my_mailbox.put(val);
      my_mailbox.put(str);
      $display("[%0t] Task1: After put - value: %0d, name: %s", $time, val, str);
    end
  endtask

  // Task2: Gets values from the mailbox
  task automatic task2;
    int v;
    string s;
    begin
      $display("[%0t] Task2: Before get", $time);
      my_mailbox.get(v);
      my_mailbox.get(s);
      $display("[%0t] Task2: After get - value: %0d, name: %s", $time, v, s);
    end
  endtask

  // Initial block to run tasks concurrently
  initial begin
    fork
      task1(10, "Apple");
      task2();
    join
    $display("[%0t] Simulation Completed", $time);
    #10 $finish;
  end
endmodule

// Output:
// [0] Task1: Before put - value: 10, name: Apple
// [0] Task1: After put - value: 10, name: Apple
// [0] Task2: Before get
// [0] Task2: After get - value: 10, name: Apple
// [0] Simulation Completed