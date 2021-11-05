`ifndef ENV_INCLUDED_
`define ENV_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: env
// Description:
// Environment contains handles of  device0 agent,device1 agent,virtual sequencer,scoreboard 
//--------------------------------------------------------------------------------------------
class env extends uvm_env;

  // Factory registration to create uvm_method and override it
  `uvm_component_utils(env)
  
  //declaring handle for env_config
  env_config env_cfg_h;

  // declaring device0 handles
  device0_agent device0_agent_h;
  
  // Declaring device1 handles
  device1_agent device1_agent_h;

  //handle for virtual seqr
  virtual_sequencer virtual_seqr_h;

  //handle for scoreboard 
  uart_scoreboard scoreboard_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "env", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual function void start_of_simulation_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);

endclass : env

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - env
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function env::new(string name = "env",uvm_component parent = null);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// Description:
//  Create required components
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void env::build_phase(uvm_phase phase);
  super.build_phase(phase);
  
  `uvm_info(get_full_name(),"ENV: build_phase",UVM_LOW);
  if(!uvm_config_db #(env_config)::get(this,"","env_config",env_cfg_h)) begin
    `uvm_fatal("FATAL_SA_AGENT_CONFIG", 
                $sformatf("Couldn't get the device1_agent_config from config_db"))
  end
  device0_agent_h=device0_agent::type_id::create("device0_agent_h",this);
  device1_agent_h = device1_agent::type_id::create("device1_agent_h",this);
  
  if(env_cfg_h.has_virtual_seqr) begin
    virtual_seqr_h = virtual_sequencer::type_id::create("virtual_seqr_h",this);
  end
  
  if(env_cfg_h.has_scoreboard) begin
    scoreboard_h = uart_scoreboard::type_id::create("scoreboard_h",this);
  end

endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: connect_phase
// Description:
//  To connect virtual sequencer handles with device0 and device1 sequencer  
//  connect the monitor analysis port with scoreboard analysis fifo export
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void env::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  if(env_cfg_h.has_virtual_seqr) begin
    virtual_seqr_h.device0_seqr_h = device0_agent_h.device0_seqr_h;
    virtual_seqr_h.device1_seqr_h = device1_agent_h.device1_seqr_h;
  end
  
  //connecting analysis port to analysis fifo
  device1_agent_h.device1_mon_proxy_h.device1_analysis_port.connect(scoreboard_h.device1_analysis_fifo.
                                                                                  analysis_export);
  device0_agent_h.device0_mon_proxy_h.device0_analysis_port.connect(scoreboard_h.device0_analysis_fifo.
                                                                                  analysis_export);

endfunction : connect_phase

//--------------------------------------------------------------------------------------------
// Function: end_of_elaboration_phase
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void env::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
endfunction  : end_of_elaboration_phase

//--------------------------------------------------------------------------------------------
// Function: start_of_simulation_phase
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void env::start_of_simulation_phase(uvm_phase phase);
  super.start_of_simulation_phase(phase);
endfunction : start_of_simulation_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
task env::run_phase(uvm_phase phase);

  phase.raise_objection(this, "env");

  super.run_phase(phase);

  // Work here
  // ...

  phase.drop_objection(this);

endtask : run_phase

`endif

