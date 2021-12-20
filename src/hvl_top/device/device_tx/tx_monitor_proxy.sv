`ifndef TX_MONITOR_PROXY_INCLUDED_
`define TX_MONITOR_PROXY_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: tx_monitor_proxy
// Description:
// Monitor is written by extending uvm_monitor,uvm_monitor is inherited from uvm_component, 
// A monitor is a passive entity that samples the DUT signals through virtual interface and 
// converts the signal level activity to transaction level,monitor samples DUT signals but does not drive them.
// Monitor should have analysis port (TLM port) and virtual interface handle that points to DUT signal
//--------------------------------------------------------------------------------------------
class tx_monitor_proxy extends uvm_component;
  
  //register with factory so can use create uvm_method and
  //override in future if necessary
  
  `uvm_component_utils(tx_monitor_proxy)
  
  // Variable: m_cfg
  // Declaring handle for tx agent config class 
  tx_agent_config tx_agent_cfg_h;

  //declaring analysis port for the monitor port
  uvm_analysis_port #(tx_xtn)tx_analysis_port;
  
  //Declaring Virtual Monitor BFM Handle
  virtual tx_monitor_bfm tx_mon_bfm_h;
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "tx_monitor_proxy", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
endclass : tx_monitor_proxy

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
// name - tx_monitor_proxy
// parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function tx_monitor_proxy::new(string name = "tx_monitor_proxy",
                                 uvm_component parent= null);
  super.new(name, parent);
  
  //creating monitor port
  tx_analysis_port=new("tx_analysis_port",this);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// <Description_here>
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void tx_monitor_proxy::build_phase(uvm_phase phase);
  super.build_phase(phase);
  
 if(!uvm_config_db #(virtual tx_monitor_bfm)::get(this,"","tx_monitor_bfm",tx_mon_bfm_h))begin
    `uvm_fatal("FATAL_tx_MONITOR_PROXY_CANNOT_GET TX MONITOR BFM","cannot get() MONITOR BFM tx monitor proxy");
  end 

endfunction : build_phase


//--------------------------------------------------------------------------------------------
// Function: end_of_elaboration_phase
// <Description_here>
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void tx_monitor_proxy::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
  tx_mon_bfm_h.tx_mon_proxy_h = this;
endfunction  : end_of_elaboration_phase



//--------------------------------------------------------------------------------------------
// Task: run_phase
// <Description_here>
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
task tx_monitor_proxy::run_phase(uvm_phase phase);
  tx_xtn tx_packet;

  //`uvm_info(get_type_name(), $sformatf("Inside the tx_monitor_proxy"), UVM_LOW);

  tx_packet = tx_xtn::type_id::create("tx_packet");

  //`uvm_info(get_type_name(),$sformatf("mon_req = \n %p",tx_packet.sprint()),UVM_LOW);

  // Wait for system reset
  tx_mon_bfm_h.wait_for_system_reset();

  // Wait for the IDLE state of UART interface
  tx_mon_bfm_h.wait_for_idle_state();

  // Generating the BCLK
  // Used for debugging purpose ans hence used only in simulation
  // `ifdef SIMULATION_ONLY
  fork 
    tx_mon_bfm_h.gen_bclk(tx_agent_cfg_h.tx_baudrate_divisor);
  join_none
  //`endif

  // Driving logic
  forever begin
    uart_transfer_char_s struct_packet;
    uart_transfer_cfg_s struct_cfg;

    tx_xtn  tx_clone_packet;

    // Wait for transfer to start
    tx_mon_bfm_h.wait_for_transfer_start();

    tx_seq_item_converter::from_class(tx_packet,tx_agent_cfg_h,struct_packet);

    //   `uvm_info(get_type_name(),$sformatf("strt tx pkt seq_item from class: , \n %p",
    //                                       struct_packet),UVM_LOW)

    tx_cfg_converter::from_class(tx_agent_cfg_h,struct_cfg); 
    tx_mon_bfm_h.sample_data(struct_packet, struct_cfg);

    tx_seq_item_converter::to_class(struct_packet,tx_packet);

   `uvm_info(get_type_name(),$sformatf("Received packet from tx MONITOR BFM : , \n %s",
                                        tx_packet.sprint()),UVM_HIGH)

    // Clone and publish the cloned item to the subscribers
    $cast(tx_clone_packet, tx_packet.clone());
    `uvm_info(get_type_name(),$sformatf("Sending packet via analysis_port : , \n %s",
                                        tx_clone_packet.sprint()),UVM_HIGH)
    tx_analysis_port.write(tx_clone_packet);

  end
endtask : run_phase

`endif

