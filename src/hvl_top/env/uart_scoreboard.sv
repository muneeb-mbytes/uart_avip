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
  tx_xtn device0_tx_data;
  tx_xtn device1_tx_data;
  
  //Variable : device1_tx_h
  //declaring device1 transaction handle
  rx_xtn device0_rx_data;
  rx_xtn device1_rx_data;
  
  reg [7:0]  tx0_data[$];
  reg [7:0]  tx1_data[$];
  reg [7:0]  rx0_data[$];
  reg [7:0]  rx1_data[$];


  
  //Variable : env_cfg_h
  //declaring env config handle
  env_config env_cfg_h;

  //Variable : device0_analysis_fifo
  //declaring analysis fifo
  uvm_tlm_analysis_fifo#(tx_xtn)device_tx_analysis_fifo;
  uvm_tlm_analysis_fifo#(tx_xtn)device1_tx_analysis_fifo;
 
  //Variable : device1_analysis_fifo
  //declaring analysis fifo
  uvm_tlm_analysis_fifo#(rx_xtn)device_rx_analysis_fifo;
  uvm_tlm_analysis_fifo#(rx_xtn)device1_rx_analysis_fifo;


  //Variable tx_count
  //to keep track of number of transaction 
  int tx_count = 0;


  //Variable rx_count
  //to keep track of number of transaction 
  int rx_count = 0;

  //Variable byte_data_cmp_verified_tx_count
  //to keep track of number of byte wise compared verified tx data
  int byte_data_cmp_verified_device0_tx_device1_rx_count = 0;

  //Variable byte_data_cmp_verified_rx_count
  //to keep track of number of byte wise compared verified rx data
  int byte_data_cmp_verified_device1_tx_device0_rx_count = 0;
  
  //Variable byte_data_cmp_failed_tx_count
  //to keep track of number of byte wise compared failed tx data
  int byte_data_cmp_failed_device0_tx_device1_rx_count = 0;

  //Variable byte_data_cmp_failed_rx_count
  //to keep track of number of byte wise compared failed rx data
  int byte_data_cmp_failed_device1_tx_device0_rx_count = 0;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "uart_scoreboard", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
  extern virtual task compare_tx0_rx1();
  extern virtual task compare_tx1_rx0();
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
  
  device_tx_analysis_fifo = new("device_tx_analysis_fifo",this);
  device1_tx_analysis_fifo = new("device1_tx_analysis_fifo",this);
  device_rx_analysis_fifo = new("device_rx_analysis_fifo",this);
  device1_rx_analysis_fifo = new("device1_rx_analysis_fifo",this);
  
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

  super.run_phase(phase);

 forever begin
 
 `uvm_info(get_type_name(),$sformatf("before calling analysis fifo get method"),UVM_HIGH)
 fork begin
 device_tx_analysis_fifo.get(device0_tx_data);
 foreach(device0_tx_data.tx_data[i])begin
 tx0_data.push_back(device0_tx_data.tx_data[i]);
 `uvm_info(get_type_name(),$sformatf("printing tx0_data[%p]= %p",i, tx0_data[i]),UVM_HIGH)
 end

 device1_rx_analysis_fifo.get(device1_rx_data);

 foreach(device1_rx_data.rx_data[i])begin
 rx1_data.push_back(device1_rx_data.rx_data[i]);
 `uvm_info(get_type_name(),$sformatf("printing rx1_data[%p]=%p",i, rx1_data[i]),UVM_HIGH)
 end
 compare_tx0_rx1();
 tx_count++;

 `uvm_info(get_type_name(),$sformatf("tx_count=%0d",tx_count),UVM_HIGH)
