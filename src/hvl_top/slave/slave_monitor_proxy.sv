`ifndef SLAVE_MONITOR_PROXY_INCLUDED_
`define SLAVE_MONITOR_PROXY_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: slave_monitor_proxy
// This is the HVL slave monitor proxy
// It gets the sampled data from the HDL slave monitor and 
// converts them into transaction items
//--------------------------------------------------------------------------------------------
class slave_monitor_proxy extends uvm_monitor;
  `uvm_component_utils(slave_monitor_proxy)

  //Declaring Monitor Analysis Import
  uvm_analysis_port #(slave_tx) slave_analysis_port;
  
  //Declaring Virtual Monitor BFM Handle
  virtual slave_monitor_bfm slave_mon_bfm_h;

  // Variable: slave_agent_cfg_h;
  // Handle for slave agent configuration
  slave_agent_config slave_agent_cfg_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "slave_monitor_proxy", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual function void start_of_simulation_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);

endclass : slave_monitor_proxy

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
// name - slave_monitor_proxy
// parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function slave_monitor_proxy::new(string name = "slave_monitor_proxy",
                                 uvm_component parent = null);
  super.new(name, parent);
  slave_analysis_port = new("slave_analysis_port",this);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// Description_here:
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void slave_monitor_proxy::build_phase(uvm_phase phase);
  super.build_phase(phase);
  
  if(!uvm_config_db#(virtual slave_monitor_bfm)::get(this,"","slave_monitor_bfm",slave_mon_bfm_h)) begin
    `uvm_fatal("FATAL_SMP_MON_BFM",$sformatf("Couldn't get S_MON_BFM in Slave_Monitor_proxy"));  
  end 

endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: connect_phase
// <Description_here>
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void slave_monitor_proxy::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
endfunction : connect_phase

//--------------------------------------------------------------------------------------------
// Function: end_of_elaboration_phase
// <Description_here>
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void slave_monitor_proxy::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
endfunction  : end_of_elaboration_phase

//--------------------------------------------------------------------------------------------
// Function: start_of_simulation_phase
// <Description_here>
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void slave_monitor_proxy::start_of_simulation_phase(uvm_phase phase);
  super.start_of_simulation_phase(phase);
endfunction : start_of_simulation_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// <Description_here>
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
task slave_monitor_proxy::run_phase(uvm_phase phase);

  phase.raise_objection(this, "slave_monitor_proxy");

  super.run_phase(phase);

  // Work here
  // ...

  phase.drop_objection(this);

endtask : run_phase

`endif

