// ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// Module name: reset_item
// HDL        : UVM
// Author     : Paulovici Vlad-Marian
// Description: It consist of data fields required for generating the stimulus.In order to generate the stimulus, the sequence items are randomized in sequences.
// Date       : 28 August, 2023
// -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
class reset_item extends uvm_sequence_item;

  bit hw_rst;
  bit sw_rst;
  bit state;
  `uvm_object_utils_begin(reset_item)
    `uvm_field_int (hw_rst,      UVM_DEFAULT)
    `uvm_field_int (sw_rst,      UVM_DEFAULT)
    `uvm_field_int (state,       UVM_DEFAULT)
  `uvm_object_utils_end
                     
  function new (string name = "reset_item");
    super.new(name);
  endfunction
endclass