end
 
 
 begin
 //`uvm_info(get_type_name(),$sformatf("printing device0_tx_data,device1_tx_data,\n%s, \n %s",device0_tx_data,device1_tx_data.sprint()),UVM_HIGH)
 device1_tx_analysis_fifo.get(device1_tx_data);

 foreach(device1_tx_data.tx_data[i])begin
 tx1_data.push_back(device1_tx_data.tx_data[i]);
 `uvm_info(get_type_name(),$sformatf("tx1_data[%p]= %p",i, tx1_data[i]),UVM_HIGH)
 end
 device_rx_analysis_fifo.get(device0_rx_data);

 foreach(device0_rx_data.rx_data[i])begin
 rx0_data.push_back(device0_rx_data.rx_data[i]);
 `uvm_info(get_type_name(),$sformatf("rx0_data[%p]=%p",i, rx0_data[i]),UVM_HIGH)
 end
 compare_tx1_rx0();
 rx_count++;

 `uvm_info(get_type_name(),$sformatf("rx_count=%0d",rx_count),UVM_HIGH)
 end
 join
 `uvm_info(get_type_name(),$sformatf("after calling analysis fifo get method"),UVM_HIGH) 
end

endtask : run_phase

//-------------------------------------------------------
// task compare
//-------------------------------------------------------
  task uart_scoreboard::compare_tx0_rx1(); 
  `uvm_info(get_type_name(),$sformatf("tx_data_size = %0d",tx0_data.size()),UVM_HIGH);
  `uvm_info(get_type_name(),$sformatf("rx_data_size = %0d",rx1_data.size()),UVM_HIGH);
   if (tx0_data.size() == rx1_data.size())begin

     `uvm_info (get_type_name(), $sformatf ("Size of tx data from device0_tx_data and device1_rx_data is equal"),UVM_HIGH);
     `uvm_info (get_type_name(), $sformatf ("Entering tx0_rx1 for loop "),UVM_HIGH);

  for(int i=0;i<tx0_data.size();i++) begin
 //foreach(tx0_data[i]) begin
    `uvm_info(get_type_name(),$sformatf("data size = %0d",tx0_data.size()),UVM_HIGH);
     `uvm_info (get_type_name(), $sformatf ("inside tx0_rx1 for loop "),UVM_HIGH);
    if(tx0_data[i] != rx1_data[i]) begin
     `uvm_error("ERROR_SC device0_tx_device1_rx_data_MISMATCH", 
                 $sformatf("device0_tx_data TX[%0d] = 'h%0x and device1_rx_data RX [%0d] = 'h%0x", 
                           i, tx0_data[i],
                           i, rx1_data[i]) );
   byte_data_cmp_failed_device0_tx_device1_rx_count++;

    `uvm_info (get_type_name(), $sformatf ("byte_data_cmp_failed_device0_tx_device1_rx_count :%0d",
                                            byte_data_cmp_failed_device0_tx_device1_rx_count),UVM_NONE);
   end


   else begin
     `uvm_info("SB_tx_data1_MATCH", 
                 $sformatf("device0_tx_data TX[%0d] = 'h%0x and device1_rx_data RX[%0d] = 'h%0x", 
                           i,tx0_data[i],
                           i,rx1_data[i]), UVM_HIGH);

   byte_data_cmp_verified_device0_tx_device1_rx_count++;

    `uvm_info (get_type_name(), $sformatf ("byte_data_cmp_verified_device0_tx_device1_rx_count :%0d",
                                            byte_data_cmp_verified_device0_tx_device1_rx_count),UVM_NONE);
            end
          end

     `uvm_info (get_type_name(), $sformatf ("Size of tx data from device0_tx_data and device1_rx_data  after checking data"),UVM_HIGH);
    end
  endtask :compare_tx0_rx1 
    
task uart_scoreboard::compare_tx1_rx0(); 
  `uvm_info(get_type_name(),$sformatf("tx_data_size = %0d",tx1_data.size()),UVM_HIGH);
  `uvm_info(get_type_name(),$sformatf("rx_data_size = %0d",rx0_data.size()),UVM_HIGH);

   if (tx1_data.size() == rx0_data.size())begin

     `uvm_info (get_type_name(), $sformatf ("Size of tx data from device1_tx_data and device0_rx_data is equal"),UVM_HIGH);
     `uvm_info (get_type_name(), $sformatf ("Entering tx1_rx0 for loop "),UVM_HIGH);
 foreach(tx1_data[i]) begin

    `uvm_info(get_type_name(),$sformatf("data size = %0d",tx1_data.size()),UVM_HIGH);
     `uvm_info (get_type_name(), $sformatf ("inside tx1_rx0 for loop "),UVM_HIGH);
   if(tx1_data[i] != rx0_data[i]) begin
     `uvm_error("ERROR_SC device1_tx_device0_rx_data_MISMATCH", 
                 $sformatf("device1_tx_data TX[%0d] = 'h%0x and device0_rx_data RX [%0d] = 'h%0x", 
                           i,tx1_data[i],
                           i,rx0_data[i]) );

   byte_data_cmp_failed_device1_tx_device0_rx_count++;

    `uvm_info (get_type_name(), $sformatf ("byte_data_cmp_failed_device1_tx_device0_rx_count :%0d",
                                            byte_data_cmp_failed_device1_tx_device0_rx_count),UVM_NONE);
   end
   else begin
     `uvm_info("SB_tx_data1_MATCH", 
            $sformatf("device1_tx_data TX[%0d] = 'h%0x and device0_rx_data RX[%0d] = 'h%0x", 
                           i,tx1_data[i],
                           i,rx0_data[i]), UVM_HIGH);

                           
   byte_data_cmp_verified_device1_tx_device0_rx_count++;

    `uvm_info (get_type_name(), $sformatf ("byte_data_cmp_verified_device1_tx_device0_rx_count :%0d",
                                            byte_data_cmp_verified_device1_tx_device0_rx_count),UVM_NONE);
    end
  end
     `uvm_info (get_type_name(), $sformatf ("Size of tx data from device1_tx_data and device0_rx_data is equal"),UVM_HIGH);
   end
   //else begin
   //  `uvm_error (get_type_name(),$sformatf("Size of device0_tx_data and device1_rx_data is not equal"));
   //end
   //
   //if (device1_tx_data.tx_data.size() == device0_rx_data.rx_data.size())begin 
   //  `uvm_info (get_type_name(), $sformatf ("Size of tx data from device1_tx_data and device0_rx_data is equal"),UVM_HIGH);
   //end
   //else begin
   //  `uvm_error (get_type_name(),$sformatf("Size of device1_tx_data and device0_rx_data is not equal"));
   //end
 endtask : compare_tx1_rx0
   //-------------------------------------------------------
   // check phase
   //-------------------------------------------------------
