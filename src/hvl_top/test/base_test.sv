`ifndef BASE_TEST_INCLUDED_
`define BASE_TEST_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: base_test
// Base test has the test scenarios for testbench which has the env, config, etc.
// Sequences are created and started in the test
//--------------------------------------------------------------------------------------------
class base_test extends uvm_test;
  
  `uvm_component_utils(base_test)

  // Variable: e_cfg_h
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
  extern virtual function void setup_device0_agent_cfg();
  extern virtual function void setup_device1_agent_cfg();
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);

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
//  Create required ports
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void base_test::build_phase(uvm_phase phase);
  super.build_phase(phase);

  // Setup the environemnt cfg 
  setup_env_cfg();

  // Create the environment
  env_h = env::type_id::create("env",this);

endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: setup_env_cfg
// Setup the environment configuration with the required values
// and store the handle into the config_db
//--------------------------------------------------------------------------------------------
function void base_test:: setup_env_cfg();

  env_cfg_h = env_config::type_id::create("env_cfg_h");
 
  env_cfg_h.has_scoreboard = 1;
  env_cfg_h.has_virtual_seqr = 1;
  
  // Setup the device0 agent cfg 
  setup_device0_agent_cfg();

  // Setup the device1 agent cfg 
  setup_device1_agent_cfg();

  uvm_config_db #(env_config)::set(this,"*","env_config",env_cfg_h);

endfunction: setup_env_cfg

//--------------------------------------------------------------------------------------------
// Function: setup_device0_agent_cfg
// Setup the device0 agent configuration with the required values
// and store the handle into the config_db
//--------------------------------------------------------------------------------------------
function void base_test::setup_device0_agent_cfg();

  env_cfg_h.device0_agent_cfg_h = device0_agent_config::type_id::create("device0_agent_cfg_h");

  // Configure the device0 agent configuration
  env_cfg_h.device0_agent_cfg_h.is_active = uvm_active_passive_enum'(UVM_ACTIVE);

  uvm_config_db #(device0_agent_config)::set(this,"*device0_agent*","device0_agent_config",
                                                          env_cfg_h.device0_agent_cfg_h);
 env_cfg_h.device0_agent_cfg_h.print();

endfunction: setup_device0_agent_cfg

//--------------------------------------------------------------------------------------------
// Function: setup_device1_agents_cfg
// Setup the device1 agent(s) configuration with the required values
// and store the handle into the config_db
//--------------------------------------------------------------------------------------------
function void base_test::setup_device1_agent_cfg();

    env_cfg_h.device1_agent_cfg_h = device1_agent_config::type_id::create("device1_agent_cfg_h",this);

    env_cfg_h.device1_agent_cfg_h.is_active = uvm_active_passive_enum'(UVM_ACTIVE);

    uvm_config_db #(device1_agent_config)::set(this,("*device1_agent_h*"),
                                             "device1_agent_config", env_cfg_h.device1_agent_cfg_h);

endfunction: setup_device1_agent_cfg

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

`endif

