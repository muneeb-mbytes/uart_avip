`ifndef TX_AGENT_BFM_INCLUDED_
`define TX_AGENT_BFM_INCLUDED_
 
//--------------------------------------------------------------------------------------------
// Module: tx Agent BFM
// This module is used as the configuration class for tx agent bfm and its components
//--------------------------------------------------------------------------------------------
module tx_agent_bfm(uart_if intf);
    
  //-------------------------------------------------------
  //Package : Importing Uvm Package 
  //-------------------------------------------------------
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  initial
  begin
     $display("tx Agent BFM");
  end
  
  //-------------------------------------------------------
  //tx driver bfm instantiation
  //-------------------------------------------------------
  tx_driver_bfm tx_drv_bfm_h(.pclk(intf.pclk), 
                             .areset(intf.areset),
                             .bclk(intf.bclk),
                             .Tx0(intf.tx0),
                             .Tx1(intf.tx1), 
                             .Tx2(intf.tx2),
                             .Tx3(intf.tx3)
                           );
 
  //-------------------------------------------------------
  //tx monitor bfm instantiation
  //-------------------------------------------------------
  tx_monitor_bfm tx_mon_bfm_h(intf);
 
  //-------------------------------------------------------
  // Setting the virtual handle of BMFs into config_db
  //-------------------------------------------------------
  initial begin
   uvm_config_db#(virtual tx_driver_bfm)::set(null,"*", "tx_driver_bfm", tx_drv_bfm_h); 
   uvm_config_db#(virtual tx_monitor_bfm)::set(null,"*", "tx_monitor_bfm", tx_mon_bfm_h);
 end

endmodule : tx_agent_bfm

`endif
