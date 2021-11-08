`ifndef DEVICE1_MONITOR_BFM_INCLUDED_
`define DEVICE1_MONITOR_BFM_INCLUDED_

//--------------------------------------------------------------------------------------------
// Module       : device1 Monitor BFM
// Description  : Connects the device1 monitor bfm with the monitor proxy
//--------------------------------------------------------------------------------------------

interface device1_monitor_bfm (uart_if intf);
  bit areset;  
  //-------------------------------------------------------
  // Creating the handle for proxy driver
  //-------------------------------------------------------
  import uart_device1_pkg::device1_monitor_proxy;
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  device1_monitor_proxy device1_mon_proxy_h;

  initial begin
    $display("device1 Monitor BFM");
  end

 // task wait_for_reset();
 //   @(negedge areset);
 //   `uvm_info("device1 driver bfm",$sformatf("waiting for reset"),UVM_NONE)
 // endtask: wait_for_reset

 // task drive_for_idle();
 //   @(negedge areset);
 //   `uvm_info("device1 driver bfm",$sformatf("driving idle state"),UVM_NONE)
 // endtask: drive_for_idle

 // task drive_for_start_bit(); //1bit
 //   @(negedge areset);
 //   `uvm_info("device1 driver bfm",$sformatf("driving start bit"),UVM_NONE)
 // endtask: drive_for_start_bit
 
 task drive_for_data(); //5 to 8 bits
   @(negedge areset);
   `uvm_info("device1 driver bfm",$sformatf("drive data"),UVM_NONE)
   //  for(i=0;i<8;i++)begin
   //  vif.rx=tx_data[i];
   //  end
 endtask: drive_for_data
 
 task drive_for_parity_bit(); //1bit
   @(negedge areset);
   `uvm_info("device1 driver bfm",$sformatf("drive parity bit"),UVM_NONE)
 endtask: drive_for_parity_bit
 
 // task drive_for_stop_bit(); //1bit
 //   @(negedge areset);
 //   `uvm_info("device1 driver bfm",$sformatf("drive stop bit"),UVM_NONE)
 // endtask: drive_for_stop_bit

endinterface : device1_monitor_bfm 

`endif
