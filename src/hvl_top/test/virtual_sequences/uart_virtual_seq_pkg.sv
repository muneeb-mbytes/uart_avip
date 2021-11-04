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
  import uart_device0_pkg::*;
  import uart_device1_pkg::*;
  import device0_uart_seq_pkg::*;
  import device1_uart_seq_pkg::*;
  import uart_env_pkg::*;


  //-------------------------------------------------------
  // Include all other files
  //-------------------------------------------------------

  `include "uart_virtual_seq_base.sv"
  `include "uart_virtual_seqs.sv"
  
endpackage : uart_virtual_seq_pkg

`endif
