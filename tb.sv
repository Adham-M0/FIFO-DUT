
interface fifo_if (input clk);

  
    logic reset;
    logic Wr_enable;
    logic [7:0] data_in;
    logic Read_enable;
    logic full;
    logic empty;
    logic [7:0] data_out;
    clocking cb @(posedge clk);
      default input #1 output #1 ;
      output reset, Wr_enable,data_in ,Read_enable ;
      input full ,empty,data_out  ;
    endclocking
  
  modport tb  (clocking cb);
    modport dut (input reset, Wr_enable,data_in ,Read_enable,output full ,empty,data_out );
 endinterface;
     
class fifo_rand;
      
      
  rand logic [7:0] first_data;
  rand logic [7:0] second_data;
  rand logic [7:0] third_data;
  rand logic [7:0] fourth_data;
  rand logic wr_enable_rand;
  rand logic read_enable_rand;
  rand logic reset_rand;
       
  constraint randomize_data
    {
    // Constraints for first data
    first_data inside {[100:230]};
    // Constraints for second data
    second_data inside {[200:255]};
    // Constraints for third data
    third_data dist {
      [0:100] :/ 30,
      [100:200] :/ 60,
      [200:255] :/ 10
    };
    // Constraints for fourth data
    if (first_data > 150)
      fourth_data inside {[0:50]};
    else
      fourth_data inside {[0:255]};
    // Constraints for write enable
    wr_enable_rand dist {
      1'b0 := 10,
      1'b1 := 90
    };
     read_enable_rand != wr_enable_rand;

    // Constraints for read enable
    read_enable_rand dist {
      1'b0 := 50,
      1'b1 := 50
    };
    
    reset_rand dist {
      1'b0 := 99,
      1'b1 := 1
    };
      
    }
      
    endclass
    
    module FIFO_tb (fifo_if.tb if_tb,input clk);
      
        fifo_rand r0;
     
        initial  begin
           r0 = new;
          forever
            begin
          r0.randomize();
          
          if_tb.cb.reset<=r0.reset_rand;
          
          if_tb.cb.Wr_enable<=r0.wr_enable_rand;

          if_tb.cb.Read_enable<=r0.read_enable_rand;

          if_tb.cb.data_in<=r0.first_data;
          #10

          if_tb.cb.data_in<=r0.second_data;
          #10
          
          if_tb.cb.data_in<=r0.third_data;
          #10
          
         
          if_tb.cb.data_in<=r0.fourth_data;
        end 
          end
      
 covergroup covp @(posedge clk);
		CP1: coverpoint if_tb.cb.full;
		CP2: coverpoint if_tb.cb.empty;


	
endgroup
      covp cov1;
      initial begin 
        cov1=new();
      end
      
    endmodule
    module top;
           bit clk;
    always #10 clk = ~clk;
 
      fifo_if if0(clk) ; 
      FIFO dut (if0.dut,clk);
      FIFO_tb t1 (if0.tb,clk);
      
      initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    #4000 $finish;
  end
    endmodule
