`ifndef RX_MONITOR_PROXY_INCLUDED_
`define RX_MONITOR_PROXY_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: rx_monitor_proxy
// This is the HVL rx monitor proxy
// It gets the sampled data from the HDL rx monitor and 
// converts them into transaction items
//--------------------------------------------------------------------------------------------
class rx_monitor_proxy extends uvm_monitor;
  `uvm_component_utils(rx_monitor_proxy)

  //Declaring Monitor Analysis Import
  uvm_analysis_port #(rx_xtn) rx_analysis_port;
  
  //Declaring Virtual Monitor BFM Handle
  virtual rx_monitor_bfm rx_mon_bfm_h;

  // Variable: rx_agent_cfg_h;
  // Handle for rx agent configuration
  rx_agent_config rx_agent_cfg_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "rx_monitor_proxy", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
  extern virtual function void reset_detected();
  extern virtual task read(uart_reciver_char_s data_packet);
  //extern virtual task sample_from_bfm();

endclass : rx_monitor_proxy

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
// name - rx_monitor_proxy
// parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function rx_monitor_proxy::new(string name = "rx_monitor_proxy",
                                 uvm_component parent = null);
  super.new(name, parent);
  rx_analysis_port = new("rx_analysis_port",this);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// Description_here:
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void rx_monitor_proxy::build_phase(uvm_phase phase);
  super.build_phase(phase);
  
  if(!uvm_config_db#(virtual rx_monitor_bfm)::get(this,"","rx_monitor_bfm",rx_mon_bfm_h)) begin
    `uvm_fatal("FATAL_SMP_MON_BFM",$sformatf("Couldn't get S_MON_BFM in rx_Monitor_proxy"));  
  end 

endfunction : build_phase


//--------------------------------------------------------------------------------------------
// Function: end_of_elaboration_phase
// <Description_here>
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void rx_monitor_proxy::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
  rx_mon_bfm_h.rx_mon_proxy_h = this;
endfunction  : end_of_elaboration_phase


//--------------------------------------------------------------------------------------------
// Function reset_detected
// This task detect the system reset appliction
//--------------------------------------------------------------------------------------------
function void rx_monitor_proxy::reset_detected();
  `uvm_info(get_type_name(), $sformatf("System reset is detected"), UVM_NONE);

endfunction: reset_detected

//--------------------------------------------------------------------------------------------
// Task: run_phase
// <Description_here>
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
task rx_monitor_proxy::run_phase(uvm_phase phase);

  rx_xtn rx_packet;
  
  `uvm_info(get_type_name(), $sformatf("Inside the rx_monitor_proxy"), UVM_LOW);

  rx_packet =  rx_xtn::type_id::create("rx_packet");

  // Wait for system reset
  rx_mon_bfm_h.wait_for_system_reset();

  // Wait for the IDLE state of uart interface
  rx_mon_bfm_h.wait_for_idle_state();
  
  // Generating the BCLK
  // Used for debugging purpose ans hence used only in simulation
  // `ifdef SIMULATION_ONLY
  fork 
    rx_mon_bfm_h.gen_bclk(rx_agent_cfg_h.rx_baudrate_divisor);
  join_none
  //`endif
  

  // Driving logic
  forever begin
    uart_reciver_char_s struct_packet;
    uart_transfer_cfg_s struct_cfg;

    rx_xtn rx_clone_packet;

    // Wait for transfer to start
    rx_mon_bfm_h.wait_for_transfer_start();

    rx_seq_item_converter::from_class(rx_packet,rx_agent_cfg_h,struct_packet);

    `uvm_info(get_type_name(),$sformatf("strt rx pkt seq_item from class: , \n %p",
                                        struct_packet),UVM_LOW)

    rx_cfg_converter::from_class(rx_agent_cfg_h,struct_cfg); 

    rx_mon_bfm_h.sample_data(struct_packet, struct_cfg);

    rx_seq_item_converter::to_class(struct_packet,rx_agent_cfg_h,rx_packet);

    `uvm_info(get_type_name(),$sformatf("Received packet from BFM : , \n %s",
                                        rx_packet.sprint()),UVM_LOW)

    // Clone and publish the cloned item to the subscribers
    $cast(rx_clone_packet, rx_packet.clone());
    `uvm_info(get_type_name(),$sformatf("Sending packet via analysis_port : , \n %s",
                                        rx_clone_packet.sprint()),UVM_HIGH)
    rx_analysis_port.write(rx_clone_packet);

  end
 
endtask : run_phase


//-------------------------------------------------------
// Task : Read
// Captures the tx data sampled.
//-------------------------------------------------------

task rx_monitor_proxy::read(uart_reciver_char_s data_packet);
 rx_seq_item_converter rx_seq_item_conv_h;


endtask: read

`endif

