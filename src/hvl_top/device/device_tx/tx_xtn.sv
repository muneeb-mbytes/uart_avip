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
  rand bit[CHAR_LENGTH-1:0] tx_data[];
  bit parity;
  int uart_type;
  tx_agent_config tx_agent_cfg_h;

  //-------------------------------------------------------
  // constraints for uart
  //-------------------------------------------------------
  constraint tx_data_size{tx_data.size() > 0; tx_data[0]%2==0;}
    
  
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

//--------------------------------------------------------------------------------------------
// function: post_randomize()
// Descripition: Returns the parity bit for each transaction
//--------------------------------------------------------------------------------------------
function void tx_xtn::post_randomize();
  bit parity_local; 
  uart_type =  uart_type_e'(tx_agent_cfg_h.uart_type);
  $display("uart_bits_xtn = %0d", uart_type);
  
  //foreach(tx_data[i]) begin

    // Parity generation
    if(tx_agent_cfg_h.parity_scheme == EVEN_PARITY) begin
      for(int row_no=0; row_no < tx_data.size(); row_no++)begin
        `uvm_info("tx_xtn",$sformatf("tx_data_size = %0d",tx_data.size()),UVM_HIGH)
        for(int i=0; i < uart_type; i++)begin
          parity_local = ^tx_data[row_no][uart_type];
        end
      end
    end

    else begin
      for(int row_no=0; row_no < tx_data.size(); row_no++)begin
      //  `uvm_info("tx_xtn",$sformatf("tx_data_size = %0d",tx_data.size()),UVM_HIGH)
         for(int i=0; i < uart_type; i++)begin
        //foreach(tx_data[i]) begin
          `uvm_info("DEBUG", $sformatf("before parity=%0b",parity), UVM_NONE) 
          //parity = ~(^tx_data[row_no][i]);
          parity_local = ~(^tx_data[uart_type]);
          `uvm_info("DEBUG", $sformatf("parity_local=%0b",parity_local), UVM_NONE) 
        end
        parity = parity_local;
        parity_local = 0;
        `uvm_info("DEBUG", $sformatf("parity=%0b",parity), UVM_NONE) 
      end
    end
    `uvm_info("DEBUG_MSHA", $sformatf("parity=%0b",parity), UVM_NONE) 
  //end
  
  foreach(tx_data[i]) begin
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

