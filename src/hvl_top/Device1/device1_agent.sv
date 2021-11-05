`ifndef DEVICE1_AGENT_INCLUDED_
`define DEVICE1_AGENT_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: device1_agent
// This agent has sequencer, driver_proxy, monitor_proxy for UART
//--------------------------------------------------------------------------------------------
class device1_agent extends uvm_agent;
  `uvm_component_utils(device1_agent)
  
  // Variable: device1_agent_cfg_h;
  // Handle for device1 agent configuration
  device1_agent_config device1_agent_cfg_h;

  // Variable: device1_seqr_h;
  // Handle for device1 sequencer
  device1_sequencer device1_seqr_h;

  // Variable: device1_drv_proxy_h
  // Handle for device1 driver proxy
  device1_driver_proxy device1_drv_proxy_h;

  // Variable: device1_mon_proxy_h
  // Handle for device1 monitor proxy
  device1_monitor_proxy device1_mon_proxy_h;

  // Variable: device1_coverage
  // Decalring a handle for device1_coverage
  device1_coverage device1_cov_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "device1_agent", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual function void start_of_simulation_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);

endclass : device1_agent

//--------------------------------------------------------------------------------------------
// Construct: new
// Initializes the device1_agent class object
//
// Parameters:
//  name - instance name of the  device1_agent
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function device1_agent::new(string name = "device1_agent",uvm_component parent=null);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// Creates the required ports, gets the required configuration from config_db
//
// Parameters:
//  phase - stores the current phase
//--------------------------------------------------------------------------------------------
function void device1_agent::build_phase(uvm_phase phase);
  super.build_phase(phase);

  if(!uvm_config_db #(device1_agent_config)::get(this,"","device1_agent_config",device1_agent_cfg_h)) begin
    `uvm_fatal("FATAL_SA_AGENT_CONFIG", $sformatf("Couldn't get the device1_agent_config from config_db"));
  end
  if(device1_agent_cfg_h.is_active == UVM_ACTIVE) begin
    device1_drv_proxy_h = device1_driver_proxy::type_id::create("device1_drv_proxy_h",this);
    device1_seqr_h=device1_sequencer::type_id::create("device1_seqr_h",this);
  end
  device1_mon_proxy_h = device1_monitor_proxy::type_id::create("device1_mon_proxy_h",this);
  
  //coverage
  if(device1_agent_cfg_h.has_coverage) begin
    device1_cov_h = device1_coverage::type_id::create("device1_cov_h",this);
  end

endfunction : build_phase


//--------------------------------------------------------------------------------------------
// Function: connect_phase
// Description: it connects the components using TLM ports
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void device1_agent::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  if(device1_agent_cfg_h.is_active == UVM_ACTIVE) begin
    device1_drv_proxy_h.device1_agent_cfg_h = device1_agent_cfg_h;
    device1_seqr_h.device1_agent_cfg_h = device1_agent_cfg_h;
    
    // Connecting the ports
    device1_drv_proxy_h.seq_item_port.connect(device1_seqr_h.seq_item_export);
    
    // connect monitor port to coverage
  end
  
  device1_mon_proxy_h.device1_agent_cfg_h = device1_agent_cfg_h;
  
  //device1_drv_proxy_h.seq_item_port.connect(device1_seqr_h.seq_item_export);
  //
  //coverage connections

endfunction : connect_phase

//--------------------------------------------------------------------------------------------
//Function: end_of_elaboration_phase
// <Description_here>
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void device1_agent::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
endfunction  : end_of_elaboration_phase

//--------------------------------------------------------------------------------------------
// Function: start_of_simulation_phase
// <Description_here>
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void device1_agent::start_of_simulation_phase(uvm_phase phase);
  super.start_of_simulation_phase(phase);
endfunction : start_of_simulation_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// <Description_here>
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
task device1_agent::run_phase(uvm_phase phase);
  
  phase.raise_objection(this, "device1_agent");
  
  super.run_phase(phase);

  // Work here
  // ...

  phase.drop_objection(this);

endtask : run_phase

`endif

