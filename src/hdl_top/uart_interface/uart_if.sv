`ifndef UART_IF_INCLUDED_
`define UART_IF_INCLUDED_

//--------------------------------------------------------------------------------------------
// Interface : uart_if
//  Declaration of pin level signals for UART interface
//--------------------------------------------------------------------------------------------
interface uart_if(input pclk,input areset);

  logic bclk;

  //transaction signals 
  logic tx0;
  logic tx1;
  logic tx2;
  logic tx3;

  //reciving signals
  logic rx;

endinterface : uart_if 

`endif
