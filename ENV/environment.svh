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
  apb_coverage            coverage_apb;
  output_coverage         coverage_output;
  reset_coverage          coverage_reset;

  virtual function void build_phase(uvm_phase phase);
    super.build_phase (phase);
    agent_apb           =           apb_agent::type_id::create("agent_apb", this);       
    agent_reset         =           reset_agent::type_id::create("agent_reset", this);
    scoreboard_test     =           scoreboard::type_id::create("scoreboard_test", this);
    coverage_apb        =           apb_coverage::type_id::create("coverage_apb", this); 
    coverage_output     =           output_coverage::type_id::create("coverage_output", this); 
    coverage_reset      =           reset_coverage::type_id::create("coverage_reset", this); 
    uvm_config_db #(uvm_active_passive_enum)::set(this, "agent_output", "is_active", UVM_PASSIVE);
    agent_output        =           output_agent::type_id::create("agent_output", this);
  endfunction

  virtual function void connect_phase (uvm_phase phase);
  super.connect_phase(phase);
    agent_apb.mon_apb.mon_analysis_port_apb.connect (scoreboard_test.ap_imp_apb);
    agent_reset.mon_reset.mon_analysis_port_reset.connect (scoreboard_test.ap_imp_reset);
    agent_output.mon_output.mon_analysis_port_output.connect (scoreboard_test.ap_imp_output);
    agent_apb.mon_apb.mon_analysis_port_apb.connect (coverage_apb.analysis_export);
    agent_output.mon_output.mon_analysis_port_output.connect (coverage_output.analysis_export);
    agent_reset.mon_reset.mon_analysis_port_reset.connect (coverage_reset.analysis_export);
  endfunction
    
endclass 