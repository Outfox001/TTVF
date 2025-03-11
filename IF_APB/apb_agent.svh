// ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// Module name: apb_agent
// HDL        : UVM
// Author     : Paulovici Vlad-Marian
// Description: An agent encapsulates a Sequencer, Driver and Monitor into a single entity by instantiating and connecting the components together via interfaces.
// Date       : 28 August, 2023
// -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
class apb_agent extends uvm_agent;

  `uvm_component_utils(apb_agent)
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction //new()

  afvip_apb_driver            drv0;
  output_monitor           mon0;
  afvip_apb_sequencer         seq0;

  virtual function void build_phase(uvm_phase phase);
    if(get_is_active())
      begin
        seq0 = afvip_apb_sequencer::type_id::create ("seq0", this);
        drv0 = afvip_apb_driver::type_id::create ("drv0", this);
      end
    mon0 = output_monitor::type_id::create ("mon0", this);
  endfunction

  virtual function void connect_phase (uvm_phase phase);
    if(get_is_active())
      drv0.seq_item_port.connect (seq0.seq_item_export);
  endfunction


endclass //req_ack_agent extends uvm_agent