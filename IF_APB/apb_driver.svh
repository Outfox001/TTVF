class apb_driver extends uvm_driver #(apb_item, apb_item);

  `uvm_component_utils(apb_driver)
  function new(string name, uvm_component parent);
    super.new (name, parent);    
  endfunction //new()

  virtual apb_interface vif_apb;
  apb_item data_project;

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(virtual apb_interface) :: get ( this, "", "vif_apb", vif_apb)) begin
      `uvm_fatal (get_type_name (), "Didn't get handle to virtual interface")
  end
  endfunction

  virtual task run_phase(uvm_phase phase);
    zero();
    @(vif_apb.cb_master_apb);
    @(posedge vif_apb.reset_n);

	  forever begin    
    	seq_item_port.get_next_item(req);
      $cast (data_project, req.clone());
      data_project.set_id_info(req);
    	repeat(data_project.delay_psel) @(vif_apb.cb_master_apb);   
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
    vif_apb.cb_master_apb.psel 			                        <=0;
    vif_apb.cb_master_apb.pwrite                            <=0;
    vif_apb.cb_master_apb.penable                           <=0;
    vif_apb.cb_master_apb.paddr                             <=0;
    vif_apb.cb_master_apb.pwdata                            <=0;
  endtask

  virtual task write( apb_item data_project);
    vif_apb.cb_master_apb.psel 			                        <=  1;
    vif_apb.cb_master_apb.pwrite                            <=  data_project.pwrite;  
    vif_apb.cb_master_apb.pwdata 		                        <=  data_project.pwdata;
    vif_apb.cb_master_apb.paddr 		                        <=  data_project.paddr;
    @(vif_apb.cb_master_apb);                       
  	vif_apb.cb_master_apb.penable 	                        <=  1;
    @(vif_apb.cb_master_apb iff vif_apb.cb_master_apb.pready);
    vif_apb.cb_master_apb.penable 	                        <=  0;
    vif_apb.cb_master_apb.psel 			                        <=  0;    
  endtask

  virtual task read(inout apb_item data_project);
    vif_apb.cb_master_apb.psel 			                        <=  1;
    vif_apb.cb_master_apb.pwrite                            <=  data_project.pwrite;
    vif_apb.cb_master_apb.paddr 		                        <=  data_project.paddr;
    @(vif_apb.cb_master_apb);                       
  	vif_apb.cb_master_apb.penable 	                        <=  1;
    @(vif_apb.cb_master_apb iff vif_apb.cb_master_apb.pready);
    data_project.prdata                                 =   vif_apb.cb_master_apb.prdata; 
    vif_apb.cb_master_apb.penable 	                        <=  0;
    vif_apb.cb_master_apb.psel 			                        <=  0;
  endtask


endclass //req_ack_driver extends uvm_driver
