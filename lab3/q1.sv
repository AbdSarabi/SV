

module FullAdder1 (
  input  logic [3:0] ina,       
  input  logic [3:0] inb,       
  input  logic       carry_in,  
  output logic [3:0]sum_out  ,   
  output logic        carry_out  
);
  
 assign {carry_out,sum_out}=ina+inb+carry_in;


endmodule


module tbFullAdder1;
  logic [3:0] ina, inb;
  logic carry_in;
  logic [3:0] sum_out;
  logic carry_out;

  FullAdder1 dut (
    .ina(ina),
    .inb(inb),
    .carry_in(carry_in),
    .sum_out(sum_out),
    .carry_out(carry_out)
  );


  initial begin
    $display("Time | ina  | inb  | carry_in | sum_out | carry_out");
    $display("----------------------------------------------------");

    carry_in = 0;

    ina = 4'b0001; inb = 4'b0010; 
    #5;
    $display("%4t | %b | %b |    %b     |   %b   |    %b",
              $time, ina, inb, carry_in, sum_out, carry_out);

    ina = 4'b1111; inb = 4'b0001; 
    #5;
    $display("%4t | %b | %b |    %b     |   %b   |    %b",
              $time, ina, inb, carry_in, sum_out, carry_out);

    ina = 4'b1010; inb = 4'b0101; carry_in = 1; 
    #5;
    $display("%4t | %b | %b |    %b     |   %b   |    %b",
              $time, ina, inb, carry_in, sum_out, carry_out);

    ina = 4'b1111; inb = 4'b1111; carry_in = 1; 
    #5;
    $display("%4t | %b | %b |    %b     |   %b   |    %b",
              $time, ina, inb, carry_in, sum_out, carry_out);

    $display("----------------------------------------------------");
    $display("Done ");
    $finish;
  end
endmodule
