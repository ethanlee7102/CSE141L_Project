// control decoder
module Control #(parameter opwidth = 3, mcodebits = 9)(
  input [mcodebits-1:0] instr,    // subset of machine code (any width you need)
  output logic RegDst, Branch, how_high,
     MemtoReg, MemWrite, ALUSrc, RegWrite,
  output logic[opwidth-1:0] ALUOp);	   // for up to 8 ALU operations

always_comb begin
// defaults
  RegDst 	=   'b0;   // 1: not in place  just leave 0
  Branch 	=   'b0;   // 1: branch (jump)
  how_high = 'b0;    // 
  MemWrite  =	'b0;   // 1: store to memory
  ALUSrc 	=	'b0;   // 1: immediate  0: second reg file output
  RegWrite  =	'b1;   // 0: for store or no op  1: most other operations 
  MemtoReg  =	'b0;   // 1: load -- route memory instead of ALU to reg_file data in
  ALUOp	    =   'b000; 
// sample values only -- use what you need
case(instr[8:6])    // override defaults with exceptions

       // ALU Ops
  'b000:  begin
      ALUOp = 'b000;  // add:  y = a+b
      RegWrite  =	'b1;
  end
  'b001:  begin
      ALUOp = 'b001;  // left shift
      RegWrite  =	'b1;
  end
  'b010:  begin
      ALUOp = 'b010;  // right shift
      RegWrite  =	'b1;
  end
  'b011:  begin 
      ALUOp = 'b011;  // NAND
      RegWrite  =	'b1;
  end
  'b100:  begin
      ALUOp = 'b100;  // SUB
      RegWrite  =	'b1;
  end

  'b101:  begin				  // load
			MemtoReg = 'b1;
      RegWrite  =	'b1;    
  end
  
  'b110:  begin					// store operation
      MemWrite = 'b1;      // write to data mem
      RegWrite = 'b0;      // typically don't also load reg_file
	end

  'b111: begin    // branch
    Branch = 'b1;
    how_high = instr[4:3];
  end
// ...
endcase

end
	
endmodule