class apb_coverage extends uvm_subscriber #(apb_item);

  //----------------------------------------------------------------------------
  `uvm_component_utils(apb_coverage)
  //----------------------------------------------------------------------------
  apb_item cov_item;
  // virtual afvip_if vif;
  //----------------------------------------------------------------------------
  function new(string name="apb_coverage",uvm_component parent);
    super.new(name,parent);
    Cov_reg = new();
    Cov_delay = new();
    Cov_pwdata_addr = new();
    Cov_pwdata_op1 = new();
    Cov_pwdata_op2 = new();
    Cov_pwdata_const = new();
    Cov_pwdata_shift = new();
    Cov_data_read = new();
    Cov_opcode = new();
    Cov_pwrite = new();
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------

  real reg_cov;
  real delay_cov;
  real data_addr_cov;
  real data_op1_cov;
  real data_op2_cov;
  real data_const_cov;
  real data_shift_cov;
  real data_read_cov;
  real opcode_cov;
  real reg_pwrite;

  //----------------------------------------------------------------------------
  covergroup Cov_reg;
    PADDR: coverpoint cov_item.paddr {
        bins reg00 ={'d0};
        bins reg01 ={'d1};
        bins reg02 ={'d2};
        bins reg03 ={'d3};
        bins reg04 ={'d4};
        bins reg05 ={'d5};
        bins reg06 ={'d6};
        bins reg07 ={'d7};
        bins reg08 ={'d8};
        bins reg09 ={'d9};
        bins reg10 ={'d10};
        bins reg11 ={'d11};
        bins reg12 ={'d12};
        bins reg13 ={'d13};
        bins reg14 ={'d14};
        bins reg15 ={'d15};
        // bins invalid_addresses[1] = {[32'd16: $]};
     }
  endgroup:Cov_reg;
//----------------------------------------------------------------------------
  //----------------------------------------------------------------------------
  covergroup Cov_pwdata_addr;
    PWDATA: coverpoint cov_item.pwdata[5:0] {
        bins reg00 ={'d0};
        bins reg01 ={'d1};
        bins reg02 ={'d2};
        bins reg03 ={'d3};
        bins reg04 ={'d4};
        bins reg05 ={'d5};
        bins reg06 ={'d6};
        bins reg07 ={'d7};
        bins reg08 ={'d8};
        bins reg09 ={'d9};
        bins reg10 ={'d10};
        bins reg11 ={'d11};
        bins reg12 ={'d12};
        bins reg13 ={'d13};
        bins reg14 ={'d14};
        bins reg15 ={'d15};
    }
  endgroup
  //----------------------------------------------------------------------------

    covergroup Cov_data_read;
    PRDATA: coverpoint cov_item.prdata {

      bins interval [3]  = {[6'h0:      6'h3F]};

    }
  endgroup
  //----------------------------------------------------------------------------
  covergroup Cov_pwdata_op1;
    PWDATA: coverpoint cov_item.pwdata[13:6] {
        bins interval[10] ={['b0 : $]};
    }
  endgroup
   //-----------------------------------------------------------------------------

     //----------------------------------------------------------------------------
  covergroup Cov_pwdata_op2;
    PWDATA: coverpoint cov_item.pwdata[21:14] {
        bins interval[10] ={['b0 : $]};
    }
  endgroup
   //-----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  covergroup Cov_pwdata_const;
    PWDATA: coverpoint cov_item.pwdata[25:22] {
        bins interval[5] ={['b0 : $]};
    }
  endgroup
   //-----------------------------------------------------------------------------

    //----------------------------------------------------------------------------
  covergroup Cov_pwdata_shift;
    PWDATA: coverpoint cov_item.pwdata[27:26] {
        bins interval[4] ={['b0 : $]};
    }
  endgroup
   //-----------------------------------------------------------------------------
  //----------------------------------------------------------------------------
  covergroup Cov_opcode;
    PWDATA: coverpoint cov_item.pwdata[31:28] {
        bins opcode00 ={'b0000};
        bins opcode01 ={'b0001};
        bins opcode02 ={'b0010};
        bins opcode03 ={'b0011};
        bins opcode04 ={'b0100};
        bins opcode05 ={'b0101};
        bins opcode06 ={'b0110};
        bins opcode07 ={'b0111};
        bins opcode08 ={'b1000};
        bins opcode09 ={'b1001};
    }
  endgroup
   //-----------------------------------------------------------------------------

  //---------------------  write method ----------------------------------------
  covergroup Cov_pwrite;
    PWRITE: coverpoint cov_item.pwrite {
      bins min = {0};
      bins max = {1}; 
    }
  endgroup
  //-------------------------------------------------------------------------------
  covergroup Cov_delay;
    delay_psel: coverpoint cov_item.delay_psel {
      bins interval[4] = {['d0:$]};
    }
  endgroup

 function void write(apb_item t);
    cov_item=t;
    Cov_reg.sample();
    Cov_delay.sample();
    Cov_pwdata_addr.sample();
    Cov_pwdata_op1.sample();
    Cov_pwdata_op2.sample();
    Cov_pwdata_shift.sample();
    Cov_pwdata_const.sample();
    Cov_pwrite.sample();
    Cov_data_read.sample();
    Cov_opcode.sample();

  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function void extract_phase(uvm_phase phase);
    super.extract_phase(phase);
    reg_cov=Cov_reg.get_coverage();
    delay_cov=Cov_delay.get_coverage();
    data_addr_cov = Cov_pwdata_addr.get_coverage();
    data_op1_cov = Cov_pwdata_op1.get_coverage();
    data_op2_cov = Cov_pwdata_op2.get_coverage();
    data_shift_cov = Cov_pwdata_shift.get_coverage();
    data_const_cov = Cov_pwdata_const.get_coverage();
    data_read_cov = Cov_data_read.get_coverage();
    opcode_cov = Cov_opcode.get_coverage();
    reg_pwrite =  Cov_pwrite.get_coverage();
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
 function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info(get_type_name(),$sformatf("APB Interface : Coverage for PADDR is %f",reg_cov),UVM_MEDIUM)
    `uvm_info(get_type_name(),$sformatf("APB Interface : Coverage for PWDATA_ADDR is %f",data_addr_cov),UVM_MEDIUM)
    `uvm_info(get_type_name(),$sformatf("APB Interface : Coverage for PWDATA_OP1 is %f",data_op1_cov),UVM_MEDIUM)
    `uvm_info(get_type_name(),$sformatf("APB Interface : Coverage for PWDATA_OP2 is %f",data_op2_cov),UVM_MEDIUM)
    `uvm_info(get_type_name(),$sformatf("APB Interface : Coverage for PWDATA_SHIFT is %f",data_shift_cov),UVM_MEDIUM)
    `uvm_info(get_type_name(),$sformatf("APB Interface : Coverage for PWDATA_CONST is %f",data_const_cov),UVM_MEDIUM)
    `uvm_info(get_type_name(),$sformatf("APB Interface : Coverage for PWDATA_OPCODE is %f",opcode_cov),UVM_MEDIUM)
    `uvm_info(get_type_name(),$sformatf("APB Interface : Coverage for PRDATA is %f",data_read_cov),UVM_MEDIUM)
    `uvm_info(get_type_name(),$sformatf("APB Interface : Coverage for PWRITE is %f",reg_pwrite),UVM_MEDIUM)
    `uvm_info(get_type_name(),$sformatf("APB Interface : Coverage for DELAY is %f",delay_cov),UVM_MEDIUM)
  endfunction
  //----------------------------------------------------------------------------
  
endclass:apb_coverage