module counter (
    clk, en, up_down, load, data, count
);
// contador simples de 4 bits e up_down;
input clk, en, load, up_down;
input [3:0] data;

output reg [3:0] count;

initial count = 0;

always @(posedge clk) begin
    // $display(en);s
    if (load)
        count <= data;
    else if (en)
        if (up_down)
            if (count < 9)
                count <= count + 1;
            else 
                count <= 0;
        else 
            if (count > 0)
                count <= count - 1;
            else
                count <= 9;
end
    
endmodule