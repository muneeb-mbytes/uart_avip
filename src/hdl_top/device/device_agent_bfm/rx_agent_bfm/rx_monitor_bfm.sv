`ifndef RX_MONITOR_BFM_INCLUDED_
`define RX_MONITOR_BFM_INCLUDED_

//--------------------------------------------------------------------------------------------
// Inteface : RX Monitor BFM
// Connects the rx monitor bfm with the monitor proxy
//--------------------------------------------------------------------------------------------

import uart_globals_pkg::*;

interface rx_monitor_bfm( input pclk, 
                          input areset,  
                          input rx
                        );
  bit bclk;
  bit frame_error;
  bit parity_error;
  bit [3:0] uart_bit_counter;
  bit break_error;
  bit [2:0] break_counter = 7;
  
  string name = "UART_RX_MONITOR_BFM";

  // Used for holding the UART transfer state
  uart_fsm_state_e state;
  
  //  rx_agent_config rx_agent_cfg_h;

  bit end_of_transfer;
  //-------------------------------------------------------
  //Package : Importing UVM package
  //-------------------------------------------------------
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  //-------------------------------------------------------
  //Import the rx_monitor_proxy
  //-------------------------------------------------------
  import rx_pkg::rx_monitor_proxy;
  
  //Variable : rx_mon_proxy_h
  //Creating the handle for proxy driver
  rx_monitor_proxy rx_mon_proxy_h;
  
  initial
  begin
    $display("RX Monitor BFM");
  end

  //-------------------------------------------------------
  // Task: wait_for_system_reset
  // Waiting for system reset to be active
  //-------------------------------------------------------
  task wait_for_system_reset();
    state=IDLE;
    @(negedge areset);
    `uvm_info(name, $sformatf("System reset detected"), UVM_HIGH);
    @(posedge areset);
    `uvm_info(name, $sformatf("System reset deactivated"), UVM_HIGH);
  endtask: wait_for_system_reset


  //-------------------------------------------------------
  // Task: wait_for_idle_state
  // Waits for the IDLE condition on uart interface
  //-------------------------------------------------------
  task wait_for_idle_state();
  //   state = state.first();
    @(negedge pclk);
    while (rx !== 'b1) begin
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
    
    bit [1:0]rx_local;

    // Detect the falling edge on rx0
    do begin
      @(negedge pclk);
      rx_local = {rx_local[0],rx};
    end while(rx_local!= NEGEDGE);
    
    state = START;
    `uvm_info(name, $sformatf("Transfer start is detected"), UVM_NONE);
  endtask: wait_for_transfer_start  
  
  //-------------------------------------------------------
  // Task: sample_data
  // Used for sampling the rx 
  //-------------------------------------------------------
  task sample_data(inout uart_reciver_char_s data_packet, input uart_transfer_cfg_s cfg_pkt);
    int bit_clock_divisor; 
    int row_no;
    data_packet.no_of_rx_bits_transfer = 0;

    @(negedge pclk);

    // Derving the bit clock divisor
    
    bit_clock_divisor = cfg_pkt.oversampling_bits*cfg_pkt.baudrate_divisor;
    `uvm_info(name, $sformatf("in sample data"), UVM_NONE)
    `uvm_info(name,$sformatf("dt pkt = \n %p",data_packet.no_of_rx_bits_transfer),UVM_LOW)
    
    for(int k=0, bit_no=0; k<data_packet.no_of_rx_bits_transfer; k++) begin
      
      `uvm_info(name, $sformatf("in sample data for loop"), UVM_NONE)

      // Logic for MSB first or LSB first
      bit_no = cfg_pkt.msb_first ? ((data_packet.no_of_rx_bits_transfer- 1) - k) : k;
      
      //oversampling_period for each bit
      repeat((bit_clock_divisor/2)-1) begin
        @(negedge pclk);
      end
      data_packet.rx[row_no][bit_no] = rx;
      state = uart_fsm_state_e'(bit_no);
      `uvm_info("DEBUG_MSHA", $sformatf("sample_uart_packet state = %0s and state = %0d",
                                      state.name(), state), UVM_NONE)
      uart_bit_counter++;
      
      // data_packet.no_of_rx_bits_transfer=1;
      `uvm_info(name, $sformatf("end of loop"), UVM_NONE)
      //if($countones(data_packet.rx[bit_no]) begin
      //  break_counter--;
      //end
      end
      `uvm_info(name, $sformatf("begins parity"), UVM_NONE)
      //oversampling_period for each bit
      repeat((bit_clock_divisor/2)-1) begin
        @(negedge pclk);
      end
      data_packet.rx=rx;
      state = PARITY;
      
      `uvm_info("DEBUG_MSHA", $sformatf("sample_uart_packet state = %0s and state = %0d",
                                      state.name(), state), UVM_NONE)
      //task to detect parity error
      parity_checking(data_packet,cfg_pkt);
      
      // stop bit detection
      if(uart_bit_counter+1 == cfg_pkt.uart_type+1) begin
        do begin
          @(negedge pclk);
        end while(rx!=1);
        
        `uvm_info(name,$sformatf("stop condition detected"),UVM_NONE)
        state = STOP;
      end
      framing_checks(cfg_pkt);
    endtask : sample_data
  
  //--------------------------------------------------------------------------------------------
  //Task: parity checking
  //
  //checking for the parity error based on the parity scheme
  //--------------------------------------------------------------------------------------------
  task parity_checking(uart_reciver_char_s data_packet,uart_transfer_cfg_s cfg_pkt);
    
    //bit parity_bit_local;
    bit parity_check;
  
    //checking for parity error
    //parity_bit_local=parity_e'(cfg_pkt.parity_scheme);
  
    if(cfg_pkt.parity_scheme==EVEN_PARITY)begin
      foreach(data_packet.rx[i]) begin
        parity_check=^(data_packet.rx[i]);
      end
      parity_error=parity_check?0:1;
    end
    
    else begin
      foreach(data_packet.rx[i]) begin
        parity_check=~(^data_packet.rx[i]);
      end
      parity_error=parity_check?1:0;
    end
  endtask: parity_checking
  
  //--------------------------------------------------------------------------------------------
  //Task: framing check
  //
  //
  //--------------------------------------------------------------------------------------------
  task framing_checks(uart_transfer_cfg_s cfg_pkt);
    bit[3:0]uart_type_check;
    bit rx_local;
    uart_type_check=uart_type_e'(cfg_pkt.uart_type);
    if(uart_bit_counter+1 == uart_type_check+1)begin
      rx_local = 1;
    end
    else begin
      rx_local = 0;
    end
    
    frame_error = rx_local ? 0 : 1;
  
    // data_packet.rx=rx;
    if(frame_error == 0)begin
      `uvm_info(name, $sformatf("frame error is not  detected"),UVM_FULL);
    end
    else begin
      `uvm_info(name, $sformatf("frame error is detected"),UVM_FULL);
    end
  endtask: framing_checks

// task break_condition_check();

// endtask:break_condition_check



 
endinterface : rx_monitor_bfm

`endif 
