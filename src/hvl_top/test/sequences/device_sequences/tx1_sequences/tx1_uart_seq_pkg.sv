`ifndef TX1_UART_SEQ_PKG_INCLUDED_
`define TX1_UART_SEQ_PKG_INCLUDED_

//-----------------------------------------------------------------------------------------
// Package: tx1_uart_seq_pkg
// Description:
// Includes all the files written to run the simulation
//-------------------------------------------------------------------------------------------
package tx1_uart_seq_pkg;
  
  //-------------------------------------------------------
  // Importing UVM Pkg
  //-------------------------------------------------------
  `include "uvm_macros.svh"
  import uvm_pkg::*;
  import tx_pkg::*;

  //-------------------------------------------------------
  // Including required uart tx1 seq files
  //-------------------------------------------------------
  `include "tx1_base_sequence.sv"
  `include "tx1_uart_fd_8b_seq.sv"
  `include "tx1_uart_fd_lsb_seq.sv"
  `include "tx1_uart_fd_msb_seq.sv"
  `include "tx1_uart_fd_baudrate_seq.sv"
  `include "tx1_uart_fd_string_seq.sv"

endpackage : tx1_uart_seq_pkg

`endif

