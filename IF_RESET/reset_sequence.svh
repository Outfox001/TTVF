// ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// Module name: reset_sequence
// HDL        : UVM
// Author     : Paulovici Vlad-Marian
// Description: Provides one more pre-defined UVM approach which can be utilized to ease the 
//              implementation of creating a test sequence by combining multiple sequences.
// Date       : 28 August, 2023
// -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
class reset_sequence extends uvm_sequence;

  `uvm_object_utils(reset_sequence)

  function new(string name = "reset_sequence");
    super.new(name);
  endfunction //new()

  reset_item test1;
  
virtual task body();
    begin 
    test1 = reset_item::type_id::create("test1");

    start_item(test1);
      test1.state =0;
    finish_item(test1);
    #50
    start_item(test1);
      test1.state =1;
    finish_item(test1);
    #50
    start_item(test1);
      test1.reset_n =1;
    finish_item(test1);
    #50
    start_item(test1);
      test1.reset_n =0;
    finish_item(test1);
    #50
    start_item(test1);
      test1.reset_n =1;
    finish_item(test1);
    end
  endtask

endclass //master_seq extends uvm_sequence