class apb_sequence extends uvm_sequence #(apb_item, apb_item);

    `uvm_object_utils(apb_sequence)
    apb_item item;
    function new (string name="apb_sequence");
      super.new(name);    
      item = apb_item::type_id::create("item");
    endfunction

    bit response_queue_error_report_disabled = 1;
    function void set_response_queue_error_report_disabled(bit value=1 );
    response_queue_error_report_disabled = value;
    endfunction

    function bit get_response_queue_error_report_disabled();
    return response_queue_error_report_disabled;
    endfunction
endclass : apb_sequence

 
class apb_write_all_sequence extends apb_sequence;

  `uvm_object_utils(apb_write_all_sequence)

 
  function new (string name="apb_write_all_sequence");
      super.new(name);    
  endfunction

  virtual task body();

      for(int i = 0; i<32 ;i++) begin
           start_item (item);
           if(!(item.randomize() with { pwdata == i*2;
                                        paddr == i*4 ;
                                        delay_psel inside {[0:15]} ;
                                        pwrite ==1 ;
                                       }))

            `uvm_error(get_type_name(), "rand_error")
           finish_item (item);
           get_response(item);
        end

  endtask : body
endclass : apb_write_all_sequence


class apb_write_all_with_random_sequence extends apb_sequence;

  `uvm_object_utils(apb_write_all_with_random_sequence)

  
  function new (string name="apb_write_all_with_random_sequence");
    super.new(name);    
  endfunction

  virtual task body();

    for(int i = 0; i<32 ;i++) begin
      start_item (item);
      if(!(item.randomize() with {pwdata inside {[0:'hFFFFFFFF]};
                                  paddr == i*4 ;
                                  delay_psel inside {[0:15]} ;
                                  pwrite ==1 ;
                                 }))

          `uvm_error(get_type_name(), "rand_error")
         finish_item (item);
         get_response(item);
      end

  endtask : body
endclass : apb_write_all_with_random_sequence


class apb_write_one_h40_sequence extends apb_sequence;

  `uvm_object_utils(apb_write_one_h40_sequence)

  function new (string name="apb_write_one_h40_sequence");
    super.new(name);    
  endfunction

  virtual task body();

      start_item (item);
      if(!(item.randomize() with {pwdata inside {[0:'hFFFFFFFF]};
                                  paddr == 'h40 ;
                                  delay_psel inside {[0:15]} ;
                                  pwrite ==1 ;
                                 }))
          `uvm_error(get_type_name(), "rand_error")
         finish_item (item);
         get_response(item);
  endtask : body
endclass : apb_write_one_h40_sequence


class apb_write_all_with_curent_x2_sequence extends apb_sequence;

  `uvm_object_utils(apb_write_all_with_curent_x2_sequence)
  function new (string name="apb_write_all_with_curent_x2_sequence");
    super.new(name);    
  endfunction
  int unsigned last_pwdata = 'hFFFFFFFE;

  virtual task body();

  for(int i = 0; i<32 ;i++) begin
    start_item (item);
    item.pwdata = last_pwdata *i;
    item.paddr = i*4;
    item.delay_psel = 2;
    item.pwrite = 1;
    finish_item (item);  
    get_response(item);
  end

  endtask : body
endclass : apb_write_all_with_curent_x2_sequence


class apb_write_all_with_1_sequence extends apb_sequence;

  `uvm_object_utils(apb_write_all_with_1_sequence)

 
  function new (string name="apb_write_all_with_1_sequence");
      super.new(name);    
  endfunction

  virtual task body();

      for(int i = 0; i<32 ;i++) begin
           start_item (item);
           if(!(item.randomize() with { pwdata == 'h11111111;
                                        paddr == i*4 ;
                                        delay_psel inside {[0:15]} ;
                                        pwrite ==1 ;
                                       }))

            `uvm_error(get_type_name(), "rand_error")
           finish_item (item);
           get_response(item);
        end

  endtask : body
endclass : apb_write_all_with_1_sequence


class apb_write_all_with_F_sequence extends apb_sequence;

  `uvm_object_utils(apb_write_all_with_F_sequence)

 
  function new (string name="apb_write_all_with_F_sequence");
      super.new(name);    
  endfunction

  virtual task body();

      for(int i = 0; i<32 ;i++) begin
           start_item (item);
           if(!(item.randomize() with { pwdata == 'hFFFFFFFF;
                                        paddr == i*4 ;
                                        delay_psel inside {[0:15]} ;
                                        pwrite ==1 ;
                                       }))

            `uvm_error(get_type_name(), "rand_error")
           finish_item (item);
           get_response(item);
        end

  endtask : body
endclass : apb_write_all_with_F_sequence


class apb_read_1_write_1_sequence extends apb_sequence;

  `uvm_object_utils(apb_read_1_write_1_sequence)

 
  function new (string name="apb_write_all_with_F_sequence");
      super.new(name);    
  endfunction

  virtual task body();

      for(int i = 0; i<32 ;i++) begin
          start_item (item);
          if(!(item.randomize() with { pwdata inside {[0:'hFFFFFFFF]};
                                      paddr == i*4 ;
                                      delay_psel inside {[0:15]} ;
                                      pwrite ==1 ;
                                     }))

          `uvm_error(get_type_name(), "rand_error")
          finish_item (item);
          get_response(item);
          start_item(item);
          item.pwrite =0;
          item.paddr = i*4;
          finish_item(item);
          get_response(item);
        end
  endtask : body
endclass : apb_read_1_write_1_sequence


class apb_write_all_without_one_sequence extends apb_sequence;

  `uvm_object_utils(apb_write_all_without_one_sequence)

 
  function new (string name="apb_write_all_without_one_sequence");
      super.new(name);    
  endfunction

  virtual task body();

      for(int i = 0; i<32 ;i++) begin
        if(i!=11) begin
           start_item (item);
           if(!(item.randomize() with { pwdata == i*2;
                                        paddr == i*4 ;
                                       delay_psel inside {[0:3]} ;
                                       pwrite ==1 ;
                                       }))

            `uvm_error(get_type_name(), "rand_error")
           finish_item (item);
           get_response(item);
        end
        end

  endtask : body
endclass : apb_write_all_without_one_sequence


class apb_read_all_sequence extends apb_sequence;

  `uvm_object_utils(apb_read_all_sequence)

 
  function new (string name="apb_read_all_sequence");
      super.new(name);    
  endfunction


  virtual task body();

      for(int i = 0; i<32 ;i++) begin
           start_item (item);
           if(!(item.randomize() with { paddr == i*4 ;
                                        delay_psel inside {[0:15]} ;
                                        pwrite ==0 ;
                                       }))

            `uvm_error(get_type_name(), "rand_error")
           finish_item (item);
           get_response(item);
        end

  endtask : body
endclass : apb_read_all_sequence


class apb_write_random_sequence extends apb_sequence;

    `uvm_object_utils(apb_write_random_sequence)

    function new (string name="apb_write_random_sequence");
        super.new(name);    
    endfunction

 
    virtual task body();
             start_item (item);
             if(!(item.randomize() with {paddr inside {['h0:16'h7c]} ;
                                        paddr % 4 ==0; 
                                         delay_psel inside {[0:16]} ;
                                         pwrite == 1;
                                         }))
              `uvm_error(get_type_name(), "rand_error")
             finish_item (item);
             get_response(item);
    endtask : body
endclass : apb_write_random_sequence


class apb_read_random_sequence extends apb_sequence;

    `uvm_object_utils(apb_read_random_sequence)

    function new (string name="apb_read_random_sequence");
        super.new(name);    
    endfunction

 
    virtual task body();
             start_item (item);
             if(!(item.randomize() with {paddr inside {[16'h0:16'h7c]};
                                         paddr %4 ==0;
                                         delay_psel == 1 ;
                                         pwrite == 0;
                                         }))
              `uvm_error(get_type_name(), "rand_error")
             finish_item (item);
             get_response(item);

    endtask : body
endclass : apb_read_random_sequence


class apb_read_choose_sequence extends apb_sequence;

    `uvm_object_utils(apb_read_choose_sequence)

    function new (string name="apb_read_choose_sequence");
        super.new(name);    
    endfunction

 
    virtual task body();
             start_item (item);
             item.paddr = 16'h50;
             item.pwrite =0;
             finish_item(item);
             get_response(item);

    endtask : body
endclass : apb_read_choose_sequence


class back2back_sequence extends apb_sequence;

    `uvm_object_utils(back2back_sequence)

    function new (string name="back2back_sequence");
        super.new(name);    
    endfunction

    virtual task body();
        for(int i = 0; i<40 ;i++) begin
             start_item (item);
             if(!(item.randomize() with {pwdata == i;
                                         paddr inside {[16'h0:16'h7c] };
                                         paddr [1:0] ==0;
                                         delay_psel == 0 ;
                                         pwrite  inside {[0:1] } ;}))
              `uvm_error(get_type_name(), "rand_error")
             finish_item (item);
             get_response(item);

        end
    endtask : body
endclass : back2back_sequence


class apb_write_all_half_superior_sequence extends apb_sequence;

  `uvm_object_utils(apb_write_all_half_superior_sequence)

 
  function new (string name="apb_write_all_half_superior_sequence");
      super.new(name);    
  endfunction

  virtual task body();

      for(int i = 0; i<16 ;i++) begin
           start_item (item);
           if(!(item.randomize() with { pwdata == i*2;
                                        paddr == i*4 ;
                                        delay_psel inside {[0:15]} ;
                                        pwrite ==1 ;
                                       }))

            `uvm_error(get_type_name(), "rand_error")
           finish_item (item);
           get_response(item);
        end

  endtask : body
endclass : apb_write_all_half_superior_sequence


class apb_write_all_half_inferior_sequence extends apb_sequence;

  `uvm_object_utils(apb_write_all_half_inferior_sequence)

 
  function new (string name="apb_write_all_half_inferior_sequence");
      super.new(name);    
  endfunction

  virtual task body();

      for(int i = 16; i<32 ;i++) begin
           start_item (item);
           if(!(item.randomize() with { pwdata == i*2;
                                        paddr == i*4 ;
                                        delay_psel inside {[0:15]} ;
                                        pwrite ==1 ;
                                       }))

            `uvm_error(get_type_name(), "rand_error")
           finish_item (item);
           get_response(item);
        end

  endtask : body
endclass : apb_write_all_half_inferior_sequence


class opcode_sequence_0 extends apb_sequence;

    `uvm_object_utils(opcode_sequence_0)

    function new (string name="opcode_sequence_0");
        super.new(name);    
    endfunction

      virtual task body();

      start_item(item);
      item.paddr = 16'h80;
      item.pwrite =1;
      item.pwdata[2:0]     = 0; //OPCODE
      item.pwdata[7:3]     = 0;           //RS0
      item.pwdata[12:8]    = 2;           //RS1
      item.pwdata[20:16]   = 4;          //DST
      item.pwdata[31:24]   = 6; //IMM
      item.pwdata[15:13]   =  0; //Bits0
      item.pwdata[23:21]   =  0; //Bits0
      finish_item(item);
      get_response(item);
      
      endtask
endclass : opcode_sequence_0


class opcode_sequence_1 extends apb_sequence;

    `uvm_object_utils(opcode_sequence_1)

    function new (string name="opcode_sequence_1");
        super.new(name);    
    endfunction

      virtual task body();

      start_item(item);
      item.paddr = 16'h80;
      item.pwrite =1;
      item.pwdata[2:0]     = 1; //OPCODE
      item.pwdata[7:3]     = 2;           //RS0
      item.pwdata[12:8]    = 4;           //RS1
      item.pwdata[20:16]   = 6;          //DST
      item.pwdata[31:24]   = 8; //IMM
      item.pwdata[15:13]   =  0; //Bits0
      item.pwdata[23:21]   =  0; //Bits0
      finish_item(item);
      get_response(item);
      
      endtask
endclass : opcode_sequence_1


class opcode_sequence_2 extends apb_sequence;

    `uvm_object_utils(opcode_sequence_2)

    function new (string name="opcode_sequence_2");
        super.new(name);    
    endfunction

      virtual task body();

      start_item(item);
      item.paddr = 16'h80;
      item.pwrite =1;
      item.pwdata[2:0]     = 2; //OPCODE
      item.pwdata[7:3]     = 8;           //RS0
      item.pwdata[12:8]    = 4;           //RS1
      item.pwdata[20:16]   = 2;          //DST
      item.pwdata[31:24]   = 0; //IMM
      item.pwdata[15:13]   =  0; //Bits0
      item.pwdata[23:21]   =  0; //Bits0
      finish_item(item);
      get_response(item);
      
      endtask
endclass : opcode_sequence_2


class opcode_sequence_3 extends apb_sequence;

    `uvm_object_utils(opcode_sequence_3)

    function new (string name="opcode_sequence_3");
        super.new(name);    
    endfunction

      virtual task body();

      start_item(item);
      item.paddr = 16'h80;
      item.pwrite =1;
      item.pwdata[2:0]     = 3; //OPCODE
      item.pwdata[7:3]     = 13;           //RS0
      item.pwdata[12:8]    = 23;           //RS1
      item.pwdata[20:16]   = 23;          //DST
      item.pwdata[31:24]   = 158; //IMM
      item.pwdata[15:13]   =  0; //Bits0
      item.pwdata[23:21]   =  0; //Bits0
      finish_item(item);
      get_response(item);
      
      endtask
endclass : opcode_sequence_3


class opcode_sequence_4 extends apb_sequence;

    `uvm_object_utils(opcode_sequence_4)

    function new (string name="opcode_sequence_4");
        super.new(name);    
    endfunction

      virtual task body();

      start_item(item);
      item.paddr = 16'h80;
      item.pwrite =1;
      item.pwdata[2:0]     = 4; //OPCODE
      item.pwdata[7:3]     = 18;           //RS0
      item.pwdata[12:8]    = 16;           //RS1
      item.pwdata[20:16]   = 14;          //DST
      item.pwdata[31:24]   = 12; //IMM
      item.pwdata[15:13]   =  0; //Bits0
      item.pwdata[23:21]   =  0; //Bits0
      finish_item(item);
      get_response(item);
      
      endtask
endclass : opcode_sequence_4


class reg_h84_sequence extends apb_sequence;

    `uvm_object_utils(reg_h84_sequence)
    bit[1:0] clr_error;

    function new (string name="reg_h84_sequence");
        super.new(name);    
    endfunction

    virtual task body();
        start_item(item);
        item.paddr = 16'h84;
        item.pwrite =0;
        finish_item(item);

    get_response(item);
    clr_error = item.prdata;
      
      endtask
endclass : reg_h84_sequence


class reg_h88_sequence extends apb_sequence;

    `uvm_object_utils(reg_h88_sequence)
    rand bit[1:0] pwdata_error;
    function new (string name="reg_h88_sequence");
        super.new(name);    
    endfunction

      virtual task body();
      start_item(item);
      item.paddr = 16'h88;
      item.pwrite =1;
      item.pwdata = pwdata_error;
      finish_item(item);
      endtask
endclass : reg_h88_sequence


class reg_h8c_sequence extends apb_sequence;

    `uvm_object_utils(reg_h8c_sequence)

    function new (string name="reg_h8c_sequence");
        super.new(name);    
    endfunction

      virtual task body();
      start_item(item);
      item.paddr = 16'h8c;
      item.pwrite =1;
      item.pwdata =1;
      finish_item(item);
      
      endtask
endclass : reg_h8c_sequence


class reg_test_same_destination extends apb_sequence;

    `uvm_object_utils(reg_test_same_destination)

    function new (string name="reg_test_same_destination");
        super.new(name);    
    endfunction

      virtual task body();
        for(int i = 0; i<32 ;i++) begin
           start_item (item);
           if(!(item.randomize() with { paddr == i*4 ;
                                        pwdata == i*8+1;
                                        delay_psel inside {[0:15]} ;
                                        pwrite ==1 ;
                                       }))

            `uvm_error(get_type_name(), "rand_error")
           finish_item (item);
           get_response(item);
           start_item (item);
           if(!(item.randomize() with { paddr == i*4 ;
                                        delay_psel inside {[0:15]} ;
                                        pwrite ==0 ;
                                       }))

            `uvm_error(get_type_name(), "rand_error")
           finish_item (item);
           get_response(item);
           start_item (item);
           if(!(item.randomize() with { paddr == i*4 ;
                                        pwdata == i*26+2;
                                        delay_psel inside {[0:15]} ;
                                        pwrite ==1 ;
                                       }))

            `uvm_error(get_type_name(), "rand_error")
           finish_item (item);
           get_response(item);
           start_item (item);
           if(!(item.randomize() with { paddr == i*4 ;
                                        delay_psel inside {[0:15]} ;
                                        pwrite ==0 ;
                                       }))

            `uvm_error(get_type_name(), "rand_error")
           finish_item (item);
           get_response(item);
        end
      
      endtask
endclass : reg_test_same_destination


class reg_write_read_address extends apb_sequence;

  `uvm_object_utils(reg_write_read_address)

 
  function new (string name="reg_write_read_address");
      super.new(name);    
  endfunction

  virtual task body();

      for(int i = 0; i<32 ;i++) begin
           start_item (item);
           if(!(item.randomize() with { paddr == i*4 ;
                                        delay_psel inside {[0:15]} ;
                                        pwrite ==1 ;
                                       }))

            `uvm_error(get_type_name(), "rand_error")
           finish_item (item);
           get_response(item);
           start_item (item);
           if(!(item.randomize() with { paddr == i*4 ;
                                        delay_psel inside {[0:15]} ;
                                        pwrite ==0 ;
                                       }))

            `uvm_error(get_type_name(), "rand_error")
           finish_item (item);
           get_response(item);
        end

  endtask : body
endclass : reg_write_read_address


class reg_error_addres extends apb_sequence;

  `uvm_object_utils(reg_error_addres)

 
  function new (string name="reg_error_addres");
      super.new(name);    
  endfunction

  virtual task body();

      for(int i = 0; i<100 ;i++) begin
           start_item (item);
           if(!(item.randomize() with { paddr inside {['h0:16'h7f]} ;
                                        delay_psel inside {[0:15]} ;
                                        pwrite inside {[0:1]} ;
                                       }))

            `uvm_error(get_type_name(), "rand_error")

           finish_item (item);
           get_response(item);
        end

  endtask : body
endclass : reg_error_addres


class reg_b2bseq extends apb_sequence;

  `uvm_object_utils(reg_b2bseq)

 
  function new (string name="reg_b2bseq");
      super.new(name);    
  endfunction

  virtual task body();

      for(int i = 0; i<32 ;i++) begin
           start_item (item);
           if(!(item.randomize() with { pwdata == i*2;
                                        paddr == i*4 ;
                                        delay_psel ==0 ;
                                        pwrite ==1 ;
                                       }))

            `uvm_error(get_type_name(), "rand_error")
           finish_item (item);
           get_response(item);
        end
        for(int i = 0; i<32 ;i++) begin
           start_item (item);
           if(!(item.randomize() with { pwdata == i*2;
                                        paddr == i*4 ;
                                        delay_psel ==0 ;
                                        pwrite ==0 ;
                                       }))

            `uvm_error(get_type_name(), "rand_error")
           finish_item (item);
           get_response(item);
        end

  endtask : body
endclass : reg_b2bseq


class reg_fix_delay extends apb_sequence;

  `uvm_object_utils(reg_fix_delay)

 
  function new (string name="reg_fix_delay");
      super.new(name);    
  endfunction

  virtual task body();

      for(int i = 0; i<32 ;i++) begin
           start_item (item);
           if(!(item.randomize() with { pwdata == i*2;
                                        paddr == i*4 ;
                                        delay_psel inside {[0:15]} ;
                                        pwrite ==1 ;
                                       }))

            `uvm_error(get_type_name(), "rand_error")
           finish_item (item);
           get_response(item);
        end
        for(int i = 0; i<32 ;i++) begin
           start_item (item);
           if(!(item.randomize() with { pwdata == i*2;
                                        paddr == i*4 ;
                                        delay_psel inside {[0:15]} ;
                                        pwrite ==0 ;
                                       }))

            `uvm_error(get_type_name(), "rand_error")
           finish_item (item);
           get_response(item);
        end

  endtask : body
endclass : reg_fix_delay


class sequence_field_with_0 extends apb_sequence;

    `uvm_object_utils(sequence_field_with_0)

    function new (string name="sequence_field_with_0");
        super.new(name);    
    endfunction

      virtual task body();

      start_item(item);
      item.paddr = 16'h80;
      item.pwrite =1;
      item.pwdata[2:0]     = 0; //OPCODE
      item.pwdata[7:3]     = 0;           //RS0
      item.pwdata[12:8]    = 2;           //RS1
      item.pwdata[20:16]   = 4;          //DST
      item.pwdata[31:24]   = 6; //IMM
      item.pwdata[15:13]   =  0; //Bits0
      item.pwdata[23:21]   =  0; //Bits0
      finish_item(item);
      get_response(item);
      
      endtask
endclass : sequence_field_with_0


class sequence_field_with_1 extends apb_sequence;

    `uvm_object_utils(sequence_field_with_1)

    function new (string name="sequence_field_with_1");
        super.new(name);    
    endfunction

      virtual task body();

      start_item(item);
      item.paddr = 16'h80;
      item.pwrite =1;
      item.pwdata[2:0]     = 0; //OPCODE
      item.pwdata[7:3]     = 0;           //RS0
      item.pwdata[12:8]    = 2;           //RS1
      item.pwdata[20:16]   = 4;          //DST
      item.pwdata[31:24]   = 6; //IMM
      item.pwdata[15:13]   =  1; //Bits0
      item.pwdata[23:21]   =  1; //Bits0
      finish_item(item);
      get_response(item);
      
      endtask
endclass : sequence_field_with_1


class opcode_sequence_0_to_4 extends apb_sequence;

    `uvm_object_utils(opcode_sequence_0_to_4)

    function new (string name="opcode_sequence_0_to_4");
        super.new(name);    
    endfunction

      virtual task body();

       start_item (item);
     if(!(item.randomize() with {paddr == 'h80 ;
                                 delay_psel inside {[0:15]};
                                 pwrite == 1;
                                pwdata[2:0] inside {[0:4]};         //OPCODE
                                pwdata[7:3] inside {[0:31]};        //RS0    
                                pwdata[12:8] inside {[0:31]};       //RS1   
                                pwdata[20:16] inside {[0:31]};      //DST      
                                pwdata[31:24] inside {[0:255]};     //IMM 
                                pwdata[15:13]   ==  0; //Bits0
                                pwdata[23:21]   ==  0; //Bits0
                                 }))
      `uvm_error(get_type_name(), "rand_error")
     finish_item (item);
     get_response(item);
      
      endtask
endclass : opcode_sequence_0_to_4


class opcode_sequence_read extends apb_sequence;

    `uvm_object_utils(opcode_sequence_read)

    function new (string name="opcode_sequence_read");
        super.new(name);    
    endfunction

      virtual task body();

       start_item (item);
     if(!(item.randomize() with {paddr == 'h80 ;
                                 delay_psel ==0;
                                 pwrite == 0;
                                 }))
      `uvm_error(get_type_name(), "rand_error")
     finish_item (item);
     get_response(item);
      
      endtask
endclass : opcode_sequence_read


class opcode_sequence_5_to_7 extends apb_sequence;

    `uvm_object_utils(opcode_sequence_5_to_7)

    function new (string name="opcode_sequence_5_to_7");
        super.new(name);    
    endfunction

      virtual task body();

     start_item (item);
     if(!(item.randomize() with {paddr == 'h80 ;
                                 delay_psel ==0;
                                 pwrite == 1;
                                pwdata[2:0] inside {[5:7]}; //OPCODE
                                pwdata[7:3] inside {[0:31]};        
                                pwdata[12:8] inside {[0:31]};          
                                pwdata[20:16] inside {[0:31]};          
                                pwdata[31:24] inside {[0:255]};   
                                pwdata[15:13]   ==  0; //Bits0
                                pwdata[23:21]   ==  0; //Bits0
                                 }))
      `uvm_error(get_type_name(), "rand_error")
     finish_item (item);
     get_response(item);
      
      endtask
endclass : opcode_sequence_5_to_7


class apb_write_all_addres_sequence extends apb_sequence;

  `uvm_object_utils(apb_write_all_addres_sequence)

 
  function new (string name="apb_write_all_addres_sequence");
      super.new(name);    
  endfunction

  virtual task body();

      for(int i = 0; i<128 ;i++) begin
           start_item (item);
           if(!(item.randomize() with { pwdata == i*2;
                                        paddr == i ;
                                        delay_psel ==0 ;
                                        pwrite ==1 ;
                                       }))

            `uvm_error(get_type_name(), "rand_error")
           finish_item (item);
           get_response(item);
        end
  endtask : body
endclass : apb_write_all_addres_sequence


class apb_read_all_addres_sequence extends apb_sequence;

  `uvm_object_utils(apb_read_all_addres_sequence)

 
  function new (string name="apb_read_all_addres_sequence");
      super.new(name);    
  endfunction

  virtual task body();

      for(int i = 0; i<128 ;i++) begin
           start_item (item);
           if(!(item.randomize() with { 
                                        paddr == i ;
                                        delay_psel ==0;
                                        pwrite ==0 ;
                                       }))

            `uvm_error(get_type_name(), "rand_error")
           finish_item (item);
           get_response(item);
        end
  endtask : body
endclass : apb_read_all_addres_sequence


class apb_write_ones_by_one_sequence extends apb_sequence;

    `uvm_object_utils(apb_write_ones_by_one_sequence)


    function new (string name="apb_write_ones_by_one_sequence");
        super.new(name);    
    endfunction

    virtual task body();

        int unsigned shift_data = 1;
        for(int i = 0; i<32 ;i++) begin
         for(int j = 0; j<32 ;j++) begin
                start_item (item);
                if(!(item.randomize() with {pwdata == shift_data;
                                            paddr == i*4 ;
                                            delay_psel == 2 ;
                                            pwrite == 1;}))
                 `uvm_error(get_type_name(), "rand_error")
                finish_item (item);
                get_response(item);
                if(j==31) begin 
                shift_data = 1; end else begin
                shift_data = shift_data<<1;
                end
           end
       end
    endtask : body
endclass : apb_write_ones_by_one_sequence


class apb_write_ones_by_zero_sequence extends apb_sequence;

    `uvm_object_utils(apb_write_ones_by_zero_sequence)

 
    function new (string name="apb_write_ones_by_zero_sequence");
        super.new(name);    
    endfunction


    virtual task body();

        int unsigned shift_data = 'hFFFFFFFE;
        int unsigned FF_data = 0;
        for(int i = 0; i<32 ;i++) begin
         for(int j = 0; j<32 ;j++) begin
                start_item (item);
                if(!(item.randomize() with {pwdata == shift_data;
                                            paddr == i*4 ;
                                            delay_psel == 2 ;
                                            pwrite == 1;}))
                 `uvm_error(get_type_name(), "rand_error")
                finish_item (item);
                get_response(item);
                if(j==31) begin 
                shift_data = 'hFFFFFFFE; end else begin
                shift_data = shift_data<<1;
                shift_data = shift_data+1;
                end
           end
       end
    endtask : body
endclass : apb_write_ones_by_zero_sequence


class apb_opcode_cum_vreau_eu extends apb_sequence;

    `uvm_object_utils(apb_opcode_cum_vreau_eu)

 
    function new (string name="apb_opcode_cum_vreau_eu");
        super.new(name);    
    endfunction


    virtual task body();
    for(int i=0;i<32;i++) begin
        for(int j=0;j<32;j++) begin
            for(int k=0;k<32;k++)begin
         start_item (item);
           if(!(item.randomize() with {paddr == 'h80 ;
                                 delay_psel ==0;
                                 pwrite == 1;
                                pwdata[2:0] == 0;         //OPCODE
                                pwdata[7:3] == k;        //RS0    
                                pwdata[12:8] ==j;       //RS1   
                                pwdata[20:16] ==i;      //DST      
                                pwdata[31:24] ==1;     //IMM 
                                pwdata[15:13]   ==  0; //Bits0
                                pwdata[23:21]   ==  0; //Bits0}))
           }));
                 `uvm_error(get_type_name(), "rand_error")
                finish_item (item);
                get_response(item);
            end
        end
    end

    endtask : body
endclass : apb_opcode_cum_vreau_eu