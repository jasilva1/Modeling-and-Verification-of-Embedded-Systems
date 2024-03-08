`timescale 1 ns / 1 ps
module stoplight1_tb;
   reg Ped, CLK;
   stoplight x1(Ped, CLK, SigG, SigY, SigR); // Instantiate the stoplight1 module

   initial begin
      x1.S0 = 0;
      x1.S1 = 0;
      x1.S2 = 0;
      x1.S3 = 0;
      CLK = 0;
      Ped = 0;

      $dumpfile("stoplight1_dump.vcd");
      $dumpvars(0, stoplight1_tb);
      #200000 $finish;
   end

   always #10 CLK = ~CLK;

   always @(posedge CLK) begin
      if ($time <= 100000) begin
          if ({x1.S3,x1.S2,x1.S1,x1.S0} == 4'b0100) begin
              $display("%8d", $time," state: ",x1.S3,x1.S2,x1.S1,x1.S0, " (reached target)");
              $display("Number of clock cycles until reached: " , "%8d", $time);
              $finish;
          end
          else begin
              $display("%8d", $time," state: ",x1.S3,x1.S2,x1.S1,x1.S0);
          end
          Ped = $random;
      end
      else begin
          $display("Timed Out, state 0100 unreachable.");
          $finish;
      end
   end
endmodule
