`ifndef TX_DRIVER_BFM_INCLUDED_
`define TX_DRIVER_BFM_INCLUDED_

//--------------------------------------------------------------------------------------------
// Interface : UART_TX_DRIVER_BFM
//  Used as the HDL driver for UART
//  It connects with the HVL driver_proxy for driving the stimulus
//
// Parameters:
//  intf - UART Interface
//--------------------------------------------------------------------------------------------
import uart_globals_pkg::*;

interface tx_driver_bfm(input pclk, input areset, 
                         output reg tx
                       );
  
  //Declare interface handle  
  //virtual uart_if vif;
  
  bit bclk;
  bit osclk;
  string name = "UART_TX_DRIVER_BFM";

  // Used for holding the UART transfer state
  uart_fsm_state_e state;

  //-------------------------------------------------------
  //package : Importing UVM pacakges
  //-------------------------------------------------------
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  //-------------------------------------------------------
  // Creating the handle for proxy driver
  //-------------------------------------------------------
  import tx_pkg::tx_driver_proxy;

  tx_driver_proxy tx_drv_proxy_h;
  
  initial 
  begin
    $display("tx driver BFM");
  end

  //-------------------------------------------------------
  // Task: wait_for_reset
  // Waiting for system reset to be active
  //-------------------------------------------------------
  task wait_for_reset();
    state = state.first();
    //`uvm_info("DEBUG_MSHA", $sformatf("drive_idle_state state = %0s and state = %0d",
                                      //state.name(), state), UVM_NONE)
    @(negedge areset);
    `uvm_info(name, $sformatf("System reset detected"), UVM_HIGH);
    @(posedge areset);
    `uvm_info(name, $sformatf("System reset de-assertion detected"), UVM_HIGH);
  endtask: wait_for_reset

  //-------------------------------------------------------
  // Task: drive_idle_state
  // Driving the TX lane to be logc 1 for IDLE condition 
  //-------------------------------------------------------
  task drive_idle_state(int no_of_idle_clks = 2);
    @(posedge pclk);
    `uvm_info(name, $sformatf("Driving the IDLE state"), UVM_HIGH);
    tx <= 1;
    state = IDLE;
    `uvm_info("DEBUG_MSHA", $sformatf("drive_idle_state state = %0s and state = %0d",
                                      state.name(), state), UVM_NONE)
    `uvm_info(name, $sformatf("IDLE state Completed"), UVM_HIGH);

    repeat(no_of_idle_clks - 1) begin
      @(posedge pclk);
    end
    
  endtask: drive_idle_state


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
  // Task: gen_oclk
  // Used for generating the oclk with regards to baudrate 
  //-------------------------------------------------------
  task gen_ov_samp_clk(input int baudrate_divisor,int oversampling_bits);
    `uvm_info("DEBUG_MSHA", $sformatf("oversampling_bits = %0d",
                                     oversampling_bits), UVM_NONE)
    `uvm_info("DEBUG_MSHA", $sformatf(" baudrate_divisor= %0d",
                                     baudrate_divisor), UVM_NONE)

    forever begin
      repeat((baudrate_divisor*oversampling_bits) ) begin
        @(posedge bclk);
        osclk = ~osclk;
      end
    end
  endtask: gen_ov_samp_clk

  //-------------------------------------------------------
  // Task: drive_uart_packet
  // Driving the UART packet on to the TX lane(s)
  //-------------------------------------------------------
  task drive_uart_packet(inout uart_transfer_char_s data_packet,
                         input uart_transfer_cfg_s cfg_pkt);

  int bit_clock_divisor;

  @(posedge pclk);

  // Derving the bit clock divisor
  bit_clock_divisor = cfg_pkt.oversampling_bits*cfg_pkt.baudrate_divisor;

  // Driving an array of UART packets
  for(int row_no=0; row_no < data_packet.no_of_tx_data_elements; row_no++) begin
    
    // Driving the start condition
    tx <= START_BIT;
    state = START;
    `uvm_info("DEBUG_MSHA", $sformatf("drive_uart_packet state = %0s and state = %0d",
                                      state.name(), state), UVM_NONE)

    repeat(bit_clock_divisor-1) begin
      @(posedge pclk);
    end
    
    // Driving data payload and parity bit
    for(int k=0, bit_no=0; k<data_packet.no_of_tx_data_bits_transfer; k++) begin
      
      // Logic for MSB first or LSB first 
      bit_no = cfg_pkt.msb_first ? ((data_packet.no_of_tx_data_bits_transfer - 1) - k) : k;

      @(posedge pclk);
      tx <= data_packet.tx[row_no][bit_no];
      state = uart_fsm_state_e'(bit_no);
      `uvm_info("DEBUG_MSHA", $sformatf("drive_uart_packet state = %0s and state = %0d",
                                      state.name(), state), UVM_NONE)

      // oversampling_period for each bit
      repeat(bit_clock_divisor-1) begin
        @(posedge pclk);
      end
    end

    //Driving Parity bit 
    @(posedge pclk);
    tx <= data_packet.parity_bit;
    state = PARITY;
    
    `uvm_info("DEBUG_MSHA", $sformatf("drive_uart_packet state = %0s and state = %0d",
                                      state.name(), state), UVM_NONE)

    repeat(bit_clock_divisor-1) begin
      @(posedge pclk);
    end
    
    // Driving the STOP bit
    // // TODO(mshariff): Need to add logic for STOP_1_5 and STOP_2
    @(posedge pclk);
    tx <= cfg_pkt.stop_bit;
    state = STOP_1BIT;
    `uvm_info("DEBUG_MSHA", $sformatf("drive_uart_packet state = %0s and state = %0d",
                                      state.name(), state), UVM_NONE)
    
    repeat((bit_clock_divisor*cfg_pkt.baudrate_divisor)) begin
      @(posedge pclk);
    end
  end

endtask: drive_uart_packet
  
  //// Driving Parity Bit
  //@(posedge pclk);
  //tx0 <= data_packet.parity_bit;
  //
  //repeat(cfg_pkt.baudrate_divisor-1) begin
  //  @(posedge pclk);
  //end
  
  //stop_bit = stop_bit_e'(stop_bit.STOP_BIT_ONEBIT);
  
  
endinterface : tx_driver_bfm

`endif
