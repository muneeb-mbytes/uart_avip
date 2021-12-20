`ifndef UART_FD_8B_TEST_INCLUDED_
`define UART_FD_8B_TEST_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: uart_fd_8b_test
// Description:
// Extended the uart_fd_8b_test class from base_test class
//--------------------------------------------------------------------------------------------
class uart_fd_8b_test extends base_test;

  //Registering the uart_fd_8b_test in the factory
  `uvm_component_utils(uart_fd_8b_test)

  //-------------------------------------------------------
  // Declaring sequence handles  
  //-------------------------------------------------------
  uart_fd_8b_virtual_seq uart_fd_8b_virtual_seq_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "uart_fd_8b_test", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);

endclass : uart_fd_8b_test


//--------------------------------------------------------------------------------------------
// Construct: new
// Initializes class object
// Parameters:
// name - uart_fd_8b_test
// parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function uart_fd_8b_test::new(string name = "uart_fd_8b_test",uvm_component parent);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function:build_phase
//--------------------------------------------------------------------------------------------
function void uart_fd_8b_test::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Task:run_phase
// Responsible for starting the transactions
//--------------------------------------------------------------------------------------------
task uart_fd_8b_test::run_phase(uvm_phase phase);

  uart_fd_8b_virtual_seq_h = uart_fd_8b_virtual_seq::type_id::create("uart_fd_8b_virtual_seq_h");

  phase.raise_objection(this);

  uart_fd_8b_virtual_seq_h.start(env_h.virtual_seqr_h); 
  
  phase.drop_objection(this);

endtask : run_phase

`endif

