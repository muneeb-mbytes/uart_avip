`ifndef TX_AGENT_INCLUDED_
`define TX_AGENT_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: tx_agent
// This agent is a configurable with respect to configuration which can create active and passive components
// It contains testbench components like sequencer,driver_proxy and monitor_proxy for UART
// --------------------------------------------------------------------------------------------
class tx_agent extends uvm_agent;
  `uvm_component_utils(tx_agent)

  // Variable: tx_agent_cfg_h
  // Declaring handle for tx agent config class 
  tx_agent_config tx_agent_cfg_h;

  // Varible: tx_seqr_h 
  // Handle for tx sequencer
  tx_sequencer tx_seqr_h;
  
  // Variable: tx_drv_proxy_h
  // Creating a Handle for tx driver proxy
  tx_driver_proxy tx_drv_proxy_h;
  
  // Variable: tx_mon_proxy_h
  // Declaring a handle for tx monitor proxy
  tx_monitor_proxy tx_mon_proxy_h;

  // Variable: tx_coverage
  // Decalring a handle for tx_coverage
  tx_coverage tx_cov_h;

  //coverage handle
  
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "tx_agent", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual function void start_of_simulation_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);

endclass : tx_agent

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters: 
// name - instance name of the uart tx_agent
// parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function  tx_agent::new(string name="tx_agent",uvm_component parent = null);
  super.new(name,parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// creates the required ports,gets the required configuration from config_db
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void tx_agent::build_phase(uvm_phase phase);
  super.build_phase(phase);

  if(!uvm_config_db #(tx_agent_config)::get(this,"","tx_agent_config",tx_agent_cfg_h)) begin
    `uvm_fatal("FATAL_MA_CANNOT_GET_tx_AGENT_CONFIG","cannot get tx_agent_cfg_h from uvm_config_db");
  end

  if(tx_agent_cfg_h.is_active == UVM_ACTIVE) begin
    tx_drv_proxy_h=tx_driver_proxy::type_id::create("tx_driver_proxy",this);
    tx_seqr_h=tx_sequencer::type_id::create("tx_sequencer",this);
  end

  tx_mon_proxy_h=tx_monitor_proxy::type_id::create("tx_monitor_proxy",this);

  if(tx_agent_cfg_h.has_coverage) begin
    tx_cov_h = tx_coverage::type_id::create("tx_cov_h",this);
  end

 // connect monitor port to coverage
//  if(tx_agent_cfg_h.has_coverage) begin
//    tx_cov_h.tx_agent_cfg_h = tx_agent_cfg_h;
//  end

endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: connect_phase
// Connecting tx_driver, tx_monitor and tx_sequencer for configuration
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void tx_agent::connect_phase(uvm_phase phase);
 super.connect_phase(phase);
  
  if(tx_agent_cfg_h.is_active == UVM_ACTIVE) begin
    tx_drv_proxy_h.tx_agent_cfg_h = tx_agent_cfg_h;
    tx_seqr_h.tx_agent_cfg_h = tx_agent_cfg_h;

    //Connecting the ports
    tx_drv_proxy_h.seq_item_port.connect(tx_seqr_h.seq_item_export);
  end

  tx_mon_proxy_h.tx_agent_cfg_h = tx_agent_cfg_h; 
  
  if(tx_agent_cfg_h.has_coverage) begin
    // MSHA: tx_cov_h.tx_agent_cfg_h = tx_agent_cfg_h;
     tx_cov_h.tx_agent_cfg_h = tx_agent_cfg_h;
    // connect monitor port to coverage

    tx_mon_proxy_h.tx_analysis_port.connect(tx_cov_h.analysis_export);
  end
  tx_mon_proxy_h.tx_agent_cfg_h = tx_agent_cfg_h;
  
endfunction : connect_phase

//--------------------------------------------------------------------------------------------
// Function: end_of_elaboration_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void tx_agent::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
endfunction  : end_of_elaboration_phase

//--------------------------------------------------------------------------------------------
// Function: start_of_simulation_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void tx_agent::start_of_simulation_phase(uvm_phase phase);
  super.start_of_simulation_phase(phase);
endfunction : start_of_simulation_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
task tx_agent::run_phase(uvm_phase phase);

//  phase.raise_objection(this, "tx_agent");

  super.run_phase(phase);

  // Work here
  // ...

  //phase.drop_objection(this);

endtask : run_phase

`endif

