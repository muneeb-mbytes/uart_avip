`ifndef UART_FD_BAUDRATE_TEST_INCLUDED_
`define UART_FD_BAUDRATE_TEST_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: uart_fd_baudrate_test
// Description:
// Extended the uart_fd_baudrate_test class from base_test class
//--------------------------------------------------------------------------------------------
class uart_fd_baudrate_test extends uart_fd_8b_test;

  //Registering the uart_fd_baudrate_test in the factory
  `uvm_component_utils(uart_fd_baudrate_test)

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "uart_fd_baudrate_test", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern virtual function void setup_device_cfg();

endclass : uart_fd_baudrate_test

//--------------------------------------------------------------------------------------------
// Construct: new
// Initializes class object
// Parameters:
// name - uart_fd_baudrate_test
// parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function uart_fd_baudrate_test::new(string name = "uart_fd_baudrate_test",uvm_component parent);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function:build_phase
//--------------------------------------------------------------------------------------------
function void uart_fd_baudrate_test::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: setup_tx_agent_cfg
// Setup the tx agent configuration with the required values
// and store the handle into the config_db
//--------------------------------------------------------------------------------------------
function void uart_fd_baudrate_test::setup_device_cfg();
  super.setup_device_cfg();
  foreach(env_cfg_h.device_cfg_h[i])begin
  env_cfg_h.device_cfg_h[i].set_baudrate_divisor(.primary_prescalar(1), .secondary_prescalar(0));
end
endfunction : setup_device_cfg

`endif

