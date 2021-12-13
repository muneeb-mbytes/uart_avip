`ifndef TX1_UART_FD_8B_SEQ_INCLUDED_
`define TX1_UART_FD_8B_SEQ_INCLUDED_


//--------------------------------------------------------------------------------------------
// Class: seq extended from base seq class
//--------------------------------------------------------------------------------------------

class tx1_uart_fd_8b_seq extends tx1_base_sequence;

  //-------------------------------------------------------
  // Factory Registration is done to override the object
  //-------------------------------------------------------
  `uvm_object_utils(tx1_uart_fd_8b_seq)

  //-------------------------------------------------------
  // Externally defined tasks and functions
  //-------------------------------------------------------
  extern function new(string name = "tx1_uart_fd_8b_seq");
  extern virtual task body();

endclass : tx1_uart_fd_8b_seq

//--------------------------------------------------------------------------------------------
// Construct: new
// Initializes tx1 sequence class object 
//
// Parameters:
//  name - tx1_uart_fd_8b_seq
//--------------------------------------------------------------------------------------------
function tx1_uart_fd_8b_seq::new(string name = "tx1_uart_fd_8b_seq");
  super.new(name);
endfunction : new

//-------------------------------------------------------
// task:body
// based on the request from driver task will drive the transaction 
//-------------------------------------------------------

task tx1_uart_fd_8b_seq::body();
  req=tx_xtn::type_id::create("req"); begin
  start_item(req);
  // ..
  // randomize the signals
  req.print();
  finish_item(req);
end
endtask : body

`endif
