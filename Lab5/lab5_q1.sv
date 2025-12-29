

class Register;
  logic [7:0] data;

  function new(logic [7:0] init_val = 8'd0);
    data = init_val;
  endfunction

  function void load(logic [7:0] new_val);
    data = new_val;
  endfunction

  function logic [7:0] get_data();
    return data;
  endfunction
endclass
class ShiftRightRegister extends Register;
  function void shift_right();
    data = data >> 1;
  endfunction
endclass

class ShiftLeftRegister extends Register;
  function void shift_left();
    data = data << 1;
  endfunction
endclass


module testbench;

  Register r;

  initial begin
    r = new();
    $display("Initial data = %0d", r.get_data());

    r.load(8'd20);
    $display("After load = %0d", r.get_data());

    #10;
    $finish;
  end

endmodule
