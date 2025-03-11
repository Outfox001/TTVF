// ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// Module name: output_monitor
// HDL        : UVM
// Author     : Paulovici Vlad-Marian
// Description: Is responsible for capturing signal activity from the design interface and translate it into transaction level data objects that can be sent to other components.
// Date       : 28 August, 2023
// -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
class output_monitor extends uvm_monitor ;
  `uvm_component_utils (output_monitor)

//---------------------------------------------CONSTRUCTOR----------------------------------------------------------------------------------------------------------------------
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction //new()
 
//---------------------------------------------HANDLER--------------------------------------------------------------------------------------------------------------------------
	uvm_analysis_port #(output_item) mon_analysis_port;

//---------------------------------------------BUILD PHASE----------------------------------------------------------------------------------------------------------------------
  function void build_phase(uvm_phase phase);      
    super.build_phase (phase);
    mon_analysis_port = new ("mon_analysis_port", this);
      if(! uvm_config_db #(virtual output_interface) :: get (this , "", "vif_output", vif_output)) begin
        `uvm_error (get_type_name (), "Not found")
      end
    endfunction

//---------------------------------------------RUN PHASE------------------------------------------------------------------------------------------------------------------------
  task run_phase(uvm_phase phase);
  endtask

endclass 