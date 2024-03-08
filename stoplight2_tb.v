`timescale 1 ns / 1 ps
module stoplight2_tb;
   reg Ped, CLK;
   stoplight2 x1(Ped, CLK, SigG, SigY, SigR); // Instantiate the stoplight1 module
   initial begin
      // Initial inputs and states
      x1.S0 = 0;
      x1.S1 = 0;
      x1.S2 = 0;
      x1.S3 = 0;
      x1.S4 = 0;
      CLK = 0;
      Ped = 0;

      $dumpfile("stoplight2_dump.vcd");
      $dumpvars(0, stoplight2_tb);
      #200000 $finish;
   end

   always #10 CLK = ~CLK;

   always @(posedge CLK) begin
      if ($time <= 100000) begin
          if ({x1.S4,x1.S3,x1.S2,x1.S1,x1.S0} == 5'b01000) begin
              $display("%8d", $time," state: ",x1.S4,x1.S3,x1.S2,x1.S1,x1.S0, " (reached target)");
              $display("Cycles until the target is reached: " , "%8d", $time);
              $finish;
          end
          else begin
              $display("%8d", $time," state: ",x1.S4,x1.S3,x1.S2,x1.S1,x1.S0);
          end
          Ped = $random;
      end
      else begin
          $display("Simulation end, target state unreachable.");
          $finish;
      end
   end
endmodule