function void uart_scoreboard::check_phase(uvm_phase phase);
  super.check_phase(phase);

  $display(" ");
  $display("-------------------------------------------- ");
  $display("SCOREBOARD CHECK PHASE");
  $display("-------------------------------------------- ");
  $display(" ");

// 1. Check if the comparisions counter is NON-zero
//    A non-zero value indicates that the comparisions never happened and throw error
  
  if ((byte_data_cmp_verified_device0_tx_device1_rx_count != 0)&&(byte_data_cmp_failed_device0_tx_device1_rx_count == 0)) begin
	  `uvm_info (get_type_name(), $sformatf ("all tx comparisions are succesful"),UVM_NONE);
  end
  else begin
    `uvm_info (get_type_name(), $sformatf ("byte_data_cmp_verified_device0_tx_device1_rx_count :%0d",
                                            byte_data_cmp_verified_device0_tx_device1_rx_count),UVM_NONE);
	  `uvm_info (get_type_name(), $sformatf ("byte_data_cmp_failed_device0_tx_device1_rx_count : %0d", 
                                            byte_data_cmp_failed_device0_tx_device1_rx_count),UVM_NONE);
    `uvm_error (get_type_name(), $sformatf ("comparisions of tx with rx not happened"));
  end

  if ((byte_data_cmp_verified_device1_tx_device0_rx_count != 0)&&(byte_data_cmp_failed_device1_tx_device0_rx_count == 0) ) begin
	  `uvm_info (get_type_name(), $sformatf ("all rx comparisions are succesful"),UVM_NONE);
  end
  else begin
    `uvm_info (get_type_name(), $sformatf ("byte_data_cmp_verified_device1_tx_device0_rx_count :%0d",
                                            byte_data_cmp_verified_device1_tx_device0_rx_count),UVM_NONE);
	  `uvm_info (get_type_name(), $sformatf ("byte_data_cmp_failed_device1_tx_device0_rx_count : %0d", 
                                            byte_data_cmp_failed_device1_tx_device0_rx_count),UVM_NONE);
    end

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
   
  if (device_tx_analysis_fifo.size() == 0)begin
     `uvm_info (get_type_name(), $sformatf ("device0_tx_analysis_fifo is empty"),UVM_HIGH);
  end
  else begin
     `uvm_info (get_type_name(), $sformatf ("device0_tx_analysis_fifo:%0d",device_tx_analysis_fifo.size() ),UVM_HIGH);
     `uvm_error (get_type_name(), $sformatf ("device0_tx_analysis FIFO is not empty"));
  end
  
  if (device1_tx_analysis_fifo.size() == 0)begin
     `uvm_info (get_type_name(), $sformatf ("device1_tx_analysis_fifo is empty"),UVM_HIGH);
  end
  else begin
     `uvm_info (get_type_name(), $sformatf ("device1_tx_analysis_fifo:%0d",device1_tx_analysis_fifo.size() ),UVM_HIGH);
     `uvm_error (get_type_name(), $sformatf ("device1_tx_analysis FIFO is not empty"));
  end
  
  if (device_rx_analysis_fifo.size()== 0)begin
     `uvm_info (get_type_name(), $sformatf ("device0_rx_analysis_FIFO is empty"),UVM_HIGH);
  end
  else begin
     `uvm_info (get_type_name(), $sformatf ("device0_rx_analysis_fifo:%0d",device_rx_analysis_fifo.size()),UVM_HIGH);
     `uvm_error (get_type_name(),$sformatf ("device0_rx_analysis FIFO is not empty"));
  end

  if (device1_rx_analysis_fifo.size()== 0)begin
     `uvm_info (get_type_name(), $sformatf ("device1_rx_analysis_FIFO is empty"),UVM_HIGH);
  end
  
  else begin
     `uvm_info (get_type_name(), $sformatf ("device1_rx_analysis_fifo:%0d",device1_rx_analysis_fifo.size()),UVM_HIGH);
     `uvm_error (get_type_name(),$sformatf ("device1_rx_analysis FIFO is not empty"));
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
  `uvm_info (get_type_name(),$sformatf("No. of transactions from rx:%0d",
                             rx_count),UVM_NONE);

  //Number of comparisions done in between device0_tx and device1_rx
  `uvm_info (get_type_name(),$sformatf("Total no. of byte wise tx0 comparisions with rx1:%0d",
                 byte_data_cmp_verified_device0_tx_device1_rx_count+byte_data_cmp_failed_device0_tx_device1_rx_count),UVM_HIGH);
  //Number of comparisions done in between device1_tx and device0_rx
  `uvm_info (get_type_name(),$sformatf("Total no. of byte wise tx1 comparisions with rx0:%0d",
                 byte_data_cmp_verified_device1_tx_device0_rx_count+byte_data_cmp_failed_device1_tx_device0_rx_count),UVM_HIGH);
  



  //Number of tx comparisios passed for device0_tx and device1_rx
  `uvm_info (get_type_name(),$sformatf("Total no. of byte wise tx and rx comparisions passed:%0d",
                byte_data_cmp_verified_device0_tx_device1_rx_count),UVM_NONE);

  //Number of tx compariosn failed for device0_tx and device1_rx
  `uvm_info (get_type_name(),$sformatf("No. of byte wise tx and rx comparision failed:%0d",
                byte_data_cmp_failed_device0_tx_device1_rx_count),UVM_NONE);

  //Number of tx comparisios passed for device1_tx and device0_rx
  `uvm_info (get_type_name(),$sformatf("Total no. of byte wise tx and rx comparisions passed:%0d",
                byte_data_cmp_verified_device1_tx_device0_rx_count),UVM_NONE);

  //Number of tx compariosn failed for device1_tx and device0_rx
  `uvm_info (get_type_name(),$sformatf("No. of byte wise tx and rx comparision failed:%0d",
                byte_data_cmp_failed_device1_tx_device0_rx_count),UVM_NONE);
endfunction : report_phase

`endif

