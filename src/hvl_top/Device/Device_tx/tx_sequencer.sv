`ifndef TX_SEQUENCER_INCLUDED_
`define TX_SEQUENCER_INCLUDED_

 //--------------------------------------------------------------------------------------------
 // Class: tx_sequencer
 //--------------------------------------------------------------------------------------------
 class tx_sequencer extends uvm_sequencer #(device_tx);
  
  //register with factory so we can override it in further by using uvm method.

  `uvm_component_utils(tx_sequencer)

  // Variable: tx_agent_cfg_h
  // Declaring handle for tx agent config class 
  tx_agent_config tx_agent_cfg_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "tx_sequencer", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual function void start_of_simulation_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);

endclass : tx_sequencer

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
// name - tx_sequencer
// parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function tx_sequencer::new(string name = "tx_sequencer",
                                 uvm_component parent = null);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// <Description_here>
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void tx_sequencer::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: connect_phase
// <Description_here>
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void tx_sequencer::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
endfunction : connect_phase

//--------------------------------------------------------------------------------------------
// Function: end_of_elaboration_phase
// <Description_here>
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void tx_sequencer::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
endfunction  : end_of_elaboration_phase

//--------------------------------------------------------------------------------------------
// Function: start_of_simulation_phase
// <Description_here>
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void tx_sequencer::start_of_simulation_phase(uvm_phase phase);
  super.start_of_simulation_phase(phase);
endfunction : start_of_simulation_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// <Description_here>
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
task tx_sequencer::run_phase(uvm_phase phase);
  
  // phase.raise_objection(this, "tx_sequencer");

  super.run_phase(phase);

  // Work here
  // ...

  // phase.drop_objection(this);

endtask : run_phase

`endif

