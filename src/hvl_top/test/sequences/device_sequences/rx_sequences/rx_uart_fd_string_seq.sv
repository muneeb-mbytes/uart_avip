`ifndef RX_UART_FD_STRING_SEQ_INCLUDED_
`define RX_UART_FD_STRING_SEQ_INCLUDED_

//--------------------------------------------------------------------------------------------
// class: extended class from base class
//--------------------------------------------------------------------------------------------
class rx_uart_fd_string_seq extends rx_base_sequence;


  //register with factory so can use create uvm_method 
  //and override in future if necessary 
  `uvm_object_utils(rx_uart_fd_string_seq)


  //---------------------------------------------
  // Externally defined tasks and functions
  //---------------------------------------------

  extern function new (string name="rx_uart_fd_string_seq");
  extern virtual task body();

endclass:rx_uart_fd_string_seq

//-----------------------------------------------------------------------------
// Constructor: new
// Initializes the device_sequence class object
//
// Parameters:
//  name - instance name of the config_template
//-----------------------------------------------------------------------------

function rx_uart_fd_string_seq::new(string name="rx_uart_fd_string_seq");
  super.new(name);
endfunction:new

//-----------------------------------------------------------------------------
//task:body
//based on the request from driver task will drive the transaction
//-----------------------------------------------------------------------------
task rx_uart_fd_string_seq::body();
  req = rx_xtn::type_id::create("req");
  start_item(req);
  //for(int i=0;i<8;i++) begin
  if(!req.randomize())
    `uvm_fatal(get_type_name(),"Randomization failed")
  //end
  req.print();
  finish_item(req);
endtask:body

`endif
