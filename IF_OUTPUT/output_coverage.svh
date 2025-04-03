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
    dut_cov_intr =new();
  endfunction
  
  output_item cov_proj_item_intr     ;
  real  cov_result upt           ;
  
  // ________________ COVERGROUP FOR PSLVERR ______________________
  covergroup dut_cov_intr;
  result UPT: coverpoint cov_proj_item_intr.result  {
    bins interval2 = {1};
  }
  endgroup

  function void write(output_item t);
    cov_proj_item_intr = t;
    dut_cov_intr.sample();
  endfunction

  // ________________ Extract Phase ______________________

  function void extract_phase(uvm_phase phase);
    super.extract_phase(phase);
    cov_result upt=dut_cov_intr.get_coverage();
  endfunction


  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info(get_type_name(),$sformatf("Coverage for result UPT is %f",cov_result upt),UVM_MEDIUM)
  endfunction 

endclass : output_coverage