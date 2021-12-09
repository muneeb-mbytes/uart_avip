`ifndef TX_XTN_INCLUDED_
`define TX_XTN_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: tx_xtn.
// Description:
// This class holds the data items required to drive stimulus to dut
// and also holds methods that manipulatethose data items
//--------------------------------------------------------------------------------------------
class tx_xtn extends uvm_sequence_item;
  
  //register with factory so we can override with uvm method in future if necessary.
  `uvm_object_utils(tx_xtn)
  
  //input signals
  rand bit[CHAR_LENGTH:0] tx_data[];
  bit parity;
  bit parity_element;
  int uart_type;
  tx_agent_config tx_agent_cfg_h;

  //-------------------------------------------------------
  // constraints for uart
  //-------------------------------------------------------
  constraint tx_data_size{tx_data.size() > 0;}
  
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "tx_xtn");
  extern function void post_randomize();
  extern function void do_copy(uvm_object rhs);
  extern function bit do_compare(uvm_object rhs, uvm_comparer comparer);
  extern function void do_print(uvm_printer printer);

endclass : tx_xtn

//--------------------------------------------------------------------------------------------
// Construct: new
// initializes the class object
//
// Parameters:
// name - tx_xtn
//--------------------------------------------------------------------------------------------
function tx_xtn::new(string name = "tx_xtn");
  super.new(name);
endfunction : new


//function void tx_xtn::cast(input tx_agent_config tx_agent_cfg_h);
//  
//  parity =  parity_e'(tx_agent_cfg_h.parity_bit);
//  $display("parity in cast = %0d",parity);
//
//endfunction : cast

//--------------------------------------------------------------------------------------------
// function: post_randomize()
// Descripition: Returns the parity bit for each transaction
//--------------------------------------------------------------------------------------------
function void tx_xtn::post_randomize();
  
  parity    =  parity_e'(tx_agent_cfg_h.parity_scheme);
  uart_type =  uart_type_e'(tx_agent_cfg_h.uart_type);
  $display("parity xtn = %b", parity);
  $display("uart_bits_xtn = %0d", uart_type);
  
  if(parity == 1'b0) begin
    foreach(tx_data[i]) begin
      if(($countones(tx_data[i])%2)!==0) begin
        parity_element = 1;
      end
      else begin
        parity_element = 0;
      end
    end
    $display("parity ele = %b",parity_element);
  end
  
  else begin
    foreach(tx_data[i]) begin
      if(($countones(tx_data[i])%2)!==0) begin
        parity_element = 0;
      end
      else begin
        parity_element = 1;
      end
    end
    $display("parity ele = %b",parity_element);
  end
  
  tx_data[uart_type] = parity_element;
  foreach(tx_data[i]) begin
    //tx_data[]
    $display("parity arrat xtn = %b",tx_data[i]);
  end

endfunction

//--------------------------------------------------------------------------------------------
// do_copy method
//--------------------------------------------------------------------------------------------
function void tx_xtn::do_copy (uvm_object rhs);
  tx_xtn rhs_;
  
  if(!$cast(rhs_,rhs)) begin
    `uvm_fatal("do_copy","cast of the rhs object failed")
  end
  super.do_copy(rhs);
  tx_data= rhs_.tx_data;

endfunction : do_copy

//--------------------------------------------------------------------------------------------
// do_compare method
//--------------------------------------------------------------------------------------------
function bit  tx_xtn::do_compare (uvm_object rhs,uvm_comparer comparer);
  tx_xtn rhs_;
  
  if(!$cast(rhs_,rhs)) begin
    `uvm_fatal("FATAL_tx_xtn_DO_COMPARE_FAILED","cast of the rhs object failed")
    return 0;
  end
  
  return super.do_compare(rhs,comparer) &&
  tx_data == rhs_.tx_data;
endfunction : do_compare

//--------------------------------------------------------------------------------------------
// Function: do_print method
// Print method can be added to display the data members values
//--------------------------------------------------------------------------------------------
function void tx_xtn::do_print(uvm_printer printer);
  super.do_print(printer);
  foreach(tx_data[i]) begin
    printer.print_field($sformatf("tx[%0d]",i), this.tx_data[i], $bits(tx_data),UVM_BIN);
  end 
endfunction : do_print
  
`endif

