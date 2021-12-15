`ifndef RX_DRIVER_BFM_INCLUDED_
`define RX_DRIVER_BFM_INCLUDED_

//--------------------------------------------------------------------------------------------
// Interface : rx_driver_bfm
//  Used as the HDL driver for UART
//  It connects with the HVL driver_proxy for driving the stimulus
//
// Parameters:
//  intf - UART Interface
//--------------------------------------------------------------------------------------------
import uart_globals_pkg::*;
interface rx_driver_bfm(uart_if intf);
  bit areset;
  
  //-------------------------------------------------------
  // Creating the handle for proxy driver
  //-------------------------------------------------------
  import rx_pkg::rx_driver_proxy;
  rx_driver_proxy rx_drv_proxy_h;
  
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  
  initial begin
    $display("rx Driver BFM");
  end
//--------------------------------------------------------------------------------------------
//Task: wait_for_reset
// Waiting for system reset to be active/
//--------------------------------------------------------------------------------------------
task wait_for_reset();
  @(negedge areset);
  `uvm_info("rx driver bfm",$sformatf("waiting for reset"),UVM_NONE)
endtask: wait_for_reset

//--------------------------------------------------------------------------------------------
//Task: drive_idle_state 
//This task drives the UART interface to it's IDLA state
//--------------------------------------------------------------------------------------------
task drive_for_idle();
  @(negedge areset);
  `uvm_info("rx driver bfm",$sformatf("driving idle state"),UVM_NONE)
endtask: drive_for_idle

//--------------------------------------------------------------------------------------------
//Task: drive_start_bit 
// This task drives the start bit
//--------------------------------------------------------------------------------------------
task drive_for_start_bit(); //1bit
  @(negedge areset);
  `uvm_info("rx driver bfm",$sformatf("driving start bit"),UVM_NONE)
endtask: drive_for_start_bit

//--------------------------------------------------------------------------------------------
//Task: drive_for_data 
// This task drives the data
//--------------------------------------------------------------------------------------------
task drive_for_data(); //5 to 8 bits
  @(negedge areset);
  `uvm_info("rx driver bfm",$sformatf("drive data"),UVM_NONE)
  //for(i=0;i<8;i++)begin
  //vif.rx=tx_data[i];
  //end
endtask: drive_for_data

//--------------------------------------------------------------------------------------------
//Task: drive_for_parity_bit 
// This task drives the parity bit
//--------------------------------------------------------------------------------------------
task drive_for_parity_bit(); //1bit
  @(negedge areset);
  `uvm_info("rx driver bfm",$sformatf("drive parity bit"),UVM_NONE)
endtask: drive_for_parity_bit

//--------------------------------------------------------------------------------------------
//Task: drive_for_parity_bit 
// This task drives the stop bit
//--------------------------------------------------------------------------------------------
task drive_for_stop_bit(); //1bit
  @(negedge areset);
  `uvm_info("rx driver bfm",$sformatf("drive stop bit"),UVM_NONE)
endtask: drive_for_stop_bit

endinterface : rx_driver_bfm

`endif
