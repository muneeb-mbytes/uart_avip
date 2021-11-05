`ifndef ENV_CONFIG_INCLUDED_
`define ENV_CONFIG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: env_config
// Used for setting various configurations for the environment
//--------------------------------------------------------------------------------------------
class env_config extends uvm_object;
  `uvm_object_utils(env_config)
  
  // Variable: has_scoreboard
  // Enables the scoreboard. Default value is 1
  bit has_scoreboard = 1;

  // Variable: has_virtual_sqr
  // Enables the virtual sequencer. Default value is 1
  bit has_virtual_seqr = 1;


  // Variable: ma_cfg_h
  // Handle for device0 agent configuration
  device0_agent_config device0_agent_cfg_h;

  // Variable: sa_cfg_h
  // device1 agnet configuration handle
  device1_agent_config device1_agent_cfg_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "env_config");

endclass : env_config

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - env_config
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function env_config::new(string name = "env_config");
  super.new(name);
endfunction : new


`endif

