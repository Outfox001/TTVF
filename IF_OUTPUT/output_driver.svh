// ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// Module name: output_driver
// HDL        : UVM
// Author     : Paulovici Vlad-Marian
// Description: UVM driver is an active entity that has knowledge on how to drive signals to a particular interface of the design.
//              Is the place where the protocols are realized to be tested.
// Date       : 28 August, 2023
// -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
class output_driver extends uvm_driver #(output_item, output_item);

  `uvm_component_utils(output_driver)
  function new(string name, uvm_component parent);
    super.new (name, parent);    
  endfunction //new()

  virtual output_interface vif_output;
  output_item output_data;

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(virtual output_interface) :: get ( this, "", "vif_output", vif_output)) begin
      `uvm_fatal (get_type_name (), "Didn't get handle to virtual interface")
  end
  endfunction

  virtual task run_phase(uvm_phase phase);
  endtask


endclass //req_ack_driver extends uvm_driver
