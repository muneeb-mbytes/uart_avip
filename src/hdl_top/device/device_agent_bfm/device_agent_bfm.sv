`ifndef DEVICE_AGENT_BFM_INCLUDED_
`define DEVICE_AGENT_BFM_INCLUDED_

//--------------------------------------------------------------------------------------------
// Module      : rx Agent BFM
// Description : Instantiates driver and monitor
//--------------------------------------------------------------------------------------------
module device_agent_bfm(uart_if intf);
  
  //-------------------------------------------------------
  // Package : Importing Uvm Package
  //-------------------------------------------------------
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  initial begin
    $display("Device Agent BFM");
  end

  //-------------------------------------------------------
  //rx driver bfm instantiation
  //-------------------------------------------------------
  //rx_driver_bfm rx_driver_bfm_h (intf.SLV_DRV_MP, intf.MON_MP);
  tx_agent_bfm tx_agent_bfm_h(intf);

  //-------------------------------------------------------
  // rx monitor bfm instantiation
  //-------------------------------------------------------
  rx_agent_bfm rx_agent_bfm_h(intf);
  
  //-------------------------------------------------------
  //Setting the virtual handle of BMFs into config_db
  //-------------------------------------------------------
  //initial begin
  //  uvm_config_db#(virtual rx_driver_bfm)::set(null,"*", "rx_driver_bfm", rx_drv_bfm_h);
  //  uvm_config_db #(virtual rx_monitor_bfm)::set(null,"*", "rx_monitor_bfm", rx_mon_bfm_h);
  //end

endmodule : device_agent_bfm

`endif
