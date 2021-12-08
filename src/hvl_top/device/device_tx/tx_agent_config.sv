`ifndef TX_AGENT_CONFIG_INCLUDED_
`define TX_AGENT_CONFIG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: tx_agent_config
// Used as the configuration class for tx agent and it's components
//--------------------------------------------------------------------------------------------
class tx_agent_config extends uvm_object;
  `uvm_object_utils(tx_agent_config)

  // Variable: is_active
  // Used for creating the agent in either passive or active mode
  uvm_active_passive_enum is_active=UVM_ACTIVE;
   
  // Variable: has_coverage
  // Used for enabling the tx agent coverage
  bit has_coverage;

  // Variable: has_parity
  // Used for enabling the parity bit
  bit has_parity;

  // Variable: shift_dir
  // Shifts the data, LSB first or MSB first
  shift_direction_e shift_dir;
  
  // Variable: stop_bit
  // Used to indicate how many stop bits required 
  stop_bit_e stop_bit_duration;
  
  // Variable: uart_type
  // Used to indicate how many stop bits required 
  uart_type_e uart_type;

  // Variable: oversampling_bits
  // Tells about how many clk cycles required for each bit
  oversampling_e oversampling_bits;

  // Variable: parity_bit
  // Tells about even parity or odd parity
  parity_e parity_scheme;

  // Variable: tx_baudrate_divisor
  // Specifies the baudrate divisor for the transmitter
  int tx_baudrate_divisor;
  
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "tx_agent_config");
  extern function void do_print(uvm_printer printer);
endclass : tx_agent_config

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
// name - tx_agent_config
// parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function tx_agent_config::new(string name = "tx_agent_config");
  super.new(name);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: do_print method
// Print method can be added to display the data members values
//--------------------------------------------------------------------------------------------
function void tx_agent_config::do_print(uvm_printer printer);
  super.do_print(printer);
  printer.print_string ("is_active",is_active.name());
  printer.print_field ("has_parity",has_parity, 1, UVM_DEC);
  printer.print_field ("tx_baudrate_divisor",tx_baudrate_divisor, $bits(tx_baudrate_divisor), UVM_DEC);
  printer.print_string ("shift_dir",shift_dir.name());
  printer.print_string ("uart_type",uart_type.name());
  printer.print_string ("stop_bit",stop_bit_duration.name());
  printer.print_field ("has_coverage",has_coverage, 1, UVM_DEC);
  printer.print_string ("oversampling_type",oversampling_bits.name());
  printer.print_string ("parity_type",parity_scheme.name());
  //printer.print_string ("has_transmitter",has_transmitter,1,UVM_DEC);
endfunction : do_print
`endif

