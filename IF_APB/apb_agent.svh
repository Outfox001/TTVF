class apb_agent extends uvm_agent;

  `uvm_component_utils(apb_agent)
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction //new()

  apb_driver            drv_apb;
  apb_monitor           mon_apb;
  apb_sequencer         seq_apb;

  virtual function void build_phase(uvm_phase phase);
   if(get_is_active())
      begin
        seq_apb = apb_sequencer::type_id::create ("seq_apb", this);
        drv_apb = apb_driver::type_id::create ("drv_apb", this);
      end
    mon_apb = apb_monitor::type_id::create ("mon_apb", this);
  endfunction

  virtual function void connect_phase (uvm_phase phase);
   if(get_is_active())
      drv_apb.seq_item_port.connect (seq_apb.seq_item_export);
  endfunction


endclass //req_ack_agent extends uvm_agent