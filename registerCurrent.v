module registerCurrent (
    setFloorState, data, out,
    setMemory, position, queue
);
    input setFloorState, setMemory;
    input [5:0] data;
    input [3:0] position;
    output reg [5:0] out;

    output reg [9:0] queue;

    initial begin
        out = 0;
        queue = 0;
    end

    always @(posedge setFloorState or posedge setMemory) begin
        out <= data;
    end

    always @(posedge setMemory) begin
        queue[position] <= (out[5:2] != position);
    end
endmodule