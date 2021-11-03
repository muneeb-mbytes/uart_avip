`ifndef UART_MASTER_PKG_INCLUDED_
`define UART_MASTER_PKG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Package: uart_master_pkg
// Includes all the files related to UART master
//--------------------------------------------------------------------------------------------
package uart_master_pkg;
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
  `include "master_tx.sv"
  `include "uart_master_seq_item_converter.sv"
  `include "master_agent_config.sv"
  `include "master_sequencer.sv"
  `include "master_driver_proxy.sv"
  `include "master_monitor_proxy.sv"
  `include "master_coverage.sv"
  `include "master_agent.sv"
 
  
endpackage : uart_master_pkg

`endif
