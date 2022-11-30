module displayEncoder (display, floor);
    input [6:0] display;
    output reg [3:0] floor;

    always @(display) begin
        case (display)
            7'b0111111: floor = 0;
            7'b0000110: floor = 1;
            7'b1011011: floor = 2;
            7'b1001111: floor = 3;
            7'b1100110: floor = 4;
            7'b1101101: floor = 5;
            7'b1111101: floor = 6;
            7'b0000111: floor = 7;
            7'b1111111: floor = 8;
            7'b1101111: floor = 9;
            default: floor = 0;
        endcase
    end
endmodule

module floorDecoder (
    floor, inside
);
    input [3:0] floor;
    output reg [9:0] inside;

    always @(floor) begin
        case (floor)
            0: inside = 10'b0000000001;
            1: inside = 10'b0000000010;
            2: inside = 10'b0000000100;
            3: inside = 10'b0000001000;
            4: inside = 10'b0000010000;
            5: inside = 10'b0000100000;
            6: inside = 10'b0001000000;
            7: inside = 10'b0010000000;
            8: inside = 10'b0100000000;
            9: inside = 10'b1000000000;
            default: inside = 0;
        endcase
    end
endmodule