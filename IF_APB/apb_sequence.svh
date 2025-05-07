class apb_sequence extends uvm_sequence #(apb_item, apb_item);

    `uvm_object_utils(apb_sequence)
    apb_item item;
    function new (string name="apb_sequence");
      super.new(name);    
      item = apb_item::type_id::create("item");
    endfunction
endclass : apb_sequence

 
class op1_op2 extends apb_sequence;

  `uvm_object_utils(op1_op2)

 
  function new (string name="op1_op2");
      super.new(name);    
  endfunction

  virtual task body();

      // for(int i = 0; i<32 ;i++) begin
      //      start_item (item);
      //      if(!(item.randomize() with { pwdata == i;
      //                                   paddr == i ;
      //                                   delay_psel == 2 ;
      //                                   pwrite ==1 ;
      //                                  }))

      //       `uvm_error(get_type_name(), "rand_error")
      //      finish_item (item);
      //      get_response(item);
      //   end
        start_item(item);
        item.pwrite = 0;
        // item.pwdata = 32'b00000100000001000000010000000001;
        item.paddr  = 1;
        item.delay_psel = 5;
        finish_item (item);
        get_response(item);

        start_item(item);
        item.pwrite = 1;
        item.pwdata = 32'b0001_00_0000_00000001_00000001_000001;
        item.paddr  = 1;
        item.delay_psel = 5;
        finish_item (item);
        get_response(item);

        start_item(item);
        item.pwrite = 0;
        // item.pwdata = 32'b00000100000001000000010000000001;
        item.paddr  = 1;
        item.delay_psel = 5;
        finish_item (item);
        get_response(item);

  endtask : body
endclass : op1_op2

class write_all_with_1 extends apb_sequence;

  `uvm_object_utils(write_all_with_1)

 
  function new (string name="write_all_with_1");
      super.new(name);    
  endfunction

  virtual task body();

        start_item(item);
        item.pwrite = 1;
        item.pwdata = 32'b0001_00_0000_00000001_00000001_000000;
        item.delay_psel = 5;
        finish_item (item);
        get_response(item);

        start_item(item);
        item.pwrite = 1;
        item.pwdata = 32'b0001_00_0000_00000001_00000001_000001;
        item.delay_psel = 5;
        finish_item (item);
        get_response(item);

        start_item(item);
        item.pwrite = 1;
        item.pwdata = 32'b0001_00_0000_00000001_00000001_000010;
        item.delay_psel = 5;
        finish_item (item);
        get_response(item);

        start_item(item);
        item.pwrite = 1;
        item.pwdata = 32'b0001_00_0000_00000001_00000001_000011;
        item.delay_psel = 5;
        finish_item (item);
        get_response(item);

        start_item(item);
        item.pwrite = 1;
        item.pwdata = 32'b0001_00_0000_00000001_00000001_000100;
        item.delay_psel = 5;
        finish_item (item);
        get_response(item);

        start_item(item);
        item.pwrite = 1;
        item.pwdata = 32'b0001_00_0000_00000001_00000001_0000101;
        item.delay_psel = 5;
        finish_item (item);
        get_response(item);

        start_item(item);
        item.pwrite = 1;
        item.pwdata = 32'b0001_00_0000_00000001_00000001_0000110;
        item.delay_psel = 5;
        finish_item (item);
        get_response(item);

        start_item(item);
        item.pwrite = 1;
        item.pwdata = 32'b0001_00_0000_00000001_00000001_000111;
        item.delay_psel = 5;
        finish_item (item);
        get_response(item);

        start_item(item);
        item.pwrite = 1;
        item.pwdata = 32'b0001_00_0000_00000001_00000001_001000;
        item.delay_psel = 5;
        finish_item (item);
        get_response(item);

        start_item(item);
        item.pwrite = 1;
        item.pwdata = 32'b0001_00_0000_00000001_00000001_001001;
        item.delay_psel = 5;
        finish_item (item);
        get_response(item);

        start_item(item);
        item.pwrite = 1;
        item.pwdata = 32'b0001_00_0000_00000001_00000001_001010;
        item.delay_psel = 5;
        finish_item (item);
        get_response(item);

        start_item(item);
        item.pwrite = 1;
        item.pwdata = 32'b0001_00_0000_00000001_00000001_001011;
        item.delay_psel = 5;
        finish_item (item);
        get_response(item);

        start_item(item);
        item.pwrite = 1;
        item.pwdata = 32'b0001_00_0000_00000001_00000001_001100;
        item.delay_psel = 5;
        finish_item (item);
        get_response(item);

        start_item(item);
        item.pwrite = 1;
        item.pwdata = 32'b0001_00_0000_00000001_00000001_001101;
        item.delay_psel = 5;
        finish_item (item);
        get_response(item);

        start_item(item);
        item.pwrite = 1;
        item.pwdata = 32'b0001_00_0000_00000001_00000001_001110;
        item.delay_psel = 5;
        finish_item (item);
        get_response(item);

        start_item(item);
        item.pwrite = 1;
        item.pwdata = 32'b0001_00_0000_00000001_00000001_001111;
        item.delay_psel = 5;
        finish_item (item);
        get_response(item);


  endtask : body
endclass : write_all_with_1

class read_all_address extends apb_sequence;

  `uvm_object_utils(read_all_address)

 
  function new (string name="read_all_address");
      super.new(name);    
  endfunction

  virtual task body();

      for(int i = 0; i<16 ;i++) begin
           start_item (item);
           if(!(item.randomize() with { paddr == i ;
                                        delay_psel == i ;
                                        pwrite ==0 ;
                                       }))

            `uvm_error(get_type_name(), "rand_error")
           finish_item (item);
           get_response(item);
        end

  endtask : body
endclass : read_all_address

class read_addr20 extends apb_sequence;

  `uvm_object_utils(read_addr20)

 
  function new (string name="read_addr20");
      super.new(name);    
  endfunction

  virtual task body();

        start_item(item);
        item.pwrite = 1;
        item.pwdata = 32'b0001_00_0000_00000001_00000001_010100;
        item.delay_psel = 5;
        finish_item (item);
        get_response(item);

  endtask : body
