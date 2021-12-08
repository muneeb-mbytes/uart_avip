`ifndef TX_BASE_SEQUENCE_INCLUDED_
`define TX_BASE_SEQUENCE_INCLUDED_
//--------------------------------------------------------------------------------------------
// Class: tx_base_sequence
// Creating tx_base_seq extends from uvm_sequence 
//--------------------------------------------------------------------------------------------
class tx_base_sequence extends uvm_sequence #(tx_xtn);
  //register with factory so we can override using uvm methods in future.

  `uvm_object_utils(tx_base_sequence)
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "tx_base_sequence");

endclass : tx_base_sequence

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - tx_base_sequence
//--------------------------------------------------------------------------------------------
function tx_base_sequence::new(string name = "tx_base_sequence");
  super.new(name);
endfunction : new

`endif

