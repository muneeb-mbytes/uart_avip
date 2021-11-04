`ifndef UART_DEVICE1_PKG_INCLUDED_
`define UART_DEVICE1_PKG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Package: uart_device1_pkg
// Includes all the files related to UART device1
//--------------------------------------------------------------------------------------------
package uart_device1_pkg;
  
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
  `include "device1_tx.sv"
  `include "uart_device1_seq_item_converter.sv"
  `include "device1_agent_config.sv"
  `include "device1_sequencer.sv"
  `include "device1_driver_proxy.sv"
  `include "device1_monitor_proxy.sv"
  `include "device1_coverage.sv"
  `include "device1_agent.sv"
 
  
endpackage : uart_device1_pkg

`endif
