//
// Module: main
// Description: This module serves as the top-level module for the design. It instantiates the read_image_hex module and provides the necessary signals for communication.
//
// Signals:
//   - HCLK: Clock signal for the design.
//   - HRESETn: Active-low reset signal for the design.
//   - HSYNC: Horizontal synchronization signal.
//   - VSYNC: Vertical synchronization signal.
//   - DATA_R0, DATA_G0, DATA_B0: Red, green, and blue data signals for pixel 0.
//   - DATA_R1, DATA_G1, DATA_B1: Red, green, and blue data signals for pixel 1.
//   - ctrl_done: Control signal indicating the completion of the read_image_hex module.
//
// Testbench:
//   - The testbench generates the clock signal (HCLK) and the reset signal (HRESETn) for the design.
//   - The clock signal alternates every 10 ns.
//   - The reset signal is asserted for 25 ns and then de-asserted.
//
// Dependencies:
//   - parameter.v: File containing parameter definitions.
//   - read_image_hex.v: File containing the read_image_hex module.
//
// Usage:
//   - Instantiate this module in your design hierarchy and connect the necessary signals.
//   - Ensure that the parameter file (parameter.v) and the read_image_hex module (read_image_hex.v) are included in the project.
`timescale 1ns/1ps

///////////////////////// Testbench //////////////////////////

`include "parameter.v"
`include "read_image_hex.v"

module main;

///////////////////////// Internal Signals //////////////////////////
reg HCLK, HRESETn;
wire HSYNC, VSYNC;
wire [7:0] DATA_R0, DATA_G0, DATA_B0, DATA_R1, DATA_G1, DATA_B1;
wire ctrl_done;

read_image_hex #(.INPUT_FILE(`INPUTFILENAME)) uut (
  .HCLK(HCLK),
  .HRESETn(HRESETn),
  .HSYNC(HSYNC),
  .VSYNC(VSYNC),
  .DATA_R0(DATA_R0),
  .DATA_G0(DATA_G0),
  .DATA_B0(DATA_B0),
  .DATA_R1(DATA_R1),
  .DATA_G1(DATA_G1),
  .DATA_B1(DATA_B1),
  .ctrl_done(ctrl_done)
);

///////////////////////// Test Vectors //////////////////////////
initial begin
  HCLK = 0;
  forever #10 HCLK = ~HCLK;
end

initial begin
  HRESETn = 0;
  #25 HRESETn = 1;
end
endmodule