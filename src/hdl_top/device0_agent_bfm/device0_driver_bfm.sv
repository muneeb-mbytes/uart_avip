//--------------------------------------------------------------------------------------------
// Interface : UART_device0_driver_bfm
//  Used as the HDL driver for UART
//  It connects with the HVL driver_proxy for driving the stimulus
//
// Parameters:
//  intf - UART Interface
//--------------------------------------------------------------------------------------------
interface device0_driver_bfm(uart_if intf);

virtual uart_if vif;

  //-------------------------------------------------------
  // Creating the handle for proxy driver
  //-------------------------------------------------------
  import uart_device0_pkg::device0_driver_proxy;

  device0_driver_proxy device0_drv_proxy;


initial 
  begin
    $display("device0 driver BFM");
  end

endinterface : device0_driver_bfm

