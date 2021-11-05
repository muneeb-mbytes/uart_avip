`ifndef DEVICE1_MONITOR_BFM_INCLUDED_
`define DEVICE1_MONITOR_BFM_INCLUDED_

//--------------------------------------------------------------------------------------------
// Module       : device1 Monitor BFM
// Description  : Connects the device1 monitor bfm with the monitor proxy
//--------------------------------------------------------------------------------------------

interface device1_monitor_bfm (uart_if intf);
  
  //-------------------------------------------------------
  // Creating the handle for proxy driver
  //-------------------------------------------------------
  import uart_device1_pkg::device1_monitor_proxy;

  device1_monitor_proxy device1_mon_proxy_h;

  initial begin
    $display("device1 Monitor BFM");
  end

endinterface : device1_monitor_bfm 

`endif
