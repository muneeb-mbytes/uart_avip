`ifndef DEVICE_PKG_INCLUDED_
`define DEVICE_PKG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Package: device_pkg
// Includes all the files related to UART device_config
//--------------------------------------------------------------------------------------------
package device_pkg;
  
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
  `include "device_config.sv"
  `include "device.sv"
 
  
endpackage : device_pkg

`endif

