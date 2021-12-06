`ifndef BASE_TEST_INCLUDED_
`define BASE_TEST_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: base_test
//  Base test has the test scenarios for testbench which has the env, config, etc.
//  Sequences are created and started in the test
//--------------------------------------------------------------------------------------------
class base_test extends uvm_test;
  `uvm_component_utils(base_test)
  // Variable: env_cfg_h
  // Declaring environment config handle
  env_config env_cfg_h;

  // Variable: env_h
  // Handle for environment 
  env env_h;


  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "base_test", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void setup_env_cfg();
  extern virtual function void setup_device_agent_cfg();
  extern virtual function void setup_tx_agent_cfg();
  extern virtual function void setup_rx_agents_cfg();
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);

endclass : base_test

//--------------------------------------------------------------------------------------------
// Construct: new
//  Initializes class object
//
// Parameters:
//  name - base_test
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function base_test::new(string name = "base_test",uvm_component parent = null);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// Create required ports
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void base_test::build_phase(uvm_phase phase);
  super.build_phase(phase);
  // Setup the environemnt cfg 
  env_cfg_h = env_config::type_id::create("env_cfg_h");
  env_cfg_h.device_agent_cfg_h = device_agent_config::type_id::create("device_agent_cfg_h");
  setup_env_cfg();  
  // Create the environment
  env_h = env::type_id::create("env_h",this);
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: setup_env_cfg
// Setup the environment configuration with the required values
// and store the handle into the config_db
//--------------------------------------------------------------------------------------------
function void base_test::setup_env_cfg();
  env_cfg_h.no_of_agents = NO_OF_DEVICES;
  env_cfg_h.has_scoreboard = 1;
  env_cfg_h.has_virtual_seqr = 1;
  // Setup device agent cfg
  setup_device_agent_cfg();
  uvm_config_db #(device_agent_config)::set(this,"*","device_agent_config",env_cfg_h.device_agent_cfg_h);
  env_cfg_h.device_agent_cfg_h.print();

  // Setup the tx agent cfg 
  //env_cfg_h.tx_agent_config_h =  new[env_cfg_h.no_of_agents];
  //foreach(env_cfg_h.tx_agent_config_h[i]) begin
  //  env_cfg_h.tx_agent_config_h[i] =
  //  tx_agent_config::type_id::create($sformatf("env_cfg_h.tx_agent_config_h[%0d]",i));
  //end
  //setup_tx_agent_cfg();

  //foreach(env_cfg_h.tx_agent_config_h[i]) begin
  //  uvm_config_db #(tx_agent_config)::set(this,"*","tx_agent_config", env_cfg_h.tx_agent_config_h[i]);
  //  env_cfg_h.tx_agent_config_h[i].print();
  //end
  //
  //env_cfg_h.rx_agent_config_h =  new[env_cfg_h.no_of_agents];
  //foreach(env_cfg_h.rx_agent_config_h[i]) begin
  //  env_cfg_h.rx_agent_config_h[i] =
  //  rx_agent_config::type_id::create($sformatf("env_cfg_h.rx_agent_config_h[%0d]",i));
  //end
  //
  //setup_rx_agents_cfg();
  //
  //foreach(env_cfg_h.rx_agent_config_h[i]) begin
  //  uvm_config_db #(rx_agent_config)::set(this,"*","rx_agent_config", env_cfg_h.rx_agent_config_h[i]);
  //  env_cfg_h.rx_agent_config_h[i].print();
  //end

  // set method for env_cfg
  uvm_config_db #(env_config)::set(this,"*","env_config",env_cfg_h);
  env_cfg_h.print();
  // env_cfg_h.device_agent_cfg_h = 
  // device_agent_config::type_id::create($sformatf("env_cfg_h.device_agent_cfg_h"));
  //env_cfg_h.device_agent_cfg_h.print();
 
endfunction: setup_env_cfg

//--------------------------------------------------------------------------------------------
// Function: setup_tx_agent_cfg
// Setup the tx agent configuration with the required values
// and store the handle into the config_db
//--------------------------------------------------------------------------------------------
function void base_test::setup_tx_agent_cfg();
  foreach(env_cfg_h.device_agent_cfg_h.tx_agent_config_h[i]) begin
    env_cfg_h.device_agent_cfg_h.tx_agent_config_h[i].is_active            = uvm_active_passive_enum'(UVM_ACTIVE);
    env_cfg_h.device_agent_cfg_h.tx_agent_config_h[i].uart_type            = uart_type_e'(UART_TYPE_EIGHT_BIT);
    env_cfg_h.device_agent_cfg_h.tx_agent_config_h[i].shift_dir            = shift_direction_e'(LSB_FIRST);
    env_cfg_h.device_agent_cfg_h.tx_agent_config_h[i].parity_bit           = parity_e'(EVEN_PARITY);
    env_cfg_h.device_agent_cfg_h.tx_agent_config_h[i].stop_bit             = stop_bit_e'(STOP_BIT_ONEBIT);
    env_cfg_h.device_agent_cfg_h.tx_agent_config_h[i].tx_baudrate_divisor  = env_cfg_h.device_agent_cfg_h.get_baudrate_divisor();
    env_cfg_h.device_agent_cfg_h.tx_agent_config_h[i].oversampling_bits    = oversampling_e'(OVERSAMPLING_TWO);
  end
endfunction: setup_tx_agent_cfg

//--------------------------------------------------------------------------------------------
// Function: setup_rx_agents_cfg
// Setup the rx agent configuration with the required values
// and store the handle into the config_db
//--------------------------------------------------------------------------------------------
function void base_test::setup_rx_agents_cfg();
  foreach(env_cfg_h.device_agent_cfg_h.rx_agent_config_h[i]) begin
    env_cfg_h.device_agent_cfg_h.rx_agent_config_h[i].is_active            = uvm_active_passive_enum'(UVM_ACTIVE);
    env_cfg_h.device_agent_cfg_h.rx_agent_config_h[i].uart_type            = uart_type_e'(UART_TYPE_EIGHT_BIT);
    env_cfg_h.device_agent_cfg_h.rx_agent_config_h[i].shift_dir            = shift_direction_e'(LSB_FIRST);
    env_cfg_h.device_agent_cfg_h.rx_agent_config_h[i].parity_bit           = parity_e'(EVEN_PARITY);
    env_cfg_h.device_agent_cfg_h.rx_agent_config_h[i].rx_baudrate_divisor  = env_cfg_h.device_agent_cfg_h.get_baudrate_divisor();
    env_cfg_h.device_agent_cfg_h.rx_agent_config_h[i].oversampling_bits    = oversampling_e'(OVERSAMPLING_TWO);
  end

endfunction: setup_rx_agents_cfg

function void base_test::setup_device_agent_cfg();

  env_cfg_h.device_agent_cfg_h.set_baudrate_divisor(.primary_prescalar(0), .secondary_prescalar(0));

  // Setup the tx agent cfg 
  env_cfg_h.device_agent_cfg_h.tx_agent_config_h =  new[env_cfg_h.no_of_agents];
  foreach(env_cfg_h.device_agent_cfg_h.tx_agent_config_h[i]) begin
    env_cfg_h.device_agent_cfg_h.tx_agent_config_h[i] =
    tx_agent_config::type_id::create($sformatf("env_cfg_h.device_agent_cfg_h.tx_agent_config_h[%0d]",i));
  end
  setup_tx_agent_cfg();

  foreach(env_cfg_h.device_agent_cfg_h.tx_agent_config_h[i]) begin
    uvm_config_db #(tx_agent_config)::set(this,"*","tx_agent_config", env_cfg_h.device_agent_cfg_h.tx_agent_config_h[i]);
    env_cfg_h.device_agent_cfg_h.tx_agent_config_h[i].print();
  end
  
  env_cfg_h.device_agent_cfg_h.rx_agent_config_h =  new[env_cfg_h.no_of_agents];
  foreach(env_cfg_h.device_agent_cfg_h.rx_agent_config_h[i]) begin
    env_cfg_h.device_agent_cfg_h.rx_agent_config_h[i] =
    rx_agent_config::type_id::create($sformatf("env_cfg_h.device_agent_cfg_h.rx_agent_config_h[%0d]",i));
  end
  
  setup_rx_agents_cfg();
  
  foreach(env_cfg_h.device_agent_cfg_h.rx_agent_config_h[i]) begin
    uvm_config_db #(rx_agent_config)::set(this,"*","rx_agent_config", env_cfg_h.device_agent_cfg_h.rx_agent_config_h[i]);
    env_cfg_h.device_agent_cfg_h.rx_agent_config_h[i].print();
  end

endfunction : setup_device_agent_cfg


//--------------------------------------------------------------------------------------------
// Function: end_of_elaboration_phase
// Used for printing the testbench topology
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void base_test::end_of_elaboration_phase(uvm_phase phase);
  uvm_top.print_topology();
endfunction : end_of_elaboration_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// Used for giving basic delay for simulation 
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
task base_test::run_phase(uvm_phase phase);

  phase.raise_objection(this, "base_test");

  `uvm_info(get_type_name(), $sformatf("Inside BASE_TEST"), UVM_NONE);
  super.run_phase(phase);

  // TODO(mshariff): 
  // Need to be replaced with delay task in BFM interface
  // in-order to get rid of time delays in HVL side
  //spi_fd_8b_master_seq_h = spi_fd_8b_master_seq::type_id::create("spi_fd_8b_master_seq_h"); 
  //spi_fd_8b_master_seq_h.start(env_h.master_agent_h.master_seqr_h);
  #100;
  
  `uvm_info(get_type_name(), $sformatf("Done BASE_TEST"), UVM_NONE);
  phase.drop_objection(this);

endtask : run_phase

`endif

