`ifndef TX_UART_FD_LSB_SEQ_INCLUDED_
`define TX_UART_FD_LSB_SEQ_INCLUDED_

//--------------------------------------------------------------------------------------------
// class: extended class from base class
//--------------------------------------------------------------------------------------------
class tx_uart_fd_lsb_seq extends tx_base_sequence;
  
  //register with factory so can use create uvm_method 
  //and override in future if necessary 
  `uvm_object_utils(tx_uart_fd_lsb_seq)

  //---------------------------------------------
  // Externally defined tasks and functions
  //---------------------------------------------
  extern function new (string name="tx_uart_fd_lsb_seq");
  extern virtual task body();

endclass:tx_uart_fd_lsb_seq

//-----------------------------------------------------------------------------
// Constructor: new
// Initializes the device_sequence class object
//
// Parameters:
//  name - instance name of the config_template
//-----------------------------------------------------------------------------
function tx_uart_fd_lsb_seq::new(string name="tx_uart_fd_lsb_seq");
  super.new(name);
endfunction:new

//-----------------------------------------------------------------------------
//task:body
//based on the request from driver task will drive the transaction
//-----------------------------------------------------------------------------
task tx_uart_fd_lsb_seq::body();
  req = device_tx::type_id::create("req");
  start_item(req);
  if(!req.randomize() with {req.tx.size() == 1;
                           }) begin
    `uvm_fatal(get_type_name(),"Randomization failed")
  end
  req.print();
  finish_item(req);
endtask:body

`endif

