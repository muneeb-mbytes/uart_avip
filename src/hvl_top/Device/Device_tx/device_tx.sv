`ifndef DEVICE_TX_INCLUDED_
`define DEVICE_TX_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: device_tx.
// Description:
// This class holds the data items required to drive stimulus to dut
// and also holds methods that manipulatethose data items
//--------------------------------------------------------------------------------------------
class device_tx extends uvm_sequence_item;
  //register with factory so we can override with uvm method in future if necessary.
    `uvm_object_utils(device_tx)
    
    //input signals

    rand bit [CHAR_LENGTH-1:0]tx[];
    bit parity;
    //-------------------------------------------------------
    // constraints for uart
    //-------------------------------------------------------
    //constraint length{CHAR_LENGTH>5 && CHAR_LENGTH<8;}
    //constraint tx{tx0.size<8;}
    //constraint mod8{foreach(tx0[i])
    //                   tx0[i]%8==0;}
    
    //-------------------------------------------------------
    // Externally defined Tasks and Functions
    //-------------------------------------------------------
    extern function new(string name = "device_tx");
    extern function void post_randomize();
    extern function void do_copy(uvm_object rhs);
    extern function bit do_compare(uvm_object rhs, uvm_comparer comparer);
    extern function void do_print(uvm_printer printer);

endclass : device_tx

//--------------------------------------------------------------------------------------------
// Construct: new
// initializes the class object
//
// Parameters:
// name - device_tx
//--------------------------------------------------------------------------------------------
function device_tx::new(string name = "device_tx");
  super.new(name);
endfunction : new

//--------------------------------------------------------------------------------------------
// function: post_randomize()
// Descripition: Returns the parity bit for each transaction
//--------------------------------------------------------------------------------------------
function void device_tx::post_randomize();
  foreach(tx[i]) begin
  if(($countones(tx[i])%2)==0) begin
    parity = 0;
  end
  else begin
    parity = 1;
  end
end
endfunction
//--------------------------------------------------------------------------------------------
// do_copy method
//--------------------------------------------------------------------------------------------
function void device_tx::do_copy (uvm_object rhs);
  device_tx rhs_;
  
  if(!$cast(rhs_,rhs)) begin
    `uvm_fatal("do_copy","cast of the rhs object failed")
  end
  super.do_copy(rhs);
  tx= rhs_.tx;

endfunction : do_copy

//--------------------------------------------------------------------------------------------
// do_compare method
//--------------------------------------------------------------------------------------------
function bit  device_tx::do_compare (uvm_object rhs,uvm_comparer comparer);
  device_tx rhs_;
  
  if(!$cast(rhs_,rhs)) begin
    `uvm_fatal("FATAL_device_TX_DO_COMPARE_FAILED","cast of the rhs object failed")
    return 0;
  end
  
  return super.do_compare(rhs,comparer) &&
  tx == rhs_.tx;
endfunction : do_compare

//--------------------------------------------------------------------------------------------
// Function: do_print method
// Print method can be added to display the data members values
//--------------------------------------------------------------------------------------------

function void device_tx::do_print(uvm_printer printer);
  super.do_print(printer);
  foreach(tx[i]) begin
  printer.print_field($sformatf("tx[%0d]",i), this.tx[i], $bits(tx),UVM_BIN);
  end 
endfunction : do_print
  

`endif

