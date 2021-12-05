`ifndef TX_UART_FD_SEQ_INCLUDED_
`define TX_UART_FD_SEQ_INCLUDED_


//--------------------------------------------------------------------------------------------
// Class: seq extended from base seq class
//--------------------------------------------------------------------------------------------

class tx_uart_fd_seq extends tx_base_sequence;

  //-------------------------------------------------------
  // Factory Registration is done to override the object
  //-------------------------------------------------------
  `uvm_object_utils(tx_uart_fd_seq)

  //-------------------------------------------------------
  // Externally defined tasks and functions
  //-------------------------------------------------------
  extern function new(string name = "tx_uart_fd_seq");
  extern virtual task body();

endclass : tx_uart_fd_seq

//--------------------------------------------------------------------------------------------
// Construct: new
// Initializes tx sequence class object 
//
// Parameters:
//  name - tx_uart_fd_seq
//--------------------------------------------------------------------------------------------
function tx_uart_fd_seq::new(string name = "tx_uart_fd_seq");
  super.new(name);
endfunction : new

//-------------------------------------------------------
// task:body
// based on the request from driver task will drive the transaction 
//-------------------------------------------------------

task tx_uart_fd_seq::body();
  req=device_tx::type_id::create("req"); begin
  start_item(req);
  // ..
  // randomize the signals
  finish_item(req);
end
endtask : body

`endif
