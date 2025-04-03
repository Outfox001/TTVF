// ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// Module name: output_interface
// HDL        : UVM
// Author     : Paulovici Vlad-Marian
// Description: It is a way to encapsulate signals into a block. All related signals are grouped together to form an interface block so that the same interface.
// Date       : 28 August, 2023
// -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
interface output_interface(
  input clk,
  input reset_n
  );

  import uvm_pkg::*;
  wire     [8:0]         result   ;

  clocking cb_master_output @(posedge clk);
  input result;
  endclocking

endinterface