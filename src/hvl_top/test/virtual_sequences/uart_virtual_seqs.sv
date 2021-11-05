`ifndef UART_VIRTUAL_SEQS_INCLUDED_
`define UART_VIRTUAL_SEQS_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: uart_virtual_seqs
// Extended class from UART virtual sequence 
//--------------------------------------------------------------------------------------------
class uart_virtual_seqs extends uart_virtual_seq_base;

  //register with factory so can use create uvm_method and
  //override in future if necessary 
  
  `uvm_object_utils(uart_virtual_seqs)
  
  //--------------------------------------------------------------------------------------------
  // Externally defined tasks and functions
  //--------------------------------------------------------------------------------------------
  extern function new(string name="uart_virtual_seqs");
  extern task body();

endclass

//--------------------------------------------------------------------------------------------
// Constructor:new
//
// Paramters:
// name - Instance name of the virtual_sequence
// parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function uart_virtual_seqs::new(string name = "uart_virtual_seqs");
  super.new(name);
endfunction: new

//--------------------------------------------------------------------------------------------
// task:body
// Creates the required ports
//
// Parameters:
// phase - stores the current phase
//--------------------------------------------------------------------------------------------

task uart_virtual_seqs::body();
 super.body();//Sets up the sub-sequencer pointer
 // ...
endtask: body

`endif

