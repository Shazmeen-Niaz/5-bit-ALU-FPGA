module alu_tb();
  reg clk, reset;
  reg [4:0] sw_A, sw_B;
  reg [1:0] op_sel;
  wire [9:0] alu_out;

  alu_top uut (
    .clk(clk), .reset(reset),
    .sw_A(sw_A), .sw_B(sw_B),
    .op_sel(op_sel), .alu_out(alu_out)
  );

  always #5 clk = ~clk;

  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars(0, alu_tb);
    clk = 0; reset = 1;
    #15 reset = 0;
    sw_A = 5'd6;  sw_B = 5'd6;  op_sel = 2'b00;
    #20 $display("Add Result: %d", alu_out);
    sw_A = 5'd15; sw_B = 5'd9;  op_sel = 2'b01;
    #20 $display("Sub Result: %d", alu_out);
    sw_A = 5'd4;  sw_B = 5'd4;  op_sel = 2'b10;
    #20 $display("Mul Result: %d", alu_out);
    #20 $finish;
  end
endmodule
