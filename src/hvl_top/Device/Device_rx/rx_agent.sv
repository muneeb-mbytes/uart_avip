`ifndef RX_AGENT_INCLUDED_
`define RX_AGENT_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: rx_agent
// This agent has sequencer, driver_proxy, monitor_proxy for UART
//--------------------------------------------------------------------------------------------
class rx_agent extends uvm_agent;
  `uvm_component_utils(rx_agent)
  
  // Variable: rx_agent_cfg_h;
  // Handle for rx agent configuration
  rx_agent_config rx_agent_cfg_h;

  // Variable: rx_seqr_h;
  // Handle for rx sequencer
  rx_sequencer rx_seqr_h;

  // Variable: rx_drv_proxy_h
  // Handle for rx driver proxy
  rx_driver_proxy rx_drv_proxy_h;

  // Variable: rx_mon_proxy_h
  // Handle for rx monitor proxy
  rx_monitor_proxy rx_mon_proxy_h;

  // Variable: rx_coverage
  // Decalring a handle for rx_coverage
  rx_coverage rx_cov_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "rx_agent", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual function void start_of_simulation_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);

endclass : rx_agent

//--------------------------------------------------------------------------------------------
// Construct: new
// Initializes the rx_agent class object
//
// Parameters:
//  name - instance name of the  rx_agent
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function rx_agent::new(string name = "rx_agent",uvm_component parent=null);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// Creates the required ports, gets the required configuration from config_db
//
// Parameters:
//  phase - stores the current phase
//--------------------------------------------------------------------------------------------
function void rx_agent::build_phase(uvm_phase phase);
  super.build_phase(phase);

  if(!uvm_config_db #(rx_agent_config)::get(this,"","rx_agent_config",rx_agent_cfg_h)) begin
    `uvm_fatal("FATAL_SA_AGENT_CONFIG", $sformatf("Couldn't get the rx_agent_config from config_db"));
  end
  if(rx_agent_cfg_h.is_active == UVM_ACTIVE) begin
    rx_drv_proxy_h = rx_driver_proxy::type_id::create("rx_drv_proxy_h",this);
    rx_seqr_h=rx_sequencer::type_id::create("rx_seqr_h",this);
  end
  rx_mon_proxy_h = rx_monitor_proxy::type_id::create("rx_mon_proxy_h",this);
  
  //coverage
  if(rx_agent_cfg_h.has_coverage) begin
    rx_cov_h = rx_coverage::type_id::create("rx_cov_h",this);
  end

endfunction : build_phase


//--------------------------------------------------------------------------------------------
// Function: connect_phase
// Description: it connects the components using TLM ports
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void rx_agent::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  if(rx_agent_cfg_h.is_active == UVM_ACTIVE) begin
    rx_drv_proxy_h.rx_agent_cfg_h = rx_agent_cfg_h;
    rx_seqr_h.rx_agent_cfg_h = rx_agent_cfg_h;
    
    // Connecting the ports
    rx_drv_proxy_h.seq_item_port.connect(rx_seqr_h.seq_item_export);
    
    // connect monitor port to coverage
  end
  
  rx_mon_proxy_h.rx_agent_cfg_h = rx_agent_cfg_h;
  
  //rx_drv_proxy_h.seq_item_port.connect(rx_seqr_h.seq_item_export);
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
function void rx_agent::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
endfunction  : end_of_elaboration_phase

//--------------------------------------------------------------------------------------------
// Function: start_of_simulation_phase
// <Description_here>
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void rx_agent::start_of_simulation_phase(uvm_phase phase);
  super.start_of_simulation_phase(phase);
endfunction : start_of_simulation_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// <Description_here>
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
task rx_agent::run_phase(uvm_phase phase);
  
//  phase.raise_objection(this, "rx_agent");
  
  super.run_phase(phase);

  // Work here
  // ...

  //phase.drop_objection(this);

endtask : run_phase

`endif

