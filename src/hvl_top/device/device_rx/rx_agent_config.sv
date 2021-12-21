`ifndef RX_AGENT_CONFIG_INCLUDED_
`define RX_AGENT_CONFIG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: rx_agent_config
// Used as the configuration class for rx agent and it's components
//--------------------------------------------------------------------------------------------
class rx_agent_config extends uvm_object;
  `uvm_object_utils(rx_agent_config)
  
  // Variable: is_active
  // Used for creating the agent in either passive or active mode
  uvm_active_passive_enum is_active=UVM_PASSIVE;

  // Variable: has_coverage
  // Used for enabling the rx agent coverage
  bit has_coverage;
  
  //bit has_receiver;

  // Variable: has_parity
  // Used for enabling the parity bit
  bit has_parity;


  // Variable: shift_direction
  // Tells about the direction of data 
  rand shift_direction_e shift_dir;

  // Variable: uart_type
  // Used to indicate how many stop bits required 
  rand uart_type_e uart_type;

  // Variable: oversampling_bits
  // Tells about how many clk cycles required for each bit
  rand oversampling_e oversampling_bits;

  // Variable: parity_bit
  // Tells about even parity or odd parity
  rand parity_e parity_scheme;

  // Variable: rx_baudrate_divisor
  // Specifies the baudrate divisor for the receiver
  int rx_baudrate_divisor;

  //-------------------------------------------------------
  // Constraint for oversampling
  //-------------------------------------------------------
  constraint over_sampling_c{oversampling_bits > 0;}

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "rx_agent_config");
  extern function void do_print(uvm_printer printer);
endclass : rx_agent_config

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
// name - rx_agent_config
// parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function rx_agent_config::new(string name = "rx_agent_config");
  super.new(name);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: do_print method
// Print method can be added to display the data members values
//--------------------------------------------------------------------------------------------
function void rx_agent_config::do_print(uvm_printer printer);
  super.do_print(printer);
  printer.print_string ("is_active",is_active.name());
  printer.print_field  ("has_parity",has_parity, 1, UVM_DEC);
  printer.print_field  ("rx_baudrate_divisor",rx_baudrate_divisor, $bits(rx_baudrate_divisor), UVM_DEC);  
  printer.print_string ("shift_dir",shift_dir.name());
  printer.print_field  ("has_coverage",has_coverage, 1, UVM_DEC);
  printer.print_string ("uart_type",uart_type.name());
  printer.print_string ("oversampling_type",oversampling_bits.name());
  printer.print_string ("parity_type",parity_scheme.name());
endfunction : do_print
`endif

