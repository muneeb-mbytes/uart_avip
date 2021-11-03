`ifndef MASTER_BASE_SEQUENCE_INCLUDED_
`define MASTER_BASE_SEQUENCE_INCLUDED_
//--------------------------------------------------------------------------------------------
// Class: master_base_sequence
// Creating master_base_seq extends from uvm_sequence 
//--------------------------------------------------------------------------------------------
class master_base_sequence extends uvm_sequence #(master_tx);
  //register with factory so we can ovverride using uvm methods in future.

  `uvm_object_utils(master_base_sequence)
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "master_base_sequence");

endclass : master_base_sequence

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - master_base_sequence
//--------------------------------------------------------------------------------------------
function master_base_sequence::new(string name = "master_base_sequence");
  super.new(name);
endfunction : new

`endif

