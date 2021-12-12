`ifndef TX_MONITOR_BFM_INCLUDED_
`define TX_MONITOR_BFM_INCLUDED_

//--------------------------------------------------------------------------------------------
// Inteface : tx Monitor BFM
// Connects the tx monitor bfm with the monitor proxy
//--------------------------------------------------------------------------------------------

import uart_globals_pkg::*;

interface tx_monitor_bfm( input pclk, 
                          input areset,  
                          input tx
                        );
  bit bclk;
  bit frame_error;
  bit parity_error;
  bit [3:0] uart_bit_counter;
  bit break_error;

//  tx_agent_config tx_agent_cfg_h;

  string name = "UART_TX_MONITOR_BFM";

  // Used for holding the UART transfer state
  uart_fsm_state_e state;

  bit end_of_transfer;
  //-------------------------------------------------------
  //Package : Importing UVM package
  //-------------------------------------------------------
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  //-------------------------------------------------------
  //Import the tx_monitor_proxy
  //-------------------------------------------------------
  import tx_pkg::tx_monitor_proxy;
  
  //Variable : tx_mon_proxy_h
  //Creating the handle for proxy driver
  tx_monitor_proxy tx_mon_proxy_h;
  
  initial
  begin
    $display("tx Monitor BFM");
  end

  //-------------------------------------------------------
  // Task: wait_for_system_reset
  // Waiting for system reset to be active
  //-------------------------------------------------------
  task wait_for_system_reset();
    @(negedge areset);
    `uvm_info("TX_MONITOR_BFM", $sformatf("System reset detected"), UVM_HIGH);
    @(posedge areset);
    `uvm_info("TX_MONITOR_BFM", $sformatf("System reset deactivated"), UVM_HIGH);
  endtask: wait_for_system_reset


  //-------------------------------------------------------
  // Task: wait_for_idle_state
  // Waits for the IDLE condition on uart interface
  //-------------------------------------------------------
  task wait_for_idle_state();
    @(negedge pclk);
    while (tx !== 'b1) begin
      @(negedge pclk);
    end
    `uvm_info(name, $sformatf("IDLE condition has been detected"), UVM_NONE);
  endtask: wait_for_idle_state

  //-------------------------------------------------------
  // Task: gen_bclk
  // Used for generating the bclk with regards to baudrate 
  //-------------------------------------------------------
  task gen_bclk(input int baudrate_divisor);
   // @(posedge pclk);
    forever begin
      repeat(baudrate_divisor - 1) begin
        @(posedge pclk);
        bclk = ~bclk;
      end
    end
  endtask: gen_bclk
  
  //-------------------------------------------------------
  // Task: wait_for_transfer_start
  // Waits for the start to be active-low
  //-------------------------------------------------------
  task wait_for_transfer_start();

    bit [1:0]tx_local;

    // Detect the falling edge on tx0
    do begin
      @(negedge pclk);
      tx_local = {tx,tx_local[0]};
    end while(tx_local != NEGEDGE);

    `uvm_info(name, $sformatf("Transfer start is detected"), UVM_NONE);
  endtask: wait_for_transfer_start

  //-------------------------------------------------------
  // Task: sample_data
  // Used for sampling the tx 
  //-------------------------------------------------------
  task sample_data(inout uart_transfer_char_s data_packet, input uart_transfer_cfg_s cfg_pkt);
    
    bit bit_clock_divisor;
    //int row_no;

    @(negedge pclk);
 
 // for(int row_no=0; row_no < data_packet.no_of_tx_elements; row_no++) begin
 
    bit_clock_divisor = cfg_pkt.oversampling_bits*cfg_pkt.baudrate_divisor;

    `uvm_info(name, $sformatf("in sample data"), UVM_NONE)
    `uvm_info(name,$sformatf("dt pkt = \n %p",data_packet.no_of_tx_bits_transfer),UVM_LOW) 
    
    for(int k=0, bit_no=0; k<data_packet.no_of_tx_bits_transfer; k++) begin
     
     `uvm_info(name, $sformatf("in sample data for loop"), UVM_NONE)
    
    // Logic for MSB first or LSB first 
    bit_no = cfg_pkt.msb_first ? ((data_packet.no_of_tx_bits_transfer- 1) - k) : k;


   // oversampling_period for each bit
   repeat((bit_clock_divisor/2)-1) begin
     @(negedge pclk);
   end
   
   data_packet.tx[bit_no] = tx;
   state = uart_fsm_state_e'(bit_no);
   `uvm_info("DEBUG_MSHA", $sformatf("sample_uart_packet state = %0s and state = %0d",
                                      state.name(), state), UVM_NONE)

   uart_bit_counter++;
   `uvm_info(name, $sformatf("end of loop"), UVM_NONE)
  end

  `uvm_info(name, $sformatf("begins parity"), UVM_NONE)
    //oversampling_period for each bit
    repeat((bit_clock_divisor/2)-1) begin
      @(negedge pclk);
    end

    data_packet.tx=tx;
    state = PARITY;
    `uvm_info("DEBUG_MSHA", $sformatf("sample_uart_packet state = %0s and state = %0d",
                                      state.name(), state), UVM_NONE)
  //task to detect parity error
  parity_checking(data_packet,cfg_pkt);
 
  // stop bit detection
  if(uart_bit_counter+1 == cfg_pkt.uart_type+1) begin
    do begin
      @(negedge pclk);
    end while(tx!=1);
    
    `uvm_info(name,$sformatf("stop condition detected"),UVM_NONE) 
    state = STOP;
  end

  framing_checks(cfg_pkt);

  endtask: sample_data

task parity_checking(uart_transfer_char_s data_packet,uart_transfer_cfg_s cfg_pkt);
  
  //bit parity_bit_local;
  bit parity_check;

  //checking for parity error
  //parity_bit_local=parity_e'(cfg_pkt.parity_scheme);

  if(cfg_pkt.parity_scheme==EVEN_PARITY)begin
     foreach(data_packet.tx[i]) begin
       parity_check=^(data_packet.tx[i]);
     end

     parity_error=parity_check?0:1;
   end

     else begin
       foreach(data_packet.tx[i]) begin
         parity_check=~(^data_packet.tx[i]);
       end

     parity_error=parity_check?1:0;
   end

 endtask: parity_checking

 task framing_checks(uart_transfer_cfg_s cfg_pkt);
   
   bit[3:0]uart_type_check;
   bit tx_local;
   
   uart_type_check=uart_type_e'(cfg_pkt.uart_type);
    
    if(uart_bit_counter+1 == uart_type_check+1)begin
      tx_local = 1;
    end
    else begin
      tx_local = 0;
    end

    frame_error = tx_local ? 0 : 1;

     // data_packet.tx=tx;
      if(frame_error == 0)begin
        `uvm_info(name, $sformatf("frame error is not  detected"),UVM_FULL);
      end
      else begin
        `uvm_info(name, $sformatf("frame error is detected"),UVM_FULL);
      end
 endtask: framing_checks

// task break_condition_check();

// endtask:break_condition_check
endinterface : tx_monitor_bfm

`endif
