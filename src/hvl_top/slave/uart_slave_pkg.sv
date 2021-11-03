`ifndef UART_SLAVE_PKG_INCLUDED_
`define UART_SLAVE_PKG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Package: uart_slave_pkg
// Includes all the files related to UART slave
//--------------------------------------------------------------------------------------------
package uart_slave_pkg;
  
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
  `include "slave_tx.sv"
  `include "uart_slave_seq_item_converter.sv"
  `include "slave_agent_config.sv"
  `include "slave_sequencer.sv"
  `include "slave_driver_proxy.sv"
  `include "slave_monitor_proxy.sv"
  `include "slave_coverage.sv"
  `include "slave_agent.sv"
 
  
endpackage : uart_slave_pkg

`endif
