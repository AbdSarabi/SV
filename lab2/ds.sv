
module register_design (
  input  logic        clk,       // Clock
  input  logic        reset,     // Synchronous reset (active high)
  input  logic        sel,       // Select signal
  input  logic        wr,        // Write enable
  input  logic [1:0]  addr,      // 2-bit address (4 locations)
  input  logic [15:0] wdata,     // Write data
  output logic [15:0] rdata      // Read data
);
 
  logic [15:0] mem [0:3];

  always_ff @(posedge clk) begin
    if (reset) begin
      mem[0] <= 16'b0;
      mem[1] <= 16'b0;
      mem[2] <= 16'b0;
      mem[3] <= 16'b0;
      rdata  <= 16'b0;
    end
    else if (sel && wr) begin
      mem[addr] <= wdata;
    end
    else if (sel && !wr) begin
      rdata <= mem[addr];
    end
  end
endmodule

module test_register_design;
  logic clk, reset, sel, wr;
  logic [1:0] addr;
  logic [15:0] wdata, rdata;

  register_design dut (
    .clk(clk),
    .reset(reset),
    .sel(sel),
    .wr(wr),
    .addr(addr),
    .wdata(wdata),
    .rdata(rdata)
  );

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

 
  initial begin
    reset = 1;
    sel = 0;
    wr = 0;
    addr = 0;
    wdata = 16'h0000;
    @(posedge clk);
    reset = 0;

    $display("Start Writing");

    // Write values into memory
    sel = 1; wr = 1;
    
    addr = 2'b00; wdata = 16'hAAAA; @(posedge clk);
    $display("Time=%0t: Addrress=%d  Write=%h", $time, addr,wdata);

    addr = 2'b01; wdata = 16'hBBBB; @(posedge clk);
    $display("Time=%0t: Addrress=%d  Write=%h", $time, addr,wdata);

    addr = 2'b10; wdata = 16'hCCCC; @(posedge clk);
    $display("Time=%0t: Addrress=%d  Write=%h", $time, addr,wdata);

    addr = 2'b11; wdata = 16'hDDDD; @(posedge clk);
    $display("Time=%0t: Addrress=%d  Write=%h", $time, addr,wdata);

    wr = 0;
    $display(" Done Writing ");
    $display(" Start Reading ");
    // Read values back
    addr = 2'b00; @(posedge clk);
    $display("Time=%0t: Addrress=%d  Read=%h", $time, addr,rdata);
    addr = 2'b01; @(posedge clk);
    $display("Time=%0t: Addrress=%d  Read=%h", $time, addr,rdata);
    addr = 2'b10; @(posedge clk);
    $display("Time=%0t: Addrress=%d  Read=%h", $time, addr,rdata);
    addr = 2'b11; @(posedge clk);
    $display("Time=%0t: Addrress=%d  Read=%h", $time, addr,rdata);
$display(" Done Reading ");
    $display("Finished");
    $finish;
  end
endmodule
