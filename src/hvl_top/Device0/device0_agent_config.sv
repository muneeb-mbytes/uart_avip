`ifndef DEVICE0_AGENT_CONFIG_INCLUDED_
`define DEVICE0_AGENT_CONFIG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: device0_agent_config
// Used as the configuration class for device0 agent and it's components
//--------------------------------------------------------------------------------------------
class device0_agent_config extends uvm_object;
  `uvm_object_utils(device0_agent_config)

  // Variable: is_active
  // Used for creating the agent in either passive or active mode
  uvm_active_passive_enum is_active=UVM_ACTIVE;

  // Variable: has_coverage
  // Used for enabling the device0 agent coverage
  bit has_coverage;
  
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "device0_agent_config");

endclass : device0_agent_config

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
// name - device0_agent_config
// parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function device0_agent_config::new(string name = "device0_agent_config");
  super.new(name);
endfunction : new

`endif

