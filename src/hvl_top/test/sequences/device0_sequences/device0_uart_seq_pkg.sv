`ifndef DEVICE0_UART_SEQ_PKG_INCLUDED_
`define DEVICE0_UART_SEQ_PKG_INCLUDED_

//-----------------------------------------------------------------------------------------
// Package: device0_uart_seq_pkg
// Description:
// Includes all the files written to run the simulation
//-------------------------------------------------------------------------------------------
  package device0_uart_seq_pkg;

//-------------------------------------------------------
// Import uvm package
//-------------------------------------------------------
 `include "uvm_macros.svh"
  import uvm_pkg::*;
  import uart_device0_pkg::*;

//-------------------------------------------------------
// Importing the required packages
//-------------------------------------------------------
 `include "device0_base_sequence.sv"
 `include "device0_uart_fd_seq.sv"

endpackage :device0_uart_seq_pkg

`endif

