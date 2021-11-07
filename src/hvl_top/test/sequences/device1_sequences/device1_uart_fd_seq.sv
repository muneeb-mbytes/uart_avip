`ifndef DEVICE1_UART_FD_SEQ_INCLUDED_
`define DEVICE1_UART_FD_SEQ_INCLUDED_


//--------------------------------------------------------------------------------------------
// Class: seq extended from base seq class
//--------------------------------------------------------------------------------------------

class device1_uart_fd_seq extends device1_base_sequence;

  //-------------------------------------------------------
  // Factory Registration is done to override the object
  //-------------------------------------------------------
  `uvm_object_utils(device1_uart_fd_seq)

  //-------------------------------------------------------
  // Externally defined tasks and functions
  //-------------------------------------------------------
  extern function new(string name = "device1_uart_fd_seq");
  extern virtual task body();

endclass : device1_uart_fd_seq

//--------------------------------------------------------------------------------------------
// Construct: new
// Initializes device1 sequence class object 
//
// Parameters:
//  name - device1_uart_fd_seq
//--------------------------------------------------------------------------------------------
function device1_uart_fd_seq::new(string name = "device1_uart_fd_seq");
  super.new(name);
endfunction : new

//-------------------------------------------------------
// task:body
// based on the request from driver task will drive the transaction
//-------------------------------------------------------

task device1_uart_fd_seq::body();
  req=device1_tx::type_id::create("req");
begin
  start_item(req);
  // ...
  // randomize the signals here
  finish_item(req);
end
endtask : body

`endif
