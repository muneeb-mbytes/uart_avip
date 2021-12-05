`ifndef RX_UART_FD_SEQ_INCLUDED_
`define RX_UART_FD_SEQ_INCLUDED_


//--------------------------------------------------------------------------------------------
// Class: seq extended from base seq class
//--------------------------------------------------------------------------------------------

class rx_uart_fd_seq extends rx_base_sequence;

  //-------------------------------------------------------
  // Factory Registration is done to override the object
  //-------------------------------------------------------
  `uvm_object_utils(rx_uart_fd_seq)

  //-------------------------------------------------------
  // Externally defined tasks and functions
  //-------------------------------------------------------
  extern function new(string name = "rx_uart_fd_seq");
  extern virtual task body();

endclass : rx_uart_fd_seq

//--------------------------------------------------------------------------------------------
// Construct: new
// Initializes rx sequence class object 
//
// Parameters:
//  name - rx_uart_fd_seq
//--------------------------------------------------------------------------------------------
function rx_uart_fd_seq::new(string name = "rx_uart_fd_seq");
  super.new(name);
endfunction : new

//-------------------------------------------------------
// task:body
// based on the request from driver task will drive the transaction 
//-------------------------------------------------------

task rx_uart_fd_seq::body();
  req=device_rx::type_id::create("req"); begin
  start_item(req);
  // ..
  // randomize the signals
  finish_item(req);
end
endtask : body

`endif
