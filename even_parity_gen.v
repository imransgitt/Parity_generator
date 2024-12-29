
/* module even_parity_gen(
    input clk,
    input reset,
    input i_x,
    output reg o_parity
);

// State machine approach
parameter IDLE = 2'b00,  // 0 bits
          s1   = 2'b01,  // 1 bit
          s2   = 2'b10,  // 2 bits
          s3   = 2'b11;  // 3 bits

reg [1:0] count;
reg [1:0] p_state, n_state;

// Sequential block: state transition and count update
always @(posedge clk or posedge reset) begin
  if (reset) begin
    p_state <= IDLE;
    count <= 2'b00;
    o_parity <= 1'bx;
  end 
  
  else begin
    p_state <= n_state;

    // Update count only on state transitions
    if (p_state == s1 || p_state == s2 || p_state == s3) begin
      count <= (i_x == 1) ? count + 1 : count;
    end

  end
end

// Combinational block: next state logic
always @(*) begin
   case (p_state)
    IDLE: begin
      n_state = s1;
      count = 2'b00;
      o_parity = 1'bx;
    end
    s1: begin
      n_state = s2;
      count <= (i_x==1) ? count + 1 : count; // 01
      o_parity = 1'bx;
    end
    s2: begin
      n_state = s3;
      count <= (i_x==1) ? count + 1 : count; //  10
      o_parity = 1'bx;
    end
    s3: begin
      n_state = IDLE;
      count <= (i_x==1) ? count + 1 : count; //  11
    end
    default: begin
      n_state = IDLE;
    end
  endcase
end

always@(*)
begin
  // Generate parity only in state `s3`
    if (p_state == s3) begin
      o_parity = (count % 2 == 1) ? 1'b1 : 1'b0; 
    end
end

endmodule
*/

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
