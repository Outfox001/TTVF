class apb_monitor extends uvm_monitor ;
  `uvm_component_utils (apb_monitor)

//---------------------------------------------CONSTRUCTOR----------------------------------------------------------------------------------------------------------------------
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction //new()
 
//---------------------------------------------HANDLER--------------------------------------------------------------------------------------------------------------------------
  virtual apb_interface 	      vif_apb;
  apb_item 								      delay_mon;
  bit [31:0] 										delay;
	uvm_analysis_port #(apb_item) mon_analysis_port_apb;

//---------------------------------------------BUILD PHASE----------------------------------------------------------------------------------------------------------------------
  function void build_phase(uvm_phase phase);      
    super.build_phase (phase);
    mon_analysis_port_apb = new ("mon_analysis_port_apb", this);
      if(! uvm_config_db #(virtual apb_interface) :: get (this , "", "vif_apb", vif_apb)) begin
        `uvm_error (get_type_name (), "Not found")
      end
    endfunction

//---------------------------------------------RUN PHASE------------------------------------------------------------------------------------------------------------------------
  task run_phase(uvm_phase phase);
    apb_item data_mon = apb_item::type_id::create ("data_mon", this);
    
	  fork																																														//Run the task to count the clocks between 2 high singal
      count_delay();
    join_none

	  forever begin
	  	@(vif_apb.cb_monitor_apb iff vif_apb.cb_monitor_apb.psel && vif_apb.cb_monitor_apb.penable && vif_apb.cb_monitor_apb.pready );	//Wait for the complete transaction
      data_mon.pwrite 														= vif_apb.cb_monitor_apb.pwrite;													//
      data_mon.delay_psel 												= delay;																					//Transfer the data for delay, to the monitor
      delay 																			= 0;																							//Reset the delay for the next transaction
      if (vif_apb.cb_monitor_apb.pwrite ==1 ) 				begin																								  //First case for transfer data and addr, when it is pwrite high (write)
        data_mon.pwdata 													= vif_apb.cb_monitor_apb.pwdata;
        
      `uvm_info (get_type_name(), $sformatf ("The pwdata is receive with value = %b",data_mon.pwdata), UVM_NONE)
        data_mon.paddr  													= vif_apb.cb_monitor_apb.paddr;
      end else if (vif_apb.cb_monitor_apb.pwrite ==0 )begin																								  //Second case for transfer data and addr, when it is pwrite low (read)
        data_mon.prdata 													= vif_apb.cb_monitor_apb.prdata;
        data_mon.paddr  													= vif_apb.cb_monitor_apb.paddr;
      end
      `uvm_info (get_type_name(), $sformatf ("The data from monitor was received!"), UVM_NONE)
      mon_analysis_port_apb.write(data_mon);
      $display("%s" , data_mon.sprint()); 
    end
	endtask
 
//---------------------------------------------TASK FOR DELAY-------------------------------------------------------------------------------------------------------------------
  
	task count_delay ();																																						    //Build a specific task for delay where you count  
    forever begin																																										  //the clocks between 2 high PSEL signal
      @(vif_apb.cb_monitor_apb ) if(vif_apb.cb_monitor_apb.psel == 0)	delay = delay +1;
    end
  endtask

endclass 