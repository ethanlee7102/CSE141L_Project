module PC_LUT #(parameter D=12)(
  input       [ 1:0] addr,	   // target 4 values
  input       [7:0] jt1,
  input       [7:0] jt2,
  input       [7:0] jt3,
  input       [7:0] jt4,
  output logic[D-1:0] target);
  
  always_comb begin
    case(addr)
      0: target = {4'b0000, jt1};   
      1: target = {4'b0000, jt2};   
      2: target = {4'b0000, jt3};  
      3: target = {4'b0000, jt4};
      default: target = {4'b0000, 8'b0};  // jumps to zero 
    endcase
  end

endmodule

