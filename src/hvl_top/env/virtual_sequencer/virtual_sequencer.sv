`ifndef VIRTUAL_SEQUENCER_INCLUDED_
`define VIRTUAL_SEQUENCER_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: virtual_sequencer
// Description:
// This class contains the handle of  device0 sequencer,device1 sequencer and environment config 
//--------------------------------------------------------------------------------------------
class virtual_sequencer extends uvm_sequencer #(uvm_sequence_item);
  `uvm_component_utils(virtual_sequencer)

  // Variable: env_cfg_h
  // Declaring environment configuration handle
  env_config env_cfg_h;

  // Variable: device0_seqr_h
  // Declaring device0 sequencer handle
  device0_sequencer device0_seqr_h;

  // Variable: device1_seqr_h
  // Declaring device1 sequencer handle
  device1_sequencer device1_seqr_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "virtual_sequencer", uvm_component parent=null);
  extern virtual function void build_phase(uvm_phase phase);

endclass : virtual_sequencer

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - instance name of the  virtual_sequencer
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function virtual_sequencer::new(string name = "virtual_sequencer",uvm_component parent=null );
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// Get the environment config
// creates the device0 and device1 sequencer
//
// Parameters:
//  phase - stores the current phase
//--------------------------------------------------------------------------------------------
function void virtual_sequencer::build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!uvm_config_db #(env_config)::get(this,"","env_config",env_cfg_h))begin
    `uvm_error("VSEQR","COULDNT GET")
  end
  device0_seqr_h=device0_sequencer::type_id::create("device0_seqr_h",this);
  device1_seqr_h=device1_sequencer::type_id::create("device1_seqr_h",this);
endfunction : build_phase

`endif

