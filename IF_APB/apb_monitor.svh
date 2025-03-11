// ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// Module name: output_monitor
// HDL        : UVM
// Author     : Paulovici Vlad-Marian
// Description: Is responsible for capturing signal activity from the design interface and translate it into transaction level data objects that can be sent to other components.
// Date       : 28 August, 2023
// -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
class output_monitor extends uvm_monitor ;
  `uvm_component_utils (output_monitor)

//---------------------------------------------CONSTRUCTOR----------------------------------------------------------------------------------------------------------------------
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction //new()
 
//---------------------------------------------HANDLER--------------------------------------------------------------------------------------------------------------------------
  virtual apb_interface 	vif;
  afvip_apb_item 								delay_mon;
  bit [31:0] 										delay;
	uvm_analysis_port #(afvip_apb_item) mon_analysis_port;

//---------------------------------------------BUILD PHASE----------------------------------------------------------------------------------------------------------------------
  function void build_phase(uvm_phase phase);      
    super.build_phase (phase);
    mon_analysis_port = new ("mon_analysis_port", this);
      if(! uvm_config_db #(virtual apb_interface) :: get (this , "", "vif", vif)) begin
        `uvm_error (get_type_name (), "Not found")
      end
    endfunction

//---------------------------------------------RUN PHASE------------------------------------------------------------------------------------------------------------------------
  task run_phase(uvm_phase phase);
    afvip_apb_item data_mon = afvip_apb_item::type_id::create ("data_mon", this);
    
	  fork																																														//Run the task to count the clocks between 2 high singal
      count_delay();
    join_none

	  forever begin
	  	@(vif.cb_monitor iff vif.cb_monitor.psel && vif.cb_monitor.penable && vif.cb_monitor.pready);	//Wait for the complete transaction
      data_mon.pwrite 														= vif.cb_monitor.pwrite;													//
      data_mon.delay_psel 												= delay;																					//Transfer the data for delay, to the monitor
      delay 																			= 0;																							//Reset the delay for the next transaction
      if (vif.cb_monitor.pwrite ==1 ) 				begin																								  //First case for transfer data and addr, when it is pwrite high (write)
        data_mon.pwdata 													= vif.cb_monitor.pwdata;
        data_mon.paddr  													= vif.cb_monitor.paddr;
      end else if (vif.cb_monitor.pwrite ==0 )begin																								  //Second case for transfer data and addr, when it is pwrite low (read)
        data_mon.prdata 													= vif.cb_monitor.prdata;
        data_mon.paddr  													= vif.cb_monitor.paddr;
      end
      `uvm_info (get_type_name(), $sformatf ("The data from monitor was received!"), UVM_NONE)
      mon_analysis_port.write(data_mon);
      $display("%s" , data_mon.sprint()); 
    end
	endtask
 
//---------------------------------------------TASK FOR DELAY-------------------------------------------------------------------------------------------------------------------
  
	task count_delay ();																																						    //Build a specific task for delay where you count  
    forever begin																																										  //the clocks between 2 high PSEL signal
      @(vif.cb_monitor ) if(vif.cb_monitor.psel == 0)	delay = delay +1;
    end
  endtask

endclass 