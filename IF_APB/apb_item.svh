
class  afvip_apb_item extends uvm_sequence_item;
  
  rand bit [31:0]     pwdata;
  rand bit [3:0]      delay_psel;
  rand bit [31:0]     prdata;
  rand bit [15:0]     paddr;
  rand bit            pwrite;

  `uvm_object_utils_begin(afvip_apb_item)
    `uvm_field_int (pwdata,          UVM_DEFAULT)
    `uvm_field_int (delay_psel,      UVM_DEFAULT)
    `uvm_field_int (paddr,           UVM_DEFAULT)
    `uvm_field_int (pwrite,          UVM_DEFAULT)
    `uvm_field_int (prdata ,         UVM_DEFAULT)
  `uvm_object_utils_end
                    
  function new (string name = "afvip_apb_item");
    super.new(name);
  endfunction

endclass