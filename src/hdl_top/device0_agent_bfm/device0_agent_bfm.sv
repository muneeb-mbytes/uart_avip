`ifndef DEVICE0_AGENT_BFM_INCLUDED_
`define DEVICE0_AGENT_BFM_INCLUDED_
 
//--------------------------------------------------------------------------------------------
// Module: device0 Agent BFM
// This module is used as the configuration class for device0 agent bfm and its components
//--------------------------------------------------------------------------------------------

module device0_agent_bfm(uart_if intf);

 import uvm_pkg::*;
`include "uvm_macros.svh"

 initial
 begin
    $display("device0 Agent BFM");
 end
 
 device0_driver_bfm device0_drv_bfm_h(intf);
 device0_monitor_bfm device0_mon_bfm_h(intf);

 //-------------------------------------------------------
 // Setting the virtual handle of BMFs into config_db
 //-------------------------------------------------------
 initial begin
   uvm_config_db#(virtual device0_driver_bfm)::set(null,"*", "device0_driver_bfm", device0_drv_bfm_h); 
   uvm_config_db#(virtual device0_monitor_bfm)::set(null,"*", "device0_monitor_bfm", device0_mon_bfm_h);
 end

endmodule : device0_agent_bfm

`endif
