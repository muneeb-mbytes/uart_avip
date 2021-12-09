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
  extern static function void from_class(input tx_xtn input_conv_h,tx_agent_config tx_agent_cfg_h,
                                         output uart_transfer_char_s output_conv); 
  extern static function void to_class(input uart_transfer_char_s input_conv,
                                       output tx_xtn output_conv_h);
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


//--------------------------------------------------------------------------------------------
// function: from_class
// converting seq_item transactions into struct data items
//--------------------------------------------------------------------------------------------
function void tx_seq_item_converter::from_class(input tx_xtn input_conv_h,
                           tx_agent_config tx_agent_cfg_h,output uart_transfer_char_s output_conv); 
  
  output_conv.no_of_tx_bits_transfer= uart_type_e'(tx_agent_cfg_h.uart_type);
  uart_tx_bits = output_conv.no_of_tx_bits_transfer;
  output_conv.no_of_tx_elements = input_conv_h.tx_data.size();
  `uvm_info("device_seq_item_conv_class",$sformatf("tx_from_class"),UVM_LOW);
  
  for(int row_no = 0; row_no < input_conv_h.tx_data.size(); row_no++) begin
    for(int i = 0; i <= output_conv.no_of_tx_bits_transfer; i++) begin
      output_conv.tx[row_no][i] = input_conv_h.tx_data[row_no][i];
    end
    //output_conv.parity_bit = input_conv_h.parity;
    `uvm_info("device_seq_item_conv_class",$sformatf("total tx = \n %b",output_conv.tx),UVM_LOW)
  end
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
                                                      output tx_xtn output_conv_h);
  output_conv_h = new();
  
  // Defining the size of arrays
  //output_conv_h.tx_data = new[input_conv.tx.size()];
  output_conv_h.tx_data = new[$size(input_conv.tx)];
  
  // Storing the values in the respective arrays
  //for(int row_no = 0; row_no < output_cov_h.tx.size(); row_no++) begin
  for(int i=0; i<input_conv.no_of_tx_bits_transfer; i++) begin
    output_conv_h.tx_data[i] = input_conv.tx[i];
  end
  `uvm_info("device_seq_item_conv_class",
  $sformatf("To class tx = \n %p",output_conv_h.tx_data),UVM_LOW)
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
endfunction : do_print

`endif
