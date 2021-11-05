`ifndef DEVICE1_DRIVER_PROXY_INCLUDED_
`define DEVICE1_DRIVER_PROXY_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: device1_driver_proxy
// This is the proxy driver on the HVL side
// It receives the transactions and converts them to task calls for the HDL driver
//--------------------------------------------------------------------------------------------
class device1_driver_proxy extends uvm_driver#(device1_tx);
  `uvm_component_utils(device1_driver_proxy)

  // Variable: device1_driver_bfm_h;
  // Handle for device1 driver bfm
  virtual device1_driver_bfm device1_drv_bfm_h;

  // Variable: device1_agent_cfg_h;
  // Handle for device1 agent configuration
  device1_agent_config device1_agent_cfg_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "device1_driver_proxy", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual function void start_of_simulation_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);

endclass : device1_driver_proxy

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
// name - device1_driver_proxy
// parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function device1_driver_proxy::new(string name = "device1_driver_proxy",
                                 uvm_component parent = null);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// Description_here:device1_driver_bfm congiguration is obtained in build phase
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void device1_driver_proxy::build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!uvm_config_db #(virtual device1_driver_bfm)::get(this,"","device1_driver_bfm",device1_drv_bfm_h)) begin
    `uvm_fatal("FATAL_SDP_CANNOT_GET_device1_DRIVER_BFM","cannot get() device1_drv_bfm_h");
  end
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: connect_phase
// Description_here: Connects driver_proxy and driver_bfm
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void device1_driver_proxy::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
endfunction : connect_phase

//--------------------------------------------------------------------------------------------
// Function: end_of_elaboration_phase
// <Description_here>
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void device1_driver_proxy::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
endfunction  : end_of_elaboration_phase

//--------------------------------------------------------------------------------------------
// Function: start_of_simulation_phase
// <Description_here>
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void device1_driver_proxy::start_of_simulation_phase(uvm_phase phase);
  super.start_of_simulation_phase(phase);
endfunction : start_of_simulation_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// <Description_here>
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
task device1_driver_proxy::run_phase(uvm_phase phase);

  super.run_phase(phase);

  seq_item_port.get_next_item(req);
  // Work here
  // ...
  seq_item_port.item_done();

endtask : run_phase

`endif
