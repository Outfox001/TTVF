// ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// Module name: output_pkg
// HDL        : System Verilog
// Author     : Paulovici Vlad-Marian
// Description: Package for the apb protocol
// Date       : 28 August, 2023
// -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
package output_pkg;

  import uvm_pkg::*;

  `include "uvm_macros.svh"
  `include "output_item.svh"
  `include "output_driver.svh"
  `include "output_monitor.svh"
  `include "output_sequencer.svh"
  `include "output_agent.svh"
  `include "output_sequence.svh"
  // `include "output_coverage.svh"
    
endpackage