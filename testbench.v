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
    // inputs de usuário
    reg [3:0] obj;
    reg [3:0] objFloorA, objFloorB, objFloorC;

    wire [9:0] displayA, displayB, displayC;
    wire [9:0] insideA, insideB, insideC;
    wire [3:0] stateA, stateB, stateC;

    // utils
        displayEncoder ssEncoderA (.display(displayA), .floor(stateA));
        displayEncoder ssEncoderB (.display(displayB), .floor(stateB));
        displayEncoder ssEncoderC (.display(displayC), .floor(stateC));

        floorDecoder fsA (.floor(objFloorA), .inside(insideA));
        floorDecoder fsB (.floor(objFloorB), .inside(insideB));
        floorDecoder fsC (.floor(objFloorC), .inside(insideC));

    initial clk = 0; always #1 clk = ~clk;    

    always @(displayA or displayB or displayC) begin
        $display("A = %d, B = %d, C = %d", stateA, stateB, stateC);
    end

    controlUnit uut (.clk(clk), .obj(obj), .insideA(insideA), .insideB(insideB), .insideC(insideC),
    .displayA(displayA), .displayB(displayB), .displayC(displayC));

    initial begin
        #2 objFloorA = 9; #2 objFloorB = 9; #2 objFloorC = 9;
        #20 objFloorB = 0;
        #20 objFloorA = 0;
        #2 objFloorA = 5; objFloorB = 5;
        #2 obj = 0;
        #20 objFloorC = 0;
    end


    
endmodule