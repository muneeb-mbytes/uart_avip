`ifndef RX_COVERAGE_INCLUDED_
`define RX_COVERAGE_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: rx_coverage
// Description:
// Class for coverage report for UART
//--------------------------------------------------------------------------------------------
class rx_coverage extends uvm_subscriber#(device_rx);
  `uvm_component_utils(rx_coverage)

  // Variable: rx_agent_cfg_h
  // Declaring handle for rx agent configuration class 
  rx_agent_config rx_agent_cfg_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "rx_coverage", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual function void start_of_simulation_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
  extern virtual function void write(device_rx t);

endclass : rx_coverage

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
// name - rx_coverage
// parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function rx_coverage::new(string name = "rx_coverage",
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
function void rx_coverage::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: connect_phase
// <Description_here>
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void rx_coverage::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
endfunction : connect_phase

//--------------------------------------------------------------------------------------------
// Function: end_of_elaboration_phase
// <Description_here>
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void rx_coverage::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
endfunction  : end_of_elaboration_phase

//--------------------------------------------------------------------------------------------
// Function: start_of_simulation_phase
// <Description_here>
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void rx_coverage::start_of_simulation_phase(uvm_phase phase);
  super.start_of_simulation_phase(phase);
endfunction : start_of_simulation_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// <Description_here>
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
task rx_coverage::run_phase(uvm_phase phase);

  //phase.raise_objection(this, "rx_coverage");

  super.run_phase(phase);

  // Work here
  // ...

  //phase.drop_objection(this);

endtask : run_phase

//--------------------------------------------------------------------------------------------
// Function: write
// 
//--------------------------------------------------------------------------------------------
function void rx_coverage::write(device_rx t);
  // ...
endfunction: write

`endif

