`ifndef UART_SCOREBOARD_INCLUDED_
`define UART_SCOREBOARD_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: uart_scoreboard
// Scoreboard the data getting from monitor port that goes into the implementation port
//--------------------------------------------------------------------------------------------
class uart_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(uart_scoreboard)

  //Variable : master_tx_h
  //declaring master transaction handle
  master_tx master_tx_h;
  
  //Variable : slave_tx_h
  //declaring slave transaction handle
  slave_tx slave_tx_h;
  
  //Variable : env_cfg_h
  //declaring env config handle
  env_config env_cfg_h;

  //Variable : master_analysis_fifo
  //declaring analysis fifo
  uvm_tlm_analysis_fifo#(master_tx)master_analysis_fifo;
 
  //Variable : slave_analysis_fifo
  //declaring analysis fifo
  uvm_tlm_analysis_fifo#(slave_tx)slave_analysis_fifo;
  
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "uart_scoreboard", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
endclass : uart_scoreboard

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - uart_scoreboard
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function uart_scoreboard::new(string name = "uart_scoreboard", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// Build master and slave analysis fifo
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void uart_scoreboard::build_phase(uvm_phase phase);
  super.build_phase(phase);
  
  master_analysis_fifo = new("master_analysis_fifo",this);
  slave_analysis_fifo = new("slave_analysis_fifo",this);
  
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: connect_phase
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void uart_scoreboard::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
endfunction : connect_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// Used to give delays and check the wdata and rdata are similar or not
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
task uart_scoreboard::run_phase(uvm_phase phase);

  phase.raise_objection(this, "uart_scoreboard");

  super.run_phase(phase);

  // Work here
  // ...

  phase.drop_objection(this);

endtask : run_phase

`endif

