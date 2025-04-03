// ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// Module name: virtual_sequencer
// HDL        : UVM
// Author     : Paulovici Vlad-Marian
// Description: It generates data transactions as class objects and sends it to the driver for execution.
// Date       : 28 August, 2023
// -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
class virtual_sequencer extends uvm_sequencer;

  `uvm_component_utils(virtual_sequencer)
  apb_sequencer     seq_apb;
  reset_sequencer   seq_reset;
  
  function new( string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction : build_phase

endclass 