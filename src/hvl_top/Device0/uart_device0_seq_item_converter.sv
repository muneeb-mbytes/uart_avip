`ifndef UART_DEVICE0_SEQ_ITEM_CONVERTER_INCLUDED_
`define UART_DEVICE0_SEQ_ITEM_CONVERTER_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: uart_device0_seq_item_converter
// Description:
// class for converting the transaction items to struct and vice veras
//--------------------------------------------------------------------------------------------
class uart_device0_seq_item_converter extends uvm_object;
  `uvm_object_utils(uart_device0_seq_item_converter)

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "uart_device0_seq_item_converter");

endclass : uart_device0_seq_item_converter

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
// name - uart_device0_seq_item_converter
//--------------------------------------------------------------------------------------------
function uart_device0_seq_item_converter::new(string name = "uart_device0_seq_item_converter");
  super.new(name);
endfunction : new

`endif

//convert string  to ASCII to 8bits
//int i=0;
//s=string[20];
//while(str[i])
//$display("%s",str[i++]);
//
//s.atob(ASCII to binary)
//
