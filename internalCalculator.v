module internalCalculator (
    F, C, en, up_down
); 
input [3:0] F; // andar que o usuário deseja ir
input [3:0] C; // andar em que o elevador se encontra

output reg en, up_down; // enable do motor do elevador, direção do motor

always @(F or C) begin
    en = 0; up_down = 0;

    if (F == C) en = 1'b0;
    else if (F > C) 
    // elevador deve subir
        begin
        en = 1'b1;
        up_down = 1'b1;
        end
    else 
    // elevador deve descer
        begin
        en = 1'b1;
        up_down = 1'b0;
        end

end
    
endmodule