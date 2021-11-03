`ifndef SLAVE_AGENT_BFM_INCLUDED_
`define SLAVE_AGENT_BFM_INCLUDED_

//--------------------------------------------------------------------------------------------
// Module      : Slave Agent BFM
// Description : Instantiates driver and monitor
//--------------------------------------------------------------------------------------------
module slave_agent_bfm(uart_if intf);
  
   import uvm_pkg::*;
  `include "uvm_macros.svh"

  initial begin
    $display("Slave Agent BFM");
  end

  //-------------------------------------------------------
  //Slave driver bfm instantiation
  //-------------------------------------------------------
  //slave_driver_bfm slave_driver_bfm_h (intf.SLV_DRV_MP, intf.MON_MP);
  //-------------------------------------------------------
  //apb slave driver bfm instantiation
  //-------------------------------------------------------
  slave_driver_bfm slave_drv_bfm_h(intf);

  //-------------------------------------------------------
  //apb slave monitor bfm instantiation
  //-------------------------------------------------------
  slave_monitor_bfm slave_mon_bfm_h(intf);
  

  //-------------------------------------------------------
  //Slave driver bfm instantiation
  //-------------------------------------------------------
 // slave_monitor_bfm slave_monitor_bfm_h (intf.MON_MP);
initial begin
   uvm_config_db#(virtual slave_driver_bfm)::set(null,"*", "slave_driver_bfm", slave_drv_bfm_h); 
   uvm_config_db #(virtual slave_monitor_bfm)::set(null,"*", "slave_monitor_bfm", slave_mon_bfm_h); 
 end

endmodule : slave_agent_bfm

`endif
