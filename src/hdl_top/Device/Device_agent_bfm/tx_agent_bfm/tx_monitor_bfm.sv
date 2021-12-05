`ifndef TX_MONITOR_BFM_INCLUDED_
`define TX_MONITOR_BFM_INCLUDED_
//--------------------------------------------------------------------------------------------
// Inteface : tx Monitor BFM
// Connects the tx monitor bfm with the monitor proxy
//--------------------------------------------------------------------------------------------

import uart_globals_pkg::*;

interface tx_monitor_bfm(uart_if intf);
  
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import tx_pkg::tx_monitor_proxy;
  
  //Variable : tx_mon_proxy_h
  //Creating the handle for proxy driver
  tx_monitor_proxy tx_mon_proxy_h;

  initial
  begin
    $display("tx Monitor BFM");
  end

endinterface : tx_monitor_bfm

`endif
