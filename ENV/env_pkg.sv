// ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// Module name: env_pkg
// HDL        : UVM
// Author     : Paulovici Vlad-Marian
// Description: Package for the enviroment and scoreboard
// Date       : 28 August, 2023
// -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
package env_pkg;

  import uvm_pkg::*;
  import apb_pkg::*;
  import reset_pkg::*;
  import output_pkg::*;
  
  `include "uvm_macros.svh"
  `include "scoreboard.svh"
  `include "environment.svh"
  `include "virtual_sequencer.svh"
    
endpackage