module counter (
    clk, en, reset, up_down, load, data, count
);

input clk, en, reset, load, up_down;
input [3:0] data;

output reg [3:0] count;

always @(posedge clk) begin
    if (reset)
        count <= 0;
    else if (load)
        count <= data;
    else if (en)
        if (up_down)
            count <= count + 1;
        else 
            count <= count - 1;
end
    
endmodule