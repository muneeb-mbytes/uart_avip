
`ifndef UART_SCOREBOARD_INCLUDED_
`define UART_SCOREBOARD_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: uart_scoreboard
// Scoreboard the data getting from monitor port that goes into the implementation port
//--------------------------------------------------------------------------------------------
class uart_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(uart_scoreboard)

  //Variable : device0_tx_h
  //declaring device0 transaction handle
  tx_xtn tx_data1;
  
  //Variable : device1_tx_h
  //declaring device1 transaction handle
  rx_xtn rx_data1;
  
  //Variable : env_cfg_h
  //declaring env config handle
  env_config env_cfg_h;

  //Variable : device0_analysis_fifo
  //declaring analysis fifo
  uvm_tlm_analysis_fifo#(tx_xtn)tx_analysis_fifo;
 
  //Variable : device1_analysis_fifo
  //declaring analysis fifo
  uvm_tlm_analysis_fifo#(rx_xtn)rx_analysis_fifo;


  //Variable tx_count
  //to keep track of number of transaction 
  int tx_count = 0;


  //Variable rx_count
  //to keep track of number of transaction 
  int rx_count = 0;

  //Variable byte_data_cmp_verified_tx_count
  //to keep track of number of byte wise compared verified tx data
  int byte_data_cmp_verified_tx_rx_count = 0;

  //Variable byte_data_cmp_verified_rx_count
  //to keep track of number of byte wise compared verified rx data
  //int byte_data_cmp_verified_rx_count = 0;
  
  //Variable byte_data_cmp_failed_tx_count
  //to keep track of number of byte wise compared failed tx data
  int byte_data_cmp_failed_tx_rx_count = 0;

  //Variable byte_data_cmp_failed_rx_count
  //to keep track of number of byte wise compared failed rx data
  //int byte_data_cmp_failed_rx_count = 0;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "uart_scoreboard", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
  extern virtual function void check_phase(uvm_phase phase);
  extern virtual function void report_phase(uvm_phase phase);
