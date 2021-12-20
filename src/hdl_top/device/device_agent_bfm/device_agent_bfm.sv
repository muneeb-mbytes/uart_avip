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
  //tx agent bfm instantiation
  //-------------------------------------------------------
  tx_agent_bfm tx_agent_bfm_h(intf);

  //-------------------------------------------------------
  // rx agent bfm instantiation
  //-------------------------------------------------------
  rx_agent_bfm rx_agent_bfm_h(intf);
  
endmodule : device_agent_bfm

`endif
