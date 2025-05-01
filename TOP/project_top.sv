// ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// Module name: project_top
// HDL        : UVM
// Author     : Paulovici Vlad-Marian
// Description: All verification components, interfaces and DUT are instantiated in a top level module called testbench. 
//              It is a static container to hold everything required to be simulated and becomes the root node in the hierarchy.
// Date       : 28 August, 2023
// -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------


`timescale 1ns/1ps
module project_top();

  import uvm_pkg::*;
  import test_pkg::*;
  import apb_pkg::*;
  import reset_pkg::*;
  import output_pkg::*;
  import env_pkg::*;

bit clk;
bit reset_n;
reg pslverr;
reg penable;
reg psel;
reg [0:31] paddr;
reg [0:31] pwdata;
reg [0:31] prdata;
reg pwrite;
reg pready;
reg [0:8] result;
reg state;

  apb_interface intf_apb        ( .clk(clk),
                                  .reset_n(reset_n));

  output_interface intf_output  ( .clk(clk),
                                  .reset_n(reset_n));
  reset_interface intf_reset    (.clk(clk));


                                 

ALU_control #()alu_dut(
  .clk        (clk)       ,
  .reset_n    (reset_n)   ,
  .psel       (psel)      ,
  .penable    (penable)   ,
  .paddr      (paddr)     ,
  .pwrite     (pwrite)    ,
  .pwdata     (pwdata)    ,
  .state      (state)     ,
  .prdata     (prdata)    ,
  .pready     (pready)    ,
  .pslverr    (pslverr)   ,
  .result     (result)    );


initial begin
  forever
  #5 clk = ~clk; 
end


initial begin
  uvm_config_db#(virtual apb_interface)     :: set (uvm_root::get(), "*",     "vif_apb" ,     intf_apb );
  uvm_config_db#(virtual output_interface)  :: set (uvm_root::get(), "*.agent_output.*",  "vif_output" ,  intf_output );
  uvm_config_db#(virtual reset_interface)   :: set (uvm_root::get(), "*.agent_reset.*",   "vif_reset" ,   intf_reset );


// run_test("first_test");
// run_test("test_write_all_read_all");
// run_test("test_write_all_read_all_error");
// run_test("test_opcode_error_check_with_0000");
run_test("test_opcode_check_full");




end

assign intf_output.result           = result;           
assign intf_output.psel             = psel;           
assign intf_output.penable          = penable;           
assign intf_output.pwrite           = pwrite;           
assign intf_output.pready           = pready;           
assign reset_n                      = intf_reset.reset_n;
assign state                        = intf_reset.state;
assign intf_apb.prdata                 = prdata;
assign intf_apb.pready                 = pready;
assign intf_apb.pslverr                = pslverr;
assign pwrite                       = intf_apb.pwrite;
assign penable                      = intf_apb.penable;
assign psel                         = intf_apb.psel;
assign paddr                        = intf_apb.paddr;
assign pwdata                       = intf_apb.pwdata;

endmodule