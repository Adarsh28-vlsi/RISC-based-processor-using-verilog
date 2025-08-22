module ALU (
    input [31:0] A,
    input [31:0] B,
    input [3:0] ALUControl,
    output reg [31:0] Result,
    output reg Zero
);
    always @(*) begin
        case (ALUControl)
            4'b0000: Result = A & B;           // AND
            4'b0001: Result = A | B;           // OR
            4'b0010: Result = ~(A & B);        // NAND
            4'b0011: Result = ~(A | B);        // NOR
            4'b0100: Result = A ^ B;           // XOR
            4'b0101: Result = A + B;           // ADD
            4'b0110: Result = A - B;           // SUB
            4'b0111: Result = ($signed(A) < $signed(B)) ? 1 : 0; // SLT
            4'b1000: Result = ($signed(A) > $signed(B)) ? 1 : 0; // SMT
            4'b1001: Result = A * B;           // MUL
            4'b1010: Result = B ? (A % B) : 0; // REMAINDER
            4'b1011: Result = A << B[4:0];     // SLL
            4'b1100: Result = A >> B[4:0];     // SRL
            4'b1101: Result = ~A;              // NOT A
            4'b1110: Result = ~B;              // NOT B
            default: Result = 0;
        endcase
        Zero = (Result == 0) ? 1'b1 : 1'b0;
    end
endmodule
