
//----- Sequences -----
//phases
sequence idle_phase ;
   !psel ;
endsequence
sequence setup_phase ;
   psel && !penable ;
endsequence
sequence access_phase_wait ;
   psel && penable && !pready ;
endsequence
sequence access_phase_last ;
   psel && penable && pready ;
endsequence 
sequence error_ctrl_opcode;
   paddr % 4 != 0 || paddr > 'h8c ;
endsequence
sequence afvip_intr_ver;
   paddr == 'h8c && pwdata ==1;
endsequence

//----- Properties -----
//parametric property to check signal is not X/Z
property pr_generic_not_unknown_psel ;
   @(posedge clk) disable iff(!rst_n)
      !$isunknown(psel) ;
endproperty 
property pr_generic_not_unknown_pwrite ;
   @(posedge clk) disable iff(!rst_n)
      !$isunknown(pwrite) ;
endproperty 
property pr_generic_not_unknown_pready ;
   @(posedge clk) disable iff(!rst_n)
      !$isunknown(pready) ;
endproperty 
property pr_generic_not_unknown_penable ;
   @(posedge clk) disable iff(!rst_n)
      !$isunknown(penable) ;
endproperty 
property pr_generic_not_unknown_prdata ;
   @(posedge clk) disable iff(!rst_n)
      !$isunknown(prdata) ;
endproperty 
property pr_generic_not_unknown_pwdata ;
   @(posedge clk) disable iff(!rst_n)
      !$isunknown(pwdata) ;
endproperty 
property pr_generic_not_unknown_paddr ;
   @(posedge clk) disable iff(!rst_n)
      !$isunknown(paddr) ;
endproperty 
//parametric property to check if signal stable during the transfer. If the signal changed means the state became IDLE or SETUP, i.e. the transfer just finished.
property pr_generic_stable_paddr ;
   @(posedge clk) disable iff(!rst_n)
      !$stable(paddr) |-> setup_phase or idle_phase ;
endproperty
property pr_generic_stable_pwrite ;
   @(posedge clk) disable iff(!rst_n)
      !$stable(pwrite) |-> setup_phase or idle_phase ;
endproperty
property pr_generic_stable_pslverr;
   @(posedge clk) disable iff(!rst_n)
      !$stable(pslverr) |-> setup_phase or idle_phase ;
endproperty
//same as pr_generic_stable but for pwdata. it should be stable only in WRITE transfers, i.e. pwrite=1
property pwdata_in_wr_transfer ;
   @(posedge clk) disable iff(!rst_n)
      !$stable(pwdata) |-> (!pwrite) or (setup_phase or idle_phase) ;
endproperty
// for penable and psel i can't use phases, since the phases are defined using these lines
property penable_in_transfer ;
   @(posedge clk) disable iff(!rst_n)
      $fell(penable) |-> idle_phase or ($past(penable) && $past(pready)) ;
endproperty
//check if psel stable during transfer. i.e. psel can fall only after tranfer completed (pready=1)
property psel_in_transfer ;
   @(posedge clk) disable iff(!rst_n)
      !psel && $past(psel) |-> $past(penable) && $past(pready) ; //The antecedent is NOT equal to ($fell) since 'X'->'0' also activates $fell
endproperty
//check if pslverr is corectly updated
property pslverr_error_ctrl ;
   @(posedge clk) disable iff(!rst_n)
       error_ctrl_opcode |-> pslverr ; 
endproperty
//check if afvip_intr is high between 1-10 tacs
property afvip_intr_ctrl ;
   @(posedge clk) disable iff(!rst_n)
      afvip_intr_ver |-> ##[1:10](afvip_intr) ; //The antecedent is NOT equal to ($fell) since 'X'->'0' also activates $fell
endproperty
//check if the system is active when reset is on low
property reset_active_low ;
   @(posedge clk) 
   !rst_n |=> ##[0:$] $rose(rst_n);
endproperty

//Operating States 
property idle_state ;
   @(posedge clk) disable iff(!rst_n)
      idle_phase |=> idle_phase or setup_phase ;
