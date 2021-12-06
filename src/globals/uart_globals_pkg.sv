`ifndef UART_GLOBALS_PKG_INCLUDED_
`define UART_GLOBALS_PKG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Package: uart_globals_pkg
// Used for storing enums, parameters and defines
//--------------------------------------------------------------------------------------------
package uart_globals_pkg;
  
  parameter CHAR_LENGTH = 8;

  parameter NO_OF_ROWS = CHAR_LENGTH**2;

  parameter NO_OF_DEVICES=1;


// Enum: shift_direction_e
// Specifies the shift direction
// LSB_FIRST - LSB is shifted out first
// MSB_FIRST - MSB is shifted out first
//
typedef enum bit {
  LSB_FIRST = 1'b0,
  MSB_FIRST = 1'b1
} shift_direction_e;

typedef enum bit[1:0] {
  STOP_BIT_ONEBIT       = 1,
  STOP_BIT_ONE_HALFBITS = 0,
  STOP_BIT_TWOBITS      = 2
} stop_bit_e;

typedef enum bit[3:0] {
  UART_TYPE_FIVE_BIT      = 5,
  UART_TYPE_SIX_BIT       = 6,
  UART_TYPE_SEVEN_BIT     = 7,
  UART_TYPE_EIGHT_BIT     = 8,
  UART_TYPE_NO_TRANSFER   = 0
} uart_type_e;


typedef enum bit[3:0] {
  OVERSAMPLING_TWO       = 2,
  OVERSAMPLING_FOUR      = 4,
  OVERSAMPLING_SIX       = 6,
  OVERSAMPLING_EIGHT     = 8,
  OVERSAMPLING_ZERO      = 0
} oversampling_e;


typedef enum bit {
EVEN_PARITY  = 1'b0,
ODD_PARITY   = 1'b1
} parity_e;

//struct uart_transfer_char_s
//tx0 array which holds the tx0 seq_item transactions
//rx0 array which holds the rx0 seq_item transactions
//no_of_tx_bits_transfer  specifies how many tx bits to trasnfer
//no_of_rx_bits_transfer  specifies how many rx bits to trasnfer

typedef struct {
  bit [NO_OF_ROWS-1:0][CHAR_LENGTH-1:0] tx;
  int no_of_tx_bits_transfer;
  int parity_bit;
  bit [NO_OF_ROWS-1:0][CHAR_LENGTH-1:0] rx;
  int no_of_rx_bits_transfer;
} uart_transfer_char_s;

typedef struct {
  int baudrate_divisor;
  bit [3:0] stop_bit;
  bit msb_first;
  bit [3:0] uart_type;
  bit [3:0] oversampling_bits;
} uart_transfer_cfg_s;


endpackage: uart_globals_pkg

`endif
