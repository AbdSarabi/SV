// Q4:  Simulate this code and analyze the result.

module test;
  reg a, b, c, d;
  wire e;

  and and1 (e, a, b, c);

  initial begin
    $monitor("%d d=%b, e=%b", $stime, d, e);
    assign d = a & b & c;

    a = 1;
    b = 0;
    c = 1;

    #10;
    force d = (a | b | c);
    force e = (a | b | c);

    #10 $stop;

    release d;
    release e;

    #10 $finish;
  end
endmodule

// output:
// 0 d=0, e=0
// 10 d=1, e=1

// This simulation demonstrates how procedural continuous assignments,
// along with force and release statements, can override signal values in SystemVerilog.
// Initially, both d and e are driven by the logical AND of a, b, and c, producing 0.
// At time 10, the force statements temporarily override these connections,
// assigning both signals the value of the OR expression (a | b | c), making them 1.
// After releasing the signals, they revert to their original AND-driven values.