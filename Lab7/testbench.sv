`timescale 1ns/1ps

module tb_control;
  logic clk, rst_, zero;
  logic [2:0] opcode;
  logic mem_rd, load_ir, halt, inc_pc, load_ac, load_pc, mem_wr;

  // Instantiate DUT
  control uut (
    .clk(clk),
    .rst_(rst_),
    .opcode(opcode),
    .zero(zero),
    .mem_rd(mem_rd),
    .load_ir(load_ir),
    .halt(halt),
    .inc_pc(inc_pc),
    .load_ac(load_ac),
    .load_pc(load_pc),
    .mem_wr(mem_wr)
  );

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk;

  // Task to test a single opcode
  task automatic test_opcode(input logic [2:0] op_value, input string op_name);
    opcode = op_value;
    $display("\n--- Testing %s (opcode=%b) ---", op_name, op_value);
    repeat (8) begin
      $display("Time=%0t | mem_rd=%b load_ir=%b halt=%b inc_pc=%b load_ac=%b load_pc=%b mem_wr=%b",
               $time, mem_rd, load_ir, halt, inc_pc, load_ac, load_pc, mem_wr);
      #10;
    end
  endtask

  // Test sequence
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_control);

    rst_ = 0;
    zero = 0;
    #10 rst_ = 1;

    test_opcode(3'b000, "HLT");
    test_opcode(3'b001, "SKZ");
    test_opcode(3'b010, "ADD");
    test_opcode(3'b011, "AND");
    test_opcode(3'b100, "XOR");
    test_opcode(3'b101, "LDA");
    test_opcode(3'b110, "STO");
    test_opcode(3'b111, "JMP");

    #10;
    rst_ = 0;
    zero = 1;
    #10 rst_ = 1;

    test_opcode(3'b000, "HLT");
    test_opcode(3'b001, "SKZ");
    test_opcode(3'b010, "ADD");
    test_opcode(3'b011, "AND");
    test_opcode(3'b100, "XOR");
    test_opcode(3'b101, "LDA");
    test_opcode(3'b110, "STO");
    test_opcode(3'b111, "JMP");

    $finish;
  end
endmodule
