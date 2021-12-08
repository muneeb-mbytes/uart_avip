`ifndef RX_UART_FD_MSB_SEQ_INCLUDED_
`define RX_UART_FD_MSB_SEQ_INCLUDED_

//--------------------------------------------------------------------------------------------
// class: extended class from base class
//--------------------------------------------------------------------------------------------
class rx_uart_fd_msb_seq extends rx_base_sequence;
  
  //register with factory so can use create uvm_method 
  //and override in future if necessary 
  `uvm_object_utils(rx_uart_fd_msb_seq)

  //---------------------------------------------
  // Externally defined tasks and functions
  //---------------------------------------------
  extern function new (string name="rx_uart_fd_msb_seq");
  extern virtual task body();

endclass:rx_uart_fd_msb_seq

//-----------------------------------------------------------------------------
// Constructor: new
// Initializes the device_sequence class object
//
// Parameters:
//  name - instance name of the config_template
//-----------------------------------------------------------------------------
function rx_uart_fd_msb_seq::new(string name="rx_uart_fd_msb_seq");
  super.new(name);
endfunction:new

//-----------------------------------------------------------------------------
//task:body
//based on the request from driver task will drive the transaction
//-----------------------------------------------------------------------------
task rx_uart_fd_msb_seq::body();
  req = rx_xtn::type_id::create("req"); begin
  start_item(req);
  req.print();
  finish_item(req);
end
endtask:body

`endif

