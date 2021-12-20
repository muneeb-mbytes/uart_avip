`ifndef UART_FD_8B_VIRTUAL_SEQ_INCLUDED_
`define UART_FD_8B_VIRTUAL_SEQ_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: uart_fd_8b_virtual_seq
// Extended class from UART virtual sequence 
//--------------------------------------------------------------------------------------------
class uart_fd_8b_virtual_seq extends uart_virtual_seq_base;
  `uvm_object_utils(uart_fd_8b_virtual_seq)
 
  tx_uart_fd_8b_seq tx_uart_fd_8b_seq_h;
  tx1_uart_fd_8b_seq tx1_uart_fd_8b_seq_h;

  //--------------------------------------------------------------------------------------------
  // Externally defined tasks and functions
  //--------------------------------------------------------------------------------------------
  extern function new(string name="uart_fd_8b_virtual_seq");
  extern task body();

endclass : uart_fd_8b_virtual_seq

//--------------------------------------------------------------------------------------------
// Constructor:new
//
// Paramters:
// name - Instance name of the virtual_sequence
// parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function uart_fd_8b_virtual_seq::new(string name = "uart_fd_8b_virtual_seq");
  super.new(name);
endfunction : new

//--------------------------------------------------------------------------------------------
// task:body
// Creates the required ports
//
// Parameters:
// phase - stores the current phase
//--------------------------------------------------------------------------------------------

task uart_fd_8b_virtual_seq::body();
 super.body();//Sets up the sub-sequencer pointer
 
   //creating device_virtual sequence handles here  
   tx_uart_fd_8b_seq_h=tx_uart_fd_8b_seq::type_id::create("tx_uart_fd_8b_seq_h");
   tx1_uart_fd_8b_seq_h=tx1_uart_fd_8b_seq::type_id::create("tx1_uart_fd_8b_seq_h");

   //configuring no of devices and starting device sequencers
   //starting rx sequencer with respective to p_sequencer declared in device seq base
   repeat(1) begin : DEVICE1_TX_SEQ_START
     #10;
     tx1_uart_fd_8b_seq_h.start(p_sequencer.tx_seqr_h_1);
   end
     
   //starting device_virtual sequencer with respective to p_sequencer declared in device_virtual seq base
   repeat(1) begin : DEVICE0_TX_SEQ_START
   //starting tx_virtual sequencer with respective to p_sequencer declared in device_virtual seq base
    tx_uart_fd_8b_seq_h.start(p_sequencer.tx_seqr_h_0);
   end

endtask : body

`endif

