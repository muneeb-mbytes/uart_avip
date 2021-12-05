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

  int no_of_agents;
  
 // tx_agent_config tx_agent_config_h[];
 // rx_agent_config rx_agent_config_h[];


  // Variable: device_cfg_h
  // Handle for device agent configuration
  device_agent_config device_agent_cfg_h;


  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "env_config");
  extern function void do_print(uvm_printer printer);

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

function void env_config::do_print(uvm_printer printer);
  super.do_print(printer);
  printer.print_field ("has_scoreboard",has_scoreboard,1, UVM_DEC);
  printer.print_field ("has_virtual_sqr",has_virtual_seqr,1, UVM_DEC);
endfunction : do_print


`endif

