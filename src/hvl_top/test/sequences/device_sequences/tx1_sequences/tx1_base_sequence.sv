`ifndef TX1_BASE_SEQUENCE_INCLUDED_
`define TX1_BASE_SEQUENCE_INCLUDED_
//--------------------------------------------------------------------------------------------
// Class: tx1_base_sequence
// Creating tx1_base_seq extends from uvm_sequence 
//--------------------------------------------------------------------------------------------
class tx1_base_sequence extends uvm_sequence #(tx_xtn);
  //register with factory so we can override using uvm methods in future.

  `uvm_object_utils(tx1_base_sequence)
  `uvm_declare_p_sequencer(tx_sequencer)
  
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "tx1_base_sequence");
  extern task body();

endclass : tx1_base_sequence

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - tx1_base_sequence
//--------------------------------------------------------------------------------------------
function tx1_base_sequence::new(string name = "tx1_base_sequence");
  super.new(name);
endfunction : new

task tx1_base_sequence::body();
  if(!$cast(p_sequencer,m_sequencer))begin
    `uvm_error(get_full_name(),"tx_agent_config pointer cast failed")
  end
endtask

`endif

