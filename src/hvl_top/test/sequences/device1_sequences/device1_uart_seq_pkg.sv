`ifndef DEVICE1_UART_SEQ_PKG_INCLUDED_
`define DEVICE1_UART_SEQ_PKG_INCLUDED_

//-----------------------------------------------------------------------------------------
// Package: device1_uart_seq_pkg
// Description:
// Includes all the files written to run the simulation
//-------------------------------------------------------------------------------------------
  package device1_uart_seq_pkg;

//-------------------------------------------------------
// Import uvm package
//-------------------------------------------------------
 `include "uvm_macros.svh"
  import uvm_pkg::*;
  import uart_device1_pkg::*;

//-------------------------------------------------------
// Importing the required packages
//-------------------------------------------------------
 `include "device1_base_sequence.sv"
 `include "device1_uart_fd_seq.sv"

endpackage :device1_uart_seq_pkg

`endif
