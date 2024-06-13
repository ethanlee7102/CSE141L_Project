module PC_LUT #(parameter D=12)(
  input       [ 1:0] addr,	   // target 4 values
  output logic[D-1:0] target);
  
  always_comb begin
    case(addr)
      0: target = 3;   
      1: target = 10;   
      2: target = 50;  
      3: target = 100;
      default: target = 0;  // jumps to zero 
    endcase
  end

endmodule

