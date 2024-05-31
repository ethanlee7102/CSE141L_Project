module PC_LUT #(parameter D=12)(
  input       [ 1:0] addr,	   // target 4 values
  input		  [D-1:0] jt1,
  input		  [D-1:0] jt2,
  input		  [D-1:0] jt3,
  input		  [D-1:0] jt4,
  output logic[D-1:0] target);

  always_comb case(addr)
    0: target = jt1;   
	1: target = jt2;   
	2: target = jt3;  
	3: target = jt4;
	default: target = 'b0;  // jumps to zero 
  endcase

endmodule


