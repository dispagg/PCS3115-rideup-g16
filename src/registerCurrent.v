module registerCurrent #(
    setFloorState, data, out,
    setMemory, position, queue
) 
    input setFloorState, setMemory;
    input [5:0] data;
    output reg [5:0] out;

    output reg [9:0] queue;

    always @(posedge setFloorState) begin
        out <= data;
    end

    always @(posedge setMemory) begin
        queue[position] <= (out != position)
    end
endmodule