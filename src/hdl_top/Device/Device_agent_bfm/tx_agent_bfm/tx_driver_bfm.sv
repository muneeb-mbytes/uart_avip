`ifndef TX_DRIVER_BFM_INCLUDED_
`define TX_DRIVER_BFM_INCLUDED_

//--------------------------------------------------------------------------------------------
// Interface : UART_tx_driver_bfm
//  Used as the HDL driver for UART
//  It connects with the HVL driver_proxy for driving the stimulus
//
// Parameters:
//  intf - UART Interface
//--------------------------------------------------------------------------------------------
import uart_globals_pkg::*;

interface tx_driver_bfm(input pclk, input areset, 
                         output reg bclk,   
                         output reg Tx0, Tx1, Tx2, Tx3
                       );
  
  //Declare interface handle  
  //virtual uart_if vif;
  
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
  task wait_for_reset_drive_idle_state();
    @(negedge areset);
    `uvm_info("DEVICE0_DRIVER_BFM", $sformatf("System reset detected"), UVM_HIGH);
    `uvm_info("DEVICE0_DRIVER_BFM", $sformatf("Driving the IDLE state"), UVM_HIGH);
    Tx0 = 1;
    @(posedge areset);
    `uvm_info("DEVICE0_DRIVER_BFM", $sformatf("System reset deactivated"), UVM_HIGH);
  endtask: wait_for_reset_drive_idle_state

  //-------------------------------------------------------
  // Task: gen_bclk
  // Used for generating the bclk with regards to baudrate 
  //-------------------------------------------------------
  task gen_bclk(uart_transfer_cfg_s pkt);
    bclk <= pclk;
    @(posedge pclk);
    bclk <= ~bclk;
    
    repeat(pkt.baudrate_divisor - 1) begin
      @(posedge pclk);
      bclk <= ~bclk;
    end
  
  endtask: gen_bclk

  //-------------------------------------------------------
  // Task: drive_data_pos_edge
  //-------------------------------------------------------
  task drive_data_pos_edge(inout uart_transfer_char_s data_packet, 
                                input uart_transfer_cfg_s cfg_pkt); 
  @(posedge pclk);

  Tx0 <= START_BIT;  

  repeat(cfg_pkt.baudrate_divisor-1) begin
    @(posedge pclk);
  end
  
  for(int row_no=0; row_no < data_packet.no_of_tx_bits_transfer/CHAR_LENGTH; row_no++) begin
    for(int k=0, bit_no=0; k<CHAR_LENGTH; k++) begin
      
      // Logic for MSB first or LSB first 
      bit_no = cfg_pkt.msb_first ? ((CHAR_LENGTH - 1) - k) : k;
      @(posedge pclk);
      Tx0 <= data_packet.tx[row_no][bit_no];

      // oversampling_period for each bit
      repeat((cfg_pkt.oversampling_bits*cfg_pkt.baudrate_divisor)-1) begin
        @(posedge pclk);
      end
    end
  end
  
  // Driving Parity Bit
  @(posedge pclk);
  Tx0 <= data_packet.parity_bit;
  
  repeat(cfg_pkt.baudrate_divisor-1) begin
    @(posedge pclk);
  end
  
  //stop_bit = stop_bit_e'(stop_bit.STOP_BIT_ONEBIT);
  @(posedge pclk);
  Tx0 <= cfg_pkt.stop_bit;
  
  repeat(cfg_pkt.baudrate_divisor-1) begin
    @(posedge pclk);
  end

endtask
  
  

endinterface : tx_driver_bfm

`endif
