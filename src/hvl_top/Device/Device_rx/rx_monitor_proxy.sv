`ifndef RX_MONITOR_PROXY_INCLUDED_
`define RX_MONITOR_PROXY_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: rx_monitor_proxy
// This is the HVL rx monitor proxy
// It gets the sampled data from the HDL rx monitor and 
// converts them into transaction items
//--------------------------------------------------------------------------------------------
class rx_monitor_proxy extends uvm_monitor;
  `uvm_component_utils(rx_monitor_proxy)

  //Declaring Monitor Analysis Import
  uvm_analysis_port #(device_rx) rx_analysis_port;
  
  //Declaring Virtual Monitor BFM Handle
  virtual rx_monitor_bfm rx_mon_bfm_h;

  // Variable: rx_agent_cfg_h;
  // Handle for rx agent configuration
  rx_agent_config rx_agent_cfg_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "rx_monitor_proxy", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual function void start_of_simulation_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
  //extern virtual task sample_from_bfm();

endclass : rx_monitor_proxy

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
// name - rx_monitor_proxy
// parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function rx_monitor_proxy::new(string name = "rx_monitor_proxy",
                                 uvm_component parent = null);
  super.new(name, parent);
  rx_analysis_port = new("rx_analysis_port",this);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// Description_here:
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void rx_monitor_proxy::build_phase(uvm_phase phase);
  super.build_phase(phase);
  
  if(!uvm_config_db#(virtual rx_monitor_bfm)::get(this,"","rx_monitor_bfm",rx_mon_bfm_h)) begin
    `uvm_fatal("FATAL_SMP_MON_BFM",$sformatf("Couldn't get S_MON_BFM in rx_Monitor_proxy"));  
  end 

endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: connect_phase
// <Description_here>
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void rx_monitor_proxy::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
endfunction : connect_phase

//--------------------------------------------------------------------------------------------
// Function: end_of_elaboration_phase
// <Description_here>
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void rx_monitor_proxy::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
endfunction  : end_of_elaboration_phase

//--------------------------------------------------------------------------------------------
// Function: start_of_simulation_phase
// <Description_here>
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void rx_monitor_proxy::start_of_simulation_phase(uvm_phase phase);
  super.start_of_simulation_phase(phase);
endfunction : start_of_simulation_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// <Description_here>
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
task rx_monitor_proxy::run_phase(uvm_phase phase);

//  phase.raise_objection(this, "rx_monitor_proxy");

  super.run_phase(phase);
  //  rx_mon_bfm_h.wait_for_reset();
  //  rx_mon_bfm_h.sample_for_idle();
  //  rx_mon_bfm_h.sample_for_start_bit();
  //  sample_from_bfm();
  //  Work here
  //  ...

  // phase.drop_objection(this);

endtask : run_phase

//task rx_monitor_proxy::sample_from_bfm();
//sample the data
//
//rx_mon_bfm_h.sample_for_data();
//rx_mon_bfm_h.sample_for_parity_bit();
//endtask: sample_from_bfm
`endif

