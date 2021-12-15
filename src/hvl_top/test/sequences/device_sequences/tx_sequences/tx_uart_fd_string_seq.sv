`ifndef TX_UART_FD_STRING_SEQ_INCLUDED_
`define TX_UART_FD_STRING_SEQ_INCLUDED_

//--------------------------------------------------------------------------------------------
// class: extended class from base class
//--------------------------------------------------------------------------------------------
class tx_uart_fd_string_seq extends tx_base_sequence;


  //register with factory so can use create uvm_method 
  //and override in future if necessary 
  `uvm_object_utils(tx_uart_fd_string_seq)

  int i;
  string str = "VAJRV";

  //---------------------------------------------
  // Externally defined tasks and functions
  //---------------------------------------------

  extern function new (string name="tx_uart_fd_string_seq");
  extern virtual task body();

endclass:tx_uart_fd_string_seq

//-----------------------------------------------------------------------------
// Constructor: new
// Initializes the device_sequence class object
//
// Parameters:
//  name - instance name of the config_template
//-----------------------------------------------------------------------------

function tx_uart_fd_string_seq::new(string name="tx_uart_fd_string_seq");
  super.new(name);
endfunction:new

//-----------------------------------------------------------------------------
//task:body
//based on the request from driver task will drive the transaction
//-----------------------------------------------------------------------------
task tx_uart_fd_string_seq::body();
  req = tx_xtn::type_id::create("req");
  start_item(req);
  //for(int i=0;i<8;i++) begin
  if(!req.randomize() with {req.tx_data.size() == 6;
                            foreach(str[i]) 
                            req.tx_data[i] == str[i];
                           })begin
    `uvm_fatal(get_type_name(),"Randomization failed")
  //end
end
  req.print();
  finish_item(req);
endtask:body

`endif
