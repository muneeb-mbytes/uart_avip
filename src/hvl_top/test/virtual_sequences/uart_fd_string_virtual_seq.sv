`ifndef UART_FD_STRING_VIRTUAL_SEQ_INCLUDED_
`define UART_FD_STRING_VIRTUAL_SEQ_INCLUDED_

//--------------------------------------------------------------------------------------------
// Extended class from uart virtual sequence
//--------------------------------------------------------------------------------------------
class uart_fd_string_virtual_seq extends uart_virtual_seq_base;
  `uvm_object_utils(uart_fd_string_virtual_seq)

  tx_uart_fd_string_seq tx_uart_fd_string_seq_h;
  rx_uart_fd_string_seq rx_uart_fd_string_seq_h;
  
  //--------------------------------------------------------------------------------------------
  // Externally defined tasks and functions
  //--------------------------------------------------------------------------------------------
  extern function new(string name="uart_fd_string_virtual_seq");
  extern task body();

endclass : uart_fd_string_virtual_seq

//--------------------------------------------------------------------------------------------
//Constructor:new
//
//Paramters:
//name - Instance name of the virtual_sequence
//parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function uart_fd_string_virtual_seq::new(string name="uart_fd_string_virtual_seq");
  super.new(name);
endfunction: new

//--------------------------------------------------------------------------------------------
//task:body
//Creates the required ports
//
//Parameters:
// phase - stores the current phase
//--------------------------------------------------------------------------------------------
task uart_fd_string_virtual_seq::body();
 super.body(); //Sets up the sub-sequencer pointer

   //creating virtual sequence handles here  
   tx_uart_fd_string_seq_h=tx_uart_fd_string_seq::type_id::create("tx_uart_fd_string_seq_h");
   rx_uart_fd_string_seq_h=rx_uart_fd_string_seq::type_id::create("rx_uart_fd_string_seq_h");

   //configuring no of devices and starting device sequencers
   //fork 
   //   //starting slave sequencer with respective to p_sequencer declared in device seq base
   //   forever begin : DEVICE1_SEQ_START
   //    uart_fd_string_device1_seq_h.start(p_sequencer.device1_seqr_h);
   //   end
   //join_none
     
   //starting virtual sequencer with respective to p_sequencer declared in virtual seq base
   fork
      repeat(5) begin : TX_SEQ_START
        tx_uart_fd_string_seq_h.start(p_sequencer.tx_seqr_h);
      end
      
      repeat(5) begin : RX_SEQ_START
       rx_uart_fd_string_seq_h.start(p_sequencer.rx_seqr_h);
      end
    join_none

endtask: body

`endif
