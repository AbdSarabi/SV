// Q2:  Using Semaphore:
// Write SystemVerilog code for two tasks, write_mem which takes 5ns to write into memory
// and read_mem which takes 5ns to read data from memory. 
// The two different process wants to access a memory which is not aware that another
// process accessing at the same time.
// Use semaphore get and put methods to avoid shared memory issues.

// Procedure:
// 1.	Open the EDA playground by clicking on https://www.edaplayground.com/ .
// 2.	In the Left Side Menu in Tools & Simulators choose Synopsys VSC 2020.03
// or Cadence Xcelium 20.09 to simulate the design.
// 3.	Start writing design:
// a.	Create new module called semaphore_example.
// b.	Use fork join inside initial block to run the two processes concurrently.
// c.	Use the delays to assume it is the required time to write/read to mem
// and $display()to print before and after the delay.
// d.	In write_mem use semaphore get and put methods.
// e.	In read_mem use semaphore get and put methods.
// 4.	Click Save and Run to simulate.
// 5.	Analyze the result.

module semaphore_example;
  int memory = 0;
  semaphore mem_lock;
  
  initial begin
    mem_lock = new(1);
  end
  
  task automatic write_mem (input int new_value);
    begin
      $display("[%0t ns] WRITE: Trying to access memory...", $time);
      
      mem_lock.get(1);
      $display("[%0t ns] WRITE: Got access to memory", $time);
      
      #5;
      memory = new_value;
      $display("[%0t ns] WRITE: Memory updated to %0d", $time, memory);
      
      mem_lock.put(1);
      $display("[%0t ns] WRITE: Released access to memory", $time);
    end
  endtask
  
  task automatic read_mem;
    begin
      $display("[%0t ns] READ: Trying to access memory...", $time);
      
      mem_lock.get(1);
      $display("[%0t ns] READ: Got access to memory", $time);
      
      #5;
      $display("[%0t ns] READ: Read memory value = %0d", $time, memory);
      
      mem_lock.put(1);
      $display("[%0t ns] READ: Released access to memory", $time);
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
// [0 ns] WRITE: Trying to access memory...
// [0 ns] WRITE: Got access to memory
// [0 ns] READ: Trying to access memory...
// [5 ns] WRITE: Memory updated to 100
// [5 ns] WRITE: Released access to memory
// [5 ns] READ: Got access to memory
// [10 ns] READ: Read memory value = 100
// [10 ns] READ: Released access to memory
// [10 ns] Simulation finished