`ifndef DEVICE1_AGENT_BFM_INCLUDED_
`define DEVICE1_AGENT_BFM_INCLUDED_

//--------------------------------------------------------------------------------------------
// Module      : device1 Agent BFM
// Description : Instantiates driver and monitor
//--------------------------------------------------------------------------------------------
module device1_agent_bfm(uart_if intf);
  
  //-------------------------------------------------------
  // Package : Importing Uvm Package and Test Package
  //-------------------------------------------------------

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  initial begin
    $display("device1 Agent BFM");
  end

  //-------------------------------------------------------
  //device1 driver bfm instantiation
  //-------------------------------------------------------
  //device1_driver_bfm device1_driver_bfm_h (intf.SLV_DRV_MP, intf.MON_MP);
  
  device1_driver_bfm device1_drv_bfm_h(intf);

  //-------------------------------------------------------
  // device1 monitor bfm instantiation
  //-------------------------------------------------------
  device1_monitor_bfm device1_mon_bfm_h(intf);
  

  // device1_monitor_bfm device1_monitor_bfm_h (intf.MON_MP);
  //-------------------------------------------------------
  //Setting the virtual handle of BMFs into config_db
  //-------------------------------------------------------
initial begin
   uvm_config_db#(virtual device1_driver_bfm)::set(null,"*", "device1_driver_bfm", device1_drv_bfm_h); 
   uvm_config_db #(virtual device1_monitor_bfm)::set(null,"*", "device1_monitor_bfm", device1_mon_bfm_h); 
 end

endmodule : device1_agent_bfm

`endif
