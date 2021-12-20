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
   covergroup tx_covergroup with function sample(tx_agent_config tx_agent_cfg_h, tx_xtn tx_data);
     option.per_instance = 1;

    // START_BIT_CP : coverpoint packet.start_bit {
      // option.comment = "start bit";
       //bins START_BIT[] = {[0:1]}
     //}

     STOP_BIT_CP : coverpoint stop_bit_e'(tx_agent_cfg_h.stop_bit_duration) {
       option.comment = "stop bit";
       bins STOP_BIT_ONEBIT = {1};
       bins STOP_BIT_ONEHALF = {2};
       bins STOP_BIT_TWOBIT = {3};

     }

     PARITY_CP : coverpoint parity_e'(tx_agent_cfg_h.parity_scheme) {
       option.comment = "parity bit UART.EVEN and ODD";
       bins EVEN_PARITY = {0};
       bins ODD_PARITY  =  {1};
     }
     
     // direction = shift_direction_e'(cfg.on voidi_mode); 
     SHIFT_DIRECTION_CP : coverpoint shift_direction_e'(tx_agent_cfg_h.shift_dir) {
       option.comment = "Shift direction UART. MSB and LSB";
       bins LSB_FIRST = {0};
       bins MSB_FIRST = {1};
     }

     UART_TYPE_DATA_CP : coverpoint uart_type_e'(tx_agent_cfg_h.uart_type) {
      option.comment = "Data size of the packet transfer";
      bins TRANSFER_5BIT = {5};
      bins TRANSFER_6BIT = {6};
      bins TRANSFER_7BIT = {7};
      bins TRANSFER_8BIT = {8};
      bins TRANSFER_MANY_BITS = {[9:64]};
    } 
    
    BAUD_RATE_CP : coverpoint (tx_agent_cfg_h.tx_baudrate_divisor) {
      option.comment = "it control the rate of transfer in communication channel";
     
      bins BAUDRATE_DIVISOR_1 = {2}; 
      bins BAUDRATE_DIVISOR_2 = {4}; 
      bins BAUDRATE_DIVISOR_3 = {6}; 
      bins BAUDRATE_DIVISOR_4 = {8}; 
      bins BAUDRATE_DIVISOR_5 = {[10:$]}; 

       illegal_bins illegal_bin = {0};
     }

    OVERSAMPLING_CP : coverpoint oversampling_e'(tx_agent_cfg_h.oversampling_bits) {
      option.comment = "it check for how many clock cycles the single bit remains stable";
      bins OVERSAMPLING_TWO = {2};
      bins OVERSAMPLING_FOUR = {4};
      bins OVERSAMPLING_SIX = {6};
      bins OVERSAMPLING_EIGHT = {8};
      bins OVERSAMPLING_MANY_BITS = {[16:$]};
    }

    //cross of the data transfer with shift direction
    UART_TYPE_DATA_CP_X_SHIFT_DIRECTIO_CP : cross UART_TYPE_DATA_CP,SHIFT_DIRECTION_CP;

    //cross of the data transfer with stop bits
    UART_TYPE_DATA_CP_X_STOP_BIT_CP : cross UART_TYPE_DATA_CP,STOP_BIT_CP;

    //cross of the data transfer with parity bit
    UART_TYPE_DATA_CP_X_PARITY_BIT_CP : cross UART_TYPE_DATA_CP,PARITY_CP;

    //cross of the data transfer with baudrate divisor
    UART_TYPE_DATA_CP_X_BAUD_RATE_CP : cross UART_TYPE_DATA_CP,BAUD_RATE_CP;

    //cross of the data transfer with shift direction and baudrate divisor
    UART_TYPE_DATA_CP_X_SHIFT_DIRECTION_CP_X_BAUD_RATE_CP : cross
    UART_TYPE_DATA_CP,SHIFT_DIRECTION_CP,BAUD_RATE_CP;

  endgroup : tx_covergroup

 //-------------------------------------------------------
 //Externally defined Tasks and functions
 //-------------------------------------------------------
 extern function new(string name = "tx_coverage", uvm_component parent = null);
 extern virtual function void write(tx_xtn t);
 //extern virtual function void report_phase(uvm_phase phase);

 endclass : tx_coverage

 //--------------------------------------------------------------------------------------------
 //Construct: new
 //Parameters:
 // name -  tx_coverage
 // parent - parent under which this component is crested
 //--------------------------------------------------------------------------------------------
function tx_coverage::new(string name = "tx_coverage", uvm_component parent = null);
  super.new(name,parent);
  tx_covergroup=new();
endfunction : new

//--------------------------------------------------------------------------------------------
//Function : write
//sampling is done
//--------------------------------------------------------------------------------------------
function void tx_coverage::write(tx_xtn t);
  //`uvm_info("
    tx_covergroup.sample(tx_agent_cfg_h,t);     
  endfunction : write 


`endif

