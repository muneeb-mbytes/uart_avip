`ifndef UART_SLAVE_SEQ_ITEM_CONVERTER_INCLUDED_
`define UART_SLAVE_SEQ_ITEM_CONVERTER_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: uart_slave_seq_item_converter
// Description:
// class for converting the transaction items to struct and vice versa
//--------------------------------------------------------------------------------------------
class uart_slave_seq_item_converter extends uvm_object;
  `uvm_object_utils(uart_slave_seq_item_converter)

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "uart_slave_seq_item_converter");
endclass : uart_slave_seq_item_converter

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
// name - uart_slave_seq_item_converter
//--------------------------------------------------------------------------------------------
function uart_slave_seq_item_converter::new(string name = "uart_slave_seq_item_converter");
  super.new(name);
endfunction : new

`endif

