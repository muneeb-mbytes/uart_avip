`ifndef SLAVE_COVERAGE_INCLUDED_
`define SLAVE_COVERAGE_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: slave_coverage
// Description:
// Class for coverage report for UART
//--------------------------------------------------------------------------------------------
class slave_coverage extends uvm_subscriber#(slave_tx);
  `uvm_component_utils(slave_coverage)

  // Variable: master_agent_cfg_h
  // Declaring handle for slave agent configuration class 
  slave_agent_config slave_agent_cfg_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "slave_coverage", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual function void start_of_simulation_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
  extern virtual function void write(slave_tx t);

endclass : slave_coverage

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - slave_coverage
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function slave_coverage::new(string name = "slave_coverage",
                                 uvm_component parent = null);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void slave_coverage::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: connect_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void slave_coverage::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
endfunction : connect_phase

//--------------------------------------------------------------------------------------------
// Function: end_of_elaboration_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void slave_coverage::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
endfunction  : end_of_elaboration_phase

//--------------------------------------------------------------------------------------------
// Function: start_of_simulation_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void slave_coverage::start_of_simulation_phase(uvm_phase phase);
  super.start_of_simulation_phase(phase);
endfunction : start_of_simulation_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
task slave_coverage::run_phase(uvm_phase phase);

  phase.raise_objection(this, "slave_coverage");

  super.run_phase(phase);

  // Work here
  // ...

  phase.drop_objection(this);

endtask : run_phase

//--------------------------------------------------------------------------------------------
// Function: write
// 
//--------------------------------------------------------------------------------------------
function void slave_coverage::write(slave_tx t);
  // ...
endfunction: write

`endif

