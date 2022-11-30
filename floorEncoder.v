module floorEncoder (
    inside, floorNum
);
    input [9:0] inside;
    output reg [3:0] floorNum;

    always @(inside) begin
        case (inside)
            10'b0000000001: floorNum=0;
            10'b0000000010: floorNum=1;
            10'b0000000100: floorNum=2;
            10'b0000001000: floorNum=3;
            10'b0000010000: floorNum=4;
            10'b0000100000: floorNum=5;
            10'b0001000000: floorNum=6;
            10'b0010000000: floorNum=7;
            10'b0100000000: floorNum=8;
            10'b1000000000: floorNum=9;
        endcase 
    end

    
endmodule