`ifndef UART_FD_MSB_TEST_INCLUDED_
`define UART_FD_MSB_TEST_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: uart_fd_msb_test
// Description:
// Extended the uart_fd_msb_test class from base_test class
//--------------------------------------------------------------------------------------------
class uart_fd_msb_test extends uart_fd_8b_test;

  //Registering the uart_fd_msb_test in the factory
  `uvm_component_utils(uart_fd_msb_test)

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "uart_fd_msb_test", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern virtual function void setup_tx_agent_cfg();
  extern virtual function void setup_rx_agents_cfg();

endclass : uart_fd_msb_test

//--------------------------------------------------------------------------------------------
// Construct: new
// Initializes class object
// Parameters:
// name - uart_fd_msb_test
// parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function uart_fd_msb_test::new(string name = "uart_fd_msb_test",uvm_component parent);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function:build_phase
//--------------------------------------------------------------------------------------------
function void uart_fd_msb_test::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: setup_tx_agent_cfg
// Setup the tx agent configuration with the required values
// and store the handle into the config_db
//--------------------------------------------------------------------------------------------
function void uart_fd_msb_test::setup_tx_agent_cfg();
  super.setup_tx_agent_cfg();

  foreach(env_cfg_h.device_cfg_h.tx_agent_config_h[i]) begin
  env_cfg_h.device_cfg_h.tx_agent_config_h[i].shift_dir = shift_direction_e'(MSB_FIRST);
end
endfunction : setup_tx_agent_cfg

//--------------------------------------------------------------------------------------------
// Function: setup_rx_agent_cfg
// Setup the rx agent configuration with the required values
// and store the handle into the config_db
//--------------------------------------------------------------------------------------------
function void uart_fd_msb_test::setup_rx_agents_cfg();
  super.setup_rx_agents_cfg();

  foreach(env_cfg_h.device_cfg_h.rx_agent_config_h[i]) begin
  env_cfg_h.device_cfg_h.rx_agent_config_h[i].shift_dir = shift_direction_e'(MSB_FIRST);
end
endfunction : setup_rx_agents_cfg

`endif

