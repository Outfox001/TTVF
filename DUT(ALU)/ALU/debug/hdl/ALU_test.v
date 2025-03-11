module ALU_test();

wire clk;
wire reset_n;
wire psel;
wire penable;
wire pwrite;
wire pready;
wire  [31:0] paddr;
wire  [31:0] pwdata;
wire  [8:0]  result;

//DUT

ALU_control instALU_control(

.clk(clk),
.reset_n(reset_n),
.psel(psel),
.penable(penable),
.paddr(paddr),
.pwrite(pwrite),
.pwdata(pwdata),
.pready(pready),
.result(result)



);

//TB

ALU_testbench instALU_testbench(

.clk    (clk), 
.reset_n  (reset_n),  
.psel   (psel),
.penable(penable),
.pwrite (pwrite),
.paddr  (paddr),
.pwdata (pwdata)



);


endmodule