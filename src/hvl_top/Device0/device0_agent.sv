`ifndef DEVICE0_AGENT_INCLUDED_
`define DEVICE0_AGENT_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: device0_agent
// This agent is a configurable with respect to configuration which can create active and passive components
// It contains testbench components like sequencer,driver_proxy and monitor_proxy for UART
// --------------------------------------------------------------------------------------------
class device0_agent extends uvm_agent;
  `uvm_component_utils(device0_agent)

  // Variable: device0_agent_cfg_h
  // Declaring handle for device0 agent config class 
  device0_agent_config device0_agent_cfg_h;

  // Varible: device0_seqr_h 
  // Handle for slave seuencer
  device0_sequencer device0_seqr_h;
  
  // Variable: device0_drv_proxy_h
  // Creating a Handle fordevice0 driver proxy
  device0_driver_proxy device0_drv_proxy_h;
  
  // Variable: device0_mon_proxy_h
  // Declaring a handle for device0 monitor proxy
  device0_monitor_proxy device0_mon_proxy_h;

  // Variable: device0_coverage
  // Decalring a handle for device0_coverage
  device0_coverage device0_cov_h;

  //coverage handle
  
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "device0_agent", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual function void start_of_simulation_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);

endclass : device0_agent

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters: 
// name - instance name of the uart device0_agent
// parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function  device0_agent::new(string name="device0_agent",uvm_component parent = null);
  super.new(name,parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// creates the required ports,gets the required configuration from config_db
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void device0_agent::build_phase(uvm_phase phase);
  super.build_phase(phase);

  if(!uvm_config_db #(device0_agent_config)::get(this,"","device0_agent_config",device0_agent_cfg_h)) begin
    `uvm_fatal("FATAL_MA_CANNOT_GET_device0_AGENT_CONFIG","cannot get device0_agent_cfg_h from uvm_config_db");
  end

  if(device0_agent_cfg_h.is_active == UVM_ACTIVE) begin
    device0_drv_proxy_h=device0_driver_proxy::type_id::create("device0_driver_proxy",this);
    device0_seqr_h=device0_sequencer::type_id::create("device0_sequencer",this);
  end

  device0_mon_proxy_h=device0_monitor_proxy::type_id::create("device0_monitor_proxy",this);

  if(device0_agent_cfg_h.has_coverage) begin
    device0_cov_h = device0_coverage::type_id::create("device0_cov_h",this);
  end

  if(device0_agent_cfg_h.has_coverage) begin
    device0_cov_h.device0_agent_cfg_h = device0_agent_cfg_h;
    // connect monitor port to coverage
  end

endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: connect_phase
// Connecting device0_driver, device0_monitor and device0_sequencer for configuration
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void device0_agent::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  
  if(device0_agent_cfg_h.is_active == UVM_ACTIVE) begin
    device0_drv_proxy_h.device0_agent_cfg_h = device0_agent_cfg_h;
    device0_seqr_h.device0_agent_cfg_h = device0_agent_cfg_h;

    //Connecting the ports
    device0_drv_proxy_h.seq_item_port.connect(device0_seqr_h.seq_item_export);
  end
  
  device0_mon_proxy_h.device0_agent_cfg_h = device0_agent_cfg_h;
  
endfunction : connect_phase

//--------------------------------------------------------------------------------------------
// Function: end_of_elaboration_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void device0_agent::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
endfunction  : end_of_elaboration_phase

//--------------------------------------------------------------------------------------------
// Function: start_of_simulation_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void device0_agent::start_of_simulation_phase(uvm_phase phase);
  super.start_of_simulation_phase(phase);
endfunction : start_of_simulation_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
task device0_agent::run_phase(uvm_phase phase);

  phase.raise_objection(this, "device0_agent");

  super.run_phase(phase);

  // Work here
  // ...

  phase.drop_objection(this);

endtask : run_phase

`endif