endproperty
property setup_state ;
   @(posedge clk) disable iff(!rst_n)
      setup_phase |=> access_phase_wait or access_phase_last ;
endproperty
property access_wait_state ;
   @(posedge clk) disable iff(!rst_n)
      access_phase_wait |=> access_phase_wait or access_phase_last ;
endproperty
property access_last_state ;
   @(posedge clk) disable iff(!rst_n)
      access_phase_last |=> idle_phase or setup_phase ;
endproperty

//----- Assertions -----
// check all signal for being valid. The protocol doesn't actualy require this. only psel must be always valid.
psel_never_X    : assert property (pr_generic_not_unknown_psel)     else $display("[%0t] Error! psel is unknown (=X/Z)", $time) ;
pwrite_never_X  : assert property (pr_generic_not_unknown_pwrite)   else $display("[%0t] Error! pwrite is unknown (=X/Z)", $time) ;
penable_never_X : assert property (pr_generic_not_unknown_penable)  else $display("[%0t] Error! penable is unknown (=X/Z)", $time) ;
pready_never_X  : assert property (pr_generic_not_unknown_pready )  else $display("[%0t] Error! pready is unknown (=X/Z)", $time) ;
paddr_never_X   : assert property (pr_generic_not_unknown_paddr  )  else $display("[%0t] Error! paddr is unknown (=X/Z)", $time) ;
pwdata_never_X  : assert property (pr_generic_not_unknown_pwdata )  else $display("[%0t] Error! pwdata is unknown (=X/Z)", $time) ;
prdata_never_X  : assert property (pr_generic_not_unknown_prdata )  else $display("[%0t] Error! prdata is unknown (=X/Z)", $time) ;

//check signals stability during a transfer 
asr_paddr_stable_in_transfer     : assert property (pr_generic_stable_paddr )     else $display("[%0t] Error! paddr must not change throughout the transfer", $time) ;
asr_pwrite_stable_in_transfer    : assert property (pr_generic_stable_pwrite)     else $display("[%0t] Error! pwrite must not change throughout the transfer", $time) ;
asr_penable_stable_in_transfer   : assert property (penable_in_transfer)          else $display("[%0t] Error! penable must not change throughout the access phase", $time) ;
asr_psel_stable_in_transfer      : assert property (psel_in_transfer)             else $display("[%0t] Error! psel must not change throughout the transfer", $time) ;
asr_pwdata_stable_in_wr_transfer : assert property (pwdata_in_wr_transfer)        else $display("[%0t] Error! pwdata must not change throughout the write transfer", $time) ;
asr_pslverr_stable_in_transfer   : assert property (pr_generic_stable_pslverr)    else $display("[%0t] Error! pslverr must not change throughout the transfer", $time) ;
asr_pslverr_ctrl                 : assert property (pslverr_error_ctrl )          else $display("[%0t] Error! pslverr is on high when you have addres not a multiple of 4 or is bigger than 'h8c ", $time) ;
asr_afvip_ctrl                   : assert property (afvip_intr_ctrl )             else $display("[%0t] Error! afvip_intrr have to be on high in minim 10 clocks", $time) ;
asr_reset_low                    : assert property (reset_active_low )            else $display("[%0t] Error! the configuration must run on reset low", $time) ;

//check transition between operational states of the protocol 
  Operating_state_idle        : assert property (idle_state)     
                                  else $display("[%0t] Error! The transfer must start with setup phase (psel=1, penable=0).", $time) ;
  Operating_state_setup       : assert property (setup_state) 
                                  else $display("[%0t] Error! The setup phase must proceed to access phase (psel=1, penable=0) after 1 clk.", $time) ;
  Operating_state_access_wait : assert property (access_wait_state) 
                                  else $display("[%0t] Error! The transfer must stay in access phase (wait state (pready=0) or proceed to finish (pready=1).", $time) ;
  Operating_state_access_last : assert property (access_last_state) 
                                  else $display("[%0t] Error! After a transfer finished, must proceed to IDLE (psel=0) or setup phase (psel=1, penable=0).",  $time) ;
