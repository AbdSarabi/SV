class Register;
  logic [7:0] data;
  static int count = 0;

  function new(logic [7:0] init_val = 8'd0);
    data = init_val;
    count++;
  endfunction

  function void load(logic [7:0] new_val);
    data = new_val;
  endfunction

  function logic [7:0] get_data();
    return data;
  endfunction

  static function int get_count();
    return count;
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
  shiftLeftRegister  sl1, sl2;
  shiftRightRegister sr1;

  initial begin
    sl1 = new(8'b00001111);
    sr1 = new(8'b10101010);

    $display("Initial Data Values:");
    $display("ShiftLeft = %b", sl1.get_data());
    $display("ShiftRight = %b", sr1.get_data());

    sl1.shiftLeft();
    sr1.shiftRight();

    $display("\nAfter Shift:");
    $display("ShiftLeft  (<<1) = %b", sl1.get_data());
    $display("ShiftRight (>>1) = %b", sr1.get_data());

    $display("\nInstance Count:");
    $display("Register::get_count()      = %0d", Register::get_count());
    
    $finish;
  end
endmodule
