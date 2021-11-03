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
  extern virtual function void setup_master_agent_cfg();
  extern virtual function void setup_slave_agent_cfg();
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
  
  // Setup the master agent cfg 
  setup_master_agent_cfg();

  // Setup the slave agent cfg 
  setup_slave_agent_cfg();

  uvm_config_db #(env_config)::set(this,"*","env_config",env_cfg_h);

endfunction: setup_env_cfg

//--------------------------------------------------------------------------------------------
// Function: setup_master_agent_cfg
// Setup the master agent configuration with the required values
// and store the handle into the config_db
//--------------------------------------------------------------------------------------------
function void base_test::setup_master_agent_cfg();

  env_cfg_h.master_agent_cfg_h = master_agent_config::type_id::create("master_agent_cfg_h");

  // Configure the Master agent configuration
  env_cfg_h.master_agent_cfg_h.is_active = uvm_active_passive_enum'(UVM_ACTIVE);

  uvm_config_db #(master_agent_config)::set(this,"*master_agent*","master_agent_config",
                                                          env_cfg_h.master_agent_cfg_h);

endfunction: setup_master_agent_cfg

//--------------------------------------------------------------------------------------------
// Function: setup_slave_agents_cfg
// Setup the slave agent(s) configuration with the required values
// and store the handle into the config_db
//--------------------------------------------------------------------------------------------
function void base_test::setup_slave_agent_cfg();

    env_cfg_h.slave_agent_cfg_h = slave_agent_config::type_id::create("slave_agent_cfg_h",this);

    env_cfg_h.slave_agent_cfg_h.is_active = uvm_active_passive_enum'(UVM_ACTIVE);

    uvm_config_db #(slave_agent_config)::set(this,("*slave_agent_h*"),
                                             "slave_agent_config", env_cfg_h.slave_agent_cfg_h);

endfunction: setup_slave_agent_cfg

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

