`ifndef RX_COVERAGE_INCLUDED_
`define RX_COVERAGE_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: rx_coverage
// Description:
// Class for coverage report for UART
//--------------------------------------------------------------------------------------------
class rx_coverage extends uvm_subscriber#(rx_xtn);
  `uvm_component_utils(rx_coverage)

  // Variable: rx_agent_cfg_h
  // Declaring handle for rx agent configuration class 
  rx_agent_config rx_agent_cfg_h;
  //rx_xtn rx_data;

  //-------------------------------------------------------
  // Covergroup
  // Covergroup consists of the various coverpoints based on the no. of the variables used to improve the coverage.
  //-------------------------------------------------------
  covergroup rx_covergroup with function sample (rx_agent_config rx_agent_cfg_h, rx_xtn rx_data);
  option.per_instance = 1;

     //STOP_BIT_CP : coverpoint stop_bit_e'(rx_agent_cfg_h.stop_bit_duration) {
       //option.comment = "stop bit";
       //bins STOP_BIT_ONEBIT = {1};
       //bins STOP_BIT_ONEHALF = {2};
       //bins STOP_BIT_TWOBIT = {3};

     //}

     PARITY_CP : coverpoint parity_e'(rx_agent_cfg_h.parity_scheme) {
       option.comment = "parity bit UART.EVEN and ODD";
       bins EVEN_PARITY = {0};
       bins ODD_PARITY  =  {1};
     }
     
     // direction = shift_direction_e'(cfg.on voidi_mode); 
     SHIFT_DIRECTION_CP : coverpoint shift_direction_e'(rx_agent_cfg_h.shift_dir) {
       option.comment = "Shift direction UART. MSB and LSB";
       bins LSB_FIRST = {0};
       bins MSB_FIRST = {1};
     }

     UART_TYPE_DATA_CP : coverpoint uart_type_e'(rx_agent_cfg_h.uart_type) {
      option.comment = "Data size of the packet transfer";
      bins TRANSFER_5BIT = {5};
      bins TRANSFER_6BIT = {6};
      bins TRANSFER_7BIT = {7};
      bins TRANSFER_8BIT = {8};
    //  bins TRANSFER_MANY_BITS = {[16:$]};
    } 
    
    BAUD_RATE_CP : coverpoint (rx_agent_cfg_h.rx_baudrate_divisor) {
      option.comment = "it control the rate of transfer in communication channel";
     
      bins BAUDRATE_DIVISOR_1 = {2}; 
      bins BAUDRATE_DIVISOR_2 = {4}; 
      bins BAUDRATE_DIVISOR_3 = {6}; 
      bins BAUDRATE_DIVISOR_4 = {8}; 
      bins BAUDRATE_DIVISOR_5 = {[10:$]}; 

       illegal_bins illegal_bin = {0};
     }

    OVERSAMPLING_CP : coverpoint oversampling_e'(rx_agent_cfg_h.oversampling_bits) {
      option.comment = "it check for how many clock cycles the single bit remains stable";
      bins OVERSAMPLING_TWO = {2};
      bins OVERSAMPLING_FOUR = {4};
      bins OVERSAMPLING_SIX = {6};
      bins OVERSAMPLING_EIGHT = {8};
     // bins OVERSAMPLING_MANY_BITS = {[16:$]};
    }
  endgroup : rx_covergroup

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "rx_coverage", uvm_component parent = null);
  //extern virtual function void build_phase(uvm_phase phase);
  //extern virtual function void connect_phase(uvm_phase phase);
  //extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual function void write(rx_xtn t);
  extern virtual function void report_phase(uvm_phase phase);
  //extern virtual task run_phase(uvm_phase phase);
  //extern virtual function void write(rx_xtn t);

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
   rx_covergroup = new(); 
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: write
// To acess the subscriber write function is required with default parameter as t
//--------------------------------------------------------------------------------------------
function void rx_coverage::write(rx_xtn t);
  `uvm_info(get_type_name()," RX COVERAGE",UVM_LOW);
    rx_covergroup.sample(rx_agent_cfg_h,t);     
endfunction: write

//--------------------------------------------------------------------------------------------
// Function: report_phase
// Used for reporting the coverage instance percentage values
//--------------------------------------------------------------------------------------------
function void rx_coverage::report_phase(uvm_phase phase);
  `uvm_info(get_type_name(), $sformatf("rx Agent Coverage = %0.2f %%",
                                       rx_covergroup.get_coverage()), UVM_NONE);
endfunction: report_phase
`endif

