// ---------------------------------------------------------------------------------------------------------------------
// Module name: output_monitor
// HDL        : UVM
// Author     : Paulovici Vlad-Marian
// Description: Is responsible for capturing signal activity from the design interface and translate it into transaction level data objects that can be sent to other components
// Date       : 28 August, 2023
// ---------------------------------------------------------------------------------------------------------------------
class output_monitor extends uvm_monitor ;

  `uvm_component_utils (output_monitor)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction //new()

  virtual output_interface vif_output;
  uvm_analysis_port #(output_item) mon_analysis_port_output;

  function void build_phase(uvm_phase phase);
    super.build_phase (phase);
    mon_analysis_port_output = new ("mon_analysis_port_output", this);
    if(! uvm_config_db #(virtual output_interface) :: get (this , "", "vif_output", vif_output)) begin
      `uvm_error (get_type_name (), "Not found")
    end
  endfunction

  task run_phase(uvm_phase phase);
    output_item data_mon_passive = output_item::type_id::create ("data_mon_passive", this);
    @(posedge vif_output.reset_n);
    forever begin
      @(posedge vif_output.cb_master_output);
      data_mon_passive.result  = vif_output.cb_master_output.result;
      mon_analysis_port_output.write(data_mon_passive);
    end
  endtask

endclass //req_ack_monitor extends uvm_monitor