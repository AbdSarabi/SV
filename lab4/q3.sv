module mailbox_example;
  mailbox mail;
  int val;
  string str;

  initial begin
    mail = new();
  end

  task automatic task1(input int val, input string str);
    begin
      $display("[%0t] Task1: Before put - value: %0d, name: %s", $time, val, str);
      mail.put(val);
      mail.put(str);
      $display("[%0t] Task1: After put - value: %0d, name: %s", $time, val, str);
    end
  endtask

  task automatic task2;
    int v;
    string s;
    begin
      $display("[%0t] Task2: Before get", $time);
      mail.get(v);
      mail.get(s);
      $display("[%0t] Task2: After get - value: %0d, name: %s", $time, v, s);
    end
  endtask

  initial begin
    fork
      task1(10, "Apple");
      task2();
    join
    $display("[%0t] Simulation Completed", $time);
    #10 $finish;
  end
endmodule
