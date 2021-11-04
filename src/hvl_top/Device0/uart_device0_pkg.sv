`ifndef UART_DEVICE0_PKG_INCLUDED_
`define UART_DEVICE0_PKG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Package: uart_device0_pkg
// Includes all the files related to UART device0
//--------------------------------------------------------------------------------------------
package uart_device0_pkg;
  //-------------------------------------------------------
  // Import uvm package
  //-------------------------------------------------------
  `include "uvm_macros.svh"
  import uvm_pkg::*;
 
  // Import uart_globals_pkg 
  import uart_globals_pkg::*;

  //-------------------------------------------------------
  // Include all other files
  //-------------------------------------------------------
  `include "device0_tx.sv"
  `include "uart_device0_seq_item_converter.sv"
  `include "device0_agent_config.sv"
  `include "device0_sequencer.sv"
  `include "device0_driver_proxy.sv"
  `include "device0_monitor_proxy.sv"
  `include "device0_coverage.sv"
  `include "device0_agent.sv"
 
  
endpackage : uart_device0_pkg

`endif
