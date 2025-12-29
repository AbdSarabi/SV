class Register #(parameter int DATA_WIDTH = 8);
  logic [DATA_WIDTH-1:0] data;
  static int count = 0;

  function new(logic [DATA_WIDTH-1:0] init_val = '0);
    data = init_val;
    count++;
  endfunction

  function void load(logic [DATA_WIDTH-1:0] new_val);
    data = new_val;
  endfunction

  function logic [DATA_WIDTH-1:0] get_data();
    return data;
  endfunction

  static function int get_count();
    return count;
  endfunction
endclass


class shiftLeftRegister #(parameter int DATA_WIDTH = 8)
  extends Register #(DATA_WIDTH);

  function new(logic [DATA_WIDTH-1:0] init_val = '0);
    super.new(init_val);
  endfunction

  function void shiftLeft();
    data = data << 1;
  endfunction
endclass


class shiftRightRegister #(parameter int DATA_WIDTH = 8)
  extends Register #(DATA_WIDTH);

  function new(logic [DATA_WIDTH-1:0] init_val = '0);
    super.new(init_val);
  endfunction

  function void shiftRight();
    data = data >> 1;
  endfunction
endclass


module test;

  shiftLeftRegister #(8)  sl1, sl2;
  shiftRightRegister #(8) sr1;
  shiftLeftRegister #(4)  sl_small;

  initial begin
    sl1 = new(8'b00001111);
    sl2 = new(8'b11110000);
    sr1 = new(8'b10101010);
    sl_small = new(4'b1010);

    $display("Initial Data Values:");
    $display("ShiftLeft1 (8-bit) = %b", sl1.get_data());
    $display("ShiftLeft2 (8-bit) = %b", sl2.get_data());
    $display("ShiftRight (8-bit) = %b", sr1.get_data());
    $display("ShiftLeftSmall (4-bit) = %b", sl_small.get_data());

    sl1.shiftLeft();
    sr1.shiftRight();
    sl_small.shiftLeft();

    $display("\nAfter Shifting:");
    $display("ShiftLeft1 = %b", sl1.get_data());
    $display("ShiftRight = %b", sr1.get_data());
    $display("ShiftLeftSmall = %b", sl_small.get_data());

    $display("\nInstance Count:");
    $display("Register #(8)::get_count() = %0d", Register#(8)::get_count());
    $display("Register #(4)::get_count() = %0d", Register#(4)::get_count());

    $finish;
  end
endmodule
