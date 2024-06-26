// sample top level design
module top_level(
  input        clk, reset, req, 
  output logic done);
  parameter D = 12,             // program counter width
    A = 3;             		  // ALU command bit width
  wire[D-1:0] target, 			  // jump 
              prog_ctr;
  wire        RegWrite;
  wire[7:0]   datA,datB,		  // from RegFile
              muxA, muxMem,
			  rslt, dat_out,              // alu output
              immed;
  logic sc_in,   				  // shift/carry out from/to ALU
   		pariQ,              	  // registered parity flag from ALU
		zeroQ;                    // registered zero flag from ALU 
  wire  absj;                     // from control to PC; abs jump enable
  wire  pari,
        zero,
		sc_clr,
		sc_en,
        MemWrite,
        MemtoReg,
        ALUSrc;		              // immediate switch
  wire[A-1:0] alu_cmd;
  wire[8:0]   mach_code;          // machine code
  wire[2:0] rd_addrA, rd_addrB;    // address pointers to reg_file
  logic[1:0] how_high;
// fetch subassembly
  PC #(.D(D)) 					  // D sets program counter width
     pc1 (.reset(reset)            ,
         .clk(clk)              ,
		 .reljump_en (relj),
		 .absjump_en (absj),
		 .target(target)           ,
		 .prog_ctr(prog_ctr)          );

// lookup table to facilitate jumps/branches
  PC_LUT #(.D(D))
    pl1 (.addr  (how_high),
         .target(target)          );   

// contains machine code
  instr_ROM ir1(.prog_ctr(prog_ctr),
               .mach_code(mach_code));

// control decoder
  Control ctl1(.instr(mach_code),
  .zero(zero),
  .RegDst  (), 
  .Branch  (absj)  , 
  .how_high ,
  .MemWrite , 
  .ALUSrc   , 
  .RegWrite   ,     
  .MemtoReg,
  .ALUOp(),
  .sc_en,
  .sc_clr);

  assign rd_addrB = mach_code[2:0];
  assign rd_addrA = mach_code[5:3];
  assign alu_cmd  = mach_code[8:6];
  assign immed = mach_code[4:3];

  assign muxMem = MemtoReg? dat_out : rslt;

  reg_file #(.pw(3)) rf1(.dat_in(muxMem),	   // loads, most ops
              .clk         ,
              .wr_en   (RegWrite),
              .rd_addrA(rd_addrA),
              .rd_addrB(rd_addrB),
              .wr_addr (rd_addrB),      // in place operation
              .datA_out(datA),
              .datB_out(datB)); 

  assign muxA = ALUSrc? immed : datA;

  alu alu1(.alu_cmd(alu_cmd),
         .inA    (muxA),
		 .inB    (datB),
		 .sc_i   (sc_in),   // output from sc register
     .how_high (how_high),
		 .rslt   (rslt),
		 .sc_o   (sc_o), // input to sc register
     .zero(zero),
		 .pari  );  

  dat_mem dm(.dat_in(datB)  ,  // from reg_file
             .clk           ,
			 .wr_en  (MemWrite), // stores
			 .addr   (datA),
             .dat_out(dat_out));

// registered flags from ALU
  always_ff @(posedge clk) begin
    pariQ <= pari;
	zeroQ <= zero;
    if(sc_clr)
	  sc_in <= 'b0;
    else if(sc_en)
      sc_in <= sc_o;
  end

  assign done = prog_ctr == 128;
 
endmodule