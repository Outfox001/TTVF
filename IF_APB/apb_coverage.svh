// ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// Module name: afvip_apb_coverage
// HDL        : UVM
// Author     : Paulovici Vlad-Marian
// Description: It is a user-defined metric that measures how much of the design specification that are captured in the test plan has been exercised.
// Date       : 28 August, 2023
// -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------


class afvip_apb_coverage extends uvm_subscriber #(afvip_apb_item);

  //----------------------------------------------------------------------------
  `uvm_component_utils(afvip_apb_coverage)
  //----------------------------------------------------------------------------
  afvip_apb_item cov_item;
  // virtual afvip_if vif;
  //----------------------------------------------------------------------------
  function new(string name="afvip_apb_coverage",uvm_component parent);
    super.new(name,parent);
    Cov_reg = new();
    Cov_data = new();
    Cov_data_read = new();
    Cov_reg80_opcode = new();
    Cov_reg80_rs0 = new(); 
    Cov_reg80_rs1 = new();
    Cov_reg80_dst = new(); 
    Cov_reg80_imm = new(); 
    Cov_pwrite = new();
    Cov_delay = new();
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------

  real reg_cov;
  real data_cov;
  real data_read_cov;
  real delay_cov;
  real reg80_opcode_cov;
  real reg80_rs0_cov;
  real reg80_rs1_cov;
  real reg80_dst_cov;
  real reg80_imm_cov;
  real reg_pwrite;

  //----------------------------------------------------------------------------
  covergroup Cov_reg;
    PADDR: coverpoint cov_item.paddr {
        bins reg00 ={'h00};
        bins reg01 ={'h04};
        bins reg02 ={'h08};
        bins reg03 ={'h0c};
        bins reg04 ={'h10};
        bins reg05 ={'h14};
        bins reg06 ={'h18};
        bins reg07 ={'h1c};
        bins reg08 ={'h20};
        bins reg09 ={'h24};
        bins reg10 ={'h28};
        bins reg11 ={'h2c};
        bins reg12 ={'h30};
        bins reg13 ={'h34};
        bins reg14 ={'h38};
        bins reg15 ={'h3c};
        bins reg16 ={'h40};
        bins reg17 ={'h44};
        bins reg18 ={'h48};
        bins reg19 ={'h4c};
        bins reg20 ={'h50};
        bins reg21 ={'h54};
        bins reg22 ={'h58};
        bins reg23 ={'h5c};
        bins reg24 ={'h60};
        bins reg25 ={'h64};
        bins reg26 ={'h68};
        bins reg27 ={'h6c};
        bins reg28 ={'h70};
        bins reg29 ={'h74};
        bins reg30 ={'h78};
        bins reg31 ={'h7c};
     }
  endgroup:Cov_reg;
//----------------------------------------------------------------------------
  covergroup Cov_delay;
    DELAY: coverpoint cov_item.delay_psel {
      bins zero = {0};
      bins max_value = {15};
      bins value_1[5] = {['d1:'d5]};
      bins value_2[5] = {['d6:'d10]};
      bins value_3[4] = {['d11:'d14]};
      }
  endgroup

  //----------------------------------------------------------------------------
  covergroup Cov_data;
    PWDATA: coverpoint cov_item.pwdata {
      bins zero           = {0};
      bins max_value      = {32'hFFFFFFFF};
      bins interval [10]  = {[32'h1:32'hFF]};
      bins interval1[10]  = {[32'h100:32'hFFFF]};
      bins interval2[10]  = {[32'h10000:32'hFFFFFF]};
      bins interval3[10]  = {[32'h1000000:32'hFFFFFFFF]};
    }
  endgroup
  //----------------------------------------------------------------------------

  covergroup Cov_data_read;
    PRDATA: coverpoint cov_item.prdata {
      bins zero           = {0};
      bins max_value      = {32'hFFFFFFFF};
      bins interval [10]  = {[32'h1:32'hFF]};
      bins interval1[10]  = {[32'h100:32'hFFFF]};
      bins interval2[10]  = {[32'h10000:32'hFFFFFF]};
      bins interval3[10]  = {[32'h1000000:32'hFFFFFFFF]};
    }
   endgroup
  //----------------------------------------------------------------------------
  covergroup Cov_reg80_opcode;
    PWDATA: coverpoint cov_item.pwdata[2:0] {
      bins zero = {'d0};
      bins max_value = {'d4};
      bins value_1 = {'d1};
      bins value_2 = {'d2};
      bins value_3 = {'d3};
      illegal_bins ignore[3] = {[3'd5:3'd7]};
    }
  endgroup
   //-----------------------------------------------------------------------------
  covergroup Cov_reg80_rs0;
    PADDR: coverpoint cov_item.pwdata[7:3]{
      bins zero = {0};
      bins max_value = {31};
      bins value_1 [10]= {[5'd1:5'd10]};
      bins value_2 [10]= {[5'd11:5'd20]};
      bins value_3 [10]= {[5'd21:5'd30]};
    }
  endgroup
  //-------------------------------------------------------------------------------
  covergroup Cov_reg80_rs1;
    PADDR: coverpoint cov_item.pwdata[12:8]{
      bins zero = {0};
      bins max_value = {31};
      bins value_1 [10]= {[5'd1:5'd10]};
      bins value_2 [10]= {[5'd11:5'd20]};
      bins value_3 [10]= {[5'd21:5'd30]};
    }
  endgroup
  //-------------------------------------------------------------------------------
  covergroup Cov_reg80_dst;
    PADDR: coverpoint cov_item.pwdata[20:16]{
      bins zero = {0};
      bins max_value = {31};
      bins value_1 [10]= {[5'd1:5'd10]};
      bins value_2 [10]= {[5'd11:5'd20]};
      bins value_3 [10]= {[5'd21:5'd30]};
    }
  endgroup
  //-------------------------------------------------------------------------------
  covergroup Cov_reg80_imm;
    PWDATA: coverpoint cov_item.pwdata[31:24] {
      bins zero = {'d0};
      bins max_value = {'d255};
      bins value_1 [10]= {[8'd1:8'd50]};
      bins value_2 [10]= {[8'd51:8'd100]};
      bins value_3 [10]= {[8'd101:8'd150]};
      bins value_4 [10]= {[8'd151:8'd200]};
      bins value_5 [10]= {[8'd201:8'd254]};
    }
  endgroup
  //---------------------  write method ----------------------------------------
  covergroup Cov_pwrite;
    PWRITE: coverpoint cov_item.pwrite {
      bins min = {0};
      bins max = {1}; 
    }
  endgroup
  //-------------------------------------------------------------------------------
 function void write(afvip_apb_item t);
    cov_item=t;
    Cov_reg.sample();
    Cov_data.sample();
    Cov_delay.sample();
    Cov_pwrite.sample();
    Cov_data_read.sample();
    if(t.paddr == 32'h80) begin
     Cov_reg80_opcode.sample();
     Cov_reg80_rs0.sample();
     Cov_reg80_rs1.sample();
     Cov_reg80_dst.sample();
     Cov_reg80_imm.sample();
    end
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function void extract_phase(uvm_phase phase);
    super.extract_phase(phase);
    reg_cov=Cov_reg.get_coverage();
    data_cov = Cov_data.get_coverage();
    data_read_cov = Cov_data_read.get_coverage();
    reg80_opcode_cov = Cov_reg80_opcode.get_coverage();
    reg80_rs0_cov = Cov_reg80_rs0.get_coverage();
    reg80_rs1_cov = Cov_reg80_rs1.get_coverage();
    reg80_dst_cov = Cov_reg80_dst.get_coverage();
    reg80_imm_cov = Cov_reg80_imm.get_coverage();
    reg_pwrite =  Cov_pwrite.get_coverage();
    delay_cov = Cov_delay.get_coverage();
  endfunction
  //----------------------------------------------------------------------------


  //----------------------------------------------------------------------------
 function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info(get_type_name(),$sformatf("Coverage for ADDR is %f",reg_cov),UVM_MEDIUM)
    `uvm_info(get_type_name(),$sformatf("Coverage for PWDATA is %f",data_cov),UVM_MEDIUM)
    `uvm_info(get_type_name(),$sformatf("Coverage for PRDATA is %f",data_read_cov),UVM_MEDIUM)
    `uvm_info(get_type_name(),$sformatf("Coverage for PWRITE is %f",reg_pwrite),UVM_MEDIUM)
    `uvm_info(get_type_name(),$sformatf("Coverage for DELAY is %f",delay_cov),UVM_MEDIUM)
    `uvm_info(get_type_name(),$sformatf("Coverage for Configration register [OPCODE] is  %f",reg80_opcode_cov),UVM_MEDIUM)
    `uvm_info(get_type_name(),$sformatf("Coverage for Configration register [RS0] is  %f",reg80_rs0_cov),UVM_MEDIUM)
    `uvm_info(get_type_name(),$sformatf("Coverage for Configration register [RS1] is  %f",reg80_rs1_cov),UVM_MEDIUM)
    `uvm_info(get_type_name(),$sformatf("Coverage for Configration register [DST] is  %f",reg80_dst_cov),UVM_MEDIUM)
    `uvm_info(get_type_name(),$sformatf("Coverage for Configration register [IMM] is  %f",reg80_imm_cov),UVM_MEDIUM)
    
  endfunction
  //----------------------------------------------------------------------------
  
endclass:afvip_apb_coverage