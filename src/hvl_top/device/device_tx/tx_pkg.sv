`ifndef TX_PKG_INCLUDED_
`define TX_PKG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Package: tx_pkg
// Includes all the files related to UART tx
//--------------------------------------------------------------------------------------------
package tx_pkg;
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
  `include "tx_xtn.sv"
  `include "tx_agent_config.sv"
  `include "tx_cfg_converter.sv"
  `include "tx_seq_item_converter.sv"
  `include "tx_sequencer.sv"
  `include "tx_driver_proxy.sv"
  `include "tx_monitor_proxy.sv"
  `include "tx_coverage.sv"
  `include "tx_agent.sv"
 
  
endpackage : tx_pkg

`endif
