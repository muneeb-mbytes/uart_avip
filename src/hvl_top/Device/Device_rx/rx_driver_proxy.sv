`ifndef RX_DRIVER_PROXY_INCLUDED_
`define RX_DRIVER_PROXY_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: rx_driver_proxy
// This is the proxy driver on the HVL side
// It receives the transactions and converts them to task calls for the HDL driver
//--------------------------------------------------------------------------------------------
class rx_driver_proxy extends uvm_driver#(device_rx);
  `uvm_component_utils(rx_driver_proxy)

  // Variable: rx_driver_bfm_h;
  // Handle for rx driver bfm
  virtual rx_driver_bfm rx_drv_bfm_h;

  // Variable: rx_agent_cfg_h;
  // Handle for rx agent configuration
  rx_agent_config rx_agent_cfg_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "rx_driver_proxy", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual function void start_of_simulation_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
  // extern virtual task drive_to_bfm();

endclass : rx_driver_proxy

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
// name - rx_driver_proxy
// parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function rx_driver_proxy::new(string name = "rx_driver_proxy",
                                 uvm_component parent = null);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// Description_here:rx_driver_bfm congiguration is obtained in build phase
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void rx_driver_proxy::build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!uvm_config_db #(virtual rx_driver_bfm)::get(this,"","rx_driver_bfm",rx_drv_bfm_h)) begin
    `uvm_fatal("FATAL_SDP_CANNOT_GET_rx_DRIVER_BFM","cannot get() rx_drv_bfm_h");
  end
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: connect_phase
// Description_here: Connects driver_proxy and driver_bfm
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void rx_driver_proxy::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
endfunction : connect_phase

//--------------------------------------------------------------------------------------------
// Function: end_of_elaboration_phase
// <Description_here>
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void rx_driver_proxy::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
endfunction  : end_of_elaboration_phase

//--------------------------------------------------------------------------------------------
// Function: start_of_simulation_phase
// <Description_here>
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void rx_driver_proxy::start_of_simulation_phase(uvm_phase phase);
  super.start_of_simulation_phase(phase);
endfunction : start_of_simulation_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// <Description_here>
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
task rx_driver_proxy::run_phase(uvm_phase phase);
  
  super.run_phase(phase);
  // rx_drv_bfm_h.wait_for_reset();
  // rx_drv_bfm_h.drive_for_idle();
  // rx_drv_bfm_h.drive_for_start_bit();

  seq_item_port.get_next_item(req);
  // Work here
  // ...
  // drive_to_bfm();

  seq_item_port.item_done();

endtask : run_phase
//task rx_driver_proxy::drive_to_bfm();
//drive the data
//
//rx_drv_bfm_h.drive_for_data();
//rx_drv_bfm_h.drive_for_parity_bit();
//rx_drv_bfm_h.drive_for_stop_bit();
//endtask: drive_to_bfm

`endif
