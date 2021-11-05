`ifndef device1_BASE_SEQUENCE_INCLUDED_
`define device1_BASE_SEQUENCE_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: device1_base_sequence
// Class Description:
// device1_sequence is extended from uvm_sequence to create sequence items
//--------------------------------------------------------------------------------------------
class device1_base_sequence extends uvm_sequence #(device1_tx);

  //-------------------------------------------------------
  // Factory Registration is done to override the object
  //-------------------------------------------------------
  `uvm_object_utils(device1_base_sequence)

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "device1_base_sequence");

endclass : device1_base_sequence

//--------------------------------------------------------------------------------------------
// Construct: new
//  Initializes new memory for device1_sequence
//
// Parameters:
//  name - device1_base_sequence
//--------------------------------------------------------------------------------------------
function device1_base_sequence::new(string name = "device1_base_sequence");
  super.new(name);
endfunction : new

`endif

