// ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// Module name: reset_interface
// HDL        : UVM
// Author     : Paulovici Vlad-Marian
// Description: It is a way to encapsulate signals into a block. All related signals are grouped together to form an interface block so that the same interface.
// Date       : 28 August, 2023
// -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
interface reset_interface(
  input clk
  );

  import uvm_pkg::*;
  
  bit reset_n;
  bit state;
endinterface