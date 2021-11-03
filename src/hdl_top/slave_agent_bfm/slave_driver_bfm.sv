`ifndef SLAVE_DRIVER_BFM_INCLUDED_
`define SLAVE_DRIVER_BFM_INCLUDED_


//--------------------------------------------------------------------------------------------
// Interface : slave_driver_bfm
//  Used as the HDL driver for UART
//  It connects with the HVL driver_proxy for driving the stimulus
//
// Parameters:
//  intf - UART Interface
//--------------------------------------------------------------------------------------------
//interface slave_driver_bfm(uart_if drv_intf, uart_if.MON_MP mon_intf);
interface slave_driver_bfm(uart_if intf);

  //-------------------------------------------------------
  // Creating the handle for proxy driver
  //-------------------------------------------------------
  import uart_slave_pkg::slave_driver_proxy;
  slave_driver_proxy slave_drv_proxy_h;

  initial begin
    $display("Slave Driver BFM");
  end

endinterface : slave_driver_bfm

`endif
