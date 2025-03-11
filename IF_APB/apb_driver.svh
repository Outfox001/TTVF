// ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// Module name: afvip_apb_driver
// HDL        : UVM
// Author     : Paulovici Vlad-Marian
// Description: UVM driver is an active entity that has knowledge on how to drive signals to a particular interface of the design.
//              Is the place where the protocols are realized to be tested.
// Date       : 28 August, 2023
// -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
class afvip_apb_driver extends uvm_driver #(afvip_apb_item, afvip_apb_item);

  `uvm_component_utils(afvip_apb_driver)
  function new(string name, uvm_component parent);
    super.new (name, parent);    
  endfunction //new()

  virtual apb_interface vif;
  afvip_apb_item data_project;

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(virtual apb_interface) :: get ( this, "", "vif", vif)) begin
      `uvm_fatal (get_type_name (), "Didn't get handle to virtual interface")
  end
  endfunction

  virtual task run_phase(uvm_phase phase);
    zero();
    @(vif.cb_master);
    @(posedge vif.rst_n);

	  forever begin    
    	seq_item_port.get_next_item(req);
      $cast (data_project, req.clone());
      data_project.set_id_info(req);
    	repeat(data_project.delay_psel) @(vif.cb_master);   
    	case (data_project.pwrite)
        1'b0:read(data_project);
        1'b1:write(data_project);
      endcase

	    seq_item_port.item_done();
      seq_item_port.put_response(data_project);
      `uvm_info (get_type_name(), $sformatf ("Data was received in APB_DRIVER"), UVM_NONE)
      $display("%s" , data_project.sprint());
	  end
    
  endtask

  virtual task zero ();
    vif.cb_master.psel 			                        <=0;
    vif.cb_master.pwrite                            <=0;
    vif.cb_master.penable                           <=0;
    vif.cb_master.paddr                             <=0;
    vif.cb_master.pwdata                            <=0;
  endtask

  virtual task write( afvip_apb_item data_project);
    vif.cb_master.psel 			                        <=  1;
    vif.cb_master.pwrite                            <=  data_project.pwrite;  
    vif.cb_master.pwdata 		                        <=  data_project.pwdata;
    vif.cb_master.paddr 		                        <=  data_project.paddr;
    @(vif.cb_master);                       
  	vif.cb_master.penable 	                        <=  1;
    @(vif.cb_master iff vif.cb_master.pready);
    vif.cb_master.penable 	                        <=  0;
    vif.cb_master.psel 			                        <=  0;    
  endtask

  virtual task read(inout afvip_apb_item data_project);
    vif.cb_master.psel 			                        <=  1;
    vif.cb_master.pwrite                            <=  data_project.pwrite;
    vif.cb_master.paddr 		                        <=  data_project.paddr;
    @(vif.cb_master);                       
  	vif.cb_master.penable 	                        <=  1;
    @(vif.cb_master iff vif.cb_master.pready);
    data_project.prdata                             =   vif.cb_master.prdata; 
    vif.cb_master.penable 	                        <=  0;
    vif.cb_master.psel 			                        <=  0;
  endtask


endclass //req_ack_driver extends uvm_driver
