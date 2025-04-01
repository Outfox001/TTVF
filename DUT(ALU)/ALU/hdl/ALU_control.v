module ALU_control (
    input wire clk,
    input wire reset_n,
    input wire psel,
    input wire penable,
    input wire [31:0] paddr,
    input wire pwrite,
    input wire [31:0] pwdata,
	input wire state,
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
	
	reg [5:0] result_address;
	
	reg [8:0] ResultReg_0 ;
	reg [8:0] ResultReg_1 ;
	reg [8:0] ResultReg_2 ;
	reg [8:0] ResultReg_3 ;
	reg [8:0] ResultReg_4 ;
	reg [8:0] ResultReg_5 ;
	reg [8:0] ResultReg_6 ;
	reg [8:0] ResultReg_7 ;
	reg [8:0] ResultReg_8 ;
	reg [8:0] ResultReg_9 ;
	reg [8:0] ResultReg_10 ;
	reg [8:0] ResultReg_11 ;
	reg [8:0] ResultReg_12 ;
	reg [8:0] ResultReg_13 ;
	reg [8:0] ResultReg_14 ;
	reg [8:0] ResultReg_15 ;
	
	
	
	//Comunicatie APB
    always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        pready <= 1'b0;
        pslverr <= 1'b0; 
        init <= 1'b0;
        received_data <= 0;
    end else begin
        if (psel && penable && !init && state) begin
            if (pwrite) begin
                received_data <= pwdata;
                pready <= 1'b1;
                init <= 1'b1;
            end else begin
                case (paddr)
                    32'd0  : prdata <= ResultReg_0;
                    32'd1  : prdata <= ResultReg_1;
                    32'd2  : prdata <= ResultReg_2;
                    32'd3  : prdata <= ResultReg_3;
                    32'd4  : prdata <= ResultReg_4;
                    32'd5  : prdata <= ResultReg_5;
                    32'd6  : prdata <= ResultReg_6;
                    32'd7  : prdata <= ResultReg_7;
                    32'd8  : prdata <= ResultReg_8;
                    32'd9  : prdata <= ResultReg_9;
                    32'd10 : prdata <= ResultReg_10;
                    32'd11 : prdata <= ResultReg_11;
                    32'd12 : prdata <= ResultReg_12;
                    32'd13 : prdata <= ResultReg_13;
                    32'd14 : prdata <= ResultReg_14;
                    32'd15 : prdata <= ResultReg_15;
                    32'd16 : prdata <= received_data;  
                endcase

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
			result <= op2 + { 4'b0000, constanta} ;
			endop  <= 1 ;
			end
    end
//SHIFT_OP1
 always @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            result <= 9'b000000000;
			
        else if (shift_op1) begin
			result <= op1 << received_data[27:26] ;
			endop  <= 1 ;
			end
    end 

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
//NOR
	always @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            result <= 9'b000000000;
			
			
        else if (nsau) begin
			result <= ~ (op1 | op2 );
			endop  <= 1 ;
			end
    end
	
//NAND
always @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            result <= 9'b000000000;
			
        else if (si) begin
			result <= ~(op1 & op2) ;
			endop  <= 1 ;
			end
    end
	
//COMP
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        result <= 9'b000000000;
        endop  <= 0;
    end else if (comp) begin
        if (op1 > op2) begin
            result <= 9'b000000001;
            endop  <= 1;
        end else if (op1 < op2) begin
            result <= 9'b000000010;
            endop  <= 1;
        end else if (op1 == op2) begin
            result <= 9'b100000000;
            endop  <= 1;
        end
    end
end

always @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            result_address <= 6'b000000;
		else
			result_address <= received_data[5:0];
		
    end


//ResultRegisters

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        ResultReg_0  <= 8'b0;
        ResultReg_1  <= 8'b0;
        ResultReg_2  <= 8'b0;
        ResultReg_3  <= 8'b0;
        ResultReg_4  <= 8'b0;
        ResultReg_5  <= 8'b0;
        ResultReg_6  <= 8'b0;
        ResultReg_7  <= 8'b0;
        ResultReg_8  <= 8'b0;
        ResultReg_9  <= 8'b0;
        ResultReg_10 <= 8'b0;
        ResultReg_11 <= 8'b0;
        ResultReg_12 <= 8'b0;
        ResultReg_13 <= 8'b0;
        ResultReg_14 <= 8'b0;
        ResultReg_15 <= 8'b0; 
		pslverr <= 0;
    end else begin
        case (result_address)
            6'd0  : ResultReg_0  <= result;
            6'd1  : ResultReg_1  <= result;
            6'd2  : ResultReg_2  <= result;
            6'd3  : ResultReg_3  <= result;
            6'd4  : ResultReg_4  <= result;
            6'd5  : ResultReg_5  <= result;
            6'd6  : ResultReg_6  <= result;
            6'd7  : ResultReg_7  <= result;
            6'd8  : ResultReg_8  <= result;
            6'd9  : ResultReg_9  <= result;
            6'd10 : ResultReg_10 <= result;
            6'd11 : ResultReg_11 <= result;
            6'd12 : ResultReg_12 <= result;
            6'd13 : ResultReg_13 <= result;
            6'd14 : ResultReg_14 <= result;
            6'd15 : ResultReg_15 <= result; 
			
            default:  pslverr <= 1; 
        endcase
    end
end


endmodule