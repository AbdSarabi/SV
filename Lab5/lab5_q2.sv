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


class shiftLeftRegister extends Register;
  function new(logic [7:0] init_val = 8'd0);
    super.new(init_val);
  endfunction

  function void shiftLeft();
    data = data << 1;
  endfunction
endclass


class shiftRightRegister extends Register;
  function new(logic [7:0] init_val = 8'd0);
    super.new(init_val);
  endfunction

  function void shiftRight();
    data = data >> 1;
  endfunction
endclass


module test;
  shiftLeftRegister  sl;
  shiftRightRegister sr;

  initial begin
    sl = new(8'b00110110);
    sr = new(8'b11001001);

    $display("Initial Values:");
    $display("Initial for Shift Left Register = %b", sl.get_data());
    $display("Initial for Shift Right Register = %b", sr.get_data());

    sl.shiftLeft();
    sr.shiftRight();

    $display("\nAfter Shifting:");
    $display("Shift Left Register  = %b", sl.get_data());
    $display("Shift Right Register = %b", sr.get_data());

    $finish;
  end
endmodule
