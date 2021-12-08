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
                         //output reg bclk,   
                         output reg tx0, tx1, tx2, tx3
                       );
  
  //Declare interface handle  
  //virtual uart_if vif;
  
  bit bclk;

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
    `uvm_info("TX0_DRIVER_BFM", $sformatf("System reset detected"), UVM_HIGH);
    `uvm_info("TX0_DRIVER_BFM", $sformatf("Driving the IDLE state"), UVM_HIGH);
    tx0 = 1;
    @(posedge areset);
    `uvm_info("Tx0_DRIVER_BFM", $sformatf("System reset deactivated"), UVM_HIGH);
  endtask: wait_for_reset_drive_idle_state

  //-------------------------------------------------------
  // Task: gen_bclk
  // Used for generating the bclk with regards to baudrate 
  //-------------------------------------------------------
  task gen_bclk(uart_transfer_cfg_s pkt);
    forever begin
      @(posedge pclk);
      
      repeat(pkt.baudrate_divisor - 1) begin
        @(posedge pclk);
        bclk <= ~bclk;
      end
    end
  endtask: gen_bclk

  //-------------------------------------------------------
  // Task: drive_data_pos_edge
  //-------------------------------------------------------
  task drive_data_pos_edge(inout uart_transfer_char_s data_packet, 
                                input uart_transfer_cfg_s cfg_pkt); 

  @(posedge pclk);
  tx0 <= START_BIT;  

  repeat(cfg_pkt.baudrate_divisor-1) begin
    @(posedge pclk);
  end
  
 // for(int row_no=0; row_no < data_packet.no_of_bits_transfer; row_no++) begin
    for(int k=0, bit_no=0; k<data_packet.no_of_tx_bits_transfer; k++) begin
      
      // Logic for MSB first or LSB first 
      bit_no = cfg_pkt.msb_first ? ((data_packet.no_of_tx_bits_transfer - 1) - k) : k;
      @(posedge pclk);
      tx0 <= data_packet.tx[bit_no];

      // oversampling_period for each bit
      repeat((cfg_pkt.oversampling_bits*cfg_pkt.baudrate_divisor)-1) begin
        @(posedge pclk);
      end
    end
  //end
  
  // Driving Parity Bit
  @(posedge pclk);
  tx0 <= data_packet.parity_bit;
  
  repeat(cfg_pkt.baudrate_divisor-1) begin
    @(posedge pclk);
  end
  
  //stop_bit = stop_bit_e'(stop_bit.STOP_BIT_ONEBIT);
  @(posedge pclk);
  tx0 <= cfg_pkt.stop_bit;
  
  repeat(cfg_pkt.baudrate_divisor-1) begin
    @(posedge pclk);
  end

endtask
  
endinterface : tx_driver_bfm

`endif
