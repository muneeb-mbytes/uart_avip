`ifndef DEVICE_AGENT_PKG_INCLUDED_
`define DEVICE_AGENT_PKG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Package: device_agent_pkg
// Includes all the files related to UART device_agent_config
//--------------------------------------------------------------------------------------------
package device_agent_pkg;
  
  //-------------------------------------------------------
  // Import uvm package
  //-------------------------------------------------------
  `include "uvm_macros.svh"
  import uvm_pkg::*;

  // Import uart_globals_pkg 
  import uart_globals_pkg::*;
  import tx_pkg::*;
  import rx_pkg::*;
  //import device_agent_config_pkg::*;


  //-------------------------------------------------------
  // Include all other files
  //-------------------------------------------------------
  `include "device_agent_config.sv"
  `include "device_agent.sv"
 
  
endpackage : device_agent_pkg

`endif

