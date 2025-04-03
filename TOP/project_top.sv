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
reg reset_n;
reg pslverr;
reg penable;
reg psel;
reg [0:15] paddr;
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
  .pready     (pready)    ,
  .prdata     (prdata)    ,
  .pslverr    (pslverr)   ,
  .result     (result)    ,
  .state      (state)     );


initial begin
  forever
  #5 clk = ~clk; 
end

initial begin
  uvm_config_db#(virtual apb_interface)     :: set (uvm_root::get(), "*.agent_apb.*",     "vif_apb" ,     intf_apb );
  uvm_config_db#(virtual output_interface)  :: set (uvm_root::get(), "*.agent_output.*",  "vif_output" ,  intf_output );
  uvm_config_db#(virtual reset_interface)   :: set (uvm_root::get(), "*.agent_reset.*",   "vif_reset" ,   intf_reset );


run_test("afvip_test_register_write_all_with_1");
//run_test("afvip_test_register_write_all_with_F");
//run_test("afvip_test_register_write_all_with_random");
//run_test("afvip_test_overflow");
//run_test("afvip_test_reset_all");
//run_test("afvip_test_reset_half");
//run_test("afvip_test_opcode_functionally");
//run_test("afvip_test_error_opcode");
//run_test("afvip_test_read_all_without_write");
//run_test("afvip_test_read_all_write_all");
//run_test("afvip_test_write_one_read_all");
//run_test("afvip_test_read_1_after_every_register_write");
//run_test("afvip_test_data_same_destionation");
//run_test("afvip_test_write_read_addres");
//run_test("afvip_test_addres_error");
//run_test("afvip_test_back_to_back_tranzaction");
//run_test("afvip_test_delay_tranzaction");
//run_test("afvip_test_instruction_register_field_0");
//run_test("afvip_test_instruction_register_field_with_not0");
//run_test("afvip_test_instruction_data_fields_random");
//run_test("afvip_test_instruction_data_fields_read");
//run_test("afvip_test_write_read_all_addres");
//run_test("afvip_test_write_shift_by_1");
//run_test("afvip_test_write_shift_by_0");

//run_test("afvip_test_opcode_urandom");
//run_test("afvip_full_test_without_error");
//run_test("afvip_full_test_with_error");





end

endmodule