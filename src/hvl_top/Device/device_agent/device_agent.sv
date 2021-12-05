`ifndef DEVICE_AGENT_INCLUDED_
`define DEVICE_AGENT_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: device_agent
// Description:
// device_agentironment contains handles of  tx agent,rx agent,virtual sequencer,scoreboard 
//--------------------------------------------------------------------------------------------
class device_agent extends uvm_agent;

  // Factory registration to create uvm_method and override it
  `uvm_component_utils(device_agent)
  
  //declaring handle for device_agent_config
  device_agent_config device_agent_cfg_h;

  // declaring tx_agent handles
  tx_agent tx_agent_h;
  // declaring rx_agent handles
  rx_agent rx_agent_h;

 
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "device_agent", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
endclass : device_agent

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - device_agent
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function device_agent::new(string name = "device_agent",uvm_component parent = null);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// Description:
//  Create required components
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void device_agent::build_phase(uvm_phase phase);
  super.build_phase(phase);
  
  `uvm_info(get_full_name(),"device_agent: build_phase",UVM_LOW);
  if(!uvm_config_db #(device_agent_config)::get(this,"","device_agent_config",device_agent_cfg_h)) begin
    `uvm_fatal("FATAL_SA_AGENT_CONFIG", 
                $sformatf("Couldn't get the device_agent_config from config_db"))
  end
  tx_agent_h=tx_agent::type_id::create("tx_agent_h",this);
  rx_agent_h=rx_agent::type_id::create("rx_agent_h",this);
  
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: connect_phase
// Description:
//  To connect virtual sequencer handles with tx and rx sequencer  
//  connect the monitor analysis port with scoreboard analysis fifo export
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void device_agent::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
 endfunction : connect_phase



`endif


