`ifndef UART_FD_LSB_TEST_INCLUDED_
`define UART_FD_LSB_TEST_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: uart_fd_lsb_test
// Description:
// Extended the uart_fd_lsb_test class from base_test class
//--------------------------------------------------------------------------------------------
class uart_fd_lsb_test extends uart_fd_8b_test;

  //Registering the uart_fd_lsb_test in the factory
  `uvm_component_utils(uart_fd_lsb_test)

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "uart_fd_lsb_test", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern virtual function void setup_tx_agent_cfg();
  extern virtual function void setup_rx_agent_cfg();

endclass : uart_fd_lsb_test

//--------------------------------------------------------------------------------------------
// Construct: new
// Initializes class object
// Parameters:
// name - uart_fd_lsb_test
// parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function uart_fd_lsb_test::new(string name = "uart_fd_lsb_test",uvm_component parent);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function:build_phase
//--------------------------------------------------------------------------------------------
function void uart_fd_lsb_test::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: setup_tx_agent_config
// Setup the tx agent configuration with the required values
// and store the handle into the config_db
//--------------------------------------------------------------------------------------------
function void uart_fd_lsb_test::setup_tx_agent_cfg();
  super.setup_tx_agent_cfg();
  foreach(env_cfg_h.device_cfg_h[i]) begin
  env_cfg_h.device_cfg_h[i].tx_agent_config_h.shift_dir = shift_direction_e'(LSB_FIRST);
end
endfunction : setup_tx_agent_cfg

//--------------------------------------------------------------------------------------------
// Function: setup_rx_agent_cfg
// Setup the rx agent configuration with the required values
// and store the handle into the config_db
//--------------------------------------------------------------------------------------------
function void uart_fd_lsb_test::setup_rx_agent_cfg();
  super.setup_rx_agent_cfg();
  foreach(env_cfg_h.device_cfg_h[i]) begin
 env_cfg_h.device_cfg_h[i].rx_agent_config_h.shift_dir = shift_direction_e'(LSB_FIRST);
end
endfunction : setup_rx_agent_cfg

`endif

