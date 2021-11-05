`ifndef UART_VIRTUAL_SEQ_BASE_INCLUDED_
`define UART_VIRTUAL_SEQ_BASE_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class:UART Virtual sequence
// Description:
// This class contains the handle of actual sequencer pointing towards them
//--------------------------------------------------------------------------------------------
class uart_virtual_seq_base extends uvm_sequence#(uvm_sequence_item);
  `uvm_object_utils(uart_virtual_seq_base)
  `uvm_declare_p_sequencer(virtual_sequencer)

  //declaring virtual sequencer handle
 // virtual_sequencer  virtual_seqr_h;

  //--------------------------------------------------------------------------------------------
  // declaring handles for device0 and device1 sequencer and environment config
  //--------------------------------------------------------------------------------------------
  device0_sequencer  device0_seqr_h;
  device1_sequencer   device1_seqr_h;
  env_config env_cfg_h;

  //--------------------------------------------------------------------------------------------
  // Externally defined tasks and functions
  //--------------------------------------------------------------------------------------------
  extern function new(string name="uart_virtual_seq_base");
  extern task body();

endclass : uart_virtual_seq_base

//--------------------------------------------------------------------------------------------
// Constructor:new
//
// Paramters:
// name - Instance name of the virtual_sequence
// parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
  
function uart_virtual_seq_base::new(string name="uart_virtual_seq_base");
  super.new(name);
endfunction : new

//--------------------------------------------------------------------------------------------
// task:body
// Creates the required ports
//
// Parameters:
// phase - stores the current phase
//--------------------------------------------------------------------------------------------
task uart_virtual_seq_base::body();
  if(!uvm_config_db#(env_config) ::get(null,get_full_name(),"env_config",env_cfg_h)) begin
    `uvm_fatal("CONFIG","cannot get() e_cfg from uvm_config_db.Have you set() it?")
  end

  if(!$cast(p_sequencer,m_sequencer))begin
      `uvm_error(get_full_name(),"Virtual sequencer pointer cast failed")
     end
            
  //connecting device0 sequencer and device1 sequencer in env to
  //device0 sequencer and device1 sequencer in virtual sequencer
  device0_seqr_h=p_sequencer.device0_seqr_h;
  device1_seqr_h=p_sequencer.device1_seqr_h;

endtask : body
`endif

