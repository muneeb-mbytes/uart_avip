`ifndef TX_UART_FD_STOP_BIT_2B_SEQ_INCLUDED_
`define TX_UART_FD_STOP_BIT_2B_SEQ_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: seq extended from base seq class
//--------------------------------------------------------------------------------------------

class tx_uart_fd_stop_bit_2b_seq extends tx_base_sequence;

  //-------------------------------------------------------
  // Factory Registration is done to override the object
  //-------------------------------------------------------
  `uvm_object_utils(tx_uart_fd_stop_bit_2b_seq)

  //-------------------------------------------------------
  // Externally defined tasks and functions
  //-------------------------------------------------------
  extern function new(string name = "tx_uart_fd_stop_bit_2b_seq");
  extern virtual task body();

endclass : tx_uart_fd_stop_bit_2b_seq

//--------------------------------------------------------------------------------------------
// Construct: new
// Initializes tx sequence class object 
//
// Parameters:
//  name - tx_uart_fd_stop_bit_2b_seq
//--------------------------------------------------------------------------------------------
function tx_uart_fd_stop_bit_2b_seq::new(string name = "tx_uart_fd_stop_bit_2b_seq");
  super.new(name);
endfunction : new

//-------------------------------------------------------
// task:body
// based on the request from driver task will drive the transaction 
//-------------------------------------------------------

task tx_uart_fd_stop_bit_2b_seq::body();
  super.body();
  req=tx_xtn::type_id::create("req"); begin
  req.tx_agent_cfg_h = p_sequencer.tx_agent_cfg_h;  
  start_item(req);
  if(!req.randomize()with{req.tx_data.size() == 2;}) begin
    `uvm_fatal(get_type_name(),"Randomization failed")
  end
  req.print();
  finish_item(req);
end
endtask : body

`endif
