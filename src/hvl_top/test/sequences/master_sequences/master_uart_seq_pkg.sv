`ifndef MASTER_UART_SEQ_PKG_INCLUDED_
`define MASTER_UART_SEQ_PKG_INCLUDED_

//-----------------------------------------------------------------------------------------
// Package: master_uart_seq_pkg
// Description:
// Includes all the files written to run the simulation
//-------------------------------------------------------------------------------------------
  package master_uart_seq_pkg;

//-------------------------------------------------------
// Import uvm package
//-------------------------------------------------------
 `include "uvm_macros.svh"
  import uvm_pkg::*;
  import uart_master_pkg::*;

//-------------------------------------------------------
// Importing the required packages
//-------------------------------------------------------
 `include "master_base_sequence.sv"
 `include "master_uart_fd_seq.sv"

endpackage :master_uart_seq_pkg

`endif

