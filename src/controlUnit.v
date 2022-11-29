module controlUnit (
    
);
    input clk;
    input [3:0] obj;

    prioritizer up1 ( .stateA(outputStateFloorA), .stateB(outputStateFloorB), .stateC(outputStateFloorC),
    .obj(obj), .A(setMemoryA), .B(setMemoryB), .C(setMemoryC));

    wire enA, up_downA, [3:0] countA;
    wire enB, up_downB, [3:0] countB;
    wire enC, up_downC, [3:0] countC;

    counter counterA ( .clk(clk), .en(enA), .up_down(up_downA), .count(countA));
    counter counterB ( .clk(clk), .en(enB), .up_down(up_downB), .count(countB));
    counter counterC ( .clk(clk), .en(enC), .up_down(up_downC), .count(countC));

    reg [5:0] inputStateFloorA, outputStateFloorA; wire setFloorStateA, setMemoryA, [9:0] queueA; 
    reg [5:0] inputStateFloorB, outputStateFloorB; wire setFloorStateB, setMemoryB, [9:0] queueB; 
    reg [5:0] inputStateFloorC, outputStateFloorC; wire setFloorStateC, setMemoryC, [9:0] queueC; 

    registerCurrent elevatorA ( .setFloorState(setFloorStateA), .data(inputStateFloorA), .out(outputStateFloorA),
    .setMemory(setMemoryA), .position(obj), .queue(queueA));

    registerCurrent elevatorB ( .setFloorState(setFloorStateB), .data(inputStateFloorB), .out(outputStateFloorB),
    .setMemory(setMemoryB), .position(obj), .queue(queueB));

    registerCurrent elevatorC ( .setFloorState(setFloorStateC), .data(inputStateFloorC), .out(outputStateFloorC),
    .setMemory(setMemoryC), .position(obj), .queue(queueC));

    always begin
        // passa para o registrador o andar em que o elevador se encontra
        inputStateFloorA[5:2] = countA;
        inputStateFloorB[5:2] = countB;
        inputStateFloorC[5:2] = countC;
        // passa para o registrador sua atividade (sobe, desce, inativo)
        inputStateFloorA[0] = | queueA; inp

    end

    
    


    
    
endmodule