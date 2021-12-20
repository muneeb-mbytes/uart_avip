`ifndef UART_IF_INCLUDED_
`define UART_IF_INCLUDED_

//--------------------------------------------------------------------------------------------
// Interface : uart_if
//  Declaration of pin level signals for UART interface
//--------------------------------------------------------------------------------------------
interface uart_if(input pclk,input bit areset);
  
  // Transaction signals 
  logic tx;

  // Reciving signals
  logic rx;

endinterface : uart_if 

`endif
