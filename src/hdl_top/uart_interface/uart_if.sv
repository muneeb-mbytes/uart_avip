`ifndef UART_IF_INCLUDED_
`define UART_IF_INCLUDED_

//--------------------------------------------------------------------------------------------
// Interface : uart_if
//  Declaration of pin level signals for UART interface
//--------------------------------------------------------------------------------------------
interface uart_if(input bit pclk,input bit areset);
  
  // Variable: bclk
  // Uart clock 
  logic bclk;

  // Transaction signals 
  logic tx0;
  logic tx1;
  logic tx2;
  logic tx3;

  // Reciving signals
  logic rx;

endinterface : uart_if 

`endif
