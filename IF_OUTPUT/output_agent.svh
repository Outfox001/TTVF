// ---------------------------------------------------------------------------------------------------------------------
// Module name: output_agent
// HDL        : UVM
// Author     : Paulovici Vlad-Marian
// Description: An agent encapsulates a Sequencer, Driver and Monitor into a single entity by instantiating and connecting the components together via interfaces.
// Date       : 28 August, 2023
// ---------------------------------------------------------------------------------------------------------------------
class output_agent extends uvm_agent;
  
  `uvm_component_utils(output_agent)
  
  function new(string name = "output_agent", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  output_monitor   mon_output;

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(get_is_active() == UVM_PASSIVE) begin
      mon_output = output_monitor::type_id::create("mon_output", this);
      `uvm_info(get_name(), "This is Passive agent", UVM_LOW);
    end
  endfunction
endclass