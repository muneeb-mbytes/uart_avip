`ifndef UART_GLOBALS_PKG_INCLUDED_
`define UART_GLOBALS_PKG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Package: uart_globals_pkg
// Used for storing enums, parameters and defines
//--------------------------------------------------------------------------------------------
package uart_globals_pkg;
  
  //Define :CHAR_LENGTH
  //Specifies the character length of the trasnfer
  parameter CHAR_LENGTH = 8;
  
  //Define :NO_OF_ROWS
  //Specifies the no of rows of an array
  parameter NO_OF_ROWS = CHAR_LENGTH**2;
  
  //Define :NO_OF_DEVICES
  //Specifies the no of devices
  parameter NO_OF_DEVICES=1;
  
  //Define :NO_OF_LANES
  //Specifies the no of lanses for Tx and Rx
  parameter NO_OF_LANES=1;
  
  //Define :STOP_BIT
  //Specifes the start of the transaction
  parameter START_BIT=0;

  // Enum: shift_direction_e
  // Specifies the shift direction
  // LSB_FIRST - LSB is shifted out first
  // MSB_FIRST - MSB is shifted out first

  typedef enum bit {
     LSB_FIRST = 1'b0,
     MSB_FIRST = 1'b1 
   } shift_direction_e;

  //Enum: stop_bit_e
  //Specifies the no of stop bits

  typedef enum bit[1:0] {
    STOP_BIT_ONEBIT       = 1,
    STOP_BIT_ONE_HALFBITS = 0,
    STOP_BIT_TWOBITS      = 2
  } stop_bit_e;
  
  //Enum: uart_type_e
  //Specifies the uart type based on the size of transfer

  typedef enum bit[3:0] {
    UART_TYPE_FIVE_BIT      = 5,
    UART_TYPE_SIX_BIT       = 6,
    UART_TYPE_SEVEN_BIT     = 7,
    UART_TYPE_EIGHT_BIT     = 8,
    UART_TYPE_NO_TRANSFER   = 0
  } uart_type_e;
  
  //Enum: oversampling_e
  //specifies for how many clock cycles the single bit data remains stable

  typedef enum bit[3:0] {
    OVERSAMPLING_TWO       = 4'd2,
    OVERSAMPLING_FOUR      = 4'd4,
    OVERSAMPLING_SIX       = 4'd6,
    OVERSAMPLING_EIGHT     = 4'd8,
    OVERSAMPLING_ZERO      = 4'd0
  } oversampling_e;
  
  //Enum: parity_e
  //EVEN_PARITY - no of 1's in the Transaction is even
  //ODD_PARITY - no of 1's in the Transaction is odd

  typedef enum bit {
  EVEN_PARITY  = 1'b0,
  ODD_PARITY   = 1'b1
  } parity_e;
  
  //Struct: uart_transfer_char_s
  //tx array which holds the tx seq_item transactions
  //no_of_tx_bits_transfer  specifies how many tx bits to trasnfer
  
  typedef struct {
    bit [NO_OF_ROWS-1:0][CHAR_LENGTH-1:0] tx;
    int no_of_tx_bits_transfer;
    int parity_bit;
    int no_of_tx_elements;
  } uart_transfer_char_s;

  //Struct: uart_reciver_char_s
  //rx array which holds the rx seq_item transactions
  //no_of_rx_bits_transfer  specifies how many rx bits to trasnfer

  typedef struct {
    bit [NO_OF_ROWS-1:0][CHAR_LENGTH-1:0] rx;
    int no_of_rx_bits_transfer;
  } uart_reciver_char_s;
  
  //struct: uart_transfer_cfg_s
  //baudrate_divisor: specifies the speed of the transaction
  //stop_bit: Specifies no of stop bits
  //uart_type: Specifies uart type based on the size of transfer
  //oversampling_bits: Specifies for how many clock cycles the single bit data remains stable

  typedef struct {
    int baudrate_divisor;
    bit [3:0] stop_bit;
    bit msb_first;
    bit [3:0] uart_type;
    bit [3:0] oversampling_bits;
  } uart_transfer_cfg_s;

endpackage: uart_globals_pkg

`endif
