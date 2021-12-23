`ifndef UART_VIRTUAL_SEQ_PKG_INCLUDED_
`define UART_VIRTUAL_SEQ_PKG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Package: uart_virtual_seq_pkg
//  Includes all the files related to uart virtual sequences
//--------------------------------------------------------------------------------------------
package uart_virtual_seq_pkg;

  //-------------------------------------------------------
  // Import uvm package
  //-------------------------------------------------------
  `include "uvm_macros.svh"
  import uvm_pkg::*;
  import tx_pkg::*;
  import rx_pkg::*;
  import tx_uart_seq_pkg::*;
  import rx_uart_seq_pkg::*;
  import uart_env_pkg::*;


  //-------------------------------------------------------
  // Include all other files
  //-------------------------------------------------------

  `include "uart_virtual_seq_base.sv"
  `include "uart_fd_8b_virtual_seqs.sv"
  `include "uart_fd_lsb_virtual_seq.sv"
  `include "uart_fd_msb_virtual_seq.sv"
  `include "uart_fd_baudrate_virtual_seq.sv"
  `include "uart_fd_string_virtual_seq.sv"
  `include "uart_fd_5b_virtual_seqs.sv"
  `include "uart_fd_rand_virtual_seqs.sv"
  `include "uart_fd_stop_bit_2b_virtual_seqs.sv"
  `include "uart_fd_cross_virtual_seq.sv"
  `include "uart_fd_6b_virtual_seq.sv"
  `include "uart_fd_7b_virtual_seq.sv"
  `include "uart_fd_even_parity_virtual_seq.sv"
  `include "uart_fd_oversampling_four_virtual_seq.sv"
  `include "uart_fd_oversampling_eight_virtual_seq.sv"
  `include "uart_fd_uarttype_parity_cross_virtual_seq.sv"


endpackage : uart_virtual_seq_pkg

`endif
