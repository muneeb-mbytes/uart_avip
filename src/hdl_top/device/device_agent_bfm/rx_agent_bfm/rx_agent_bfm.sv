`ifndef RX_AGENT_BFM_INCLUDED_
`define RX_AGENT_BFM_INCLUDED_

//--------------------------------------------------------------------------------------------
// Module      : rx Agent BFM
// Description : Instantiates driver and monitor
//--------------------------------------------------------------------------------------------
module rx_agent_bfm(uart_if intf);
  
  //-------------------------------------------------------
  // Package : Importing Uvm Package
  //-------------------------------------------------------
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  initial begin
    $display("rx Agent BFM");
  end

  //-------------------------------------------------------
  //rx driver bfm instantiation
  //-------------------------------------------------------
  //rx_driver_bfm rx_driver_bfm_h (intf.SLV_DRV_MP, intf.MON_MP);
  rx_driver_bfm rx_drv_bfm_h(intf);

  //-------------------------------------------------------
  // rx monitor bfm instantiation
  //-------------------------------------------------------
  rx_monitor_bfm rx_mon_bfm_h(.pclk(intf.pclk),
                              .areset(intf.areset),
                              .rx(intf.rx)
                            );
  
  // rx_monitor_bfm rx_monitor_bfm_h (intf.MON_MP);
  //-------------------------------------------------------
  //Setting the virtual handle of BMFs into config_db
  //-------------------------------------------------------
  initial begin
    uvm_config_db#(virtual rx_driver_bfm)::set(null,"*", "rx_driver_bfm", rx_drv_bfm_h);
    uvm_config_db #(virtual rx_monitor_bfm)::set(null,"*", "rx_monitor_bfm", rx_mon_bfm_h);
  end

endmodule : rx_agent_bfm

`endif
