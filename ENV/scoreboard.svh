// ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// Module name: scoreboard
// HDL        : UVM
// Author     : Paulovici Vlad-Marian
// Description: A verification component that contains checkers and verifies the functionality of a design. 
//              It usually receives transaction level objects captured from the interfaces of a DUT via Analysys Ports.
//              The scoreboard can compare between the expected and actual values to see if they match.
// Date       : 28 August, 2023
// -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
class scoreboard extends uvm_scoreboard;
    
  `uvm_component_utils(scoreboard)
  `uvm_analysis_imp_decl(_apb_port)
  `uvm_analysis_imp_decl(_output_port)
  `uvm_analysis_imp_decl(_reset_port)

uvm_analysis_imp_apb_port #(apb_item ,scoreboard) ap_imp_apb;
uvm_analysis_imp_reset_port #(reset_item, scoreboard) ap_imp_reset;
uvm_analysis_imp_output_port #(output_item ,scoreboard) ap_imp_output;

function new(string name, uvm_component parent);
  super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
  ap_imp_apb = new("ap_imp_apb", this);
  ap_imp_reset = new("ap_imp_reset", this);
  ap_imp_output = new("ap_imp_output", this);
endfunction

  bit [5:0]   pwdata_address    ;   //  Value for addres where to write the value for virtual memory  
  bit [7:0]   pwdata_operand1   ;   //  Value for operand1
  bit [7:0]   pwdata_operand2   ;   //  Value for operand2
  bit [3:0]   pwdata_constant   ;   //  Value for constant
  bit [1:0]   pwdata_shift      ;   //  Value for shift 00 -> shift with 0, 01 -> shift with 1 bit, 10 -> shift with 2 bits, 11 -> shift with 3 bits
  bit [3:0]   pwdata_opcode     ;   //  Value for opcode
                                    //  OPCODE 0001 -> ADD1         -> op1+op2
                                    //  OPCODE 0010 -> ADD2         -> op1+cont
                                    //  OPCODE 0011 -> ADD3         -> op2+cont
                                    //  OPCODE 0100 -> SHIFT_OP1    -> shift op1  
                                    //  OPCODE 0101 -> AND          -> op1 and op2
                                    //  OPCODE 0110 -> OR       
                                    //  OPCODE 0111 -> NAND
                                    //  OPCODE 1000 -> NOR          
                                    //  OPCODE 1001 -> COMP         -> op1 > op2 => 1, op1 < op2 => 2, op1 == op2 => 0

  bit [5:0]   addres_read       ;
  bit [8:0]   Resultmem [15]    ;
  bit [8:0]   ResultOutput      ;
  bit reset;


  virtual function void write_apb_port  (apb_item item);

  //                                  ----------------STARTING THE SCOREBOARD---------
  uvm_info (get_type_name(), $sformatf ("START THE SCOREBOARD "), UVM_LOW);
  $display("At %0t The item is :", $time)    ;

  uvm_info (get_type_name(), $sformatf ("PWRITE Check"), UVM_LOW);
  if(item.pwrite) begin
    pwdata_address   = item.pwdata[5:0]  ;
    pwdata_operand1  = item.pwdata[13:6] ;
    pwdata_operand2  = item.pwdata[21:14];
    pwdata_constant  = item.pwdata[25:22];
    pwdata_shift     = item.pwdata[27:26];
    pwdata_opcode    = item.pwdata[31:28];
  `uvm_info(get_type_name(), $sformatf ("For Configuration pwrite = %b , pwdata =%b, PWDATA_ADDR = %d, PWDATA_OPERAND1 = %d, PWDATA_OPERAND2 = %d, PWDATA_CONSTANT = %d, PWDATA_SHIFT = %d, PWDATA_OPCODE = %d",item.pwrite,item.pwdata , pwdata_address, pwdata_operand1, pwdata_operand2, pwdata_constant, pwdata_shift, pwdata_opcode), UVM_LOW);

  end else 
    addres_read      = item.paddr;
  `uvm_info(get_type_name(), $sformatf ("For Configuration pwrite = %b , paddr = %d, internal addr =%d", item.pwrite, item.paddr, addres_read), UVM_LOW);

  uvm_info (get_type_name(), $sformatf ("OPCODE Check"), UVM_LOW);

  if(item.pwrite) begin
  if(pwdata_opcode == 4'b0001)begin
    ResultOutput = pwdata_operand1 + pwdata_operand2;
    Resultmem [pwdata_address] = ResultOutput;
  `uvm_info(get_type_name(), $sformatf ("For OPCODE = %b , Result = %d, Storage at =%d", pwdata_opcode, ResultOutput, Resultmem[pwdata_address]), UVM_LOW);
  end
  if(pwdata_opcode == 4'b0010)begin
    ResultOutput = pwdata_operand1 + pwdata_constant;
    Resultmem [pwdata_address] = ResultOutput;
  `uvm_info(get_type_name(), $sformatf ("For OPCODE = %b , Result = %d, Storage at =%d", pwdata_opcode, ResultOutput, Resultmem[pwdata_address]), UVM_LOW);
  end
  if(pwdata_opcode == 4'b0011)begin
    ResultOutput = pwdata_operand2 + pwdata_constant;
    Resultmem [pwdata_address] = ResultOutput;
  `uvm_info(get_type_name(), $sformatf ("For OPCODE = %b , Result = %d, Storage at =%d", pwdata_opcode, ResultOutput, Resultmem[pwdata_address]), UVM_LOW);
  end
  if(pwdata_opcode == 4'b0100)begin
    ResultOutput = pwdata_operand1 << pwdata_shift;
    Resultmem [pwdata_address] = ResultOutput;
  `uvm_info(get_type_name(), $sformatf ("For OPCODE = %b , Result = %d, Storage at =%d", pwdata_opcode, ResultOutput, Resultmem[pwdata_address]), UVM_LOW);
  end
  if(pwdata_opcode == 4'b0101)begin
    ResultOutput = pwdata_operand1 & pwdata_operand2;
    Resultmem [pwdata_address] = ResultOutput;
  `uvm_info(get_type_name(), $sformatf ("For OPCODE = %b , Result = %d, Storage at =%d", pwdata_opcode, ResultOutput, Resultmem[pwdata_address]), UVM_LOW);
  end
  if(pwdata_opcode == 4'b0110)begin
    ResultOutput = pwdata_operand1 | pwdata_operand2;
    Resultmem [pwdata_address] = ResultOutput;
  `uvm_info(get_type_name(), $sformatf ("For OPCODE = %b , Result = %d, Storage at =%d", pwdata_opcode, ResultOutput, Resultmem[pwdata_address]), UVM_LOW);
  end
  if(pwdata_opcode == 4'b0111)begin
    ResultOutput = pwdata_operand1 ^ pwdata_operand2;
    Resultmem [pwdata_address] = ResultOutput;
  `uvm_info(get_type_name(), $sformatf ("For OPCODE = %b , Result = %d, Storage at =%d", pwdata_opcode, ResultOutput, Resultmem[pwdata_address]), UVM_LOW);
  end
    if(pwdata_opcode == 4'b1000)begin
    ResultOutput = ~(pwdata_operand1 & pwdata_operand2);
    Resultmem [pwdata_address] = ResultOutput;
  `uvm_info(get_type_name(), $sformatf ("For OPCODE = %b , Result = %d, Storage at =%d", pwdata_opcode, ResultOutput, Resultmem[pwdata_address]), UVM_LOW);
  end
  if(pwdata_opcode == 4'b1001)begin
    ResultOutput = ~(pwdata_operand1 | pwdata_operand2);
    Resultmem [pwdata_address] = ResultOutput;
  `uvm_info(get_type_name(), $sformatf ("For OPCODE = %b , Result = %d, Storage at =%d", pwdata_opcode, ResultOutput, Resultmem[pwdata_address]), UVM_LOW);
  end
  if(pwdata_opcode == 4'b1010)begin
    ResultOutput = ~(pwdata_operand1 ^ pwdata_operand2);
    Resultmem [pwdata_address] = ResultOutput;
  `uvm_info(get_type_name(), $sformatf ("For OPCODE = %b , Result = %d, Storage at =%d", pwdata_opcode, ResultOutput, Resultmem[pwdata_address]), UVM_LOW);
  end
  if(pwdata_opcode == 4'b1011 && pwdata_operand1 == pwdata_operand2)begin
    ResultOutput = 9'd0;
    Resultmem [pwdata_address] = ResultOutput;
  `uvm_info(get_type_name(), $sformatf ("For OPCODE = %b , Result = %d, Storage at =%d", pwdata_opcode, ResultOutput, Resultmem[pwdata_address]), UVM_LOW);
  end
  if(pwdata_opcode == 4'b1011 && pwdata_operand1 < pwdata_operand2)begin
    ResultOutput = 9'd2;
    Resultmem [pwdata_address] = ResultOutput;
  `uvm_info(get_type_name(), $sformatf ("For OPCODE = %b , Result = %d, Storage at =%d", pwdata_opcode, ResultOutput, Resultmem[pwdata_address]), UVM_LOW);
  end
  if(pwdata_opcode == 4'b1011 && pwdata_operand1 > pwdata_operand2)begin
    ResultOutput = 9'd1;
    Resultmem [pwdata_address] = ResultOutput;
  `uvm_info(get_type_name(), $sformatf ("For OPCODE = %b , Result = %d, Storage at =%d", pwdata_opcode, ResultOutput, Resultmem[pwdata_address]), UVM_LOW);
  end
  if(pwdata_opcode == 4'b0000)begin
  `uvm_error(get_type_name (),$sformatf ("The OPCODE value need to be a non-zero value"))
  `uvm_info(get_type_name(), $sformatf ("For OPCODE = %b", pwdata_opcode), UVM_LOW);
  end
  end

  if(~(item.pwrite)) begin
    ResultOutput = Resultmem [addres_read];
    `uvm_info(get_type_name(), $sformatf ("For PWRITE = %b , Result = %d, Storage at =%d", item.pwrite, ResultOutput, Resultmem[addres_read]), UVM_LOW);
  end
  endfunction


  virtual function void write_reset_port  (reset_item item_reset);
    $display("%s", item_reset.sprint());
    `uvm_info (get_type_name(), $sformatf ("START THE SCOREBOARD FOR H_RESET = %d", item_reset.hw_rst), UVM_LOW);
    if(!item_reset.hw_rst)begin
      for (int i=0; i<16; i++) Resultmem[i]=0;
      pwdata_address  = 0;
      pwdata_operand1 = 0;
      pwdata_operand2 = 0;
      pwdata_constant = 0;
      pwdata_shift    = 0;   
      pwdata_opcode   = 0;  
      addres_read     = 0;    
      ResultOutput    = 0;
       for (int i=0; i<=15; i++) begin
      `uvm_info (get_type_name (), $sformatf ("At ADDR = %d, the Resultmem[%d] has %d", i, i, Resultmem[(i)]), UVM_LOW);     end
    `uvm_info (get_type_name (), $sformatf ("Reset ALL pwdata_address = %h, pwdata_operand1 = %h, pwdata_operand2 = %h, pwdata_constant = %h, pwdata_shift = %h, pwdata_opcode = %h, addres_read = %h, ResultOutput = %h,", pwdata_address, pwdata_operand1, pwdata_operand2, pwdata_constant, pwdata_shift, pwdata_opcode, addres_read, ResultOutput), UVM_LOW);
    end
    if(!item_reset.sw_rst)begin
      pwdata_address  = 0;
      pwdata_operand1 = 0;
      pwdata_operand2 = 0;
      pwdata_constant = 0;
      pwdata_shift    = 0;   
      pwdata_opcode   = 0;  
      addres_read     = 0;    
      ResultOutput    = 0; 
    `uvm_info (get_type_name (), $sformatf ("Reset just the Value for signal pwdata_address = %h, pwdata_operand1 = %h, pwdata_operand2 = %h, pwdata_constant = %h, pwdata_shift = %h, pwdata_opcode = %h, addres_read = %h, ResultOutput = %h,", pwdata_address, pwdata_operand1, pwdata_operand2, pwdata_constant, pwdata_shift, pwdata_opcode, addres_read, ResultOutput), UVM_LOW);
    end
  endfunction


virtual function void write_output_port  (output_item item_output);
  $display("%s", item_output.sprint());
  if (item_output.OutputResult != ResultOutput)
  `uvm_error(get_type_name (),$sformatf ("The Output doesnt match. Result in scoreboard = %d, Result from monitor = %d", ResultOutput, item_output.OutputResult))
endfunction


endclass //req_ack_scoreboard extends uvm_scoreboard