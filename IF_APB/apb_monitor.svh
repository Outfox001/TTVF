class afvip_apb_monitor extends uvm_monitor;
  `uvm_component_utils(afvip_apb_monitor)

  //---------------------------------------------CONSTRUCTOR-----------------------------------------------------
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction //new()

  //---------------------------------------------HANDLER-----------------------------------------------------------
  virtual apb_interface vif;
  afvip_apb_item data_mon;
  bit [31:0] delay;
  uvm_analysis_port #(afvip_apb_item) mon_analysis_port;

  //---------------------------------------------BUILD PHASE------------------------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    mon_analysis_port = new("mon_analysis_port", this);
    if (!uvm_config_db #(virtual apb_interface)::get(this, "", "vif", vif)) begin
      `uvm_error(get_type_name(), "Not found")
    end
  endfunction

  //---------------------------------------------RUN PHASE--------------------------------------------------------
  task run_phase(uvm_phase phase);
    afvip_apb_item data_mon = afvip_apb_item::type_id::create("data_mon", this);

    fork
      
        begin
                count_delay(); // Run the task to count the clocks between two high signals
        end
        begin
         forever begin
         @(vif.cb_monitor iff vif.cb_monitor.psel && vif.cb_monitor.penable && vif.cb_monitor.pready);
         
         data_mon.pwrite      = vif.cb_monitor.pwrite;
         data_mon.delay_psel  = delay; // Transfer the delay data to the monitor
         delay                = 0; // Reset the delay for the next transaction
         data_mon.paddr  = vif.cb_monitor.paddr;
   
         if (vif.cb_monitor.pwrite == 1) begin
           data_mon.pwdata = vif.cb_monitor.pwdata;
         end else begin
           data_mon.prdata = vif.cb_monitor.prdata;
         end
   
         `uvm_info(get_type_name(), $sformatf("The data from monitor was received!"), UVM_NONE)
         mon_analysis_port.write(data_mon);
         $display("%s", data_mon.sprint());
        end
    end
  endtask
    join_any

    

  //---------------------------------------------TASK FOR DELAY--------------------------------------------------
  task count_delay();
    forever begin
      @(vif.cb_monitor);
      if (vif.cb_monitor.psel == 0)
        delay = delay + 1;
    end
  endtask

endclass // afvip_apb_monitor
