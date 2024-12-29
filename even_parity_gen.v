

module even_parity_gen(
    input clk,
    input reset,
    input i_x,              // Input bit
    output reg o_parity // Output bit
);

    // State encoding
    parameter A = 3'b000, 
              B = 3'b001, 
              C = 3'b010, 
              D = 3'b011, 
              E = 3'b100, 
              F = 3'b101, 
              G = 3'b110; 

    reg [2:0] current_state, next_state;

    // Sequential block: State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= A; // Reset to state A
        end else begin
            current_state <= next_state;
        end
    end

    // Combinational block: Next state logic and output logic
    always @(*) begin
        case (current_state)
            A: begin
                if (i_x) begin
                    next_state = C;
                    o_parity = 1'bx; 
                end else begin
                    next_state = B;
                    o_parity = 1'bx; 
                end
            end

            B: begin
                if (i_x) begin
                    next_state = E;
                    o_parity = 1'bx;
                end else begin
                    next_state = D;
                    o_parity = 1'bx; 
                end
            end

            C: begin
                if (i_x) begin
                    next_state = D;
                    o_parity = 1'bx; 
                end else begin
                    next_state = E;
                    o_parity = 1'bx; 
                end
            end

            D: begin
                if (i_x) begin
                    next_state = G;
                    o_parity = 1'bx; 
                end else begin
                    next_state = F;
                    o_parity = 1'bx; 
                end
            end

            E: begin
                if (i_x) begin
                    next_state = F;
                    o_parity = 1'bx; 
                end else begin
                    next_state = G;
                    o_parity = 1'bx; 
                end
            end

            F: begin
                    next_state = A;
                    o_parity = 1'b0; 
                     
            end

            G: begin
                    next_state = A;
                    o_parity = 1'b1; 
            end

            default: begin
                next_state = A;
                o_parity = 1'bx;
            end
        endcase
    end

endmodule
