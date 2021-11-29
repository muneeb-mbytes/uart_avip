`ifndef UART_GLOBALS_PKG_INCLUDED_
`define UART_GLOBALS_PKG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Package: uart_globals_pkg
// Used for storing enums, parameters and defines
//--------------------------------------------------------------------------------------------
package uart_globals_pkg;

parameter CHAR_LENGTH = 8;

parameter PARITY_ENABLED=1;

parameter PARITY_TYPE=0;
// Enum: shift_direction_e
// 
// Specifies the shift direction
//
// LSB_FIRST - LSB is shifted out first
// MSB_FIRST - MSB is shifted out first
//
typedef enum bit {
  LSB_FIRST = 1'b0,
  MSB_FIRST = 1'b1
} shift_direction_e;

typedef enum bit[1:0] {
  STOP_BIT_ONEBIT       = 2'b01,
  STOP_BIT_ONE_HALFBITS = 2'b10,
  STOP_BIT_TWOBITS      = 2'b11
} stop_bit_e;

endpackage: uart_globals_pkg

`endif
