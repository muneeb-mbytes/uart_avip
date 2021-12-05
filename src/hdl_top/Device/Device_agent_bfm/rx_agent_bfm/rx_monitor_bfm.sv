`ifndef RX_MONITOR_BFM_INCLUDED_
`define RX_MONITOR_BFM_INCLUDED_

//--------------------------------------------------------------------------------------------
// Module       : rx Monitor BFM
// Description  : Connects the rx monitor bfm with the monitor proxy
//--------------------------------------------------------------------------------------------

import uart_globals_pkg::*;

interface rx_monitor_bfm (uart_if intf);
  bit areset;  
  //-------------------------------------------------------
  // Creating the handle for proxy driver
  //-------------------------------------------------------
  import rx_pkg::rx_monitor_proxy;
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  rx_monitor_proxy rx_mon_proxy_h;

  initial begin
    $display("rx Monitor BFM");
  end

 // task wait_for_reset();
 //   @(negedge areset);
 //   `uvm_info("rx driver bfm",$sformatf("waiting for reset"),UVM_NONE)
 // endtask: wait_for_reset

 // task drive_for_idle();
 //   @(negedge areset);
 //   `uvm_info("rx driver bfm",$sformatf("driving idle state"),UVM_NONE)
 // endtask: drive_for_idle

 // task drive_for_start_bit(); //1bit
 //   @(negedge areset);
 //   `uvm_info("rx driver bfm",$sformatf("driving start bit"),UVM_NONE)
 // endtask: drive_for_start_bit
 
 task drive_for_data(); //5 to 8 bits
   @(negedge areset);
   `uvm_info("rx driver bfm",$sformatf("drive data"),UVM_NONE)
   //  for(i=0;i<8;i++)begin
   //  vif.rx=tx_data[i];
   //  end
 endtask: drive_for_data
 
 task drive_for_parity_bit(); //1bit
   @(negedge areset);
   `uvm_info("rx driver bfm",$sformatf("drive parity bit"),UVM_NONE)
 endtask: drive_for_parity_bit
 
 // task drive_for_stop_bit(); //1bit
 //   @(negedge areset);
 //   `uvm_info("rx driver bfm",$sformatf("drive stop bit"),UVM_NONE)
 // endtask: drive_for_stop_bit

endinterface : rx_monitor_bfm 

`endif
