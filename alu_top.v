module alu_top(
  input clk,
  input reset,
  input [4:0] sw_A, 
  input [4:0] sw_B, 
  input [1:0] op_sel, 
  output [9:0] alu_out 
);
  reg [4:0] regA, regB;
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      regA <= 5'b0;
      regB <= 5'b0;
    end else begin
      regA <= sw_A;
      regB <= sw_B;
    end
  end

  wire [5:0] add_sub_res;
  assign add_sub_res = (op_sel[0]) ? (regA - regB) : (regA + regB);

  wire [9:0] m0 = regB[0] ? {5'b0, regA} : 10'b0;
  wire [9:0] m1 = regB[1] ? {4'b0, regA, 1'b0} : 10'b0;
  wire [9:0] m2 = regB[2] ? {3'b0, regA, 2'b0} : 10'b0;
  wire [9:0] m3 = regB[3] ? {2'b0, regA, 3'b0} : 10'b0;
  wire [9:0] m4 = regB[4] ? {1'b0, regA, 4'b0} : 10'b0;
  wire [9:0] mul_res = m0 + m1 + m2 + m3 + m4;

  reg [9:0] mux_out;
  always @(*) begin
    case(op_sel)
      2'b00: mux_out = {4'b0, add_sub_res};
      2'b01: mux_out = {4'b0, add_sub_res};
      2'b10: mux_out = mul_res;
      default: mux_out = 10'b0;
    endcase
  end

  reg [9:0] final_out;
  always @(posedge clk or posedge reset) begin
    if (reset) final_out <= 10'b0;
    else final_out <= mux_out;
  end

  assign alu_out = final_out;
endmodule
