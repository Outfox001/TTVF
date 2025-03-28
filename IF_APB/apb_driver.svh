class afvip_apb_driver extends uvm_driver #(afvip_apb_item, afvip_apb_item);

  `uvm_component_utils(afvip_apb_driver)
  function new(string name, uvm_component parent);
    super.new(name, parent);    
  endfunction //new()

  virtual apb_interface vif;
  afvip_apb_item data_project;

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db #(virtual apb_interface)::get(this, "", "vif", vif)) begin
      `uvm_fatal(get_type_name(), "Didn't get handle to virtual interface")
    end
  endfunction

  virtual task run_phase(uvm_phase phase);
    @(vif.cb_master);
    @(posedge vif.rst_n);

    init0();

    forever begin    
      seq_item_port.get_next_item(req);
      $cast(data_project, req.clone());
      data_project.set_id_info(req);

      vif.cb_master.psel    <= 1;
      vif.cb_master.penable <= 0;
      vif.cb_master.paddr   <= data_project.addr;
      vif.cb_master.pwrite  <= data_project.write;
      vif.cb_master.pwdata  <= data_project.wdata;

      @(posedge vif.pclk);
      vif.cb_master.penable <= 1;
      
      @(posedge vif.pclk);
      vif.cb_master.psel    <= 0;
      vif.cb_master.penable <= 0;
      
      
      seq_item_port.item_done();
      seq_item_port.put_response(data_project);
      `uvm_info(get_type_name(), $sformatf("Data was received in APB_DRIVER"), UVM_NONE)
      $display("%s", data_project.sprint());
    end
  endtask

  task init0();
    vif.cb_master.psel    <= 0;
    vif.cb_master.penable <= 0;
    vif.cb_master.pwrite  <= 0;
    vif.cb_master.paddr   <= 0;
    vif.cb_master.pwdata  <= 0;
  endtask

endclass // afvip_apb_driver
