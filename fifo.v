module FIFO #(parameter
    ADDR_WIDTH           = 5,
    DATA_WIDTH           = 8,
    fifo_size                   =2**ADDR_WIDTH
             )(fifo_if.dut if_dut,input clk); 
    reg  [DATA_WIDTH-1:0] FIFO  [fifo_size-1:0] ;
  reg [ADDR_WIDTH-1:0] write_ptr=0,read_ptr=0;

    assign if_dut.empty   = ( write_ptr == read_ptr ) ? 1'b1 : 1'b0;
    assign if_dut.full    = ( read_ptr == (write_ptr+1'b1) ) ? 1'b1 : 1'b0;
integer i;
  always @ (posedge clk , posedge if_dut.reset) begin
        if(if_dut.reset) begin
         for(i=0;i<fifo_size;i=i+1) begin
            FIFO[i]<=0;
         end
         write_ptr <=0;
        end
  else if( if_dut.Wr_enable && ~if_dut.full) begin
            FIFO[write_ptr] <= if_dut.data_in;
              write_ptr <= write_ptr + 1;
        end

    end

  always @ (posedge clk, posedge if_dut.reset) begin

        if(if_dut.reset) begin
            if_dut.data_out <= 0;
            read_ptr <= 0;
        end

        else if( if_dut.Read_enable && ~if_dut.empty) begin
            if_dut.data_out <= FIFO[read_ptr];
            read_ptr <= read_ptr + 1;
        end

    end
  property p_writeptr;
    @(posedge clk)
    (if_dut.Wr_enable && ~if_dut.full) |=> (write_ptr == $past(write_ptr) + 1);
   endproperty
  assert property (p_writeptr);
    
property p_full_rise;
    @(posedge clk)
  (if_dut.Wr_enable && (write_ptr - read_ptr == fifo_size - 1)) |=> $rose(if_dut.full);
endproperty

assert property (p_full_rise);

property p_empty_stayslow;
    @(posedge clk)
  (if_dut.Wr_enable && (write_ptr == read_ptr) && !$past(if_dut.empty)) |=> !($rose(if_dut.empty));
endproperty

assert property (p_empty_stayslow);

  property p_readptr;
    @(posedge clk)
    (if_dut.Read_enable && ~if_dut.empty) |=> (read_ptr == $past(read_ptr) + 1);
   endproperty
  assert property (p_readptr);



endmodule
