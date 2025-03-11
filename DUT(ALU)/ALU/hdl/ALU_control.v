module ALU_control (
    input wire clk,
    input wire reset_n,
    input wire psel,
    input wire penable,
    input wire [31:0] paddr,
    input wire pwrite,
    input wire [31:0] pwdata,
    output reg [31:0] prdata,
    output reg pready,
    output reg pslverr,
	output reg [8:0] result
);

    reg [31:0] received_data;  
	reg init;
	reg endop;
	reg [4:0] currentState, nextState;
	reg load_op, shift_op1, add1, add2, add3, si, sau, nsi, nsau, comp;
	
	reg [7:0] op1;
	reg [7:0] op2;
	reg [4:0] constanta;
	
	
	//Comunicatie APB
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            pready <= 1'b0;
            pslverr <= 1'b0; 
			init <= 1'b0;
			received_data <= 0;
        end else begin
            if (psel && penable && !init) begin
                if (pwrite) begin
                    received_data <= pwdata;
                    pready <= 1'b1;
					init <= 1'b1;
                end else begin
                    
                    prdata <= received_data;
                    pready <= 1'b1;
					init <= 1'b0;
                end
            end else begin
                pready <= 1'b0;
            end
        end
    end
	
	 // Definirea starilor
    localparam INIT  = 5'b00000;
	localparam SETUP = 5'b00001;
	localparam ADD1  = 5'b00010;
	localparam ADD2  = 5'b00011;
	localparam ADD3  = 5'b00100;
	localparam SHIFT_OP1 = 5'b00101;
	localparam OR    = 5'b00110;
	localparam AND   = 5'b00111;
	localparam NOR   = 5'b01000;
	localparam NAND  = 5'b01001;
	localparam COMP  = 5'b01010;
	localparam ENDOP = 5'b01011;
	
    
	
	 always @(*) begin
        nextState = currentState; 
        case (currentState)
            INIT: begin
                if (!reset_n)
                    nextState = INIT;
                else if (init)
                    nextState = SETUP;
            end

            SETUP: begin
                if (!reset_n)
                    nextState = INIT;
                else if (received_data[31:28] == 4'b0001)
                    nextState = ADD1;
                else if (received_data[31:28] == 4'b0010)
                    nextState = ADD2;
                else if (received_data[31:28] == 4'b0011)
                    nextState = ADD3;
                else if (received_data[31:28] == 4'b0100)
                    nextState = SHIFT_OP1;
                else if (received_data[31:28] == 4'b0101)
                    nextState = AND;
                else if (received_data[31:28] == 4'b0110)
                    nextState = OR;
                else if (received_data[31:28] == 4'b0111)
                    nextState = NAND;
                else if (received_data[31:28] == 4'b1000)
                    nextState = NOR;
                else if (received_data[31:28] == 4'b1001)
                    nextState = COMP;
                else if (endop)
                    nextState = ENDOP;
            end
			ADD1: begin
                if (!reset_n)
                    nextState = INIT;
                else if (endop)
                    nextState = ENDOP;
            end
			
			ADD2: begin
                if (!reset_n)
                    nextState = INIT;
                else if (endop)
                    nextState = ENDOP;
            end
			
			ADD3: begin
                if (!reset_n)
                    nextState = INIT;
                else if (endop)
                    nextState = ENDOP;
            end
			
			SHIFT_OP1: begin
                if (!reset_n)
                    nextState = INIT;
                else if (endop)
                    nextState = ENDOP;
            end
			AND: begin
                if (!reset_n)
                    nextState = INIT;
                else if (endop)
                    nextState = ENDOP;
            end
			OR: begin
                if (!reset_n)
                    nextState = INIT;
                else if (endop)
                    nextState = ENDOP;
            end
			
			NAND: begin
                if (!reset_n)
                    nextState = INIT;
                else if (endop)
                    nextState = ENDOP;
            end
			NOR: begin
                if (!reset_n)
                    nextState = INIT;
                else if (endop)
                    nextState = ENDOP;
            end
			COMP: begin
                if (!reset_n)
                    nextState = INIT;
                else if (endop)
                    nextState = ENDOP;
            end
			
			
            ENDOP: begin
                if (!reset_n)
                    nextState = INIT;
                else
                    nextState = INIT;
            end

            default: nextState = INIT;
        endcase
    end
	
	always @(*) begin
        load_op = (currentState == SETUP)  ? 1 : 0;
        shift_op1 = (currentState == SHIFT_OP1) ? 1 : 0;
        add1 = (currentState == ADD1)    ? 1 : 0;
        add2 = (currentState == ADD2) ? 1 : 0;
        add3 = (currentState == ADD3)    ? 1 : 0;
        si   = (currentState == AND)  ? 1 : 0;
		sau   = (currentState == OR)  ? 1 : 0;
		nsi  = (currentState == NAND)  ? 1 : 0;
		nsau  = (currentState == NOR)  ? 1 : 0;
		comp  = (currentState == COMP)  ? 1 : 0;
		init  = (currentState == ENDOP)  ? 0 : 1;
		endop  = (currentState == INIT)  ? 0 : 1;
    end
	
	always @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            currentState <= INIT;
        else
            currentState <= nextState;
    end
	
	
//REG OP1
always @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            op1 <= 8'b00000000;
			
        else if (load_op)
			op1 <= received_data [13:6] ;		
    end


//REG OP2
always @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            op2 <= 8'b00000000;
			
        else if (load_op)
			op2 <= received_data [21:14] ;		
    end

//REG CONST
always @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            constanta <= 4'b0000;
			
        else if (load_op)
			constanta <= received_data [25:22] ;		
    end
	
	
//REG RESULT
//ADD1
always @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            result <= 9'b000000000;
			
        else if (add1) begin
			result <= op1 + op2 ;
			endop  <= 1 ;
			end
    end
//ADD2
always @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            result <= 9'b000000000;
			
        else if (add2) begin
			result <= op1 + { 4'b0000, constanta} ;
			endop  <= 1 ;
			end
    end
//ADD3
always @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            result <= 9'b000000000;
			
        else if (add3) begin
			result <= op1 + { 4'b0000, constanta} ;
			endop  <= 1 ;
			end
    end
//SHIFT_OP1
/* always @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            result <= 9'b000000000;
			
        else if (shift_op1) begin
			result <=  ;
			endop  <= 1 ;
			end
    end */

//AND
always @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            result <= 9'b000000000;
			
        else if (si) begin
			result <= op1 & op2 ;
			endop  <= 1 ;
			end
    end
	
//OR
always @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            result <= 9'b000000000;
			
			
        else if (sau) begin
			result <= op1 | op2 ;
			endop  <= 1 ;
			end
    end

	
	
	
	


endmodule