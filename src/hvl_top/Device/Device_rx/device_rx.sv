`ifndef DEVICE_RX_INCLUDED_
`define DEVICE_RX_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: device_rx
// It's a transaction class that holds the UART data items for generating the stimulus
//--------------------------------------------------------------------------------------------
class device_rx extends uvm_sequence_item;
  //register with factory so we can override with uvm method in future if necessary.
  `uvm_object_utils(device_rx)
  
  //input signals
  bit [CHAR_LENGTH-1:0] rx[];

  
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "device_rx");
  extern function void do_copy(uvm_object rhs);
  extern function bit do_compare(uvm_object rhs, uvm_comparer comparer);
  extern function void do_print(uvm_printer printer);

endclass : device_rx

//--------------------------------------------------------------------------------------------
// Construct: new
// Constructs the device_rx object
//  
//
// Parameters:
// name - device_rx
//--------------------------------------------------------------------------------------------
function device_rx::new(string name = "device_rx");
  super.new(name);
endfunction : new

//--------------------------------------------------------------------------------------------
// do_copy method
//--------------------------------------------------------------------------------------------

function void device_rx::do_copy (uvm_object rhs);
  device_rx rhs_;
  
  if(!$cast(rhs_,rhs)) begin
    `uvm_fatal("do_copy","cast of the rhs object failed")
  end
  super.do_copy(rhs);
  rx=rhs_.rx;

endfunction : do_copy

//--------------------------------------------------------------------------------------------
// do_compare method
//--------------------------------------------------------------------------------------------
function bit  device_rx::do_compare (uvm_object rhs,uvm_comparer comparer);
  device_rx rhs_;
  
  if(!$cast(rhs_,rhs)) begin
    `uvm_fatal("FATAL_device_rx_DO_COMPARE_FAILED","cast of the rhs object failed")
    return 0;
  end
  
  return super.do_compare(rhs,comparer) &&
  rx == rhs_.rx;
endfunction : do_compare

//--------------------------------------------------------------------------------------------
// Function: do_print method
// Print method can be added to display the data members values
//--------------------------------------------------------------------------------------------

function void device_rx::do_print(uvm_printer printer);
  super.do_print(printer);
  foreach(rx[i]) begin
  printer.print_field($sformatf("rx[%0d]",i),this.rx[i],$bits(rx),UVM_DEC);
end
endfunction : do_print

`endif
