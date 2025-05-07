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


class first_test extends test_lib;

  `uvm_component_utils(first_test)
  function new( string name = "first_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase (uvm_phase phase);

    op1_op2 op1_op2   = op1_op2::type_id::create("item_apb");
    reset_sequence reset_sequence   = reset_sequence::type_id::create("item_reset");

    phase.raise_objection(this);

    reset_sequence.start(env.agent_reset.seq_reset);
    op1_op2.start(env.agent_apb.seq_apb);
  
    `uvm_info(get_type_name(),$sformatf ("To be continued...."), UVM_NONE)
    $display("first_test TEST: Completed");
    phase.drop_objection (this);

  endtask
endclass : first_test

class test_write_all_read_all extends test_lib;

  `uvm_component_utils(test_write_all_read_all)
  function new( string name = "test_write_all_read_all", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase (uvm_phase phase);

    write_all_with_1 write_all_with_1   = write_all_with_1::type_id::create("item_apb");
    read_all_address read_all_address   = read_all_address::type_id::create("item_apb");
    reset_sequence reset_sequence   = reset_sequence::type_id::create("item_reset");

    phase.raise_objection(this);

    reset_sequence.start(env.agent_reset.seq_reset);
    write_all_with_1.start(env.agent_apb.seq_apb);
    read_all_address.start(env.agent_apb.seq_apb);
  
    `uvm_info(get_type_name(),$sformatf ("To be continued...."), UVM_NONE)
    $display("first_test TEST: Completed");
    phase.drop_objection (this);

  endtask
endclass : test_write_all_read_all

class test_write_all_read_all_error extends test_lib;

  `uvm_component_utils(test_write_all_read_all_error)
  function new( string name = "test_write_all_read_all_error", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase (uvm_phase phase);

    write_all_with_1 write_all_with_1   = write_all_with_1::type_id::create("item_apb");
    read_all_address read_all_address   = read_all_address::type_id::create("item_apb");
    read_addr20 read_addr20             = read_addr20::type_id::create("item_apb");
    reset_sequence reset_sequence       = reset_sequence::type_id::create("item_reset");

    phase.raise_objection(this);

    reset_sequence.start(env.agent_reset.seq_reset);
    write_all_with_1.start(env.agent_apb.seq_apb);
    read_all_address.start(env.agent_apb.seq_apb);
    read_addr20.start(env.agent_apb.seq_apb);
  
    `uvm_info(get_type_name(),$sformatf ("To be continued...."), UVM_NONE)
    $display("first_test TEST: Completed");
    phase.drop_objection (this);

  endtask
endclass : test_write_all_read_all_error

class test_opcode_error_check_with_0000 extends test_lib;

  `uvm_component_utils(test_opcode_error_check_with_0000)
  function new( string name = "test_opcode_error_check_with_0000", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase (uvm_phase phase);

    opcode0000_write_read_error opcode0000_write_read_error   = opcode0000_write_read_error::type_id::create("item_apb");
    reset_sequence reset_sequence       = reset_sequence::type_id::create("item_reset");

    phase.raise_objection(this);

    reset_sequence.start(env.agent_reset.seq_reset);
    opcode0000_write_read_error.start(env.agent_apb.seq_apb);
  
    `uvm_info(get_type_name(),$sformatf ("To be continued...."), UVM_NONE)
    $display("first_test TEST: Completed");
    phase.drop_objection (this);

  endtask
endclass : test_opcode_error_check_with_0000

class test_opcode_check_full extends test_lib;

  `uvm_component_utils(test_opcode_check_full)
  function new( string name = "test_opcode_check_full", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase (uvm_phase phase);

    opcode0001_write_read opcode0001_write_read   = opcode0001_write_read::type_id::create("item_apb");
    opcode0010_write_read opcode0010_write_read   = opcode0010_write_read::type_id::create("item_apb");
    opcode0011_write_read opcode0011_write_read   = opcode0011_write_read::type_id::create("item_apb");
    opcode0100_write_read opcode0100_write_read   = opcode0100_write_read::type_id::create("item_apb");
    opcode0101_write_read opcode0101_write_read   = opcode0101_write_read::type_id::create("item_apb");
    opcode0110_write_read opcode0110_write_read   = opcode0110_write_read::type_id::create("item_apb");
    opcode0111_write_read opcode0111_write_read   = opcode0111_write_read::type_id::create("item_apb");
    opcode1000_write_read opcode1000_write_read   = opcode1000_write_read::type_id::create("item_apb");
    opcode1001_write_read opcode1001_write_read   = opcode1001_write_read::type_id::create("item_apb");
    reset_sequence reset_sequence                 = reset_sequence::type_id::create("item_reset");

    phase.raise_objection(this);

    reset_sequence.start(env.agent_reset.seq_reset);
    opcode0001_write_read.start(env.agent_apb.seq_apb);
    opcode0010_write_read.start(env.agent_apb.seq_apb);
    opcode0011_write_read.start(env.agent_apb.seq_apb);
    opcode0100_write_read.start(env.agent_apb.seq_apb);
    opcode0101_write_read.start(env.agent_apb.seq_apb);
    opcode0110_write_read.start(env.agent_apb.seq_apb);
    opcode0111_write_read.start(env.agent_apb.seq_apb);
    opcode1000_write_read.start(env.agent_apb.seq_apb);
    opcode1001_write_read.start(env.agent_apb.seq_apb);
  
    `uvm_info(get_type_name(),$sformatf ("To be continued...."), UVM_NONE)
    $display("first_test TEST: Completed");
    phase.drop_objection (this);

  endtask
