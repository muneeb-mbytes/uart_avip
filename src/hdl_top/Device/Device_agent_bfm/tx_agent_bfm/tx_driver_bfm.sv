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

interface tx_driver_bfm(uart_if intf);
  
  //Declare interface handle  
  virtual uart_if vif;
  
  //-------------------------------------------------------
  //package : Importing UVM pacakges
  //-------------------------------------------------------
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  //-------------------------------------------------------
  // Creating the handle for proxy driver
  //-------------------------------------------------------
  import tx_pkg::tx_driver_proxy;
  tx_driver_proxy tx_drv_proxy;
  
  initial 
  begin
    $display("tx driver BFM");
  end

endinterface : tx_driver_bfm

`endif
