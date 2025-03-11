//------------------------------------------------------------------------------
// Universitatea Transilvania din Brasov
// Departamentul de Electronica si Calculatoare
// Proiect     : Laborator HDL
// Modul       : ck_rst_tb
// Autor       : Dan NICULA (DN)
// Data        : Oct. 1, 2019
//------------------------------------------------------------------------------
// Descriere   : Generator de semnale de ceas si de reset asincron (activ low)
//------------------------------------------------------------------------------
// Modificari  :
// Oct. 1, 2019 (DN): Initial 
//------------------------------------------------------------------------------

module ck_rst_tb (
output reg   clk   , // semnal de ceas
output reg   rst_n   // semnal de reset asincron, activ low
);

initial begin
  clk = 1'b0; 
  forever #5 clk = ~clk;
end

initial begin
  rst_n <= 1'b1;  
  @(posedge clk);
  rst_n <= 1'b0;
  @(posedge clk);
  @(posedge clk);
  rst_n <= 1'b1;  
  @(posedge clk);
end

endmodule // ck_rst_tb

