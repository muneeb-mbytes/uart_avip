`ifndef DEVICE0_MONITOR_BFM_INCLUDED_
`define DEVICE0_MONITOR_BFM_INCLUDED_
//--------------------------------------------------------------------------------------------
// Inteface : device0 Monitor BFM
// Connects the device0 monitor bfm with the monitor proxy
//--------------------------------------------------------------------------------------------
interface device0_monitor_bfm(uart_if intf);
  
  import uart_device0_pkg::device0_monitor_proxy;
  
  //Variable : device0_mon_proxy_h
  //Creating the handle for proxy driver
  device0_monitor_proxy device0_mon_proxy_h;

  initial
  begin
    $display("device0 Monitor BFM");
  end

endinterface : device0_monitor_bfm

`endif
