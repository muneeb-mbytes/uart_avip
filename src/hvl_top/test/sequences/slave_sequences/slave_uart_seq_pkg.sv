`ifndef SLAVE_UART_SEQ_PKG_INCLUDED_
`define SLAVE_UART_SEQ_PKG_INCLUDED_

//-----------------------------------------------------------------------------------------
// Package: slave_uart_seq_pkg
// Description:
// Includes all the files written to run the simulation
//-------------------------------------------------------------------------------------------
  package slave_uart_seq_pkg;

//-------------------------------------------------------
// Import uvm package
//-------------------------------------------------------
 `include "uvm_macros.svh"
  import uvm_pkg::*;
  import uart_slave_pkg::*;

//-------------------------------------------------------
// Importing the required packages
//-------------------------------------------------------
 `include "slave_base_sequence.sv"
 `include "slave_uart_fd_seq.sv"

endpackage :slave_uart_seq_pkg

`endif
