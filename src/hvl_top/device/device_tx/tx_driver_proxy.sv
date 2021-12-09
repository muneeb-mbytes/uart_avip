`ifndef TX_DRIVER_PROXY_INCLUDED_
`define TX_DRIVER_PROXY_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: tx_driver_proxy
// Description:
// Driver is written by extending uvm_driver,uvm_driver is inherited from uvm_component, 
// Methods and TLM port (seq_item_port) are defined for communication between sequencer and driver,
// uvm_driver is a parameterized class and it is parameterized with the type of the request 
// sequence_item and the type of the response sequence_item 
//--------------------------------------------------------------------------------------------
class tx_driver_proxy extends uvm_driver#(tx_xtn);
  `uvm_component_utils(tx_driver_proxy)
  
  virtual tx_driver_bfm tx_drv_bfm_h;
  
  // Variable: tx_agent_cfg_h
  // Declaring handle for tx agent config class 
  tx_agent_config tx_agent_cfg_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "tx_driver_proxy", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual function void start_of_simulation_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
  extern virtual task drive_to_bfm(inout uart_transfer_char_s packet, input uart_transfer_cfg_s packet1);
  extern virtual function void reset_detected();
  

endclass : tx_driver_proxy

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
// name - tx_driver_proxy
// parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function tx_driver_proxy::new(string name = "tx_driver_proxy",uvm_component parent = null);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void tx_driver_proxy::build_phase(uvm_phase phase);  
  super.build_phase(phase);

    if(!uvm_config_db #(virtual tx_driver_bfm)::get(this,"","tx_driver_bfm",tx_drv_bfm_h)) begin
    `uvm_fatal("FATAL_MDP_CANNOT_GET_tx_DRIVER_BFM","cannot get() tx_drv_bfm_h");
  end

endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: connect_phase
// <Description_here>
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void tx_driver_proxy::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
endfunction : connect_phase

//--------------------------------------------------------------------------------------------
// Function: end_of_elaboration_phase
// <Description_here>
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void tx_driver_proxy::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
  tx_drv_bfm_h.tx_drv_proxy_h = this;
endfunction  : end_of_elaboration_phase

//--------------------------------------------------------------------------------------------
// Function: start_of_simulation_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void tx_driver_proxy::start_of_simulation_phase(uvm_phase phase);
  super.start_of_simulation_phase(phase);
endfunction : start_of_simulation_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// <Description_here>
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
task tx_driver_proxy::run_phase(uvm_phase phase);
  
  super.run_phase(phase);

  begin
    $display("tx_drv_prox");
  end

  // Wait for system reset 
  // Drive the IDLE state for UART interface
  tx_drv_bfm_h.wait_for_reset();  
  
  // Generating the BCLK
  fork 
    tx_drv_bfm_h.gen_bclk();
  join_none

  // Drive IDLE state
//  tx_drv_bfm_h.drive_idle_state();

  forever begin
    
    uart_transfer_char_s struct_pkt;
    uart_transfer_cfg_s struct_cfg;
       
    seq_item_port.get_next_item(req);
    
    //tx_seq_item_converter::tx_bits(tx_agent_cfg_h);
    tx_cfg_converter::from_class(tx_agent_cfg_h, struct_cfg);
    `uvm_info(get_full_name(),$sformatf("strt cfg = \n %p",struct_cfg),UVM_LOW)

    tx_seq_item_converter::from_class(req,tx_agent_cfg_h,struct_pkt);
    `uvm_info(get_full_name(),$sformatf("strt pkt = \n %p",struct_pkt),UVM_LOW)

    drive_to_bfm(struct_pkt, struct_cfg);    
    
    tx_seq_item_converter::to_class(struct_pkt,req);
    `uvm_info(get_full_name(),$sformatf("req pkt = \n %p",req.sprint()),UVM_LOW)

    seq_item_port.item_done();
  end

endtask : run_phase

//--------------------------------------------------------------------------------------------
// Task: drive_to_bfm
// This task converts the transcation data packet to struct type and send
// it to the device0_driver_bfm
//--------------------------------------------------------------------------------------------

task tx_driver_proxy::drive_to_bfm(inout uart_transfer_char_s packet, input uart_transfer_cfg_s packet1);
  tx_drv_bfm_h.drive_data_pos_edge(packet,packet1); 
  //`uvm_info(get_type_name(),$sformatf("AFTER STRUCT PACKET : , \n %p",packet1),UVM_LOW);
endtask : drive_to_bfm

//--------------------------------------------------------------------------------------------
// Function reset_detected
// This task detect the system reset appliction
//--------------------------------------------------------------------------------------------
function void tx_driver_proxy::reset_detected();
  `uvm_info(get_type_name(), $sformatf("System reset is detected"), UVM_NONE);
endfunction: reset_detected

`endif

