module prioritizer (
    stateA, stateB, stateC, obj, A, B, C
);
    input [5:0] stateA, stateB, stateC;
    input [3:0] obj;
    output reg A, B, C;


    reg signed [3:0] diffA, diffB, diffC;
    reg signed [1:0] udA, udB, udC;
    reg [3:0] absA, absB, absC;
    reg validA, validB, validC;

    // always #1 $display("%b", validA);
    always @(obj) begin
        udA = stateA[1:0]; udB = stateB[1:0]; udC = stateC[1:0];

    // sobe -1 ( 11 ), desce +1 ( 01 ), inativo 0 ( 00 );
    // andar atual - objetivo => positivo/negativo/0;
        diffA = (stateA[5:2] - obj);
        diffB = (stateB[5:2] - obj);
        diffC = (stateC[5:2] - obj);

        validA = diffA*udA>=0;
        validB = diffB*udB>=0;
        validC = diffC*udC>=0;

        if (diffA < 0)
            absA = -diffA; 
        else absA = diffA;
        if (diffB < 0)
            absB = -diffB; 
        else absB = diffB;
        if (diffC < 0)
            absC = -diffC; 
        else absC = diffC;

        A = (validA && ~validB && ~validC ||
            validA && validB && ~validC && (absA <= absB) ||
            validA && ~validB && validC && (absA <= absC) ||
            validA && validB && validC && (absA <= absB && absA <= absC)) && (diffA != 0 || diffB != 0 || diffC != 0);

        B = ~validA && validB && ~validC ||
            validA && validB && ~validC && (absA > absB) ||
            ~validA && validB && validC && (absB <= absC) ||
            validA && validB && validC && (absA > absB && absB <= absC) && (diffA != 0 || diffB != 0 || diffC != 0);

        C = ~validA && ~validB && validC ||
            validA && ~validB && validC && (absA > absC) ||
            ~validA && validB && validC && (absB > absC) ||
            validA && validB && validC && (absA > absB && absB > absC) && (diffA != 0 || diffB != 0 || diffC != 0);
    end

endmodule