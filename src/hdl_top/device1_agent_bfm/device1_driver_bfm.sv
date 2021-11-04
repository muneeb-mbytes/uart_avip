`ifndef DEVICE1_DRIVER_BFM_INCLUDED_
`define DEVICE1_DRIVER_BFM_INCLUDED_


//--------------------------------------------------------------------------------------------
// Interface : device1_driver_bfm
//  Used as the HDL driver for UART
//  It connects with the HVL driver_proxy for driving the stimulus
//
// Parameters:
//  intf - UART Interface
//--------------------------------------------------------------------------------------------
//interface device1_driver_bfm(uart_if drv_intf, uart_if.MON_MP mon_intf);
interface device1_driver_bfm(uart_if intf);

  //-------------------------------------------------------
  // Creating the handle for proxy driver
  //-------------------------------------------------------
  import uart_device1_pkg::device1_driver_proxy;
  device1_driver_proxy device1_drv_proxy_h;

  initial begin
    $display("device1 Driver BFM");
  end

endinterface : device1_driver_bfm

`endif
