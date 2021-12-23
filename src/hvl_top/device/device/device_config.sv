`ifndef DEVICE_CONFIG_INCLUDED_
`define DEVICE_CONFIG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: device_config
// Used as the configuration class for device agent and it's components
//--------------------------------------------------------------------------------------------
class device_config extends uvm_object;
  `uvm_object_utils(device_config)

  rand tx_agent_config tx_agent_config_h;
  rand rx_agent_config rx_agent_config_h;

  bit has_tx_agent=1;

  bit has_rx_agent=1;

  // Variable: primary_prescalar
  // Used for setting the primary prescalar value for baudrate_divisor
  rand protected bit[2:0] primary_prescalar;

  // Variable: secondary_prescalar
  // Used for setting the secondary prescalar value for baudrate_divisor
  rand protected bit[2:0] secondary_prescalar;

  // Variable: baudrate_divisor_divisor
  // Defines the date rate 
  //
  // baudrate_divisor_divisor = (secondary_prescalar+1) * (2 ** (primary_prescalar+1))
  // baudrate = busclock / baudrate_divisor_divisor;
  //
  // Default value is 2
  protected int baudrate_divisor;

  //-------------------------------------------------------
  // Constraints for primary prescalar and
  // secondary prescalar
  //-------------------------------------------------------
  constraint primary_prescalar_c{primary_prescalar dist {[0:1]:=80,[2:7]:/20};}
  constraint secondary_prescalar_c{secondary_prescalar dist {[0:1]:=80,[2:7]:/20};}

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "device_config");
  extern function void set_baudrate_divisor(int primary_prescalar, int secondary_prescalar);
  extern function int get_baudrate_divisor();
  extern function void post_randomize();
  extern function void do_print(uvm_printer printer);

endclass : device_config

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
// name - device_config
// parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function device_config::new(string name = "device_config");
  super.new(name);
endfunction : new


//--------------------------------------------------------------------------------------------
// Function: do_print method
// Print method can be added to display the data members values
//--------------------------------------------------------------------------------------------
function void device_config::do_print(uvm_printer printer);
  super.do_print(printer);

  printer.print_field ("primary_prescalar",primary_prescalar, 3, UVM_DEC);
  printer.print_field ("secondary_prescalar",secondary_prescalar, 3, UVM_DEC);
  printer.print_field ("baudrate_divisor",baudrate_divisor, $bits(baudrate_divisor), UVM_DEC);
  printer.print_field ("has_tx_agent",has_tx_agent, 1, UVM_DEC);
  printer.print_field ("has_rx_agent",has_rx_agent, 1, UVM_DEC);
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
function void device_config::set_baudrate_divisor(int primary_prescalar, int secondary_prescalar);
  this.primary_prescalar = primary_prescalar;
  this.secondary_prescalar = secondary_prescalar;

  baudrate_divisor = (this.secondary_prescalar + 1) * (2 ** (this.primary_prescalar + 1));

endfunction : set_baudrate_divisor

//--------------------------------------------------------------------------------------------
// Function: post_randomize
//
// Parameters:
//  primary_prescalar - Primary prescalar value for baudrate calculation
//  secondary_prescalar - Secondary prescalar value for baudrate calculation
//--------------------------------------------------------------------------------------------
function void device_config::post_randomize();
  `uvm_info("device_agent_cfg",$sformatf("Before pp = %0d , sp = %0d",
  this.primary_prescalar,this.secondary_prescalar),UVM_FULL)
  set_baudrate_divisor(this.primary_prescalar,this.secondary_prescalar);
  `uvm_info("device_agent_cfg",$sformatf("After pp = %0d , sp = %0d",
  this.primary_prescalar,this.secondary_prescalar),UVM_FULL)
endfunction: post_randomize

//--------------------------------------------------------------------------------------------
// Function: get_baudrate_divisor
// Return the baudrate_divisor
//--------------------------------------------------------------------------------------------
function int device_config::get_baudrate_divisor();
  return(this.baudrate_divisor);
endfunction: get_baudrate_divisor

`endif
