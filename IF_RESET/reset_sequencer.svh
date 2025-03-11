// ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// Module name: reset_sequencer
// HDL        : UVM
// Author     : Paulovici Vlad-Marian
// Description: Is a mediator who establishes a connection between sequence and driver. 
//              Ultimately, it passes transactions or sequence items to the driver so that they can be driven to the DUT.
// Date       : 28 August, 2023
// -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
class reset_sequencer extends uvm_sequencer #(reset_item);

  `uvm_component_utils(reset_sequencer)

  function new(string name, uvm_component parent);
    super.new (name, parent);
  endfunction //new()

endclass //req_ack_seq extends uvm_sequencer