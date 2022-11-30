`timescale 1 ns/100 ps
module controlUnit (
    clk, obj, insideA, insideB, insideC,
    displayA, displayB, displayC
);
    input clk;
    input [3:0] obj; // usuário fora do elevador chama o elevador
    input [9:0] insideA, insideB, insideC; //botões dentro do elevador

    reg [5:0] stateFloorA, stateFloorB, stateFloorC;
    output [6:0] displayA, displayB, displayC;

    wire [3:0] countA, countB, countC;
    wire [3:0] imposeObjA, imposeObjB, imposeObjC;
    reg [3:0] objA, objB, objC;

    wire setMemoryA, setMemoryB, setMemoryC; 

    floorEncoder feA (.inside(insideA), .floorNum(imposeObjA));
    floorEncoder feB (.inside(insideB), .floorNum(imposeObjB));
    floorEncoder feC (.inside(insideC), .floorNum(imposeObjC));

    prioritizer up1 ( .stateA(stateFloorA), .stateB(stateFloorB), .stateC(stateFloorC),
    .obj(obj), .A(setMemoryA), .B(setMemoryB), .C(setMemoryC));

    counter counterA ( .clk(clk), .en(stateFloorA[0]), .up_down(stateFloorA[1]), .count(countA));
    counter counterB ( .clk(clk), .en(stateFloorB[0]), .up_down(stateFloorB[1]), .count(countB));
    counter counterC ( .clk(clk), .en(stateFloorC[0]), .up_down(stateFloorC[1]), .count(countC));

    // bloco do decodificador de 7 segmentos
    sevenSegment ssA ( .floor(stateFloorA[5:2]), .seg(displayA));
    sevenSegment ssB ( .floor(stateFloorB[5:2]), .seg(displayB));
    sevenSegment ssC ( .floor(stateFloorC[5:2]), .seg(displayC));

    // determina o estado inicial
    initial begin
        stateFloorA = countA; stateFloorB = countB; stateFloorC = countC;
        objA = 0; objB = 0; objC = 0;
    end

    // passa para o output o andar em que o elevador se encontra
    always @(
        countA or countB or countC
    )
    begin
        stateFloorA[5:2] = countA;
        stateFloorB[5:2] = countB;
        stateFloorC[5:2] = countC;
    end

    // Para A, B e C, são usados comparadores de 4 bits que comparam sua posição ao seu objetivo
    // e determinam se o elevador deve permanecer subindo, descendo ou inativo

    always @(posedge setMemoryA) objA <= obj;
    always @(imposeObjA) objA = imposeObjA;

    always @(stateFloorA[5:2] or objA) begin
        stateFloorA[0] = stateFloorA[5:2] != objA; // bit de enable de movimento do elevador
        stateFloorA[1] = stateFloorA[5:2] < objA; // bit de direção do elevador 
    end

    always @(posedge setMemoryB) objB <= obj;     
    always @(imposeObjB) objB = imposeObjB;

    always @(stateFloorB[5:2] or objB) begin
        stateFloorB[0] = stateFloorB[5:2] != objB;
        stateFloorB[1] = stateFloorB[5:2] < objB;
    end
    
    always @(posedge setMemoryC) objC <= obj;
    always @(imposeObjC) objC = imposeObjC;

    always @(stateFloorC[5:2] or objC) begin
        stateFloorC[0] = stateFloorC[5:2] != objC;
        stateFloorC[1] = stateFloorC[5:2] < objC;
    end
endmodule