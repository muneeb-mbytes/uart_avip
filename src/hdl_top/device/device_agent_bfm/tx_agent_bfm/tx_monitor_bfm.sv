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
  bit break_error;

//  tx_agent_config tx_agent_cfg_h;

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
    `uvm_info("TX_MONITOR_BFM", $sformatf("IDLE condition has been detected"), UVM_NONE);
  endtask: wait_for_idle_state

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

    `uvm_info("TX_MONITOR_BFM", $sformatf("Transfer start is detected"), UVM_NONE);
  endtask: wait_for_transfer_start

  //-------------------------------------------------------
  // Task: detect_bclk
  // Detects the edge on bclk with regards to pclk
  //-------------------------------------------------------
  task detect_bclk();
    
    bit [1:0] bclk_local;
    bit [1:0] tx_local;
    edge_detect_e bclk_edge_value;

    // Detect the edge on BCLK
    do begin

      @(negedge pclk);
      bclk_local = {bclk_local[0],bclk};
      end_of_transfer = 0;

      // Stop the transfer when the start bit is active-high
      tx_local = {tx_local[0],tx};
      if(tx_local == POSEDGE) begin
        `uvm_info("TX_MONITOR_BFM", $sformatf("End of Transfer Detected"), UVM_NONE);
        end_of_transfer = 1;
        return;
      end

    end while(! ((bclk_local == POSEDGE) || (bclk_local == NEGEDGE)) );

    bclk_edge_value = edge_detect_e'(bclk_local);
    `uvm_info("MASTER_MONITOR_BFM", $sformatf("SCLK %s detected", bclk_edge_value.name()),UVM_FULL);
  endtask: detect_bclk


  //-------------------------------------------------------
  // Task: sample_data
  // Used for sampling the tx 
  //-------------------------------------------------------
  task sample_data(output uart_transfer_char_s data_packet, input uart_transfer_cfg_s cfg_pkt);
    bit[4:0]counter;
    bit parity_bit_local;
    bit[3:0]uart_type_check;
 
    //data_packet.tx=tx;
    // Sampling of TX data
    // with respect to BCLK
    //
    // This loop is forever because the monitor will continue to operate 
    // till the start_bit is active-low
    forever begin
     
    data_packet.tx=tx;
 // for(int row_no=0; row_no < data_packet.no_of_tx_elements; row_no++) begin
   for(int k=0, bit_no=0; k<=data_packet.no_of_tx_bits_transfer; k++) begin
 
    // Logic for MSB first or LSB first 
    bit_no = cfg_pkt.msb_first ? ((data_packet.no_of_tx_bits_transfer- 1) - k) : k;


      // First edge is used for driving
      detect_bclk();
      if(end_of_transfer) break; 

      // Second edge is used for sampling
      detect_bclk();
      if(end_of_transfer) break; 

   // oversampling_period for each bit
   repeat((cfg_pkt.oversampling_bits*cfg_pkt.baudrate_divisor)/2) begin
     @(negedge pclk);
   end
      data_packet.tx[bit_no] = tx;
      counter++;
    end

         //parity_bit_local=parity_e'(cfg_pkt.parity_scheme);
        if(parity_bit_local==EVEN_PARITY)begin
         foreach(data_packet.tx[i]) begin
            if(($countones(data_packet.tx)%2)!==0) begin
              parity_error = 1;
              `uvm_info("TX_MONITOR_BFM", $sformatf("even parity error is detected"),UVM_FULL);
            end
            else begin
              parity_error = 0;
              `uvm_info("TX_MONITOR_BFM", $sformatf("even parity errror is not detected"),UVM_FULL);
            end
          end
        end
        
        else begin
          foreach(data_packet.tx[i]) begin
            if(($countones(data_packet.tx)%2)!==0) begin
              parity_error = 0;

              `uvm_info("TX_MONITOR_BFM", $sformatf("odd parity error is detected"),UVM_FULL);
            end
            else begin
              parity_error = 1;

              `uvm_info("TX_MONITOR_BFM", $sformatf("odd parity error is detected"),UVM_FULL);
            end
          end
        end

       uart_type_check=uart_type_e'(cfg_pkt.uart_type);

        if(counter==uart_type_check+1)begin
         data_packet.tx=tx;
         if(data_packet.tx==1)begin
           frame_error=0;

              `uvm_info("TX_MONITOR_BFM", $sformatf("frame error is not  detected"),UVM_FULL);
            end
            else begin
             frame_error=1;

              `uvm_info("TX_MONITOR_BFM", $sformatf("frame error is detected"),UVM_FULL);
           end
         end
         
         foreach(data_packet.tx[i])begin
           if(!$countones(data_packet.tx[i])==uart_type_check+2)begin
             break_error=1;

              `uvm_info("TX_MONITOR_BFM", $sformatf("break error is detected"),UVM_FULL);
            end
            else begin
               break_error=0;

              `uvm_info("TX_MONITOR_BFM", $sformatf("break error is not  detected"),UVM_FULL);
            end
             end
           end
   
  endtask: sample_data

endinterface : tx_monitor_bfm

`endif
