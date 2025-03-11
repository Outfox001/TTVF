// -----------------------------------------------------------------------------
// Module name: rwa_field
// HDL        : System Verilog
// Author     : Nicolae Nicoara (NN)
// Description: Read-Write Autoreset register field
// Date       : 25 May, 2023
// -----------------------------------------------------------------------------
`timescale 1ns/1ps
module rwa_field #(
  parameter TP        = 1              , // Time Propagation
  parameter DWIDTH    = 32             , // Data Width
  parameter RST_VALUE = {DWIDTH{1'd0}}   // Reset Value
)(
// System and Control Interface
  input                   clk   , // Clock
  input                   rst_n , // Asynchronous Reset - Active low
  input                   en    , // Write enable
// Data
  input      [DWIDTH-1:0] d     , // Input data
  output reg [DWIDTH-1:0] q       // Output data
);

// -----------------------------------------------------------------------------
// ---------------------------------- CODE -------------------------------------
// -----------------------------------------------------------------------------

always_ff @(posedge clk or negedge rst_n)
if (~rst_n)         q <= #TP RST_VALUE; else // Reset
if (en)             q <= #TP d        ; else // Set
if (q != RST_VALUE) q <= #TP RST_VALUE;      // Reset if different than reset value

endmodule