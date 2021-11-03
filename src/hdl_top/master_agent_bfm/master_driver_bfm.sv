//--------------------------------------------------------------------------------------------
// Interface : UART_master_driver_bfm
//  Used as the HDL driver for UART
//  It connects with the HVL driver_proxy for driving the stimulus
//
// Parameters:
//  intf - UART Interface
//--------------------------------------------------------------------------------------------
interface master_driver_bfm(uart_if intf);

virtual uart_if vif;

  //-------------------------------------------------------
  // Creating the handle for proxy driver
  //-------------------------------------------------------
  import uart_master_pkg::master_driver_proxy;

  master_driver_proxy master_drv_proxy;


initial 
  begin
    $display("Master driver BFM");
  end

endinterface : master_driver_bfm

