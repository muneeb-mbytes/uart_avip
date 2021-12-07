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

    repeat (2) begin
      @(posedge clk);
    end
    rst = 1'b0;

    repeat (2) begin
      @(posedge clk);
    end
    rst = 1'b1;
  end

  //-------------------------------------------------------
  // UART Interface Instantiation
  //-------------------------------------------------------
  uart_if intf(.pclk(clk),
               .areset(rst)
             );

  //-------------------------------------------------------
  // UART BFM Agent Instantiation
  //-------------------------------------------------------
  tx_agent_bfm tx_agent_bfm_h(intf);

  //-------------------------------------------------------
  // UART BFM Agent Instantiation
  //-------------------------------------------------------
  rx_agent_bfm rx_agent_bfm_h(intf);

endmodule : hdl_top

`endif
