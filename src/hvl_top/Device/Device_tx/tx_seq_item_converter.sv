`ifndef TX_SEQ_ITEM_CONVERTER_INCLUDED_
`define TX_SEQ_ITEM_CONVERTER_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: tx_seq_item_converter
// Description:
// class for converting the transaction items to struct and vice veras
//--------------------------------------------------------------------------------------------
class tx_seq_item_converter extends uvm_object;
  `uvm_object_utils(tx_seq_item_converter)

  static int uart_tx_bits;
  

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "tx_seq_item_converter");
  extern static function void tx_bits(tx_agent_config tx_agent_cfg_h);
  //                                     uart_transfer_char_s output_conv);
  extern static function void from_class(input device_tx input_conv_h,
                                         output uart_transfer_char_s output_conv); 
  extern static function void to_class(input uart_transfer_char_s input_conv,
                                       output device_tx output_conv_h);
  extern function void do_print(uvm_printer printer);
endclass : tx_seq_item_converter

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
// name - tx_seq_item_converter
//--------------------------------------------------------------------------------------------
function tx_seq_item_converter::new(string name = "tx_seq_item_converter");
  super.new(name);
endfunction : new

function void tx_seq_item_converter::tx_bits(tx_agent_config tx_agent_cfg_h);
  // `uvm_info("device_seq_item_conv_class",$sformatf("tx_bits_class"),UVM_LOW); 
  // `uvm_info("device_seq_item_conv_class",$sformatf("before no of tx bits = \n %p",
  // output_conv.no_of_tx_bits_transfer),UVM_LOW);
  uart_tx_bits = uart_type_e'(tx_agent_cfg_h.uart_type);
  //output_conv.no_of_tx_bits_transfer = 8;
  //output_conv.no_of_tx_bits_transfer = uart_tx_bits;
  //`uvm_info("device_seq_item_conv_class",$sformatf("no of tx bits = \n %p",
  //output_conv.no_of_tx_bits_transfer),UVM_LOW);
endfunction : tx_bits

//--------------------------------------------------------------------------------------------
// function: from_class
// converting seq_item transactions into struct data items
//--------------------------------------------------------------------------------------------
function void tx_seq_item_converter::from_class(input device_tx input_conv_h,
                                                       output uart_transfer_char_s output_conv); 
   tx_agent_config tx_agent_cfg_h;
  // uart_transfer_cfg_s uart_cfg_h;
   //$cast(output_conv.no_of_tx_bits_transfer,tx_agent_cfg_h.uart_type);
   //output_conv.no_of_tx_bits_transfer= uart_type_e'(tx_agent_cfg_h.uart_type);
   //output_conv.no_of_tx_bits_transfer = 8;
   // output_conv.no_of_tx_bits_transfer = uart_cfg_h.uart_type;
   //`uvm_info("device_seq_item_conv_class",$sformatf("no of tx bits = \n %p",
   //                                             output_conv.no_of_tx_bits_transfer),UVM_LOW);
   output_conv.no_of_tx_bits_transfer = uart_tx_bits;


   `uvm_info("device_seq_item_conv_class",$sformatf("tx_from_class"),UVM_LOW);
 // if(uart_type_cov == 2'b00) begin
 //   output_conv.no_of_tx_bits_transfer = 5;
 // end
 // else if(uart_type_cov == 2'b01) begin
 //   output_conv.no_of_tx_bits_transfer = 6;
 // end
 // else if(uart_type_cov == 2'b10) begin
 //   output_conv.no_of_tx_bits_transfer = 7;
 // end
 // else begin
 //   output_conv.no_of_tx_bits_transfer = 8;
 // end
 //for(int row_no = 0; row_no < input_cov_h.tx.size(); row_no++) begin
 
   for(int i = 0; i < output_conv.no_of_tx_bits_transfer; i++) begin
   //for(int i = 0; i < 8; i++) begin
     //`uvm_info("device_seq_item_conv_class",$sformatf("After shift input_cov_h tx = \n %p",
     //input_conv_h.tx[i]),UVM_LOW)
     //output_conv.tx[row_no][i] = input_conv_h.tx[row_no][i];
     output_conv.tx[i] = input_conv_h.tx[i];
     //`uvm_info("device_seq_item_conv_class",$sformatf("After shift input_cov_h tx = \n %p",
     //input_conv_h.tx[i]),UVM_LOW)   
     //`uvm_info("device_seq_item_conv_class",$sformatf("Bit tx = \n %p",output_conv.tx[i]),UVM_LOW)
   end

   output_conv.parity_bit = input_conv_h.parity;
   `uvm_info("device_seq_item_conv_class",$sformatf("total tx = \n %p",output_conv.tx),UVM_LOW)
 //end
 endfunction : from_class 
  

//function void tx_seq_item_converter::parity_check(int tx_bit_count,uart_transfer_char_s output_conv); 
//function void tx_seq_item_converter::parity_check(uart_transfer_char_s output_conv); 
////this.tx_bit_count = tx_bit_count;
//if((tx_bit_count)%2 == 0) begin
//  output_conv.parity_bit = 0;
//end
//else begin
//  output_conv.parity_bit = 1;
//end
//endfunction: parity_check

//--------------------------------------------------------------------------------------------
// function:to_class
// converting struct data items into seq_item transactions
//--------------------------------------------------------------------------------------------  
function void tx_seq_item_converter::to_class(input uart_transfer_char_s input_conv,
                                                      output device_tx output_conv_h);
  output_conv_h = new();

  // Defining the size of arrays
  output_conv_h.tx = new[CHAR_LENGTH/CHAR_LENGTH];
  //output_conv_h.rx = new[CHAR_LENGTH/CHAR_LENGTH];

  // Storing the values in the respective arrays
  //for(int row_no = 0; row_no < output_cov_h.tx.size(); row_no++) begin
    for(int i=0; i<input_conv.no_of_tx_bits_transfer; i++) begin
      //output_conv_h.tx[row_no][i] = input_conv.tx[row_no][i];
      output_conv_h.tx[i] = input_conv.tx[i];
     // output_conv_h.rx[row_no][i] = input_conv.rx[row_no][i];
     // `uvm_info("device_seq_item_conv_class",
     // $sformatf("To class rx = \n %p",output_conv_h.rx[i]),UVM_LOW)
    end
    `uvm_info("device_seq_item_conv_class",
    $sformatf("To class tx = \n %p",output_conv_h.tx),UVM_LOW)
 //end

endfunction : to_class

//--------------------------------------------------------------------------------------------
// Function: do_print method
// Print method can be added to display the data members values
//--------------------------------------------------------------------------------------------
function void tx_seq_item_converter::do_print(uvm_printer printer);
  uart_transfer_char_s uart_st;
  super.do_print(printer);
  foreach(uart_st.tx[i]) begin
    printer.print_field($sformatf("tx[%0d]",i),uart_st.tx[i],8,UVM_HEX);
  end
//  foreach(uart_st.rx[i]) begin
//    printer.print_field($sformatf("rx[%0d]",i,),uart_st.rx[i],8,UVM_HEX);
//  end
endfunction : do_print

`endif