endclass : test_opcode_check_full

class test_opcode_check_full_half_reset extends test_lib;

  `uvm_component_utils(test_opcode_check_full_half_reset)
  function new( string name = "test_opcode_check_full_half_reset", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase (uvm_phase phase);

    opcode0001_write_read opcode0001_write_read   = opcode0001_write_read::type_id::create("item_apb");
    opcode0010_write_read opcode0010_write_read   = opcode0010_write_read::type_id::create("item_apb");
    opcode0011_write_read opcode0011_write_read   = opcode0011_write_read::type_id::create("item_apb");
    opcode0100_write_read opcode0100_write_read   = opcode0100_write_read::type_id::create("item_apb");
    opcode0101_write_read opcode0101_write_read   = opcode0101_write_read::type_id::create("item_apb");
    opcode0110_write_read opcode0110_write_read   = opcode0110_write_read::type_id::create("item_apb");
    opcode0111_write_read opcode0111_write_read   = opcode0111_write_read::type_id::create("item_apb");
    opcode1000_write_read opcode1000_write_read   = opcode1000_write_read::type_id::create("item_apb");
    opcode1001_write_read opcode1001_write_read   = opcode1001_write_read::type_id::create("item_apb");
    reset_sequence reset_sequence                 = reset_sequence::type_id::create("item_reset");

    phase.raise_objection(this);

    reset_sequence.start(env.agent_reset.seq_reset);
    opcode0001_write_read.start(env.agent_apb.seq_apb);
    opcode0010_write_read.start(env.agent_apb.seq_apb);
    opcode0011_write_read.start(env.agent_apb.seq_apb);
    opcode0100_write_read.start(env.agent_apb.seq_apb);
    opcode0101_write_read.start(env.agent_apb.seq_apb);
    reset_sequence.start(env.agent_reset.seq_reset);
    opcode0110_write_read.start(env.agent_apb.seq_apb);
    opcode0111_write_read.start(env.agent_apb.seq_apb);
    opcode1000_write_read.start(env.agent_apb.seq_apb);
    opcode1001_write_read.start(env.agent_apb.seq_apb);
  
    `uvm_info(get_type_name(),$sformatf ("To be continued...."), UVM_NONE)
    $display("first_test TEST: Completed");
    phase.drop_objection (this);

  endtask
endclass : test_opcode_check_full_half_reset

class test_full_random extends test_lib;

  `uvm_component_utils(test_full_random)
  function new( string name = "test_full_random", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase (uvm_phase phase);

    random_seq random_seq               = random_seq::type_id::create("item_apb");
    reset_sequence reset_sequence       = reset_sequence::type_id::create("item_reset");

    phase.raise_objection(this);

    reset_sequence.start(env.agent_reset.seq_reset);
    repeat(5)
    random_seq.start(env.agent_apb.seq_apb);

  
    `uvm_info(get_type_name(),$sformatf ("To be continued...."), UVM_NONE)
    $display("first_test TEST: Completed");
    phase.drop_objection (this);

  endtask
endclass : test_full_random

class test_full_random_with_reset extends test_lib;

  `uvm_component_utils(test_full_random_with_reset)
  function new( string name = "test_full_random_with_reset", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase (uvm_phase phase);

    random_seq random_seq               = random_seq::type_id::create("item_apb");
    reset_sequence reset_sequence       = reset_sequence::type_id::create("item_reset");

    phase.raise_objection(this);

    reset_sequence.start(env.agent_reset.seq_reset);
    repeat(5)
    random_seq.start(env.agent_apb.seq_apb);
    reset_sequence.start(env.agent_reset.seq_reset);
    random_seq.start(env.agent_apb.seq_apb);

  
    `uvm_info(get_type_name(),$sformatf ("To be continued...."), UVM_NONE)
    $display("first_test TEST: Completed");
    phase.drop_objection (this);

  endtask
endclass : test_full_random_with_reset