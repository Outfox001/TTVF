// ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// Module name: test_lib
// HDL        : UVM
// Author     : Paulovici Vlad-Marian
// Description: It is a pattern to check and verify specific features and functionalities of a design. 
//              A verification plan lists all the features and other functional items that needs to be verified, and the tests neeeded to cover each of them.
// Date       : 28 August, 2023
// -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
class test_lib extends uvm_test;

  `uvm_component_utils(test_lib)
  function new( string name = "test_lib", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  environment env;

  virtual function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    env = environment::type_id::create("env", this);  
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  endfunction : connect_phase
 
  virtual function void end_of_elaboration_phase(uvm_phase phase);
    uvm_top.print_topology();
  endfunction
endclass : test_lib


class afvip_test_write_all_read_all extends test_lib;

  `uvm_component_utils(afvip_test_write_all_read_all)
  function new( string name = "afvip_test_write_all_read_all", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase (uvm_phase phase);

    apb_write_all_sequence apb_write_all_sequence   = apb_write_all_sequence::type_id::create("item");
    apb_read_all_sequence apb_read_all_sequence     = apb_read_all_sequence::type_id::create("item"); // vezi numele din paranteze
    reset_sequence reset_sequence   = reset_sequence::type_id::create("item_rst");

    phase.raise_objection(this);

    reset_sequence.start(env.agent_reset.seq_reset);
    apb_write_all_sequence.start(env.agent_apb.seq_apb);
    apb_read_all_sequence.start(env.agent_apb.seq_apb);
  
    `uvm_info(get_type_name(),$sformatf ("To be continued...."), UVM_NONE)
    $display("afvip_test_write_all_read_all TEST: Completed");
    phase.drop_objection (this);

  endtask
endclass : afvip_test_write_all_read_all


class afvip_test_write_all_read_one extends test_lib;

  `uvm_component_utils(afvip_test_write_all_read_one)

  function new( string name = "afvip_test_write_all_read_one", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase (uvm_phase phase);

    apb_write_all_sequence apb_write_all_sequence = apb_write_all_sequence::type_id::create("item");
    apb_read_random_sequence apb_read_random_sequence = apb_read_random_sequence::type_id::create("item"); // vezi numele din paranteze
    reset_sequence reset_sequence = reset_sequence::type_id::create("item_rst");

    phase.raise_objection(this);

    reset_sequence.start(env.agent_reset.seq_reset);
    apb_write_all_sequence.start(env.agent_apb.seq_apb);
    apb_read_random_sequence.start(env.agent_apb.seq_apb);
  
    `uvm_info(get_type_name(),$sformatf ("To be continued...."), UVM_NONE)
    $display("test....");
    phase.drop_objection (this);

  endtask
endclass : afvip_test_write_all_read_one


class afvip_test_back2back extends test_lib;

  `uvm_component_utils(afvip_test_back2back)
  function new( string name = "afvip_test_back2back", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase (uvm_phase phase);

    reset_sequence reset_sequence = reset_sequence::type_id::create("item_rst");
    back2back_sequence back2back_sequence = back2back_sequence::type_id::create("item");
    phase.raise_objection(this);

    reset_sequence.start(env.agent_reset.seq_reset);
    back2back_sequence.start(env.agent_apb.seq_apb);

    `uvm_info(get_type_name(),$sformatf ("To be continued...."), UVM_NONE)
    $display("test....");
    phase.drop_objection (this);

  endtask
endclass : afvip_test_back2back


class afvip_test_register_write_all_with_1 extends test_lib;

  `uvm_component_utils(afvip_test_register_write_all_with_1)

  function new( string name = "afvip_test_register_write_all_with_1", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase (uvm_phase phase);

    apb_write_all_with_1_sequence apb_write_all_with_1_sequence = apb_write_all_with_1_sequence::type_id::create("item");
    apb_read_all_sequence apb_read_all_sequence = apb_read_all_sequence::type_id::create("item");
    reset_sequence reset_sequence = reset_sequence::type_id::create("item_rst");
    phase.raise_objection(this);

    reset_sequence.start(env.agent_reset.seq_reset);
    apb_write_all_with_1_sequence.start(env.agent_apb.seq_apb);        
    apb_read_all_sequence.start(env.agent_apb.seq_apb);

    $display("TEST : afvip_test_register_write_all_with_1");
    $display("SUCCES");
    phase.drop_objection (this);

  endtask
endclass : afvip_test_register_write_all_with_1


class afvip_test_register_write_all_with_F extends test_lib;

  `uvm_component_utils(afvip_test_register_write_all_with_F)

  function new( string name = "afvip_test_register_write_all_with_F", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase (uvm_phase phase);
      
    apb_write_all_with_F_sequence apb_write_all_with_F_sequence = apb_write_all_with_F_sequence::type_id::create("item");
    apb_read_all_sequence apb_read_all_sequence = apb_read_all_sequence::type_id::create("item");
    reset_sequence reset_sequence = reset_sequence::type_id::create("item_rst");
    phase.raise_objection(this);

    reset_sequence.start(env.agent_reset.seq_reset);
    apb_write_all_with_F_sequence.start(env.agent_apb.seq_apb);        
    apb_read_all_sequence.start(env.agent_apb.seq_apb);

    $display("TEST : afvip_test_register_write_all_with_F");
    $display("SUCCES");
    phase.drop_objection (this);

  endtask
endclass : afvip_test_register_write_all_with_F


class afvip_test_register_write_all_with_random extends test_lib;

  `uvm_component_utils(afvip_test_register_write_all_with_random)

  function new( string name = "afvip_test_register_write_all_with_random", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase (uvm_phase phase);

    apb_write_all_with_random_sequence apb_write_all_with_random_sequence       = apb_write_all_with_random_sequence::type_id::create("item");
    apb_read_all_sequence apb_read_all_sequence                                 = apb_read_all_sequence::type_id::create("item");
    reset_sequence reset_sequence                                   = reset_sequence::type_id::create("item_rst");
    phase.raise_objection(this);

    reset_sequence.start(env.agent_reset.seq_reset);
    apb_write_all_with_random_sequence.start(env.agent_apb.seq_apb);        
    apb_read_all_sequence.start(env.agent_apb.seq_apb);

    $display("TEST : afvip_test_register_write_all_with_random");
    $display("SUCCES");
    phase.drop_objection (this);

  endtask
endclass : afvip_test_register_write_all_with_random


class afvip_test_overflow extends test_lib;

  `uvm_component_utils(afvip_test_overflow)

  function new( string name = "afvip_test_overflow", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase (uvm_phase phase);

    apb_write_random_sequence apb_write_random_sequence                           = apb_write_random_sequence::type_id::create("item");
    apb_write_all_with_curent_x2_sequence apb_write_all_with_curent_x2_sequence   = apb_write_all_with_curent_x2_sequence::type_id::create("item");
    apb_read_all_sequence apb_read_all_sequence                                   = apb_read_all_sequence::type_id::create("item");
    reset_sequence reset_sequence                                     = reset_sequence::type_id::create("item_rst");
    phase.raise_objection(this);

    reset_sequence.start(env.agent_reset.seq_reset);
    apb_write_all_with_curent_x2_sequence.start(env.agent_apb.seq_apb);        
    apb_read_all_sequence.start(env.agent_apb.seq_apb);

    $display("TEST : afvip_test_overflow");
    $display("SUCCES");
    phase.drop_objection (this);

  endtask
endclass : afvip_test_overflow


class afvip_test_reset_all extends test_lib;

  `uvm_component_utils(afvip_test_reset_all)
  function new( string name = "afvip_test_reset_all", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase (uvm_phase phase);

    apb_write_all_sequence apb_write_all_sequence                                         = apb_write_all_sequence::type_id::create("item");
    apb_read_all_sequence apb_read_all_sequence                                           = apb_read_all_sequence::type_id::create("item");
    reset_sequence reset_sequence                                             = reset_sequence::type_id::create("item_rst");
    phase.raise_objection(this);

    reset_sequence.start(env.agent_reset.seq_reset);
    apb_write_all_sequence.start(env.agent_apb.seq_apb);    
    apb_read_all_sequence.start(env.agent_apb.seq_apb);
    reset_sequence.start(env.agent_reset.seq_reset);    
    apb_read_all_sequence.start(env.agent_apb.seq_apb);

    $display("TEST : afvip_test_reset_all");
    $display("SUCCES");
    phase.drop_objection (this);

  endtask
endclass : afvip_test_reset_all


class afvip_test_reset_half extends test_lib;

  `uvm_component_utils(afvip_test_reset_half)

  function new( string name = "afvip_test_reset_half", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase (uvm_phase phase);

    apb_write_all_half_superior_sequence apb_write_all_half_superior_sequence             = apb_write_all_half_superior_sequence::type_id::create("item");
    apb_write_all_half_inferior_sequence apb_write_all_half_inferior_sequence             = apb_write_all_half_inferior_sequence::type_id::create("item");
    apb_read_all_sequence apb_read_all_sequence                                           = apb_read_all_sequence::type_id::create("item");
    reset_sequence reset_sequence                                             = reset_sequence::type_id::create("item_rst");
    phase.raise_objection(this);

    reset_sequence.start(env.agent_reset.seq_reset);
    apb_write_all_half_superior_sequence.start(env.agent_apb.seq_apb);    
    reset_sequence.start(env.agent_reset.seq_reset);    
    apb_write_all_half_inferior_sequence.start(env.agent_apb.seq_apb);  
    apb_read_all_sequence.start(env.agent_apb.seq_apb);

    $display("TEST : afvip_test_reset_half");
    $display("SUCCES");
    phase.drop_objection (this);

  endtask
endclass : afvip_test_reset_half


class afvip_test_opcode_functionally extends test_lib;

  `uvm_component_utils(afvip_test_opcode_functionally)
  function new( string name = "afvip_test_opcode_functionally", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase (uvm_phase phase);

    reset_sequence reset_sequence           = reset_sequence::type_id::create("item_rst");
    apb_write_all_sequence apb_write_all_sequence       = apb_write_all_sequence::type_id::create("item");
    opcode_sequence_0 opcode_sequence_0                 = opcode_sequence_0::type_id::create("item");
    opcode_sequence_1 opcode_sequence_1                 = opcode_sequence_1::type_id::create("item");
    opcode_sequence_2 opcode_sequence_2                 = opcode_sequence_2::type_id::create("item");
    opcode_sequence_3 opcode_sequence_3                 = opcode_sequence_3::type_id::create("item");
    opcode_sequence_4 opcode_sequence_4                 = opcode_sequence_4::type_id::create("item");
    reg_h84_sequence reg_h84_sequence                   = reg_h84_sequence::type_id::create("item");
    reg_h88_sequence reg_h88_sequence                   = reg_h88_sequence::type_id::create("item");
    reg_h8c_sequence reg_h8c_sequence                   = reg_h8c_sequence::type_id::create("item");
    apb_read_choose_sequence apb_read_choose_sequence   = apb_read_choose_sequence::type_id::create("item");
    apb_read_all_sequence apb_read_all_sequence         = apb_read_all_sequence::type_id::create("item");

    phase.raise_objection(this);

    reset_sequence.start(env.agent_reset.seq_reset);
    apb_write_all_sequence.start(env.agent_apb.seq_apb);
    opcode_sequence_0.start(env.agent_apb.seq_apb);
    reg_h8c_sequence.start(env.agent_apb.seq_apb);
    reg_h84_sequence.start(env.agent_apb.seq_apb);
    assert(reg_h88_sequence.randomize() with { pwdata_error == reg_h84_sequence.clr_error; });
    reg_h88_sequence.start(env.agent_apb.seq_apb);
    opcode_sequence_1.start(env.agent_apb.seq_apb);
    reg_h8c_sequence.start(env.agent_apb.seq_apb);
    reg_h84_sequence.start(env.agent_apb.seq_apb);
    assert(reg_h88_sequence.randomize() with { pwdata_error == reg_h84_sequence.clr_error; });
    reg_h88_sequence.start(env.agent_apb.seq_apb);
    opcode_sequence_2.start(env.agent_apb.seq_apb);
    reg_h8c_sequence.start(env.agent_apb.seq_apb);
    reg_h84_sequence.start(env.agent_apb.seq_apb);
    assert(reg_h88_sequence.randomize() with { pwdata_error == reg_h84_sequence.clr_error; });
    reg_h88_sequence.start(env.agent_apb.seq_apb);
    opcode_sequence_3.start(env.agent_apb.seq_apb);
    reg_h8c_sequence.start(env.agent_apb.seq_apb);
    reg_h84_sequence.start(env.agent_apb.seq_apb);
    assert(reg_h88_sequence.randomize() with { pwdata_error == reg_h84_sequence.clr_error; });
    reg_h88_sequence.start(env.agent_apb.seq_apb);
    opcode_sequence_4.start(env.agent_apb.seq_apb);
    reg_h8c_sequence.start(env.agent_apb.seq_apb);
    reg_h84_sequence.start(env.agent_apb.seq_apb);
    assert(reg_h88_sequence.randomize() with { pwdata_error == reg_h84_sequence.clr_error; });
    reg_h88_sequence.start(env.agent_apb.seq_apb);
    apb_read_all_sequence.start(env.agent_apb.seq_apb);
    
    `uvm_info(get_type_name(),$sformatf ("To be continued...."), UVM_NONE)
    $display("Test afvip_test_opcode_functionally COMPLETE");
    phase.drop_objection (this);

  endtask
endclass : afvip_test_opcode_functionally


class afvip_test_error_opcode extends test_lib;

  `uvm_component_utils(afvip_test_error_opcode)
  function new( string name = "afvip_test_error_opcode", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase (uvm_phase phase);

    reset_sequence reset_sequence           = reset_sequence::type_id::create("item_rst");
    apb_write_all_sequence apb_write_all_sequence       = apb_write_all_sequence::type_id::create("item");
    opcode_sequence_5_to_7 opcode_sequence_5_to_7       = opcode_sequence_5_to_7::type_id::create("item");
    reg_h84_sequence reg_h84_sequence                   = reg_h84_sequence::type_id::create("item");
    reg_h88_sequence reg_h88_sequence                   = reg_h88_sequence::type_id::create("item");
    reg_h8c_sequence reg_h8c_sequence                   = reg_h8c_sequence::type_id::create("item");
    apb_read_all_sequence apb_read_all_sequence         = apb_read_all_sequence::type_id::create("item");

    phase.raise_objection(this);

    reset_sequence.start(env.agent_reset.seq_reset);
    apb_write_all_sequence.start(env.agent_apb.seq_apb);
    opcode_sequence_5_to_7.start(env.agent_apb.seq_apb);
    reg_h8c_sequence.start(env.agent_apb.seq_apb);
    reg_h84_sequence.start(env.agent_apb.seq_apb);
    assert(reg_h88_sequence.randomize() with { pwdata_error == reg_h84_sequence.clr_error; });
    reg_h88_sequence.start(env.agent_apb.seq_apb);
    apb_read_all_sequence.start(env.agent_apb.seq_apb);
    
    `uvm_info(get_type_name(),$sformatf ("To be continued...."), UVM_NONE)
    $display("Test afvip_test_error_opcode COMPLETE");
    phase.drop_objection (this);

  endtask
endclass : afvip_test_error_opcode


class afvip_test_read_all_without_write extends test_lib;

  `uvm_component_utils(afvip_test_read_all_without_write)
  function new( string name = "afvip_test_read_all_without_write", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase (uvm_phase phase);

    apb_read_all_sequence apb_read_all_sequence           = apb_read_all_sequence::type_id::create("item");
    reset_sequence reset_sequence             = reset_sequence::type_id::create("item_rst");
    phase.raise_objection(this);

    reset_sequence.start(env.agent_reset.seq_reset);
    apb_read_all_sequence.start(env.agent_apb.seq_apb);

    `uvm_info(get_type_name(),$sformatf ("To be continued...."), UVM_NONE)
    $display("Test afvip_test_read_all_without_write COMPLETE");
    phase.drop_objection (this);

  endtask
endclass : afvip_test_read_all_without_write


class afvip_test_read_all_write_all extends test_lib;

  `uvm_component_utils(afvip_test_read_all_write_all)
  function new( string name = "afvip_test_read_all_write_all", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase (uvm_phase phase);

    apb_write_all_sequence apb_write_all_sequence                             = apb_write_all_sequence::type_id::create("item");
    apb_write_all_without_one_sequence apb_write_all_without_one_sequence     = apb_write_all_without_one_sequence::type_id::create("item");
    apb_read_all_sequence apb_read_all_sequence                               = apb_read_all_sequence::type_id::create("item");
    reset_sequence reset_sequence                                 = reset_sequence::type_id::create("item_rst");
    phase.raise_objection(this);
    
    reset_sequence.start(env.agent_reset.seq_reset);
    apb_read_all_sequence.start(env.agent_apb.seq_apb);
    apb_read_all_sequence.start(env.agent_apb.seq_apb);
    apb_write_all_without_one_sequence.start(env.agent_apb.seq_apb);        
    apb_read_all_sequence.start(env.agent_apb.seq_apb);

    `uvm_info(get_type_name(),$sformatf ("To be continued...."), UVM_NONE)
    $display("TEST : afvip_test_read_all_write_all");
    phase.drop_objection (this);

  endtask
endclass : afvip_test_read_all_write_all


class afvip_test_write_one_read_all extends test_lib;

  `uvm_component_utils(afvip_test_write_one_read_all)
  function new( string name = "afvip_test_write_one_read_all", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase (uvm_phase phase);

    apb_write_all_sequence apb_write_all_sequence                             = apb_write_all_sequence::type_id::create("item");
    apb_write_one_h40_sequence apb_write_one_h40_sequence                     = apb_write_one_h40_sequence::type_id::create("item");
    apb_read_all_sequence apb_read_all_sequence                               = apb_read_all_sequence::type_id::create("item");
    reset_sequence reset_sequence                                 = reset_sequence::type_id::create("item_rst");
    phase.raise_objection(this);
    
    reset_sequence.start(env.agent_reset.seq_reset);
    apb_write_one_h40_sequence.start(env.agent_apb.seq_apb);
    apb_read_all_sequence.start(env.agent_apb.seq_apb);

    `uvm_info(get_type_name(),$sformatf ("To be continued...."), UVM_NONE)
    $display("TEST : afvip_test_write_one_read_all");
    phase.drop_objection (this);

  endtask
endclass : afvip_test_write_one_read_all


class afvip_test_read_1_after_every_register_write extends test_lib;

  `uvm_component_utils(afvip_test_read_1_after_every_register_write)
  function new( string name = "afvip_test_read_1_after_every_register_write", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase (uvm_phase phase);

    apb_read_1_write_1_sequence apb_read_1_write_1_sequence                   = apb_read_1_write_1_sequence::type_id::create("item");
    reset_sequence reset_sequence                                 = reset_sequence::type_id::create("item_rst");
    phase.raise_objection(this);
    
    reset_sequence.start(env.agent_reset.seq_reset);
    apb_read_1_write_1_sequence.start(env.agent_apb.seq_apb);

    `uvm_info(get_type_name(),$sformatf ("To be continued...."), UVM_NONE)
    $display("TEST : afvip_test_read_1_after_every_register_write");
    phase.drop_objection (this);

  endtask
endclass : afvip_test_read_1_after_every_register_write


class afvip_test_data_same_destionation extends test_lib;

  `uvm_component_utils(afvip_test_data_same_destionation)
  function new( string name = "afvip_test_write_every_register_read_1_random_register", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase (uvm_phase phase);

    reg_test_same_destination reg_test_same_destination = reg_test_same_destination::type_id::create("item");
    reset_sequence reset_sequence = reset_sequence::type_id::create("item_rst");
    phase.raise_objection(this);

    reset_sequence.start(env.agent_reset.seq_reset);
    reg_test_same_destination.start(env.agent_apb.seq_apb);

    `uvm_info(get_type_name(),$sformatf ("To be continued...."), UVM_NONE)
    $display("TEST COMPLETE : afvip_test_data_same_destionation");
    phase.drop_objection (this);
  endtask
endclass : afvip_test_data_same_destionation


class afvip_test_write_read_addres extends test_lib;

  `uvm_component_utils(afvip_test_write_read_addres)
  function new( string name = "afvip_test_write_read_addres", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase (uvm_phase phase);
      
    reg_write_read_address reg_write_read_address               = reg_write_read_address::type_id::create("item");
    reset_sequence reset_sequence                   = reset_sequence::type_id::create("item_rst");
    phase.raise_objection(this);

    reset_sequence.start(env.agent_reset.seq_reset);
    reg_write_read_address.start(env.agent_apb.seq_apb);

    `uvm_info(get_type_name(),$sformatf ("To be continued...."), UVM_NONE)
    $display("TEST COMPLETE : afvip_test_write_read_addres");
    phase.drop_objection (this);

  endtask
endclass : afvip_test_write_read_addres


class afvip_test_addres_error extends test_lib;

  `uvm_component_utils(afvip_test_addres_error)
  function new( string name = "afvip_test_addres_error", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase (uvm_phase phase);
      
    reg_error_addres reg_error_addres                     = reg_error_addres::type_id::create("item");
    reset_sequence reset_sequence             = reset_sequence::type_id::create("item_rst");
    phase.raise_objection(this);

    reset_sequence.start(env.agent_reset.seq_reset);
    reg_error_addres.start(env.agent_apb.seq_apb);

    `uvm_info(get_type_name(),$sformatf ("To be continued...."), UVM_NONE)
    $display("TEST COMPLETE : afvip_test_addres_error");
    phase.drop_objection (this);

  endtask
endclass : afvip_test_addres_error


class afvip_test_back_to_back_tranzaction extends test_lib;

  `uvm_component_utils(afvip_test_back_to_back_tranzaction)

  function new( string name = "afvip_test_back_to_back_tranzaction", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase (uvm_phase phase);
      
    reg_b2bseq reg_b2bseq = reg_b2bseq::type_id::create("item");
    reset_sequence reset_sequence = reset_sequence::type_id::create("item_rst");
    phase.raise_objection(this);

    reset_sequence.start(env.agent_reset.seq_reset);
    reg_b2bseq.start(env.agent_apb.seq_apb);

    `uvm_info(get_type_name(),$sformatf ("To be continued...."), UVM_NONE)
    $display("TEST COMPLETE : afvip_test_back_to_back_tranzaction");
    phase.drop_objection (this);

  endtask
endclass : afvip_test_back_to_back_tranzaction


class afvip_test_delay_tranzaction extends test_lib;

  `uvm_component_utils(afvip_test_delay_tranzaction)

  function new( string name = "afvip_test_delay_tranzaction", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase (uvm_phase phase);
      
    reg_fix_delay reg_fix_delay                         = reg_fix_delay::type_id::create("item");
    reset_sequence reset_sequence           = reset_sequence::type_id::create("item_rst");
    phase.raise_objection(this);

    reset_sequence.start(env.agent_reset.seq_reset);
    reg_fix_delay.start(env.agent_apb.seq_apb);

    `uvm_info(get_type_name(),$sformatf ("To be continued...."), UVM_NONE)
    $display("TEST COMPLETE : afvip_test_delay_tranzaction");
    phase.drop_objection (this);

  endtask
endclass : afvip_test_delay_tranzaction


class afvip_test_instruction_register_field_0 extends test_lib;

  `uvm_component_utils(afvip_test_instruction_register_field_0)
  function new( string name = "afvip_test_instruction_register_field_0", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase (uvm_phase phase);

    apb_write_all_sequence apb_write_all_sequence               = apb_write_all_sequence::type_id::create("item");
    apb_read_all_sequence apb_read_all_sequence                 = apb_read_all_sequence::type_id::create("item");
    sequence_field_with_0 sequence_field_with_0                 = sequence_field_with_0::type_id::create("item");
    reset_sequence reset_sequence                   = reset_sequence::type_id::create("item_rst");
    phase.raise_objection(this);

    reset_sequence.start(env.agent_reset.seq_reset);
    apb_write_all_sequence.start(env.agent_apb.seq_apb);
    sequence_field_with_0.start(env.agent_apb.seq_apb);
    apb_read_all_sequence.start(env.agent_apb.seq_apb);

   `uvm_info(get_type_name(),$sformatf ("To be continued...."), UVM_NONE)
    $display("TEST COMPLETE : afvip_test_instruction_register_field_0");
    phase.drop_objection (this);

  endtask
endclass : afvip_test_instruction_register_field_0


class afvip_test_instruction_register_field_with_not0 extends test_lib;

  `uvm_component_utils(afvip_test_instruction_register_field_with_not0)

  function new( string name = "afvip_test_instruction_register_field_with_not0", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase (uvm_phase phase);

    apb_write_all_sequence apb_write_all_sequence                   = apb_write_all_sequence::type_id::create("item");
    apb_read_all_sequence apb_read_all_sequence                     = apb_read_all_sequence::type_id::create("item");
    sequence_field_with_1 sequence_field_with_1                     = sequence_field_with_1::type_id::create("item");
    reset_sequence reset_sequence                       = reset_sequence::type_id::create("item_rst");
    phase.raise_objection(this);

    reset_sequence.start(env.agent_reset.seq_reset);
    apb_write_all_sequence.start(env.agent_apb.seq_apb);
    sequence_field_with_1.start(env.agent_apb.seq_apb);
    apb_read_all_sequence.start(env.agent_apb.seq_apb);

    `uvm_info(get_type_name(),$sformatf ("To be continued...."), UVM_NONE)
    $display("TEST COMPLETE : afvip_test_instruction_register_field_with_not0");
    phase.drop_objection (this);

  endtask
endclass : afvip_test_instruction_register_field_with_not0


class afvip_test_instruction_data_fields_random extends test_lib;

  `uvm_component_utils(afvip_test_instruction_data_fields_random)
  function new( string name = "afvip_test_instruction_data_fields_random", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase (uvm_phase phase);

    reset_sequence reset_sequence           = reset_sequence::type_id::create("item_rst");
    apb_write_all_sequence apb_write_all_sequence       = apb_write_all_sequence::type_id::create("item");
    opcode_sequence_0_to_4 opcode_sequence_0_to_4       = opcode_sequence_0_to_4::type_id::create("item");
    reg_h84_sequence reg_h84_sequence                   = reg_h84_sequence::type_id::create("item");
    reg_h88_sequence reg_h88_sequence                   = reg_h88_sequence::type_id::create("item");
    reg_h8c_sequence reg_h8c_sequence                   = reg_h8c_sequence::type_id::create("item");
    apb_read_all_sequence apb_read_all_sequence         = apb_read_all_sequence::type_id::create("item");

    phase.raise_objection(this);

    reset_sequence.start(env.agent_reset.seq_reset);
    apb_write_all_sequence.start(env.agent_apb.seq_apb);

    for (int i=1;i<=10;i++) begin
    opcode_sequence_0_to_4.start(env.agent_apb.seq_apb);
    reg_h8c_sequence.start(env.agent_apb.seq_apb);
    reg_h84_sequence.start(env.agent_apb.seq_apb);
    assert(reg_h88_sequence.randomize() with { pwdata_error == reg_h84_sequence.clr_error; });
    reg_h88_sequence.start(env.agent_apb.seq_apb);
    end

    apb_read_all_sequence.start(env.agent_apb.seq_apb);
    
    `uvm_info(get_type_name(),$sformatf ("To be continued...."), UVM_NONE)
    $display("Test afvip_test_opcode_functionally COMPLETE");
    phase.drop_objection (this);

  endtask
endclass : afvip_test_instruction_data_fields_random


class afvip_test_instruction_data_fields_read extends test_lib;

  `uvm_component_utils(afvip_test_instruction_data_fields_read)
  function new( string name = "afvip_test_instruction_data_fields_read", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase (uvm_phase phase);

    reset_sequence reset_sequence           = reset_sequence::type_id::create("item_rst");
    apb_write_all_sequence apb_write_all_sequence       = apb_write_all_sequence::type_id::create("item");
    opcode_sequence_0_to_4 opcode_sequence_0_to_4       = opcode_sequence_0_to_4::type_id::create("item");
    reg_h84_sequence reg_h84_sequence                   = reg_h84_sequence::type_id::create("item");
    reg_h88_sequence reg_h88_sequence                   = reg_h88_sequence::type_id::create("item");
    reg_h8c_sequence reg_h8c_sequence                   = reg_h8c_sequence::type_id::create("item");
    apb_read_all_sequence apb_read_all_sequence         = apb_read_all_sequence::type_id::create("item");

    phase.raise_objection(this);

    reset_sequence.start(env.agent_reset.seq_reset);
    apb_write_all_sequence.start(env.agent_apb.seq_apb);

    for (int i=0;i<10;i++) begin
    opcode_sequence_0_to_4.start(env.agent_apb.seq_apb);
    reg_h8c_sequence.start(env.agent_apb.seq_apb);
    reg_h84_sequence.start(env.agent_apb.seq_apb);
    assert(reg_h88_sequence.randomize() with { pwdata_error == reg_h84_sequence.clr_error; });
    reg_h88_sequence.start(env.agent_apb.seq_apb);
    end

    apb_read_all_sequence.start(env.agent_apb.seq_apb);
    
    `uvm_info(get_type_name(),$sformatf ("To be continued...."), UVM_NONE)
    $display("Test afvip_test_instruction_data_fields_read COMPLETE");
    phase.drop_objection (this);

  endtask
endclass : afvip_test_instruction_data_fields_read


class afvip_test_write_read_all_addres extends test_lib;

  `uvm_component_utils(afvip_test_write_read_all_addres)
  function new( string name = "afvip_test_write_read_all_addres", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase (uvm_phase phase);

    reset_sequence reset_sequence                           = reset_sequence::type_id::create("item_rst");
    apb_write_all_addres_sequence apb_write_all_addres_sequence         = apb_write_all_addres_sequence::type_id::create("item");
    apb_read_all_addres_sequence apb_read_all_addres_sequence           = apb_read_all_addres_sequence::type_id::create("item");

    phase.raise_objection(this);

    reset_sequence.start(env.agent_reset.seq_reset);
    apb_write_all_addres_sequence.start(env.agent_apb.seq_apb);
    apb_read_all_addres_sequence.start(env.agent_apb.seq_apb);
    
    `uvm_info(get_type_name(),$sformatf ("To be continued...."), UVM_NONE)
    $display("Test afvip_test_write_read_all_addres COMPLETE");
    phase.drop_objection (this);

  endtask
endclass : afvip_test_write_read_all_addres


class afvip_test_write_shift_by_1 extends test_lib;

  `uvm_component_utils(afvip_test_write_shift_by_1)

  function new( string name = "afvip_test_write_shift_by_1", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase (uvm_phase phase);

    reset_sequence reset_sequence                             = reset_sequence::type_id::create("item_rst");
    apb_write_ones_by_one_sequence apb_write_ones_by_one_sequence         = apb_write_ones_by_one_sequence::type_id::create("item");
    apb_read_all_sequence apb_read_all_sequence                           = apb_read_all_sequence::type_id::create("item");

    phase.raise_objection(this);

    reset_sequence.start(env.agent_reset.seq_reset);
    apb_write_ones_by_one_sequence.start(env.agent_apb.seq_apb);
    apb_read_all_sequence.start(env.agent_apb.seq_apb);

    `uvm_info(get_type_name(),$sformatf ("To be continued...."), UVM_NONE)
    $display("Test afvip_test_write_shift_by_1 COMPLETE");
    phase.drop_objection (this);

  endtask
endclass : afvip_test_write_shift_by_1


class afvip_test_write_shift_by_0 extends test_lib;

  `uvm_component_utils(afvip_test_write_shift_by_0)
  function new( string name = "afvip_test_write_shift_by_0", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase (uvm_phase phase);

    reset_sequence reset_sequence                               = reset_sequence::type_id::create("item_rst");
    apb_write_ones_by_zero_sequence apb_write_ones_by_zero_sequence         = apb_write_ones_by_zero_sequence::type_id::create("item");
    apb_read_all_sequence apb_read_all_sequence                             = apb_read_all_sequence::type_id::create("item");

    phase.raise_objection(this);

    reset_sequence.start(env.agent_reset.seq_reset);
    apb_write_ones_by_zero_sequence.start(env.agent_apb.seq_apb);
    apb_read_all_sequence.start(env.agent_apb.seq_apb);
    
    `uvm_info(get_type_name(),$sformatf ("To be continued...."), UVM_NONE)
    $display("Test afvip_test_write_shift_by_0 COMPLETE");
    phase.drop_objection (this);

  endtask
endclass : afvip_test_write_shift_by_0


class afvip_test_opcode_urandom extends test_lib;

  `uvm_component_utils(afvip_test_opcode_urandom)
  function new( string name = "afvip_test_opcode_urandom", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase (uvm_phase phase);

    reset_sequence reset_sequence           = reset_sequence::type_id::create("item_rst");
    apb_write_all_sequence apb_write_all_sequence       = apb_write_all_sequence::type_id::create("item");
    apb_opcode_cum_vreau_eu apb_opcode_cum_vreau_eu     = apb_opcode_cum_vreau_eu::type_id::create("item");
    opcode_sequence_5_to_7 opcode_sequence_5_to_7       = opcode_sequence_5_to_7::type_id::create("item");
    opcode_sequence_2 opcode_sequence_2                 = opcode_sequence_2::type_id::create("item");
    reg_h84_sequence reg_h84_sequence                   = reg_h84_sequence::type_id::create("item");
    reg_h88_sequence reg_h88_sequence                   = reg_h88_sequence::type_id::create("item");
    reg_h8c_sequence reg_h8c_sequence                   = reg_h8c_sequence::type_id::create("item");
    apb_read_all_sequence apb_read_all_sequence         = apb_read_all_sequence::type_id::create("item");

    phase.raise_objection(this);

    reset_sequence.start(env.agent_reset.seq_reset);
    apb_write_all_sequence.start(env.agent_apb.seq_apb);
    opcode_sequence_5_to_7.start(env.agent_apb.seq_apb);
    reg_h8c_sequence.start(env.agent_apb.seq_apb);
    reg_h84_sequence.start(env.agent_apb.seq_apb);
    assert(reg_h88_sequence.randomize() with { pwdata_error == reg_h84_sequence.clr_error; });
    reg_h88_sequence.start(env.agent_apb.seq_apb);
    opcode_sequence_2.start(env.agent_apb.seq_apb);
    reg_h8c_sequence.start(env.agent_apb.seq_apb);
    reg_h84_sequence.start(env.agent_apb.seq_apb);
    assert(reg_h88_sequence.randomize() with {pwdata_error == reg_h84_sequence.clr_error;});
    reg_h88_sequence.start(env.agent_apb.seq_apb);
    apb_read_all_sequence.start(env.agent_apb.seq_apb);

    `uvm_info(get_type_name(),$sformatf ("To be continued...."), UVM_NONE)
    $display("Test afvip_test_opcode_urandom COMPLETE");
    phase.drop_objection (this);

  endtask
endclass : afvip_test_opcode_urandom


class afvip_full_test_without_error extends test_lib;

  `uvm_component_utils(afvip_full_test_without_error)
  function new( string name = "afvip_full_test_without_error", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase (uvm_phase phase);

    reset_sequence reset_sequence                                 = reset_sequence::type_id::create("item_rst");
    apb_write_all_sequence apb_write_all_sequence                             = apb_write_all_sequence::type_id::create("item");
    apb_read_all_sequence apb_read_all_sequence                               = apb_read_all_sequence::type_id::create("item");
    apb_write_all_half_superior_sequence apb_write_all_half_superior_sequence = apb_write_all_half_superior_sequence::type_id::create("item");
    apb_write_all_half_inferior_sequence apb_write_all_half_inferior_sequence = apb_write_all_half_inferior_sequence::type_id::create("item");
    apb_write_all_with_random_sequence apb_write_all_with_random_sequence     = apb_write_all_with_random_sequence::type_id::create("item");
    opcode_sequence_0_to_4 opcode_sequence_0_to_4                             = opcode_sequence_0_to_4::type_id::create("item");
    sequence_field_with_0 sequence_field_with_0                               = sequence_field_with_0::type_id::create("item");
    reg_h84_sequence reg_h84_sequence                                         = reg_h84_sequence::type_id::create("item");
    reg_h88_sequence reg_h88_sequence                                         = reg_h88_sequence::type_id::create("item");
    reg_h8c_sequence reg_h8c_sequence                                         = reg_h8c_sequence::type_id::create("item");

    phase.raise_objection(this);

    reset_sequence.start(env.agent_reset.seq_reset);
    apb_write_all_sequence.start(env.agent_apb.seq_apb);
    apb_read_all_sequence.start(env.agent_apb.seq_apb);

    reset_sequence.start(env.agent_reset.seq_reset);
    apb_read_all_sequence.start(env.agent_apb.seq_apb);
    apb_write_all_half_superior_sequence.start(env.agent_apb.seq_apb);
    reset_sequence.start(env.agent_reset.seq_reset);
    apb_write_all_half_inferior_sequence.start(env.agent_apb.seq_apb);
    apb_read_all_sequence.start(env.agent_apb.seq_apb);

    for(int i=0;i<=100;i++) begin
      opcode_sequence_0_to_4.start(env.agent_apb.seq_apb);
      reg_h8c_sequence.start(env.agent_apb.seq_apb);
      reg_h84_sequence.start(env.agent_apb.seq_apb);
      assert(reg_h88_sequence.randomize() with { pwdata_error == reg_h84_sequence.clr_error; });
      reg_h88_sequence.start(env.agent_apb.seq_apb);
    end
    apb_read_all_sequence.start(env.agent_apb.seq_apb);
    reset_sequence.start(env.agent_reset.seq_reset);

    apb_write_all_with_random_sequence.start(env.agent_apb.seq_apb);
    for(int i=0;i<=10;i++) begin
      sequence_field_with_0.start(env.agent_apb.seq_apb);
      reg_h8c_sequence.start(env.agent_apb.seq_apb);
      reg_h84_sequence.start(env.agent_apb.seq_apb);
      assert(reg_h88_sequence.randomize() with { pwdata_error == reg_h84_sequence.clr_error; });
      reg_h88_sequence.start(env.agent_apb.seq_apb);
    end
    apb_read_all_sequence.start(env.agent_apb.seq_apb);

    for(int i=0;i<=100;i++) begin
      opcode_sequence_0_to_4.start(env.agent_apb.seq_apb);
      reg_h8c_sequence.start(env.agent_apb.seq_apb);
      reg_h84_sequence.start(env.agent_apb.seq_apb);
      assert(reg_h88_sequence.randomize() with { pwdata_error == reg_h84_sequence.clr_error; });
      reg_h88_sequence.start(env.agent_apb.seq_apb);
    end
    apb_read_all_sequence.start(env.agent_apb.seq_apb);

    

    `uvm_info(get_type_name(),$sformatf ("To be continued...."), UVM_NONE)
    $display("Test afvip_full_test_without_error COMPLETE");
    phase.drop_objection (this);

  endtask
endclass : afvip_full_test_without_error


class afvip_full_test_with_error extends test_lib;

  `uvm_component_utils(afvip_full_test_with_error)
  function new( string name = "afvip_full_test_with_error", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase (uvm_phase phase);

    reset_sequence reset_sequence                                 = reset_sequence::type_id::create("item_rst");
    apb_write_all_sequence apb_write_all_sequence                             = apb_write_all_sequence::type_id::create("item");
    apb_read_all_sequence apb_read_all_sequence                               = apb_read_all_sequence::type_id::create("item");
    apb_write_all_addres_sequence apb_write_all_addres_sequence               = apb_write_all_addres_sequence::type_id::create("item");
    apb_read_all_addres_sequence apb_read_all_addres_sequence                 = apb_read_all_addres_sequence::type_id::create("item");
    opcode_sequence_5_to_7 opcode_sequence_5_to_7                             = opcode_sequence_5_to_7::type_id::create("item");
    sequence_field_with_1 sequence_field_with_1                               = sequence_field_with_1::type_id::create("item");
    reg_h84_sequence reg_h84_sequence                                         = reg_h84_sequence::type_id::create("item");
    reg_h88_sequence reg_h88_sequence                                         = reg_h88_sequence::type_id::create("item");
    reg_h8c_sequence reg_h8c_sequence                                         = reg_h8c_sequence::type_id::create("item");

    phase.raise_objection(this);

    reset_sequence.start(env.agent_reset.seq_reset);
    apb_write_all_addres_sequence.start(env.agent_apb.seq_apb);
    apb_read_all_addres_sequence.start(env.agent_apb.seq_apb);

    for(int i=0;i<=100;i++) begin
      opcode_sequence_5_to_7.start(env.agent_apb.seq_apb);
      reg_h8c_sequence.start(env.agent_apb.seq_apb);
      reg_h84_sequence.start(env.agent_apb.seq_apb);
      assert(reg_h88_sequence.randomize() with { pwdata_error == reg_h84_sequence.clr_error; });
      reg_h88_sequence.start(env.agent_apb.seq_apb);
    end
    apb_read_all_addres_sequence.start(env.agent_apb.seq_apb);
    reset_sequence.start(env.agent_reset.seq_reset);

    apb_write_all_sequence.start(env.agent_apb.seq_apb);
    for(int i=0;i<=100;i++) begin
      sequence_field_with_1.start(env.agent_apb.seq_apb);
      reg_h8c_sequence.start(env.agent_apb.seq_apb);
      reg_h84_sequence.start(env.agent_apb.seq_apb);
      assert(reg_h88_sequence.randomize() with { pwdata_error == reg_h84_sequence.clr_error; });
      reg_h88_sequence.start(env.agent_apb.seq_apb);
    end
    apb_read_all_sequence.start(env.agent_apb.seq_apb);

    for(int i=0;i<=100;i++) begin
      opcode_sequence_5_to_7.start(env.agent_apb.seq_apb);
      reg_h8c_sequence.start(env.agent_apb.seq_apb);
      reg_h84_sequence.start(env.agent_apb.seq_apb);
      assert(reg_h88_sequence.randomize() with { pwdata_error == reg_h84_sequence.clr_error; });
      reg_h88_sequence.start(env.agent_apb.seq_apb);
    end
    apb_read_all_sequence.start(env.agent_apb.seq_apb);
    

    `uvm_info(get_type_name(),$sformatf ("To be continued...."), UVM_NONE)
    $display("Test afvip_full_test_with_error COMPLETE");
    phase.drop_objection (this);

  endtask
endclass : afvip_full_test_with_error