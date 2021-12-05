`ifndef RX_SEQUENCER_INCLUDED_
`define RX_SEQUENCER_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: rx_sequencer
// It send transactions to driver via tlm ports
//--------------------------------------------------------------------------------------------
class rx_sequencer extends uvm_sequencer#(device_rx);
  `uvm_component_utils(rx_sequencer)
  
  // Variable: rx_agent_cfg_h;
  // Handle for rx agent configuration
  rx_agent_config rx_agent_cfg_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "rx_sequencer", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual function void start_of_simulation_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);

endclass : rx_sequencer

//--------------------------------------------------------------------------------------------
// Construct: new
// rx_sequencer class object is initialized
//
// Parameters:
// name - rx_sequencer
// parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function rx_sequencer::new(string name = "rx_sequencer", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// <Description_here>
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void rx_sequencer::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: connect_phase
// <Description_here>
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void rx_sequencer::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
endfunction : connect_phase

//--------------------------------------------------------------------------------------------
// Function: end_of_elaboration_phase
// <Description_here>
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void rx_sequencer::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
endfunction  : end_of_elaboration_phase

//--------------------------------------------------------------------------------------------
// Function: start_of_simulation_phase
// <Description_here>
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void rx_sequencer::start_of_simulation_phase(uvm_phase phase);
  super.start_of_simulation_phase(phase);
endfunction : start_of_simulation_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// <Description_here>
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
task rx_sequencer::run_phase(uvm_phase phase);
  //phase.raise_objection(this, "rx_sequencer");

  super.run_phase(phase);

  // Work here
  // ...

  //phase.drop_objection(this);

endtask : run_phase

`endif
