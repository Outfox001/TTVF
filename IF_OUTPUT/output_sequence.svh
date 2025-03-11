// ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// Module name: output_sequence
// HDL        : UVM
// Author     : Paulovici Vlad-Marian
// Description: Provides one more pre-defined UVM approach which can be utilized to ease the 
//              implementation of creating a test sequence by combining multiple sequences.
// Date       : 28 August, 2023
// -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
class output_sequence extends uvm_sequence #(output_item, output_item);

    `uvm_object_utils(output_sequence)
    output_item item;
    function new (string name="output_sequence");
      super.new(name);    
      item = output_item::type_id::create("item");
    endfunction

    bit response_queue_error_report_disabled = 1;
    function void set_response_queue_error_report_disabled(bit value=1 );
    response_queue_error_report_disabled = value;
    endfunction

    function bit get_response_queue_error_report_disabled();
    return response_queue_error_report_disabled;
    endfunction
endclass : output_sequence
