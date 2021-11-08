`ifndef DEVICE0_BASE_SEQUENCE_INCLUDED_
`define DEVICE0_BASE_SEQUENCE_INCLUDED_
//--------------------------------------------------------------------------------------------
// Class: device0_base_sequence
// Creating device0_base_seq extends from uvm_sequence 
//--------------------------------------------------------------------------------------------
class device0_base_sequence extends uvm_sequence #(device0_tx);
  //register with factory so we can override using uvm methods in future.

  `uvm_object_utils(device0_base_sequence)
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "device0_base_sequence");

endclass : device0_base_sequence

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - device0_base_sequence
//--------------------------------------------------------------------------------------------
function device0_base_sequence::new(string name = "device0_base_sequence");
  super.new(name);
endfunction : new

`endif

