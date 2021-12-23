`ifndef UART_FD_STOP_BIT_2B_TEST_INCLUDED_
`define UART_FD_STOP_BIT_2B_TEST_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: uart_fd_stop_bit_2b_test
// Description:
// Extended the uart_fd_stop_bit_2b_test class from base_test class
//--------------------------------------------------------------------------------------------
class uart_fd_stop_bit_2b_test extends uart_fd_8b_test;

  //Registering the uart_fd_stop_bit_2b_test in the factory
  `uvm_component_utils(uart_fd_stop_bit_2b_test)

  //-------------------------------------------------------
  // Declaring sequence handles  
  //-------------------------------------------------------
  uart_fd_stop_bit_2b_virtual_seq uart_fd_stop_bit_2b_virtual_seq_h;


  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "uart_fd_stop_bit_2b_test", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern virtual function void setup_tx_agent_cfg();
endclass : uart_fd_stop_bit_2b_test

//--------------------------------------------------------------------------------------------
// Construct: new
// Initializes class object
// Parameters:
// name - uart_fd_stop_bit_2b_test
// parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function uart_fd_stop_bit_2b_test::new(string name = "uart_fd_stop_bit_2b_test",uvm_component parent);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function:build_phase
//--------------------------------------------------------------------------------------------
function void uart_fd_stop_bit_2b_test::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: setup_tx_agent_config
// Setup the tx agent configuration with the required values
// and store the handle into the config_db
//--------------------------------------------------------------------------------------------
function void uart_fd_stop_bit_2b_test::setup_tx_agent_cfg();
  super.setup_tx_agent_cfg();
  foreach(env_cfg_h.device_cfg_h[i]) begin
    env_cfg_h.device_cfg_h[i].tx_agent_config_h.stop_bit_duration = stop_bit_e'(STOP_BIT_TWOBITS);
  end
endfunction : setup_tx_agent_cfg

`endif

