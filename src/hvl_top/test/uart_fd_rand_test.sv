`ifndef UART_FD_RAND_TEST_INCLUDED_
`define UART_FD_RAND_TEST_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: uart_fd_rand_test
// Description:
// Extended the uart_fd_rand_test class from base_test class
//--------------------------------------------------------------------------------------------
class uart_fd_rand_test extends uart_fd_8b_test;

  //Registering the uart_fd_rand_test in the factory
  `uvm_component_utils(uart_fd_rand_test)

  //-------------------------------------------------------
  // Declaring sequence handles  
  //-------------------------------------------------------
  uart_fd_rand_virtual_seq uart_fd_rand_virtual_seq_h;

  //Enum Variables
  shift_direction_e shift_dir;
  oversampling_e oversampling_delay;
  parity_e parity_type;
  uart_type_e uart_type_var;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "uart_fd_rand_test", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern virtual function void setup_tx_agent_cfg();
  extern virtual function void setup_rx_agent_cfg();
  extern virtual function void setup_device_agent_cfg();
endclass : uart_fd_rand_test


//--------------------------------------------------------------------------------------------
// Construct: new
// Initializes class object
// Parameters:
// name - uart_fd_rand_test
// parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function uart_fd_rand_test::new(string name = "uart_fd_rand_test",uvm_component parent);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function:build_phase
//--------------------------------------------------------------------------------------------
function void uart_fd_rand_test::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase


//function void uart_fd_rand_test::setup_device_cfg();
//  super.setup_device_cfg();
//  foreach(env_cfg_h.device_cfg_h[i]) begin
//    if(! env_cfg_h.device_cfg_h[i].randomize() with { this.tx_agent_config_h.tx_baudrate_divisor == 
//                                                      env_cfg_h.device_cfg_h[i].get_baudrate_divisor();
//                                                      this.rx_agent_config_h.rx_baudrate_divisor == 
//                                                      env_cfg_h.device_cfg_h[i].get_baudrate_divisor();
//                                                    }) begin
//      `uvm_fatal(get_type_name(),$sformatf("Randomization failed in device_cfg"))
//    end
//  end
//endfunction : setup_device_cfg

//--------------------------------------------------------------------------------------------
// Function: setup_device_agent_config
// Setup the device agent configuration with the required values
// and store the handle into the config_db
//--------------------------------------------------------------------------------------------

