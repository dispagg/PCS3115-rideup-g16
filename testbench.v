`timescale 1 ns/100 ps
module counterTB;
    reg clk, en, reset, load, up_down;
    reg [3:0] data;
    wire [3:0] count;

    counter uut(.*);

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

    internalCalculator uut(.*);

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

module sevenSegmentTB ;
    reg [3:0] Num;
    wire [9:0] seg;

    sevenSegment uut(.floor(Num), .seg(seg));

    integer i;
    initial begin
        for (i = 0; i <= 9 ; i = i+1) begin
            Num = i;
            #1
            $display("current floor: %d, output %b", Num, seg);
        end
    end

endmodule

module prioritizerTB ;
    reg [5:0] stateA, stateB, stateC;
    reg [3:0] obj;
    wire A, B, C;

    prioritizer uut (.*);

    initial begin
        obj = 7;
        stateA = 6'b001011;
        stateB = 6'b001000;
        stateC = 6'b000000;
        #1 $display("A = %b, B = %b, C = %b", A, B, C);
    end
endmodule

module controlUnitTB;
    reg clk;
    reg [3:0] obj;
    wire [5:0] stateA, stateB, stateC;

    initial begin
        clk = 0;
    end

    always begin
        #1 clk = ~clk;
    end

    always #1 $display("A = %d, B = %d, C = %d", stateA[5:2], stateB[5:2], stateC[5:2]);

    controlUnit uut (.clk(clk), .obj(obj),
    .stateFloorA(stateA), .stateFloorB(stateB), .stateFloorC(stateC));

    initial begin
        obj = 0;
        #2 obj = 9;
        #10 obj = 7; 
        // #5 obj = 3;
        // #7 obj = 0;
        #17 obj = 3;
        #18 obj = 8;
        #10 obj = 1;
    end


    
endmodule