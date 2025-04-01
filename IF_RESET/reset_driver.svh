// ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// Module name: reset_driver
// HDL        : UVM
// Author     : Paulovici Vlad-Marian
// Description: UVM driver is an active entity that has knowledge on how to drive signals to a particular interface of the design.
//              Is the place where the protocols are realized to be tested.
// Date       : 28 August, 2023
// -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
class reset_driver extends uvm_driver #(reset_item);
  `uvm_component_utils(reset_driver)
  function new(string name, uvm_component parent);
    super.new (name, parent);    
  endfunction //new()

  virtual reset_interface vif_reset;
  reset_item data_project_reset;

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
      if(!uvm_config_db #(virtual reset_interface) :: get ( this, "", "vif_reset", vif_reset)) begin
        `uvm_fatal (get_type_name (), "Didn't get handle to virtual interface")
    end
  endfunction

  virtual task run_phase(uvm_phase phase);
  	forever begin 
    	seq_item_port.get_next_item(data_project_reset);
    	$display("%s" , data_project_reset.sprint());
      vif_reset.rst_n <= data_project_reset.rst_n;
	  vif_reset.state <= data_project_reset.state;
  	  seq_item_port.item_done();
      `uvm_info (get_type_name(), $sformatf ("Data was received in APB_DRIVER"), UVM_NONE)
  	end
  endtask
endclass //req_ack_driver extends uvm_driver
