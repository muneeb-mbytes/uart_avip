`ifndef UART_FD_OVERSAMPLING_FOUR_VIRTUAL_SEQ_INCLUDED_
`define UART_FD_OVERSAMOLING_FOUR_VIRTUAL_SEQ_INCLUDED_

//--------------------------------------------------------------------------------------------
// Extended class from uart device_virtual sequence
//--------------------------------------------------------------------------------------------
class uart_fd_oversampling_four_virtual_seq extends uart_virtual_seq_base;
  `uvm_object_utils(uart_fd_oversampling_four_virtual_seq)

  
  tx_uart_fd_oversampling_four_seq tx_uart_fd_oversampling_four_seq_h;
  //rx_uart_fd_oversampling_four_fourseq rx_uart_fd_oversampling_four_seq_h;
  
  //--------------------------------------------------------------------------------------------
  // Externally defined tasks and functions
  //--------------------------------------------------------------------------------------------
  extern function new(string name="uart_fd_oversampling_four_virtual_seq");
  extern task body();

endclass : uart_fd_oversampling_four_virtual_seq

//--------------------------------------------------------------------------------------------
//Constructor:new
//
//Paramters:
//name - Instance name of the device_virtual_sequence
//parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function uart_fd_oversampling_four_virtual_seq::new(string name="uart_fd_oversampling_four_virtual_seq");
  super.new(name);
endfunction: new

//--------------------------------------------------------------------------------------------
//task:body
//Creates the required ports
//
//Parameters:
// phase - stores the current phase
//--------------------------------------------------------------------------------------------
task uart_fd_oversampling_four_virtual_seq::body();
 super.body(); //Sets up the sub-sequencer pointer

   //creating device_virtual sequence handles here  

   tx_uart_fd_oversampling_four_seq_h=tx_uart_fd_oversampling_four_seq::type_id::create("tx_uart_fd_oversampling_four_seq_h");
  // rx_uart_fd_oversampling_four_fourseq_h=rx_uart_fd_oversampling_four_fourseq::type_id::create("rx_uart_fd_oversampling_four_fourseq_h");

   //configuring no of devices and starting device sequencers
 // fork 
 //    //starting rx sequencer with respective to p_sequencer declared in device seq base
 //    forever begin : RX_SEQ_START
 //      rx_uart_fd_oversampling_four_fourseq_h.start(p_sequencer.rx_seqr_h);
 //    end
 //  join_none
     
   //starting tx virtual sequencer with respective to p_sequencer declared in device_virtual seq base
   repeat(5) begin : TX_SEQ_START
     tx_uart_fd_oversampling_four_seq_h.start(p_sequencer.tx_seqr_h);
   end

endtask: body

`endif
