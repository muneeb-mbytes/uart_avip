`ifndef RX_SEQ_ITEM_CONVERTER_INCLUDED_
`define RX_SEQ_ITEM_CONVERTER_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: rx_seq_item_converter
// Description:
// class for converting the transaction items to struct and vice versa
//--------------------------------------------------------------------------------------------
class rx_seq_item_converter extends uvm_object;
  `uvm_object_utils(rx_seq_item_converter)

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "rx_seq_item_converter");
  extern static function void from_class(input rx_xtn input_conv_h,rx_agent_config rx_agent_cfg_h,
                                         output uart_reciver_char_s output_conv);
  extern static function void to_class(input uart_reciver_char_s input_conv,
                                       rx_agent_config rx_agent_cfg_h,output rx_xtn output_conv_h);
  extern function void do_print(uvm_printer printer);
endclass : rx_seq_item_converter

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
// name - rx_seq_item_converter
//--------------------------------------------------------------------------------------------
function rx_seq_item_converter::new(string name = "rx_seq_item_converter");
  super.new(name);
endfunction : new

//--------------------------------------------------------------------------------------------
// function:from_class
// converting seq_item transactions into struct data items 
//--------------------------------------------------------------------------------------------  

function void rx_seq_item_converter::from_class(input rx_xtn input_conv_h,
                            rx_agent_config rx_agent_cfg_h,output uart_reciver_char_s output_conv);
  
  output_conv.no_of_rx_bits_transfer = uart_type_e'(rx_agent_cfg_h.uart_type);
endfunction

//--------------------------------------------------------------------------------------------
// function:to_class
// converting struct data items into seq_item transactions
//--------------------------------------------------------------------------------------------  
function void rx_seq_item_converter::to_class(input uart_reciver_char_s input_conv,
                                      rx_agent_config rx_agent_cfg_h, output rx_xtn output_conv_h);

  // Casting the uart_type to know how many bits to convert
  input_conv.no_of_rx_bits_transfer = uart_type_e'(rx_agent_cfg_h.uart_type);

  output_conv_h = new();

  // Defining the size of arrays
  //output_conv_h.rx_data= new[CHAR_LENGTH/CHAR_LENGTH];

  // Storing the values in the respective arrays
  //for(int row_no = 0; row_no < output_cov_h.tx.size(); row_no++) begin
  for(int i=0; i<input_conv.no_of_rx_bits_transfer; i++) begin
    output_conv_h.rx_data[i] = input_conv.rx[i];
    `uvm_info("device_seq_item_conv_class",
    $sformatf("To class rx = \n %p",output_conv_h.rx_data[i]),UVM_LOW)
  end

endfunction : to_class

//--------------------------------------------------------------------------------------------
// Function: do_print method
// Print method can be added to display the data members values
//--------------------------------------------------------------------------------------------
function void rx_seq_item_converter::do_print(uvm_printer printer);
  uart_reciver_char_s uart_st;
  super.do_print(printer);
  foreach(uart_st.rx[i]) begin
    printer.print_field($sformatf("rx[%0d]",i,),uart_st.rx[i],8,UVM_HEX);
  end
endfunction : do_print

`endif

