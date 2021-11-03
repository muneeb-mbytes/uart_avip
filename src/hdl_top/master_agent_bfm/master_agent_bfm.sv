`ifndef UART_MASTER_AGENT_BFM_INCLUDED_
`define UART_MASTER_AGENT_BFM_INCLUDED_
 
//--------------------------------------------------------------------------------------------
// Module: Master Agent BFM
// This module is used as the configuration class for master agent bfm and its components
//--------------------------------------------------------------------------------------------

  module master_agent_bfm(uart_if intf);

   import uvm_pkg::*;
  `include "uvm_macros.svh"

   initial
   begin
      $display("Master Agent BFM");
   end
   
   master_driver_bfm master_drv_bfm_h(intf);
   master_monitor_bfm master_mon_bfm_h(intf);
   
   initial begin
     uvm_config_db#(virtual master_driver_bfm)::set(null,"*", "master_driver_bfm", master_drv_bfm_h); 
     uvm_config_db#(virtual master_monitor_bfm)::set(null,"*", "master_monitor_bfm", master_mon_bfm_h);
   end

  endmodule : master_agent_bfm

`endif
