`ifndef DEVICE0_MONITOR_PROXY_INCLUDED_
`define DEVICE0_MONITOR_PROXY_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: device0_monitor_proxy
// Description:
// Monitor is written by extending uvm_monitor,uvm_monitor is inherited from uvm_component, 
// A monitor is a passive entity that samples the DUT signals through virtual interface and 
// converts the signal level activity to transaction level,monitor samples DUT signals but does not drive them.
// Monitor should have analysis port (TLM port) and virtual interface handle that points to DUT signal
//--------------------------------------------------------------------------------------------
class device0_monitor_proxy extends uvm_component;
  
  //register with factory so can use create uvm_method and
  //override in future if necessary
  
  `uvm_component_utils(device0_monitor_proxy)
  
  // Variable: m_cfg
  // Declaring handle for device0 agent config class 
  device0_agent_config device0_agent_cfg_h;

  //declaring analysis port for the monitor port
  uvm_analysis_port #(device0_tx)device0_analysis_port;
  
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "device0_monitor_proxy", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual function void start_of_simulation_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);

endclass : device0_monitor_proxy

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
// name - device0_monitor_proxy
// parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function device0_monitor_proxy::new(string name = "device0_monitor_proxy",
                                 uvm_component parent = null);
  super.new(name, parent);
  
  //creating monitor port
  device0_analysis_port=new("device0_analysis_port",this);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// <Description_here>
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void device0_monitor_proxy::build_phase(uvm_phase phase);
  super.build_phase(phase);
  
  if(!uvm_config_db #(device0_agent_config)::get(this,"","device0_agent_config",device0_agent_cfg_h))begin
    `uvm_fatal("FATAL_device0_MONITOR_PROXY_CANNOT_GET_device0_AGENT_CONFIG","cannot get() device0_agent_cfg_h from uvm_config_db");
  end 

endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: connect_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void device0_monitor_proxy::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  
endfunction : connect_phase

//--------------------------------------------------------------------------------------------
// Function: end_of_elaboration_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void device0_monitor_proxy::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
endfunction  : end_of_elaboration_phase

//--------------------------------------------------------------------------------------------
// Function: start_of_simulation_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void device0_monitor_proxy::start_of_simulation_phase(uvm_phase phase);
  super.start_of_simulation_phase(phase);
endfunction : start_of_simulation_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
task device0_monitor_proxy::run_phase(uvm_phase phase);

  phase.raise_objection(this, "device0_monitor_proxy");

  super.run_phase(phase);

  // Work here
  // ...

  phase.drop_objection(this);

endtask : run_phase

`endif

