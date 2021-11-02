`ifndef SLAVE_SEQUENCER_INCLUDED_
`define SLAVE_SEQUENCER_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: slave_sequencer
// It send transactions to driver via tlm ports
//--------------------------------------------------------------------------------------------
class slave_sequencer extends uvm_sequencer#(slave_tx);
  `uvm_component_utils(slave_sequencer)
  
  // Variable: slave_agent_cfg_h;
  // Handle for slave agent configuration
  slave_agent_config slave_agent_cfg_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "slave_sequencer", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual function void start_of_simulation_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);

endclass : slave_sequencer

//--------------------------------------------------------------------------------------------
// Construct: new
// slave_sequencer class object is initialized
//
// Parameters:
// name - slave_sequencer
// parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function slave_sequencer::new(string name = "slave_sequencer", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// <Description_here>
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void slave_sequencer::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: connect_phase
// <Description_here>
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void slave_sequencer::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
endfunction : connect_phase

//--------------------------------------------------------------------------------------------
// Function: end_of_elaboration_phase
// <Description_here>
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void slave_sequencer::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
endfunction  : end_of_elaboration_phase

//--------------------------------------------------------------------------------------------
// Function: start_of_simulation_phase
// <Description_here>
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void slave_sequencer::start_of_simulation_phase(uvm_phase phase);
  super.start_of_simulation_phase(phase);
endfunction : start_of_simulation_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// <Description_here>
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
task slave_sequencer::run_phase(uvm_phase phase);

  phase.raise_objection(this, "slave_sequencer");

  super.run_phase(phase);

  // Work here
  // ...

  phase.drop_objection(this);

endtask : run_phase

`endif
