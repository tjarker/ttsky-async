/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_example (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // All output pins must be assigned. If not used, assign to 0.
  assign uo_out  = ui_in + uio_in;  // Example: ou_out is the sum of ui_in and uio_in
  assign uio_out = 0;
  assign uio_oe  = 0;


  // c element using latch

  wire a;
  wire b;
  wire c;


  wire set;
  wire clear;
  reg latchOut;

  assign set = a && b;
  assign clear = !a && !b;

  always_latch begin
    if (rst_n == 1'b0) begin
      latchOut = 1'b0;  // Reset latch to 0 else
    end else if (set) begin
      latchOut = 1'b1;
    end else if (clear) begin
      latchOut = 1'b0;
    end
  end

  assign c = latchOut;
  assign a = ui_in[0];  // Example input for a
  assign b = ui_in[1];  // Example input for b
  assign uio_out[0] = c;


  // List all unused inputs to prevent warnings
  wire _unused = &{ena, clk, rst_n, 1'b0};

endmodule
