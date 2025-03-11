// ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// Module name: afvip_apb_pkg
// HDL        : System Verilog
// Author     : Paulovici Vlad-Marian
// Description: Package for the apb protocol
// Date       : 28 August, 2023
// -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
package afvip_apb_pkg;

  import uvm_pkg::*;

  `include "uvm_macros.svh"
  `include "afvip_apb_item.svh"
  `include "afvip_apb_driver.svh"
  `include "output_monitor.svh"
  `include "afvip_apb_sequencer.svh"
  `include "afvip_apb_agent.svh"
  `include "afvip_apb_sequence.svh"
  // `include "afvip_apb_coverage.svh"
    
endpackage