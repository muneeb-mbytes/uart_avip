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
  
endpackage : uart_virtual_seq_pkg

`endif
