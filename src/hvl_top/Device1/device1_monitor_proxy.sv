`ifndef DEVICE1_MONITOR_PROXY_INCLUDED_
`define DEVICE1_MONITOR_PROXY_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: device1_monitor_proxy
// This is the HVL device1 monitor proxy
// It gets the sampled data from the HDL device1 monitor and 
// converts them into transaction items
//--------------------------------------------------------------------------------------------
class device1_monitor_proxy extends uvm_monitor;
  `uvm_component_utils(device1_monitor_proxy)

  //Declaring Monitor Analysis Import
  uvm_analysis_port #(device1_tx) device1_analysis_port;
  
  //Declaring Virtual Monitor BFM Handle
  virtual device1_monitor_bfm device1_mon_bfm_h;

  // Variable: device1_agent_cfg_h;
  // Handle for device1 agent configuration
  device1_agent_config device1_agent_cfg_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "device1_monitor_proxy", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual function void start_of_simulation_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);

endclass : device1_monitor_proxy

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
// name - device1_monitor_proxy
// parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function device1_monitor_proxy::new(string name = "device1_monitor_proxy",
                                 uvm_component parent = null);
  super.new(name, parent);
  device1_analysis_port = new("device1_analysis_port",this);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// Description_here:
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void device1_monitor_proxy::build_phase(uvm_phase phase);
  super.build_phase(phase);
  
  if(!uvm_config_db#(virtual device1_monitor_bfm)::get(this,"","device1_monitor_bfm",device1_mon_bfm_h)) begin
    `uvm_fatal("FATAL_SMP_MON_BFM",$sformatf("Couldn't get S_MON_BFM in device1_Monitor_proxy"));  
  end 

endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: connect_phase
// <Description_here>
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void device1_monitor_proxy::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
endfunction : connect_phase

//--------------------------------------------------------------------------------------------
// Function: end_of_elaboration_phase
// <Description_here>
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void device1_monitor_proxy::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
endfunction  : end_of_elaboration_phase

//--------------------------------------------------------------------------------------------
// Function: start_of_simulation_phase
// <Description_here>
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void device1_monitor_proxy::start_of_simulation_phase(uvm_phase phase);
  super.start_of_simulation_phase(phase);
endfunction : start_of_simulation_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// <Description_here>
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
task device1_monitor_proxy::run_phase(uvm_phase phase);

  phase.raise_objection(this, "device1_monitor_proxy");

  super.run_phase(phase);

  // Work here
  // ...

  phase.drop_objection(this);

endtask : run_phase

`endif

