// control decoder
module Control #(parameter opwidth = 3, mcodebits = 9)(
  input [mcodebits-1:0] instr,    // subset of machine code (any width you need)
  input logic zero,
  output logic RegDst, Branch,
     MemtoReg, MemWrite, ALUSrc, RegWrite,
  output logic [1:0] how_high,
  output logic[opwidth-1:0] ALUOp,	   // for up to 8 ALU operations
  output logic sc_en, sc_clr);   

always_comb begin
// defaults
  RegDst 	=   'b0;   // 1: not in place  just leave 0
  Branch 	=   'b0;   // 1: branch (jump)
  how_high = 'b00;    // 
  MemWrite  =	'b0;   // 1: store to memory
  ALUSrc 	=	'b0;   // 1: immediate  0: second reg file output
  RegWrite  =	'b1;   // 0: for store or no op  1: most other operations 
  MemtoReg  =	'b0;   // 1: load -- route memory instead of ALU to reg_file data in
  ALUOp	    =   'b000; 
  sc_en    = 'b0;   
  sc_clr   = 'b1;
// sample values only -- use what you need
case(instr[8:6])    // override defaults with exceptions

       // ALU Ops
  'b000:  begin
      ALUSrc = 'b0;
      ALUOp = 'b000;  // add:  y = a+b
      RegWrite  =	'b1;
      sc_clr = 'b1;
      MemtoReg = 'b0;
  end
  'b001:  begin
      ALUSrc = 'b0;
      ALUOp = 'b001;  // left shift
      RegWrite  =	'b1;
      sc_en = 'b1;
      MemtoReg = 'b0;
  end
  'b010:  begin
      ALUSrc = 'b0;
      ALUOp = 'b010;  // right shift
      RegWrite  =	'b1;
      sc_en = 'b1;
      MemtoReg = 'b0;
  end
  'b011:  begin 
      ALUSrc = 'b0;
      ALUOp = 'b011;  // NAND
      RegWrite  =	'b1;
      sc_clr = 'b1;
      MemtoReg = 'b0;
  end
  'b100:  begin
      ALUSrc = 'b0;
      ALUOp = 'b100;  // SUB
      RegWrite  =	'b1;
      sc_clr = 'b1;
      MemtoReg = 'b0;
  end

  'b101:  begin				  // load
      ALUSrc = 'b0;
			MemtoReg = 'b1;
      RegWrite  =	'b1; 
      sc_clr = 'b1;   
  end
  
  'b110:  begin					// store operation
      ALUSrc = 'b0;
      MemWrite = 'b1;      // write to data mem
      RegWrite = 'b0;      // typically don't also load reg_file
      sc_clr = 'b1;
      MemtoReg = 'b0;
	end

  'b111: begin    // branch or addi
    Branch = 'b1;
    how_high = instr[4:3];
    if (instr[5] == 'b1) begin
      ALUOp = 'b000;
      Branch = 'b0;
      ALUSrc = 'b1;
      RegWrite  =	'b1;
      sc_clr = 'b1;
      MemtoReg = 'b0;
    end
    if (instr[5] == 'b0) begin
        ALUSrc = 'b0;
        Branch = zero;  // Branch if zero flag is set
        sc_clr = 'b1;
        MemtoReg = 'b0;
    end
  end
// ...
endcase

end
	
endmodule