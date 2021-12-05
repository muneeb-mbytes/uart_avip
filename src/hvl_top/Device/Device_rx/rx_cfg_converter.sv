`ifndef rx_CFG_CONVERTER_INCLUDED_
`define rx_CFG_CONVERTER_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: rx_cfg_converterzo
// Description:
// class for converting master_cfg configurations into struct configurations
//--------------------------------------------------------------------------------------------
class rx_cfg_converter extends uvm_object;
  
  `uvm_object_utils(rx_cfg_converter)

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "rx_cfg_converter");

  extern static function void from_class(input rx_agent_config input_conv_h, 
                                         output uart_transfer_cfg_s output_conv);

  extern function void do_print(uvm_printer printer);

endclass : rx_cfg_converter

//--------------------------------------------------------------------------------------------
// Construct: new
//
//
//
// Parameters:
//
//  name - rx_cfg_converter
//--------------------------------------------------------------------------------------------
function rx_cfg_converter::new(string name = "rx_cfg_converter");
  super.new(name);
endfunction : new

//--------------------------------------------------------------------------------------------
// function: from_class
// converting device_uart_cfg configurations into structure configurations
//--------------------------------------------------------------------------------------------
function void rx_cfg_converter::from_class(input rx_agent_config input_conv_h,
                                                 output uart_transfer_cfg_s output_conv);

    output_conv.uart_type = uart_type_e'(input_conv_h.uart_type);
    //output_conv.baudrate_divisor = input_conv_h.get_baudrate_divisor();
    output_conv.msb_first = shift_direction_e'(input_conv_h.shift_dir);
    output_conv.oversampling_bits = oversampling_e'(input_conv_h.oversampling_bits);

    //if(output_conv.oversampling_type == 2'b00) begin
    //  output_conv.oversampling_bits = 2;
    //end
    //else if(output_conv.oversampling_type == 2'b01) begin
    //  output_conv.oversampling_bits = 4;
    //end
    //else if(output_conv.oversampling_type == 2'b10) begin
    //  output_conv.oversampling_bits = 6;
    //end
    //else begin
    //  output_conv.oversampling_bits = 8;
    //end

      
endfunction: from_class 

//--------------------------------------------------------------------------------------------
// Function: do_print method
// Print method can be added to display the data members values
//--------------------------------------------------------------------------------------------
function void rx_cfg_converter::do_print(uvm_printer printer);

  uart_transfer_cfg_s uart_st;
  rx_agent_config rx_agent_config_h;
  super.do_print(printer);
 // printer.print_string( "uart_type",device_agent_config_h.uart_type.name());
 // printer.print_field( "baudrate_divisor",uart_st.baudrate_divisor , 
 //                                        $bits(uart_st.baudrate_divisor),UVM_DEC);
  printer.print_string( "msb_first",rx_agent_config_h.shift_dir.name());
  printer.print_string( "msb_first",rx_agent_config_h.uart_type.name());
  printer.print_string( "msb_first",rx_agent_config_h.oversampling_bits.name());

endfunction : do_print

`endif
 
 
