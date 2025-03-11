// ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// Module name: output_item
// HDL        : UVM
// Author     : Paulovici Vlad-Marian
// Description: It consist of data fields required for generating the stimulus.In order to generate the stimulus, the sequence items are randomized in sequences.
// Date       : 28 August, 2023
// -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
class  output_item extends uvm_sequence_item;
  
  rand bit item;

  `uvm_object_utils_begin(output_item)
    `uvm_field_int (  item,     UVM_DEFAULT)
  `uvm_object_utils_end
                    
  function new (string name = "output_item");
    super.new(name);
  endfunction

endclass