endclass : read_addr20

class opcode0000_write_read_error extends apb_sequence;

  `uvm_object_utils(opcode0000_write_read_error)
  function new (string name="opcode0000_write_read_error");
      super.new(name);    
  endfunction

  virtual task body();
        start_item(item);
        item.pwrite = 1;
        item.pwdata = 32'b0000_00_0000_11111111_00001101_000011;
        item.delay_psel = 2;
        finish_item (item);
        get_response(item);
        start_item(item);
        item.pwrite = 0;
        item.paddr = 3;
        item.delay_psel = 2;
        finish_item (item);
        get_response(item);
  endtask : body
endclass : opcode0000_write_read_error

class opcode0001_write_read extends apb_sequence;

  `uvm_object_utils(opcode0001_write_read)
  function new (string name="opcode0001_write_read");
      super.new(name);    
  endfunction

  virtual task body();
        start_item(item);
        item.pwrite = 1;
        item.pwdata = 32'b0001_00_1111_11111111_11111101_000000;
        item.delay_psel = 2;
        finish_item (item);
        get_response(item);
        start_item(item);
        item.pwrite = 0;
        item.paddr = 0;
        item.delay_psel = 2;
        finish_item (item);
        get_response(item);
  endtask : body
endclass : opcode0001_write_read

class opcode0010_write_read extends apb_sequence;

  `uvm_object_utils(opcode0010_write_read)
  function new (string name="opcode0010_write_read");
      super.new(name);    
  endfunction

  virtual task body();
        start_item(item);
        item.pwrite = 1;
        item.pwdata = 32'b0010_00_1111_11111111_11111101_000001;
        item.delay_psel = 2;
        finish_item (item);
        get_response(item);
        start_item(item);
        item.pwrite = 0;
        item.paddr = 1;
        item.delay_psel = 2;
        finish_item (item);
        get_response(item);
  endtask : body
endclass : opcode0010_write_read

class opcode0011_write_read extends apb_sequence;

  `uvm_object_utils(opcode0011_write_read)
  function new (string name="opcode0011_write_read");
      super.new(name);    
  endfunction

  virtual task body();
        start_item(item);
        item.pwrite = 1;
        item.pwdata = 32'b0011_00_1111_11111111_11111101_000010;
        item.delay_psel = 2;
        finish_item (item);
        get_response(item);
        start_item(item);
        item.pwrite = 0;
        item.paddr = 2;
        item.delay_psel = 2;
        finish_item (item);
        get_response(item);
  endtask : body
endclass : opcode0011_write_read

