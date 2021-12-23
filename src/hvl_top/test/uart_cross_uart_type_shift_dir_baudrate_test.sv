`ifndef UART_CROSS_UART_TYPE_SHIFT_DIR_BAUDRATE_TEST_INCLUDED_
`define UART_CROSS_UART_TYPE_SHIFT_DIR_BAUDRATE_TEST_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: uart_simple_fd_config_cpol0_cpha0_msb_c2t_t2c_baudrate_test
// Description:
//--------------------------------------------------------------------------------------------
class uart_cross_uart_type_shift_dir_baudrate_test extends uart_fd_8b_test;
  `uvm_component_utils(uart_cross_uart_type_shift_dir_baudrate_test)

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "uart_cross_uart_type_shift_dir_baudrate_test", uvm_component parent);
  extern virtual function void setup_tx_agent_cfg();
  extern virtual function void setup_rx_agent_cfg();
  extern virtual function void setup_device_cfg();

endclass : uart_cross_uart_type_shift_dir_baudrate_test

//--------------------------------------------------------------------------------------------
// Construct: new
// Initializes class object
// Parameters:
// name -  uart_cross_uart_type_shift_dir_baudrate_test
// parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function uart_cross_uart_type_shift_dir_baudrate_test::new(string name ="uart_cross_uart_type_shift_dir_baudrate_test",uvm_component parent);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: setup_tx_agent_cfg
// Setup the tx agent configuration with the required values
// and store the handle into the config_db
//--------------------------------------------------------------------------------------------
 function void uart_cross_uart_type_shift_dir_baudrate_test::setup_tx_agent_cfg();

  // Configure the TX agent configuration
  super.setup_tx_agent_cfg();

  // Modifying ONLY the required fields 
  foreach(env_cfg_h.device_cfg_h[i]) begin
  env_cfg_h.device_cfg_h[i].tx_agent_config_h.shift_dir = shift_direction_e'(LSB_FIRST);
end

  // Modifying ONLY the required fields 
  foreach(env_cfg_h.device_cfg_h[i]) begin
  env_cfg_h.device_cfg_h[i].tx_agent_config_h.shift_dir = shift_direction_e'(MSB_FIRST);
end

  foreach(env_cfg_h.device_cfg_h[i]) begin
  env_cfg_h.device_cfg_h[i].tx_agent_config_h.uart_type = uart_type_e'(UART_TYPE_FIVE_BIT);
end

//  foreach(env_cfg_h.device_cfg_h[i]) begin
//  env_cfg_h.device_cfg_h[i].tx_agent_config_h.uart_type = uart_type_e'(UART_TYPE_EIGTH_BIT);
//end
endfunction: setup_tx_agent_cfg

//--------------------------------------------------------------------------------------------
// Function: setup_slave_agents_cfg
// Setup the slave agent(s) configuration with the required values
// and store the handle into the config_db
//--------------------------------------------------------------------------------------------
 function void uart_cross_uart_type_shift_dir_baudrate_test::setup_rx_agent_cfg();

  // Configure the rx agent configuration
  super.setup_rx_agent_cfg();

  // Modifying ONLY the required fields 
  foreach(env_cfg_h.device_cfg_h[i]) begin
  env_cfg_h.device_cfg_h[i].rx_agent_config_h.shift_dir = shift_direction_e'(LSB_FIRST);
end

  // Modifying ONLY the required fields 
  foreach(env_cfg_h.device_cfg_h[i]) begin
  env_cfg_h.device_cfg_h[i].rx_agent_config_h.shift_dir = shift_direction_e'(MSB_FIRST);
end
  
foreach(env_cfg_h.device_cfg_h[i]) begin
  env_cfg_h.device_cfg_h[i].rx_agent_config_h.uart_type = uart_type_e'(UART_TYPE_FIVE_BIT);
end

//  foreach(env_cfg_h.device_cfg_h[i]) begin
//  env_cfg_h.device_cfg_h[i].rx_agent_config_h.uart_type = uart_type_e'(UART_TYPE_EIGTH_BIT);
//end
endfunction: setup_rx_agent_cfg

//--------------------------------------------------------------------------------------------
// Function: setup_device_agent_cfg
// Setup the tx agent configuration with the required values
// and store the handle into the config_db
//--------------------------------------------------------------------------------------------
function void uart_cross_uart_type_shift_dir_baudrate_test::setup_device_cfg();
  super.setup_device_cfg();
  foreach(env_cfg_h.device_cfg_h[i])begin
  env_cfg_h.device_cfg_h[i].set_baudrate_divisor(.primary_prescalar(1), .secondary_prescalar(0));
end
endfunction : setup_device_cfg

`endif
