`ifndef DEVICE1_COVERAGE_INCLUDED_
`define DEVICE1_COVERAGE_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: device1_coverage
// Description:
// Class for coverage report for UART
//--------------------------------------------------------------------------------------------
class device1_coverage extends uvm_subscriber#(device1_tx);
  `uvm_component_utils(device1_coverage)

  // Variable: device1_agent_cfg_h
  // Declaring handle for device1 agent configuration class 
  device1_agent_config device1_agent_cfg_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "device1_coverage", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual function void start_of_simulation_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
  extern virtual function void write(device1_tx t);

endclass : device1_coverage

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - device1_coverage
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function device1_coverage::new(string name = "device1_coverage",
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
function void device1_coverage::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: connect_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void device1_coverage::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
endfunction : connect_phase

//--------------------------------------------------------------------------------------------
// Function: end_of_elaboration_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void device1_coverage::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
endfunction  : end_of_elaboration_phase

//--------------------------------------------------------------------------------------------
// Function: start_of_simulation_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void device1_coverage::start_of_simulation_phase(uvm_phase phase);
  super.start_of_simulation_phase(phase);
endfunction : start_of_simulation_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
task device1_coverage::run_phase(uvm_phase phase);

  phase.raise_objection(this, "device1_coverage");

  super.run_phase(phase);

  // Work here
  // ...

  phase.drop_objection(this);

endtask : run_phase

//--------------------------------------------------------------------------------------------
// Function: write
// 
//--------------------------------------------------------------------------------------------
function void device1_coverage::write(device1_tx t);
  // ...
endfunction: write

`endif

