// ---------------------------------------------------------------------------------------------------------------------
// Module name: output_coverage
// HDL        : UVM
// Author     : Paulovici Vlad-Marian
// Description: It is a user-defined metric that measures how much of the design specification that are captured in the test plan has been exercised.
// Date       : 28 August, 2023
// ---------------------------------------------------------------------------------------------------------------------
class output_coverage extends uvm_subscriber #(output_item);  // taken from monitor

  `uvm_component_utils(output_coverage)

  function new(string name="output_coverage",uvm_component parent);
    super.new(name,parent);
    cov_result =new();
  endfunction
  
  output_item item_result     ;
  real result_cov           ;
  
  // ________________ COVERGROUP FOR PSLVERR ______________________
  covergroup cov_result;
  RESULT: coverpoint item_result.result  {
    bins interval[10] = {['d0 : $]};
  }
  endgroup

  function void write(output_item t);
    item_result = t;
    cov_result.sample();
  endfunction

  // ________________ Extract Phase ______________________

  function void extract_phase(uvm_phase phase);
    super.extract_phase(phase);
    result_cov=cov_result.get_coverage();
  endfunction


  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info(get_type_name(),$sformatf("Output Interface : Coverage for result is %f",result_cov),UVM_MEDIUM)
  endfunction 

endclass : output_coverage