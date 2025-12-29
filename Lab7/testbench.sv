`timescale 1ns/1ps

module tb_seq_controller;
  logic clk, rst_;
  logic zero;
  logic [2:0] opcode;
  logic mem_rd, load_ir, halt, inc_pc, load_ac, load_pc, mem_wr;

  sequence_controller dut(
    .clk(clk),.rst_(rst_),.zero(zero),.opcode(opcode),
    .mem_rd(mem_rd),.load_ir(load_ir),.halt(halt),.inc_pc(inc_pc),
    .load_ac(load_ac),.load_pc(load_pc),.mem_wr(mem_wr)
  );

  initial clk=0;
  always #5 clk=~clk;

  always @(posedge clk) begin
    $display("t=%0t op=%b z=%b | mem_rd=%b load_ir=%b halt=%b inc_pc=%b load_ac=%b load_pc=%b mem_wr=%b",
      $time,opcode,zero,mem_rd,load_ir,halt,inc_pc,load_ac,load_pc,mem_wr);
  end

  initial begin
    rst_=0; zero=0; opcode=3'b000;
    #12 rst_=1;

    opcode=3'b010; zero=0; repeat(10) @(posedge clk); // ADD
    opcode=3'b000; zero=0; repeat(10) @(posedge clk); // HLT
    opcode=3'b001; zero=1; repeat(10) @(posedge clk); // SKZ with zero=1
    opcode=3'b111; zero=0; repeat(10) @(posedge clk); // JMP

    $finish;
  end
endmodule
