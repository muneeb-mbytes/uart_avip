`ifndef RX_UART_SEQ_PKG_INCLUDED_
`define RX_UART_SEQ_PKG_INCLUDED_

//-----------------------------------------------------------------------------------------
// Package: rx_uart_seq_pkg
// Description:
// Includes all the files written to run the simulation
//-------------------------------------------------------------------------------------------
package rx_uart_seq_pkg;
  
  //-------------------------------------------------------
  // Importing UVM Pkg
  //-------------------------------------------------------
  `include "uvm_macros.svh"
  import uvm_pkg::*;
  import rx_pkg::*;

  //-------------------------------------------------------
  // Including required uart rx seq files
  //-------------------------------------------------------
  `include "rx_base_sequence.sv"
  `include "rx_uart_fd_8b_seq.sv"
  `include "rx_uart_fd_lsb_seq.sv"
  `include "rx_uart_fd_msb_seq.sv"
  `include "rx_uart_fd_baudrate_seq.sv"
  `include "rx_uart_fd_string_seq.sv"

endpackage : rx_uart_seq_pkg

`endif

