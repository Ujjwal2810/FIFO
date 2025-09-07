// tb_fifo_simple.v
`timescale 1ns/1ps

module tb_fifo;

  reg clk, rst_n, wr, rd;
  reg [7:0] din;
  wire [7:0] dout;
  wire empty, full;

  fifo dut (
    .clk(clk), .rst_n(rst_n), .wr(wr), .rd(rd),
    .din(din), .dout(dout), .empty(empty), .full(full)
  );

  // clock: 10ns period
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    // reset
    rst_n = 0; wr = 0; rd = 0; din = 0;
    #15 rst_n = 1;

    // ------------------
    // Write 4 values
    // ------------------
    $display("=== Write 4 values ===");
    @(posedge clk); wr=1; din=8'd11;
    @(posedge clk); din=8'd22;
    @(posedge clk); din=8'd33;
    @(posedge clk); din=8'd44;
    @(posedge clk); wr=0;

    // ------------------
    // Read 4 values
    // ------------------
    $display("=== Read 4 values ===");
    repeat (4) begin
      @(posedge clk); rd=1;
      @(posedge clk); rd=0;
      @(posedge clk);
      $display("Read value = %0d", dout);
    end

    // ------------------
    // Fill FIFO completely (DEPTH=8)
    // ------------------
    $display("=== Fill FIFO ===");
    repeat (8) begin
      @(posedge clk); wr=1; din=$random % 256;
    end
    @(posedge clk); wr=0;
    $display("FIFO full flag = %b", full);

    // Try one extra write (should be ignored)
    @(posedge clk); wr=1; din=8'hAA;
    @(posedge clk); wr=0;
    $display("Tried extra write, full=%b", full);

    // ------------------
    // Empty FIFO completely
    // ------------------
    $display("=== Empty FIFO ===");
    repeat (8) begin
      @(posedge clk); rd=1;
      @(posedge clk); rd=0;
      @(posedge clk);
      $display("Read value = %0d", dout);
    end
    $display("FIFO empty flag = %b", empty);

    // Try one extra read (should be ignored)
    @(posedge clk); rd=1;
    @(posedge clk); rd=0;
    $display("Tried extra read, empty=%b", empty);

    // done
    #20;
    $display("=== Test Complete ===");
    $finish;
  end

  // dump waveform
  initial begin
    $dumpfile("fifo.vcd");
    $dumpvars(0, tb_fifo);
  end

endmodule
