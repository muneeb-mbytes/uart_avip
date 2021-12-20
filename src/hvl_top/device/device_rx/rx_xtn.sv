`ifndef RX_XTN_INCLUDED_
`define RX_XTN_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: rx_xtn
// It's a transaction class that holds the UART data items for generating the stimulus
//--------------------------------------------------------------------------------------------
class rx_xtn extends uvm_sequence_item;
  //register with factory so we can override with uvm method in future if necessary.
  `uvm_object_utils(rx_xtn)
  
  //input signals
  bit [CHAR_LENGTH-1:0] rx_data;

  
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "rx_xtn");
  extern function void do_copy(uvm_object rhs);
  extern function bit do_compare(uvm_object rhs, uvm_comparer comparer);
  extern function void do_print(uvm_printer printer);

endclass : rx_xtn

//--------------------------------------------------------------------------------------------
// Construct: new
// Constructs the rx_xtn object
//  
//
// Parameters:
// name - rx_xtn
//--------------------------------------------------------------------------------------------
function rx_xtn::new(string name = "rx_xtn");
  super.new(name);
endfunction : new

//--------------------------------------------------------------------------------------------
// do_copy method
//--------------------------------------------------------------------------------------------

function void rx_xtn::do_copy (uvm_object rhs);
  rx_xtn rhs_;
  
  if(!$cast(rhs_,rhs)) begin
    `uvm_fatal("do_copy","cast of the rhs object failed")
  end
  super.do_copy(rhs);
  rx_data=rhs_.rx_data;

endfunction : do_copy

//--------------------------------------------------------------------------------------------
// do_compare method
//--------------------------------------------------------------------------------------------
function bit  rx_xtn::do_compare (uvm_object rhs,uvm_comparer comparer);
  rx_xtn rhs_;
  
  if(!$cast(rhs_,rhs)) begin
    `uvm_fatal("FATAL_rx_xtn_DO_COMPARE_FAILED","cast of the rhs object failed")
    return 0;
  end
  
  return super.do_compare(rhs,comparer) &&
  rx_data == rhs_.rx_data;
endfunction : do_compare

//--------------------------------------------------------------------------------------------
// Function: do_print method
// Print method can be added to display the data members values
//--------------------------------------------------------------------------------------------

function void rx_xtn::do_print(uvm_printer printer);
  super.do_print(printer);
  foreach(rx_data[i]) begin
    printer.print_field($sformatf("rx_data[%0d]",i),this.rx_data[i],$bits(rx_data),UVM_DEC);
  end
endfunction : do_print

`endif
