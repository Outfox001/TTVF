// ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// Module name: output_agent
// HDL        : UVM
// Author     : Paulovici Vlad-Marian
// Description: An agent encapsulates a Sequencer, Driver and Monitor into a single entity by instantiating and connecting the components together via interfaces.
// Date       : 28 August, 2023
// -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
class output_agent extends uvm_agent;

  `uvm_component_utils(output_agent)
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction //new()

  output_driver            drv_output;
  output_monitor           mon_output;
  output_sequencer         seq_output;

  virtual function void build_phase(uvm_phase phase);
    if(get_is_active())
      begin
        seq_output = output_sequencer::type_id::create ("seq_output", this);
        drv_output = output_driver::type_id::create ("drv_output", this);
      end
    mon_output = output_monitor::type_id::create ("mon_output", this);
  endfunction

  virtual function void connect_phase (uvm_phase phase);
    if(get_is_active())
      drv_output.seq_item_port.connect (seq_output.seq_item_export);
  endfunction


endclass //req_ack_agent extends uvm_agent