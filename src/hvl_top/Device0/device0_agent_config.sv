`ifndef DEVICE0_AGENT_CONFIG_INCLUDED_
`define DEVICE0_AGENT_CONFIG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: device0_agent_config
// Used as the configuration class for device0 agent and it's components
//--------------------------------------------------------------------------------------------
class device0_agent_config extends uvm_object;
  `uvm_object_utils(device0_agent_config)

  // Variable: is_active
  // Used for creating the agent in either passive or active mode
  uvm_active_passive_enum is_active=UVM_ACTIVE;
   
  // Variable: has_coverage
  // Used for enabling the device0 agent coverage
  bit has_coverage;
  
  shift_direction_e shift_dir;

  stop_bit_e stop_bit;
  
  // Variable: primary_prescalar
  // Used for setting the primary prescalar value for baudrate_divisor
  protected bit[2:0] primary_prescalar;

  // Variable: secondary_prescalar
  // Used for setting the secondary prescalar value for baudrate_divisor
  protected bit[2:0] secondary_prescalar;

  // Variable: baudrate_divisor_divisor
  // Defines the date rate 
  //
  // baudrate_divisor_divisor = (secondary_prescalar+1) * (2 ** (primary_prescalar+1))
  // baudrate = busclock / baudrate_divisor_divisor;
  //
  // Default value is 2
  int baudrate_divisor = 2;
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "device0_agent_config");

  extern function void do_print(uvm_printer printer);
  extern function void set_baudrate_divisor(int primary_prescalar, int secondary_prescalar);
endclass : device0_agent_config

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
// name - device0_agent_config
// parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function device0_agent_config::new(string name = "device0_agent_config");
  super.new(name);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: do_print method
// Print method can be added to display the data members values
//--------------------------------------------------------------------------------------------
function void device0_agent_config::do_print(uvm_printer printer);
  super.do_print(printer);


  printer.print_string ("is_active",is_active.name());
  printer.print_string ("shift_dir",shift_dir.name());
  printer.print_field ("primary_prescalar",primary_prescalar, 3, UVM_DEC);
  printer.print_field ("secondary_prescalar",secondary_prescalar, 3, UVM_DEC);
  printer.print_field ("baudrate_divisor",baudrate_divisor, 32, UVM_DEC);
  printer.print_field ("has_coverage",has_coverage, 1, UVM_DEC);
  printer.print_string ("stop_bit",stop_bit.name());
endfunction : do_print
//--------------------------------------------------------------------------------------------
// Function: set_baudrate_divisor
// Sets the baudrate divisor value from primary_prescalar and secondary_prescalar

// baudrate_divisor_divisor = (secondary_prescalar+1) * (2 ** (primary_prescalar+1))
// baudrate = busclock / baudrate_divisor_divisor;
//
// Parameters:
//  primary_prescalar - Primary prescalar value for baudrate calculation
//  secondary_prescalar - Secondary prescalar value for baudrate calculation
//--------------------------------------------------------------------------------------------
function void device0_agent_config::set_baudrate_divisor(int primary_prescalar, int secondary_prescalar);
  this.primary_prescalar = primary_prescalar;
  this.secondary_prescalar = secondary_prescalar;

  baudrate_divisor = (this.secondary_prescalar + 1) * (2 ** (this.primary_prescalar + 1));

endfunction : set_baudrate_divisor

`endif

