// ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// Module name: afvip_scoreboard
// HDL        : UVM
// Author     : Paulovici Vlad-Marian
// Description: A verification component that contains checkers and verifies the functionality of a design. 
//              It usually receives transaction level objects captured from the interfaces of a DUT via Analysys Ports.
//              The scoreboard can compare between the expected and actual values to see if they match.
// Date       : 28 August, 2023
// -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
class afvip_scoreboard extends uvm_scoreboard;
    
  `uvm_component_utils(afvip_scoreboard)
  `uvm_analysis_imp_decl(_apb_port)
  `uvm_analysis_imp_decl(_interrupt_port)
  `uvm_analysis_imp_decl(_reset_port)

uvm_analysis_imp_apb_port #(afvip_apb_item ,afvip_scoreboard) ap_imp;
uvm_analysis_imp_reset_port #(afvip_reset_item, afvip_scoreboard) ap_imp_reset;
uvm_analysis_imp_interrupt_port #(afvip_intrr_item ,afvip_scoreboard) ap_imp_interrupt;

function new(string name, uvm_component parent);
  super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
  ap_imp = new("ap_imp", this);
  ap_imp_reset = new("ap_imp_reset", this);
  ap_imp_interrupt = new("ap_imp_interrupt", this);
endfunction

  bit [31:0] mem [32];
  bit [2:0] opcode;
  bit [4:0] RS0;
  bit [4:0] RS1;
  bit [4:0] DST;
  bit [7:0] imm;
  bit ev_ctrl_start;
  bit ev_ctrl_error;
  bit [31:0] opcode_ver;
  bit reset;

virtual function void write_apb_port  (afvip_apb_item item);

//////////////////////////////////////////////////////----STARTING THE SCOREBOARD----////////////////////////////////////////////////////////////////////////////////////////////
  `uvm_info (get_type_name(), $sformatf ("START THE SCOREBOARD FOR PADDR = %h", item.paddr), UVM_LOW);
  $display("At %0t The item is :", $time)    ;
        
//////////////////////////////////////////////////////----Verify the address multiple of 4----////////////////////////////////////////////////////////////////////////////////////////////

  if (item.paddr % 4 != 0 ) begin  
    `uvm_error (get_type_name (), "The Address isnt a multiple of 4") 
    ev_ctrl_error =1;end else begin
    $display("%s", item.sprint()); end
          