function void uart_fd_rand_test::setup_device_agent_cfg();
  $display("inside device cfg");
  foreach(env_cfg_h.device_cfg_h[i]) begin
    if(! env_cfg_h.device_cfg_h[i].randomize() with { this.tx_agent_config_h.tx_baudrate_divisor == 
                                                      env_cfg_h.device_cfg_h[i].get_baudrate_divisor();
                                                      this.rx_agent_config_h.rx_baudrate_divisor == 
                                                      env_cfg_h.device_cfg_h[i].get_baudrate_divisor();
                                                    }) begin
      `uvm_fatal(get_type_name(),$sformatf("Randomization failed in device_cfg"))
    end
 // `uvm_info("dev_cfg_test",$sformatf("dev_baudarte = %0d",
 // env_cfg_h.device_cfg_h[i].tx_agent_config_h.tx_baudrate_divisor),UVM_FULL)
 // `uvm_info("dev_cfg_test",$sformatf("dev_baudarte = %0d",
 // env_cfg_h.device_cfg_h[i].rx_agent_config_h.rx_baudrate_divisor),UVM_FULL)
  end
endfunction : setup_device_agent_cfg

//--------------------------------------------------------------------------------------------
// Function: setup_tx_agent_config
// Setup the tx agent configuration with the required values
// and store the handle into the config_db
//--------------------------------------------------------------------------------------------
function void uart_fd_rand_test::setup_tx_agent_cfg();
  super.setup_tx_agent_cfg();
  
  foreach(env_cfg_h.device_cfg_h[i]) begin
    if(! env_cfg_h.device_cfg_h[i].tx_agent_config_h.randomize() with { this.shift_dir == shift_dir;
                                                                        this.oversampling_bits == oversampling_delay;
                                                                        this.parity_scheme == parity_type;
                                                                        this.uart_type ==
                                                                        uart_type_var;
                                                    }) begin
      `uvm_fatal(get_type_name(),$sformatf("Randomization failed in tx test"))
    end
  end

 // if(!std::randomize(shift_dir))begin
 //   `uvm_error("test",$sformatf("randomization  of dir failed"))
 // end

 // if(!std::randomize(oversampling_delay) with {oversampling_delay !=
 //                                              oversampling_e'(OVERSAMPLING_ZERO);
 //                                            })begin
 //   `uvm_error("test",$sformatf("randomization  of oversampling delay failed"))
 // end

 // if(!std::randomize(uart_type) with {uart_type != uart_type_e'(UART_TYPE_NO_TRANSFER);})begin
 //   `uvm_error("test",$sformatf("randomization  of uart_type failed"))
 // end

 // if(!std::randomize(parity_type))begin
 //   `uvm_error("test",$sformatf("randomization  of parity_type failed"))
 // end

 // `uvm_info("master_random_cfg_mode",$sformatf("rand_test_uart_type =  \n %0p",uart_type),UVM_FULL)
 // `uvm_info("master_random_cfg_mode",$sformatf("rand_test_shift_dir =  \n %0p",shift_dir),UVM_FULL)
 // `uvm_info("master_random_cfg_mode",$sformatf("rand_test_parity_type =  \n %0p",parity_type),UVM_FULL)
 // `uvm_info("master_random_cfg_mode",$sformatf("rand_tes_delay =  \n %0p",oversampling_delay),UVM_FULL)

 // foreach(env_cfg_h.device_cfg_h[i]) begin
 //   if(! env_cfg_h.device_cfg_h[i].randomize() with { env_cfg_h.device_cfg_h[i].tx_agent_config_h.shift_dir == 
 //                                                     shift_dir;
 //                                                     env_cfg_h.device_cfg_h[i].tx_agent_config_h.uart_type == 
 //                                                     uart_type;
 //                                                     env_cfg_h.device_cfg_h[i].tx_agent_config_h.oversampling_bits == 
 //                                                     oversampling_delay;
 //                                                     env_cfg_h.device_cfg_h[i].tx_agent_config_h.parity_scheme ==  
 //                                                     parity_type;
 //                                                   }) begin
 //     `uvm_fatal(get_type_name(),$sformatf("Randomization failed in rx test"))
 //   end
 // end
 // foreach(env_cfg_h.device_cfg_h[i]) begin
 //   if(! env_cfg_h.device_cfg_h[i].randomize() with { this.tx_agent_config_h.shift_dir == shift_dir;
 //                                                     this.tx_agent_config_h.uart_type ==
 //                                                     uart_type_var;
 //                                                     this.tx_agent_config_h.oversampling_bits == oversampling_delay;
 //                                                     this.tx_agent_config_h.parity_scheme == parity_type;
 //                                                     this.tx_agent_config_h.tx_baudrate_divisor
 //                                                     == env_cfg_h.device_cfg_h[i].get_baudrate_divisor(); 
 //                                                   }) begin
 //     `uvm_fatal(get_type_name(),$sformatf("Randomization failed in tx test"))
 //   end
 // end

  //foreach(env_cfg_h.device_cfg_h[i]) begin
  //   env_cfg_h.device_cfg_h[i].tx_agent_config_h.shift_dir         = shift_dir;
  //   env_cfg_h.device_cfg_h[i].tx_agent_config_h.uart_type         = uart_type;
  //   env_cfg_h.device_cfg_h[i].tx_agent_config_h.oversampling_bits = oversampling_delay;
  //   env_cfg_h.device_cfg_h[i].tx_agent_config_h.parity_scheme     = parity_type;
  //end

endfunction : setup_tx_agent_cfg

//--------------------------------------------------------------------------------------------
// Function: setup_rx_agent_cfg
// Setup the rx agent configuration with the required values
// and store the handle into the config_db
//--------------------------------------------------------------------------------------------
function void uart_fd_rand_test::setup_rx_agent_cfg();
  super.setup_rx_agent_cfg();
  
  if(!std::randomize(shift_dir))begin
    `uvm_error("test",$sformatf("randomization  of dir failed"))
  end

  if(!std::randomize(oversampling_delay) with {oversampling_delay !=
                                               oversampling_e'(OVERSAMPLING_ZERO);
                                             })begin
    `uvm_error("test",$sformatf("randomization  of oversampling delay failed"))
  end

  if(!std::randomize(uart_type_var) with {uart_type_var != uart_type_e'(UART_TYPE_NO_TRANSFER);})begin
    `uvm_error("test",$sformatf("randomization  of uart_type failed"))
  end

  if(!std::randomize(parity_type))begin
    `uvm_error("test",$sformatf("randomization  of parity_type failed"))
  end

  `uvm_info("master_random_cfg_mode",$sformatf("rand_test_uart_type =  \n %0p",uart_type_var),UVM_FULL)
  `uvm_info("master_random_cfg_mode",$sformatf("rand_test_shift_dir =  \n %0p",shift_dir),UVM_FULL)
  `uvm_info("master_random_cfg_mode",$sformatf("rand_test_parity_type =  \n %0p",parity_type),UVM_FULL)
  `uvm_info("master_random_cfg_mode",$sformatf("rand_tes_delay =  \n %0p",oversampling_delay),UVM_FULL)
  
 // foreach(env_cfg_h.device_cfg_h[i]) begin
 //   if(! env_cfg_h.device_cfg_h[i].randomize() with { this.rx_agent_config_h.shift_dir == shift_dir;
 //                                                     this.rx_agent_config_h.uart_type == uart_type;
 //                                                     this.rx_agent_config_h.oversampling_bits == oversampling_delay;
 //                                                     this.rx_agent_config_h.parity_scheme == parity_type;
 //                                                     this.rx_agent_config_h.rx_baudrate_divisor
 //                                                     == env_cfg_h.device_cfg_h[i].get_baudrate_divisor(); 
 //                                                   }) begin
 //     `uvm_fatal(get_type_name(),$sformatf("Randomization failed in tx test"))
 //   end
 // end

  foreach(env_cfg_h.device_cfg_h[i]) begin
    if(! env_cfg_h.device_cfg_h[i].rx_agent_config_h.randomize() with { this.shift_dir == shift_dir;
                                                                        this.oversampling_bits == oversampling_delay;
                                                                        this.parity_scheme == parity_type;
                                                                        this.uart_type ==
                                                                        uart_type_var;
                                                    }) begin
      `uvm_fatal(get_type_name(),$sformatf("Randomization failed in rx test"))
    end
  end

 // foreach(env_cfg_h.device_cfg_h[i]) begin
 //   if(! env_cfg_h.device_cfg_h[i].randomize() with { env_cfg_h.device_cfg_h[i].rx_agent_config_h.shift_dir == 
 //                                                     shift_dir;
 //                                                     env_cfg_h.device_cfg_h[i].rx_agent_config_h.uart_type == 
 //                                                     uart_type;
 //                                                     env_cfg_h.device_cfg_h[i].rx_agent_config_h.oversampling_bits == 
 //                                                     oversampling_delay;
 //                                                     env_cfg_h.device_cfg_h[i].rx_agent_config_h.parity_scheme ==  
 //                                                     parity_type;
 //                                                   }) begin
 //     `uvm_fatal(get_type_name(),$sformatf("Randomization failed in rx test"))
 //   end
 // end
endfunction : setup_rx_agent_cfg


`endif

