`ifndef RX_BASE_SEQUENCE_INCLUDED_
`define RX_BASE_SEQUENCE_INCLUDED_
//--------------------------------------------------------------------------------------------
// Class: rx_base_sequence
// Creating rx_base_seq extends from uvm_sequence 
//--------------------------------------------------------------------------------------------
class rx_base_sequence extends uvm_sequence #(device_rx);
  //register with factory so we can override using uvm methods in future.

  `uvm_object_utils(rx_base_sequence)
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "rx_base_sequence");

endclass : rx_base_sequence

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - rx_base_sequence
//--------------------------------------------------------------------------------------------
function rx_base_sequence::new(string name = "rx_base_sequence");
  super.new(name);
endfunction : new

`endif

