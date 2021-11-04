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
  import uart_device0_pkg::*;
  import uart_device1_pkg::*;
  import uart_env_pkg::*;
  import device0_uart_seq_pkg::*;
  import device1_uart_seq_pkg::*;
  import uart_virtual_seq_pkg::*;

  //including base_test for testing
  `include "base_test.sv"

endpackage :test_pkg

`endif
