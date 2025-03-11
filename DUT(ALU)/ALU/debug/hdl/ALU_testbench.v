module ALU_testbench (
	output reg   clk   , // semnal de ceas
	output reg   reset_n ,  // semnal de reset asincron, activ low
	output reg   psel ,
	output reg   penable,
	output reg   pwrite,
	output reg   [31:0] paddr,
	output reg   [31:0] pwdata
	
);

initial begin
  clk = 1'b0; 
  forever #5 clk = ~clk;
end

initial begin
  reset_n <= 1'b0;  
  @(posedge clk);
  reset_n <= 1'b1;
  @(posedge clk);
  @(posedge clk);
  reset_n <= 1'b1;  
  @(posedge clk);
end

initial begin
pwdata <= 32'b01100000010000011100000011000000;
@(posedge clk);
  psel <= 1'b1;  
  @(posedge clk);
  penable <= 1'b1;
  @(posedge clk);
   pwrite <= 1'b1;
  @(posedge clk);
	paddr <= 0;  
  @(posedge clk);
  
end






endmodule // ALU_testbench