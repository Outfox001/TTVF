class apb_sequencer extends uvm_sequencer #(apb_item, apb_item);

  `uvm_component_utils(apb_sequencer)
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