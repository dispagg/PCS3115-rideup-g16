`timescale 1 ns/100 ps
module controlUnit (
    clk, obj, insideA, insideB, insideC,
    stateFloorA, stateFloorB, stateFloorC
);
    input clk;
    input [3:0] obj;

    output reg [5:0] stateFloorA;
    output reg [5:0] stateFloorB;
    output reg [5:0] stateFloorC;

    wire [3:0] countA;
    wire [3:0] countB;
    wire [3:0] countC;

    reg [3:0] objA, objB, objC;

    wire setFloorStateA, setMemoryA; 
    wire setFloorStateB, setMemoryB; 
    wire setFloorStateC, setMemoryC; 

    prioritizer up1 ( .stateA(stateFloorA), .stateB(stateFloorB), .stateC(stateFloorC),
    .obj(obj), .A(setMemoryA), .B(setMemoryB), .C(setMemoryC));

    counter counterA ( .clk(clk), .en(stateFloorA[0]), .up_down(stateFloorA[1]), .count(countA));
    counter counterB ( .clk(clk), .en(stateFloorB[0]), .up_down(stateFloorB[1]), .count(countB));
    counter counterC ( .clk(clk), .en(stateFloorC[0]), .up_down(stateFloorC[1]), .count(countC));

    initial begin
        stateFloorA = countA; stateFloorB = countB; stateFloorC = countC;
        objA = 0; objB = 0; objC = 0;
    end

    always @(
        countA or countB or countC
    )
    begin
        // passa para o registrador o andar em que o elevador se encontra
        stateFloorA[5:2] = countA;
        stateFloorB[5:2] = countB;
        stateFloorC[5:2] = countC;
    end

    always @(posedge setMemoryA) objA <= obj;

    always @(stateFloorA[5:2] or objA) begin
        stateFloorA[0] = stateFloorA[5:2] != objA;
        stateFloorA[1] = stateFloorA[5:2] < objA;
    end

    always @(posedge setMemoryB) objB <= obj;     

    always @(stateFloorB[5:2] or objB) begin
        stateFloorB[0] = stateFloorB[5:2] != objB;
        stateFloorB[1] = stateFloorB[5:2] < objB;
    end
    
    always @(posedge setMemoryC) objC <= obj;

    always @(stateFloorC[5:2] or objC) begin
        stateFloorC[0] = stateFloorC[5:2] != objC;
        stateFloorC[1] = stateFloorC[5:2] - objC > 0;
    end
endmodule