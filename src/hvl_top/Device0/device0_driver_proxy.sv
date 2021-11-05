`ifndef DEVICE0_DRIVER_PROXY_INCLUDED_
`define DEVICE0_DRIVER_PROXY_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: device0_driver_proxy
// Description:
// Driver is written by extending uvm_driver,uvm_driver is inherited from uvm_component, 
// Methods and TLM port (seq_item_port) are defined for communication between sequencer and driver,
// uvm_driver is a parameterized class and it is parameterized with the type of the request 
// sequence_item and the type of the response sequence_item 
//--------------------------------------------------------------------------------------------
class device0_driver_proxy extends uvm_driver#(device0_tx);
  `uvm_component_utils(device0_driver_proxy)
  
  virtual device0_driver_bfm device0_drv_bfm_h;
  
  // Variable: device0_agent_cfg_h
  // Declaring handle for device0 agent config class 
  device0_agent_config device0_agent_cfg_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "device0_driver_proxy", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual function void start_of_simulation_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);

endclass : device0_driver_proxy

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
// name - device0_driver_proxy
// parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function device0_driver_proxy::new(string name = "device0_driver_proxy",uvm_component parent = null);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void device0_driver_proxy::build_phase(uvm_phase phase);  
  super.build_phase(phase);

    if(!uvm_config_db #(virtual device0_driver_bfm)::get(this,"","device0_driver_bfm",device0_drv_bfm_h)) begin
    `uvm_fatal("FATAL_MDP_CANNOT_GET_device0_DRIVER_BFM","cannot get() device0_drv_bfm_h");
  end

endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: connect_phase
// <Description_here>
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void device0_driver_proxy::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
endfunction : connect_phase

//--------------------------------------------------------------------------------------------
// Function: end_of_elaboration_phase
// <Description_here>
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void device0_driver_proxy::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
endfunction  : end_of_elaboration_phase

//--------------------------------------------------------------------------------------------
// Function: start_of_simulation_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void device0_driver_proxy::start_of_simulation_phase(uvm_phase phase);
  super.start_of_simulation_phase(phase);
endfunction : start_of_simulation_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// <Description_here>
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
task device0_driver_proxy::run_phase(uvm_phase phase);

  super.run_phase(phase);

  seq_item_port.get_next_item(req);
  // Work here
  // ...
  seq_item_port.item_done();

endtask : run_phase

`endif

