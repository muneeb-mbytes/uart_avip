`ifndef RX_PKG_INCLUDED_
`define RX_PKG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Package: rx_pkg
// Includes all the files related to UART rx
//--------------------------------------------------------------------------------------------
package rx_pkg;
  
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
  `include "rx_xtn.sv"
  `include "rx_agent_config.sv"
  `include "rx_seq_item_converter.sv"
  `include "rx_cfg_converter.sv"
  `include "rx_sequencer.sv"
  `include "rx_driver_proxy.sv"
  `include "rx_monitor_proxy.sv"
  `include "rx_coverage.sv"
  `include "rx_agent.sv"
 
  
endpackage : rx_pkg

`endif