endclass : uart_scoreboard

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - uart_scoreboard
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function uart_scoreboard::new(string name = "uart_scoreboard", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// Build device0 and device1 analysis fifo
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void uart_scoreboard::build_phase(uvm_phase phase);
  super.build_phase(phase);
  
  tx_analysis_fifo = new("tx_analysis_fifo",this);
  rx_analysis_fifo = new("rx_analysis_fifo",this);
  
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: connect_phase
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void uart_scoreboard::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
endfunction : connect_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// Used to give delays and check the wdata and rdata are similar or not
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
task uart_scoreboard::run_phase(uvm_phase phase);

  //phase.raise_objection(this, "uart_scoreboard");

  super.run_phase(phase);

 forever begin
 
 `uvm_info(get_type_name(),$sformatf("before calling analysis fifo get method"),UVM_HIGH)
 tx_analysis_fifo.get(tx_data1);
 tx_count++;
 
 rx_analysis_fifo.get(rx_data1);
 rx_count++;
 `uvm_info(get_type_name(),$sformatf("after calling analysis fifo get method"),UVM_HIGH) 
 `uvm_info(get_type_name(),$sformatf("printing tx_data1, \n %s",tx_data1.sprint()),UVM_HIGH)

 //`uvm_info(get_type_name(),$sformatf("after calling analysis fifo get method"),UVM_HIGH) 
 `uvm_info(get_type_name(),$sformatf("printing rx_data1, \n %s",rx_data1.sprint()),UVM_HIGH)
  
 // Data comparision for TX and RX 
  if (tx_data1.tx_data.size() == rx_data1.rx_data.size())begin 
   `uvm_info (get_type_name(), $sformatf ("Size of tx data from tx_xtn and rx data from rx_xtn is equal"),UVM_HIGH);
  end
  else begin
   `uvm_error (get_type_name(),$sformatf("Size of tx data and rx data is not equal"));
  end

  foreach(tx_data1.tx_data[i]) begin
     if(tx_data1.tx_data[i] != rx_data1.rx_data[i]) begin
       `uvm_error("ERROR_SC TX_rx_data1_MISMATCH", 
                 $sformatf("tx_data1 TX[%0d] = 'h%0x and rx_data1 RX [%0d] = 'h%0x", 
                           i, tx_data1.tx_data[i],
                           i, rx_data1.rx_data[i]) );
       byte_data_cmp_failed_tx_rx_count++;
     end
     else begin
       `uvm_info("SB_tx_data1_MATCH", 
                 $sformatf("tx_data1 TX[%0d] = 'h%0x and RX[%0d] = 'h%0x", 
                           i, tx_data1.tx_data[i],
                           i, rx_data1.rx_data[i]), UVM_HIGH);
                           
       byte_data_cmp_verified_tx_rx_count++;
     end
    end   
  end
  //phase.drop_objection(this);

endtask : run_phase

function void uart_scoreboard::check_phase(uvm_phase phase);
  super.check_phase(phase);

  $display(" ");
  $display("-------------------------------------------- ");
  $display("SCOREBOARD CHECK PHASE");
  $display("-------------------------------------------- ");
  $display(" ");

// 1. Check if the comparisions counter is NON-zero
//    A non-zero value indicates that the comparisions never happened and throw error
  
  if ((byte_data_cmp_verified_tx_rx_count != 0)&&(byte_data_cmp_failed_tx_rx_count == 0)) begin
	  `uvm_info (get_type_name(), $sformatf ("all tx comparisions are succesful"),UVM_NONE);
  end
  else begin
    `uvm_info (get_type_name(), $sformatf ("byte_data_cmp_verified_tx_count :%0d",
                                            byte_data_cmp_verified_tx_rx_count),UVM_NONE);
	  `uvm_info (get_type_name(), $sformatf ("byte_data_cmp_failed_tx_count : %0d", 
                                            byte_data_cmp_failed_tx_rx_count),UVM_NONE);
    `uvm_error (get_type_name(), $sformatf ("comparisions of tx not happened"));
  end

//  if ((byte_data_cmp_verified_rx_count != 0)&&(byte_data_cmp_failed_rx_count == 0) ) begin
//	  `uvm_info (get_type_name(), $sformatf ("all rx comparisions are succesful"),UVM_NONE);
//  end
//  else begin
//    `uvm_info (get_type_name(), $sformatf ("byte_data_cmp_verified_rx_count :%0d",
//                                            byte_data_cmp_verified_rx_count),UVM_NONE);
//	  `uvm_info (get_type_name(), $sformatf ("byte_data_cmp_failed_rx_count : %0d", 
//                                            byte_data_cmp_failed_rx_count),UVM_NONE);
//  end
//
// 2. Check if tx packets received are same as rx packets received
//    To Make sure that we have equal number of tx and rx packets
  
 if (tx_count == rx_count ) begin
    `uvm_info (get_type_name(), $sformatf ("tx and rx have equal no. of transactions"),UVM_HIGH);
  end
  else begin
   `uvm_info (get_type_name(), $sformatf ("tx_count : %0d",tx_count ),UVM_HIGH);
    `uvm_info (get_type_name(), $sformatf ("rx_count : %0d",rx_count ),UVM_HIGH);
    `uvm_error (get_type_name(), $sformatf ("tx and rx doesnot have same no. of transactions"));
  end 


// 3. Analyis fifos must be zero - This will indicate that all the packets have been compared
//    This is to make sure that we have taken all packets from both FIFOs and made the
//    comparisions
   
  if (tx_analysis_fifo.size() == 0)begin
     `uvm_info (get_type_name(), $sformatf ("Tx analysis FIFO is empty"),UVM_HIGH);
  end
  else begin
     `uvm_info (get_type_name(), $sformatf ("Tx_analysis_fifo:%0d",tx_analysis_fifo.size() ),UVM_HIGH);
     `uvm_error (get_type_name(), $sformatf ("tx analysis FIFO is not empty"));
  end
  if (rx_analysis_fifo.size()== 0)begin
     `uvm_info (get_type_name(), $sformatf ("rx analysis FIFO is empty"),UVM_HIGH);
  end
  else begin
     `uvm_info (get_type_name(), $sformatf ("rx_analysis_fifo:%0d",rx_analysis_fifo.size()),UVM_HIGH);
     `uvm_error (get_type_name(),$sformatf ("rx analysis FIFO is not empty"));
  end

endfunction : check_phase

//--------------------------------------------------------------------------------------------
// Function: report_phase
// Display the result of simulation
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void uart_scoreboard::report_phase(uvm_phase phase);
  super.report_phase(phase);
  
  $display(" ");
  $display("-------------------------------------------- ");
  $display("SCOREBOARD REPORT PHASE");
  $display("-------------------------------------------- ");
  $display(" ");
  // Total number of packets received from the tx
  `uvm_info (get_type_name(),$sformatf("No. of transactions from tx:%0d",
                             tx_count),UVM_NONE);

  //Number of tx comparisoins done
  `uvm_info (get_type_name(),$sformatf("Total no. of byte wise tx comparisions:%0d",
                 byte_data_cmp_verified_tx_rx_count+byte_data_cmp_failed_tx_rx_count),UVM_HIGH);
  //Number of rx comparisions done
  //`uvm_info (get_type_name(),$sformatf("Total no. of byte wise rx comparisions:%0d",
    //             byte_data_cmp_verified_rx_count+byte_data_cmp_failed_rx_count),UVM_HIGH);
  
  //Number of tx comparisios passed
  `uvm_info (get_type_name(),$sformatf("Total no. of byte wise tx comparisions passed:%0d",
                byte_data_cmp_verified_tx_rx_count),UVM_NONE);

  //Number of tx compariosn failed
  `uvm_info (get_type_name(),$sformatf("No. of byte wise tx comparision failed:%0d",
                byte_data_cmp_failed_tx_rx_count),UVM_NONE);

  //Number of rx compariosn failed
  //`uvm_info (get_type_name(),$sformatf("No. of byte wise rx comparision failed:%0d",
    //            byte_data_cmp_failed_rx_count),UVM_NONE);

endfunction : report_phase

`endif

