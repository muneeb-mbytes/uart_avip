`ifndef HDL_TOP_INCLUDED_
`define HDL_TOP_INCLUDED_

//--------------------------------------------------------------------------------------------
// Module      : HDL Top
// Description : Has a interface and device1 agent bfm.
//--------------------------------------------------------------------------------------------
module hdl_top;

  //-------------------------------------------------------
  // Clock and reset signals
  //-------------------------------------------------------
  bit clk;
  bit rst;
 
  //-------------------------------------------------------
  // Display statement for HDL_TOP
  //-------------------------------------------------------
  initial begin
    $display("HDL_TOP");
  end

  //-------------------------------------------------------
  // System Clock Generation
  //-------------------------------------------------------
  initial begin
    $display("CLOCK BEGINS");
    clk = 0;
    forever begin
      #10 clk = ~clk;
    end
    $display("CLOCK ENDS");
  end
    
  //-------------------------------------------------------
  // System Reset Generation
  //-------------------------------------------------------
  initial begin
    rst = 1'b1;
    
    #10; rst = 1'b0;

    repeat (2) begin
      @(posedge clk);
    end
    rst = 1'b1;
  end

  //-------------------------------------------------------
  // UART Interface Instantiation for two devices
  //-------------------------------------------------------
  uart_if intf_device0(.pclk(clk),
                      .areset(rst)
                     );

  uart_if intf_device1(.pclk(clk),
                      .areset(rst)
                     );
  //-------------------------------------------------------
  // UART BFM Agent Instantiation for device0 and device1
  //-------------------------------------------------------
  device_agent_bfm device0_agent_bfm_h(intf_device0);
  device_agent_bfm device1_agent_bfm_h(intf_device1);

  //---------------------------------------------------------
  // Assigning Device0 interface rx with Device1 inteface Tx 
  // and Viceversa
  //---------------------------------------------------------
  //rx_agent_bfm rx_agent_bfm_h(intf);
  //assign device0_agent_bfm_h.intf.tx = device1_agent_bfm_h.intf.rx;
  assign intf_device1.rx = intf_device0.tx;
  assign intf_device0.rx = intf_device1.tx;

endmodule : hdl_top

`endif
