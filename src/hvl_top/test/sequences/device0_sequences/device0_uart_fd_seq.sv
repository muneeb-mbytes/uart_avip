`ifndef device0_UART_FD_SEQ_INCLUDED_
`define device0_UART_FD_SEQ_INCLUDED_


//--------------------------------------------------------------------------------------------
// Class: seq extended from base seq class
//--------------------------------------------------------------------------------------------

class device0_uart_fd_seq extends device0_base_sequence;

  //-------------------------------------------------------
  // Factory Registration is done to override the object
  //-------------------------------------------------------
  `uvm_object_utils(device0_uart_fd_seq)

  //-------------------------------------------------------
  // Externally defined tasks and functions
  //-------------------------------------------------------
  extern function new(string name = "device0_uart_fd_seq");
  extern virtual task body();

endclass : device0_uart_fd_seq

//--------------------------------------------------------------------------------------------
// Construct: new
// Initializes sseq1 class object 
//
// Parameters:
//  name - sseq1
//--------------------------------------------------------------------------------------------
function device0_uart_fd_seq::new(string name = "device0_uart_fd_seq");
  super.new(name);
endfunction : new

//-------------------------------------------------------
// task:body
// based on the request from driver task will drive the transaction 
//-------------------------------------------------------

task device0_uart_fd_seq::body();
  req=device0_tx::type_id::create("req");
begin
  start_item(req);
  // ..
  // randomize the signals
  finish_item(req);
end
endtask : body

`endif
