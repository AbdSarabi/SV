
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

