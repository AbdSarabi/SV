// Q1:  Without Semaphore – producing shared memory issue:
// Write SystemVerilog code for two tasks, write_mem which takes 5ns to write into memory
// and read_mem which takes 4ns to read data from memory. 
// The two different process wants to access a memory which is not aware that another 
// process accessing at the same time.

// Procedure:
// 1.	Open the EDA playground by clicking on https://www.edaplayground.com.
// 2.	In the Left Side Menu in Tools & Simulators choose Synopsys VSC 2020.03
// or Cadence Xcelium 20.09 to simulate the design.
// 3.	Start writing design:
// a.	Create new module called semaphore_example.
// b.	Use fork join to call the two tasks in parallel.
// c.	Use the delays to assume it is the required time to write/read to mem
// and $display()to print before and after the delay.
// 4.	Click Save and Run to simulate.
// 5.	Analyze the result.

module no_semaphore_example;
  int memory = 0;

  task automatic write_mem (input int new_value);
    begin
      $display("[%0t ns] WRITE: Trying to write to memory...", $time);
      #5;
      memory = new_value;
      $display("[%0t ns] WRITE: Memory updated to %0d", $time, memory);
    end
  endtask

  task automatic read_mem;
    begin
      $display("[%0t ns] READ: Trying to read from memory...", $time);
      #4;
      $display("[%0t ns] READ: Read memory value = %0d", $time, memory);
    end
  endtask

  initial begin
    $display("[%0t ns] Simulation started", $time);

    fork
      write_mem(100);
      read_mem();
    join

    $display("[%0t ns] Simulation finished", $time);
    #10 $finish;
  end
endmodule

// Output:
// [0 ns] Simulation started
// [0 ns] WRITE: Trying to write to memory...
// [0 ns] READ: Trying to read from memory...
// [4 ns] READ: Read memory value = 0
// [5 ns] WRITE: Memory updated to 100
// [5 ns] Simulation finished