`ifndef TX_COVERAGE_INCLUDED_
`define TX_COVERAGE_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: tx_coverage
// Description:
// Class for coverage report for UART
//--------------------------------------------------------------------------------------------
class tx_coverage extends uvm_subscriber#(tx_xtn);
  `uvm_component_utils(tx_coverage)

  // Variable: tx_agent_cfg_h
  // Declaring handle for tx agent configuration class 
  tx_agent_config tx_agent_cfg_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "tx_coverage", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual function void start_of_simulation_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
  extern virtual function void write(tx_xtn t);

endclass : tx_coverage

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
// name - tx_coverage
// parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function tx_coverage::new(string name = "tx_coverage",
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
function void tx_coverage::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: connect_phase
// <Description_here>
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void tx_coverage::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
endfunction : connect_phase

//--------------------------------------------------------------------------------------------
// Function: end_of_elaboration_phase
// <Description_here>
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void tx_coverage::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
endfunction  : end_of_elaboration_phase

//--------------------------------------------------------------------------------------------
// Function: start_of_simulation_phase
// <Description_here>
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void tx_coverage::start_of_simulation_phase(uvm_phase phase);
  super.start_of_simulation_phase(phase);
endfunction : start_of_simulation_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// <Description_here>
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
task tx_coverage::run_phase(uvm_phase phase);

//  phase.raise_objection(this, "tx_coverage");

  super.run_phase(phase);

  // Work here
  // ...

 // phase.drop_objection(this);

endtask : run_phase

//--------------------------------------------------------------------------------------------
// Function: write
// 
//--------------------------------------------------------------------------------------------
function void tx_coverage::write(tx_xtn t);
  //  device0_tx device0_tx_h;
  //  this.device0_tx_h = t;
  // cg.sample(device0_agent_cfg_h, device0_tx_cov_data);     
endfunction: write
//extern function void write(device0_tx device0_tx_h);

`endif