class opcode0100_write_read extends apb_sequence;

  `uvm_object_utils(opcode0100_write_read)
  function new (string name="opcode0100_write_read");
      super.new(name);    
  endfunction

  virtual task body();
        start_item(item);
        item.pwrite = 1;
        item.pwdata = 32'b0100_11_1111_11111111_11111101_000011;
        item.delay_psel = 2;
        finish_item (item);
        get_response(item);
        start_item(item);
        item.pwrite = 0;
        item.paddr = 3;
        item.delay_psel = 2;
        finish_item (item);
        get_response(item);
  endtask : body
endclass : opcode0100_write_read

class opcode0101_write_read extends apb_sequence;

  `uvm_object_utils(opcode0101_write_read)
  function new (string name="opcode0101_write_read");
      super.new(name);    
  endfunction

  virtual task body();
        start_item(item);
        item.pwrite = 1;
        item.pwdata = 32'b0101_00_1111_11111111_11111101_000100;
        item.delay_psel = 2;
        finish_item (item);
        get_response(item);
        start_item(item);
        item.pwrite = 0;
        item.paddr = 4;
        item.delay_psel = 2;
        finish_item (item);
        get_response(item);
  endtask : body
endclass : opcode0101_write_read

class opcode0110_write_read extends apb_sequence;

  `uvm_object_utils(opcode0110_write_read)
  function new (string name="opcode0110_write_read");
      super.new(name);    
  endfunction

  virtual task body();
        start_item(item);
        item.pwrite = 1;
        item.pwdata = 32'b0110_00_1111_11111111_11111101_000101;
        item.delay_psel = 2;
        finish_item (item);
        get_response(item);
        start_item(item);
        item.pwrite = 0;
        item.paddr = 5;
        item.delay_psel = 2;
        finish_item (item);
        get_response(item);
  endtask : body
endclass : opcode0110_write_read

class opcode0111_write_read extends apb_sequence;

  `uvm_object_utils(opcode0111_write_read)
  function new (string name="opcode0111_write_read");
      super.new(name);    
  endfunction

  virtual task body();
        start_item(item);
        item.pwrite = 1;
        item.pwdata = 32'b0111_00_1111_11111111_11111101_000110;
        item.delay_psel = 2;
        finish_item (item);
        get_response(item);
        start_item(item);
        item.pwrite = 0;
        item.paddr = 6;
        item.delay_psel = 2;
        finish_item (item);
        get_response(item);
  endtask : body
endclass : opcode0111_write_read

class opcode1000_write_read extends apb_sequence;

  `uvm_object_utils(opcode1000_write_read)
  function new (string name="opcode1000_write_read");
      super.new(name);    
  endfunction

  virtual task body();
        start_item(item);
        item.pwrite = 1;
        item.pwdata = 32'b1000_00_1111_11111111_11111101_000111;
        item.delay_psel = 2;
        finish_item (item);
        get_response(item);
        start_item(item);
        item.pwrite = 0;
        item.paddr = 7;
        item.delay_psel = 2;
        finish_item (item);
        get_response(item);
  endtask : body
endclass : opcode1000_write_read

class opcode1001_write_read extends apb_sequence;

  `uvm_object_utils(opcode1001_write_read)
  function new (string name="opcode1001_write_read");
      super.new(name);    
  endfunction

  virtual task body();
        start_item(item);
        item.pwrite = 1;
        item.pwdata = 32'b1001_00_1111_11111111_11111101_001000;
        item.delay_psel = 2;
        finish_item (item);
        get_response(item);
        start_item(item);
        item.pwrite = 0;
        item.paddr = 8;
        item.delay_psel = 2;
        finish_item (item);
        get_response(item);
  endtask : body
endclass : opcode1001_write_read

class random_seq extends apb_sequence;

  `uvm_object_utils(random_seq)

 
  function new (string name="random_seq");
      super.new(name);    
  endfunction
  virtual task body();

      for(int i = 0; i<100 ;i++) begin
           start_item (item);
           if(!(item.randomize() with {
                                        paddr inside {[16'b0 :  16'd15]} ;
                                        delay_psel inside {[0:14]} ;
                                        pwrite inside {[0:1]} ;
                                       }))

            `uvm_error(get_type_name(), "rand_error")
           finish_item (item);
           get_response(item);
        end

  endtask : body
endclass : random_seq