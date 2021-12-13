`ifndef TX1_UART_FD_LSB_SEQ_INCLUDED_
`define TX1_UART_FD_LSB_SEQ_INCLUDED_

//--------------------------------------------------------------------------------------------
// class: extended class from base class
//--------------------------------------------------------------------------------------------
class tx1_uart_fd_lsb_seq extends tx1_base_sequence;
  
  //register with factory so can use create uvm_method 
  //and override in future if necessary 
  `uvm_object_utils(tx1_uart_fd_lsb_seq)

  //---------------------------------------------
  // Externally defined tasks and functions
  //---------------------------------------------
  extern function new (string name="tx1_uart_fd_lsb_seq");
  extern virtual task body();

endclass:tx1_uart_fd_lsb_seq

//-----------------------------------------------------------------------------
// Constructor: new
// Initializes the device_sequence class object
//
// Parameters:
//  name - instance name of the config_template
//-----------------------------------------------------------------------------
function tx1_uart_fd_lsb_seq::new(string name="tx1_uart_fd_lsb_seq");
  super.new(name);
endfunction:new

//-----------------------------------------------------------------------------
//task:body
//based on the request from driver task will drive the transaction
//-----------------------------------------------------------------------------
task tx1_uart_fd_lsb_seq::body();
  req = tx_xtn::type_id::create("req"); begin
  start_item(req);
  req.print();
  finish_item(req);
end
endtask:body

`endif

