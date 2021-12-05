`ifndef TEST_PKG_INCLUDED_
`define TEST_PKG_INCLUDED_


//--------------------------------------------------------------------------------------------
// Package: Test
// Description:
// Includes all the files written to run the simulation
//--------------------------------------------------------------------------------------------
package test_pkg;

  //-------------------------------------------------------
  // Import uvm package
  //-------------------------------------------------------
  `include "uvm_macros.svh"
  import uvm_pkg::*;

  //-------------------------------------------------------
  // Importing the required packages
  //-------------------------------------------------------
  import uart_globals_pkg::*;
  import tx_pkg::*;
  import rx_pkg::*;
  import device_agent_config_pkg::*;
  import uart_env_pkg::*;
  import tx_uart_seq_pkg::*;
  import rx_uart_seq_pkg::*;
  import uart_virtual_seq_pkg::*;

  //including base_test for testing
  `include "base_test.sv"
  `include "uart_fd_8b_test.sv"

endpackage : test_pkg

`endif
