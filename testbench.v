`timescale 1 ns/100 ps
module counterTB;
    reg clk, en, reset, load, up_down;
    reg [3:0] data;
    wire [3:0] count;

    counter ct1(.*);

    initial begin
        clk = 0;
        reset = 1'b1;
    end

    always begin
        #1 clk = ~clk;
    end
    
    always #2 $display("time=%0d,reset=%b,load=%b,ud=%b,data=%d,count=%d", $time,reset,load,up_down,data,count);


    initial begin
        #2 reset = 1'b0;
        #3 en = 1'b1; up_down = 1'b1;
        #50 up_down = 1'b0;
    end
    initial #100 en = 1'b0;
    initial begin #150 load = 1'b1; data = 9; end
endmodule

module internalCalculatorTB;
    reg [3:0] F, C;
    wire en, up_down;

    internalCalculator ic1(.*);

    integer i, j;

    initial begin
        for (i = 0; i <= 9 ; i = i+1) begin
            for (j = 0; j <= 9 ; j = j+1) begin
                F = i; C = j;
                #1
                $display("current floor: %d, desired floor: %d, en: %1b, up: %1b", C, F, en, up_down);
            end
        end
    end

endmodule