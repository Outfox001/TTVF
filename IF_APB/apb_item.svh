class  apb_item extends uvm_sequence_item;
  
  rand bit [31:0]     pwdata;
  rand bit [3:0]      delay_psel;
  rand bit [31:0]     prdata;
  rand bit [15:0]     paddr;
  rand bit            pwrite;

  `uvm_object_utils_begin(apb_item)
    `uvm_field_int (pwdata,          UVM_DEFAULT)
    `uvm_field_int (delay_psel,      UVM_DEFAULT)
    `uvm_field_int (paddr,           UVM_DEFAULT)
    `uvm_field_int (pwrite,          UVM_DEFAULT)
    `uvm_field_int (prdata ,         UVM_DEFAULT)
  `uvm_object_utils_end
                    
    constraint addr_max_c {pwdata[5:0]  < 16; }
    constraint opcode_min_c {pwdata[31:28]  > 0;  }
    constraint opcode_max_c {pwdata[31:28]  < 10;  }

  function new (string name = "apb_item");
    super.new(name);
  endfunction

endclass