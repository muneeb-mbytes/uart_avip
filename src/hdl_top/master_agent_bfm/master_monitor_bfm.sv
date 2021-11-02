//--------------------------------------------------------------------------------------------
// Inteface : Slave Monitor BFM
// Connects the slave monitor bfm with the monitor proxy
//--------------------------------------------------------------------------------------------
interface master_monitor_bfm(uart_if intf);
  
  import uart_master_pkg::master_monitor_proxy;
  
  //Variable : master_mon_proxy_h
  //Creating the handle for proxy driver
  master_monitor_proxy master_mon_proxy_h;

  initial
  begin
    $display("Master Monitor BFM");
  end

endinterface : master_monitor_bfm
