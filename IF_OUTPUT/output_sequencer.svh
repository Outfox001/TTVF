// ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// Module name: output_sequencer
// HDL        : UVM
// Author     : Paulovici Vlad-Marian
// Description: Is a mediator who establishes a connection between sequence and driver. 
//              Ultimately, it passes transactions or sequence items to the driver so that they can be driven to the DUT.
// Date       : 28 August, 2023
// -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
class output_sequencer extends uvm_sequencer #(output_item, output_item);

  `uvm_component_utils(output_sequencer)
  bit response_queue_error_report_disabled =1;

  function new(string name, uvm_component parent);
    super.new (name, parent);
  endfunction //new()


  function void set_response_queue_error_report_disabled(bit value=1 );
    response_queue_error_report_disabled = value;
  endfunction

  function bit get_response_queue_error_report_disabled();
    return response_queue_error_report_disabled;
  endfunction

endclass 