// fifo_simple.v
// Simple FIFO (circular buffer) - for learning / simulation
// Depth = 8, Width = 8 (can be parameterized if you like)
`timescale 1ns/1ps
module fifo (
  input  wire        clk,
  input  wire        rst_n,   // active low reset
  input  wire        wr,      // write enable
  input  wire        rd,      // read enable
  input  wire [7:0]  din,     // data in
  output reg  [7:0]  dout,    // data out
  output wire        empty,
  output wire        full
);

  parameter DEPTH = 8;
  parameter PTR_W = 3; // log2(DEPTH)

  reg [7:0] mem [0:DEPTH-1];
  reg [PTR_W-1:0] wptr, rptr;
  reg [PTR_W:0] count;  // counts number of items

  integer i;

  // sequential logic
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      wptr  <= 0;
      rptr  <= 0;
      count <= 0;
      dout  <= 0;
      for (i = 0; i < DEPTH; i = i + 1) mem[i] <= 0;
    end else begin
      // write
      if (wr && !full) begin
        mem[wptr] <= din;
        wptr <= (wptr + 1) % DEPTH;
        count <= count + 1;
      end

      // read
      if (rd && !empty) begin
        dout <= mem[rptr];
        rptr <= (rptr + 1) % DEPTH;
        count <= count - 1;
      end
    end
  end

  // status
  assign empty = (count == 0);
  assign full  = (count == DEPTH);

endmodule