//////////////////////////////////////////////////////----Virtual memory----////////////////////////////////////////////////////////////////////////////////////////////

  if(item.paddr < 'h80) begin
    if(item.pwrite == 1) begin
      mem[(item.paddr/4)] = item.pwdata;
      `uvm_info (get_type_name (), $sformatf ("RECEIVED PWDATA = %d, RECEIVED ADDR =%h, RECEIVED in mem[%d] =%d",item.pwdata, item.paddr, item.paddr/4, mem[(item.paddr/4)]), UVM_LOW);
    end else begin
    if(mem[(item.paddr/4)] != item.prdata)
      `uvm_error (get_type_name(), $sformatf ("ERROR :EXPECTED  Read data  = %d, RECEIVED rdata = %d",mem[(item.paddr/4)], item.prdata))   else  
      `uvm_info (get_type_name(), $sformatf ("RECEIVED PRDATA = %d, RECEIVED ADDR =%h",item.prdata, item.paddr), UVM_LOW);                 end

    for (int i=0; i<=item.paddr/4; i++) begin
      `uvm_info (get_type_name (), $sformatf ("At PADDR = %h, the mem[%d] has %d", i*4, i, mem[(i)]), UVM_LOW);     end
  end

//////////////////////////////////////////////////////----Virtual Configuration Register----////////////////////////////////////////////////////////////////////////////////////////////

  if(item.paddr == 'h80 && item.pwrite == 1) begin
    `uvm_info (get_type_name (), $sformatf ("The Address 80 has reach, the configuration of register is %d",item.pwdata), UVM_LOW);
    opcode  = item.pwdata[2:0]  ;
    RS0     = item.pwdata[7:3]  ;
    RS1     = item.pwdata[12:8] ;
    DST     = item.pwdata[20:16];
    imm     = item.pwdata[31:24];

    `uvm_info(get_type_name(), $sformatf ("For Configuration register we have OPCODE =%d, RS0 = %d, RS1 =%d, DST = %d, imm = %d", opcode, RS0, RS1, DST, imm), UVM_LOW);
    `uvm_info(get_type_name(), $sformatf ("With Value RS0 = %d, RS1 =%d, DST = %d",  mem[RS0], mem[RS1], mem[DST]), UVM_LOW);
    
    if(item.pwdata[15:13] != 'd0)begin
      `uvm_error(get_type_name (),$sformatf ("ERROR : The configuration register is wrong! Data of 13, 14 or 15 bits need to be 0"))
      `uvm_info(get_type_name(), $sformatf ("Expected Value = 000 , Received Value = %b", item.pwdata[15:13]), UVM_LOW);
      ev_ctrl_error =1;
    end

    if(item.pwdata[23:21] != 'd0)begin
      `uvm_error(get_type_name (),$sformatf ("ERROR : The configuration register is wrong! Data of 21, 22 or 23 bits need to be 0"))
      `uvm_info(get_type_name(), $sformatf ("Expected Value = 000 , Received Value = %b", item.pwdata[23:21]), UVM_LOW);
      ev_ctrl_error =1;
    end

    if(item.pwdata[2:0] > 'd4) begin
      `uvm_error (get_type_name (),$sformatf ("ERROR : The configuration register is wrong! OPCODE is %d", opcode))
      ev_ctrl_error =1;
    end
  end

  if(item.paddr == 'h80 && item.pwrite == 0) begin
    `uvm_info (get_type_name (), $sformatf ("The Address 80 has reach, the configuration of register is %d",item.prdata), UVM_LOW);
    opcode  = item.prdata[2:0]  ;
    RS0     = item.prdata[7:3]  ;
    RS1     = item.prdata[12:8] ;
    DST     = item.prdata[20:16];
    imm     = item.prdata[31:24];

    `uvm_info(get_type_name(), $sformatf ("For Configuration register we have OPCODE =%d, RS0 = %d, RS1 =%d, DST = %d, imm = %d", opcode, RS0, RS1, DST, imm), UVM_LOW);
    `uvm_info(get_type_name(), $sformatf ("With Value RS0 = %d, RS1 =%d, DST = %d",  mem[RS0], mem[RS1], mem[DST]), UVM_LOW);
    
    if(item.prdata[15:13] != 'd0)begin
      `uvm_error(get_type_name (),$sformatf ("ERROR : The configuration register is wrong! Data of 13, 14 or 15 bits need to be 0"))
      `uvm_info(get_type_name(), $sformatf ("Expected Value = 000 , Received Value = %b", item.prdata[15:13]), UVM_LOW);
      ev_ctrl_error =1;
    end

    if(item.prdata[23:21] != 'd0)begin
      `uvm_error(get_type_name (),$sformatf ("ERROR : The configuration register is wrong! Data of 21, 22 or 23 bits need to be 0"))
      `uvm_info(get_type_name(), $sformatf ("Expected Value = 000 , Received Value = %b", item.prdata[23:21]), UVM_LOW);
      ev_ctrl_error =1;
    end

    if(item.prdata[2:0] > 'd4) begin
      `uvm_error (get_type_name (),$sformatf ("ERROR : The configuration register is wrong! OPCODE is %d", opcode))
      ev_ctrl_error =1;
    end
  end

//////////////////////////////////////////////////////----Event start on address 'h8c----////////////////////////////////////////////////////////////////////////////////////////////

  if(item.paddr == 'h8c && item.pwrite ==1)begin
    ev_ctrl_start = item.pwdata;
  end
  if(item.paddr == 'h8c && item.pwrite ==0)begin
    ev_ctrl_start = item.prdata;
  end

//////////////////////////////////////////////////////----Configuration register start----////////////////////////////////////////////////////////////////////////////////////////////

  if(ev_ctrl_start == 1)begin
     
    if(opcode == 'd0) begin
      mem[DST]          = mem[RS0] + imm;
      `uvm_info (get_type_name(), $sformatf ("For OPCODE %d the operation is %d+%d=%d", opcode, mem[RS0], imm,  mem[DST]), UVM_LOW);
      `uvm_info (get_type_name(), $sformatf ("Result for this: %d ", mem[DST], ), UVM_LOW);       
    end

    if(opcode == 'd1) begin
      mem[DST]          = mem[RS0] * imm;
      `uvm_info (get_type_name(), $sformatf ("For OPCODE %d the operation is %d*%d =%d", opcode, mem[RS0], imm, mem[DST]), UVM_LOW);
      `uvm_info (get_type_name(), $sformatf ("Result for this: %d ", mem[DST]), UVM_LOW);         
    end

    if(opcode == 'd2) begin
      mem[DST]          = mem[RS0] + mem[RS1];
      `uvm_info (get_type_name(), $sformatf ("For OPCODE %d the operation is %d + %d = %d", opcode, mem[RS0], mem[RS1], mem[DST]), UVM_LOW);
      `uvm_info (get_type_name(), $sformatf ("Result for this: %d ", mem[DST]), UVM_LOW);         
    end

    if(opcode == 'd3) begin
      mem[DST]          = mem[RS0] * mem[RS1];
      `uvm_info (get_type_name(), $sformatf ("For OPCODE %d the operation is %d * %d = %d", opcode, mem[RS0], mem[RS1], mem[DST]), UVM_LOW);
      `uvm_info (get_type_name(), $sformatf ("Result for this: %d ", mem[DST]), UVM_LOW);         
    end

    if(opcode == 'd4) begin
      mem[DST]          = mem[RS0] * mem[RS1] + imm;
      `uvm_info (get_type_name(), $sformatf ("For OPCODE %d the operation is %d*%d+%d=%d", opcode, mem[RS0], mem[RS1], imm,  mem[DST]  ), UVM_LOW);
      `uvm_info (get_type_name(), $sformatf ("Result for this: %d ", mem[DST]), UVM_LOW);         
    end

    ev_ctrl_start =0;

    `uvm_info (get_type_name (), $sformatf ("After The Start of configuration register, we have"), UVM_LOW);
    for (int i=0; i<32; i++) begin
    `uvm_info (get_type_name (), $sformatf ("At PADDR = %h, the mem[%d] has %d", i*4, i, mem[(i)]), UVM_LOW);   
    end
  
  end 
    
  if(ev_ctrl_error)
  `uvm_error(get_type_name (),$sformatf ("Signal for Error is high in scoreboard, check the rules"))
  ev_ctrl_error=0;
    
endfunction

virtual function void write_interrupt_port  (afvip_intrr_item item_passive);
  $display("%s", item_passive.sprint());
endfunction

virtual function void write_reset_port  (afvip_reset_item item_reset);
  $display("%s", item_reset.sprint());
  `uvm_info (get_type_name(), $sformatf ("START THE SCOREBOARD FOR RESET_low = %d", item_reset.rst_n), UVM_LOW);
  if(!item_reset.rst_n)begin
    for (int i=0; i<32; i++) mem[i]=0;
    opcode  = 0;
    RS0     = 0;
    RS1     = 0;
    DST     = 0;
    imm     = 0;
  end

endfunction    



endclass //req_ack_scoreboard extends uvm_scoreboard