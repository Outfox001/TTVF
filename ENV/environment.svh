// ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// Module name: environment
// HDL        : UVM
// Author     : Paulovici Vlad-Marian
// Description: UVM environment have multiple agents for different interfaces, a common scoreboard, a functional coverage collector
// Date       : 28 August, 2023
// -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
class environment extends uvm_env;

  `uvm_component_utils(environment)
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction 
  
  apb_agent               agent_apb;
  scoreboard              scoreboard_test;
  output_agent            agent_output;
  reset_agent             agent_reset;

  virtual function void build_phase(uvm_phase phase);
    super.build_phase (phase);
    agent_apb           =           apb_agent::type_id::create("agent_apb", this);       
    
    // uvm_config_db #(uvm_active_passive_enum)::set(this, "agent_passive", "is_active", UVM_PASSIVE);
    agent_output      =           output_agent::type_id::create("agent_output", this);
    agent_reset       =           reset_agent::type_id::create("agent_reset", this);
    scoreboard_test   =           scoreboard::type_id::create("scoreboard_test", this);
  endfunction

  virtual function void connect_phase (uvm_phase phase);
  super.connect_phase(phase);
    agent_apb.mon0.mon_analysis_port.connect (scoreboard_test.ap_imp_apb);
    agent_reset.mon_reset.mon_analysis_port_reset.connect (scoreboard_test.ap_imp_reset);
    agent_output.mon_passive.mon_analysis_port_passive.connect (scoreboard_test.ap_imp_output);
    // agent_apb.mon0.mon_analysis_port.connect (coverage.analysis_export);
    // agent_passive.mon_passive.mon_analysis_port_passive.connect (coverageintrr.analysis_export);
  endfunction
    
endclass 