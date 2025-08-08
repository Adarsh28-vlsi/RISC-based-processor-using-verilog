// Arithmetic Logic Unit (ALU)
// Supports basic arithmetic and logical operations

module alu (
    input wire [15:0] operand_a,
    input wire [15:0] operand_b,
    input wire [3:0] alu_control,
    output reg [15:0] result,
    output wire zero_flag,
    output reg carry_flag,
    output reg overflow_flag
);

    // ALU Control Codes
    parameter ALU_ADD  = 4'b0000;
    parameter ALU_SUB  = 4'b0001;
    parameter ALU_AND  = 4'b0010;
    parameter ALU_OR   = 4'b0011;
    parameter ALU_XOR  = 4'b0100;
    parameter ALU_SLL  = 4'b0101;
    parameter ALU_SRL  = 4'b0110;
    parameter ALU_SLT  = 4'b0111;

    // Internal signals for arithmetic operations
    wire [16:0] add_result;
    wire [16:0] sub_result;
    
    assign add_result = operand_a + operand_b;
    assign sub_result = operand_a - operand_b;
    
    // Zero flag
    assign zero_flag = (result == 16'b0);
    
    // ALU Operations
    always @(*) begin
        case (alu_control)
            ALU_ADD: begin
                result = add_result[15:0];
                carry_flag = add_result[16];
                overflow_flag = (operand_a[15] == operand_b[15]) && (result[15] != operand_a[15]);
            end
            
            ALU_SUB: begin
                result = sub_result[15:0];
                carry_flag = sub_result[16];
                overflow_flag = (operand_a[15] != operand_b[15]) && (result[15] != operand_a[15]);
            end
            
            ALU_AND: begin
                result = operand_a & operand_b;
                carry_flag = 1'b0;
                overflow_flag = 1'b0;
            end
            
            ALU_OR: begin
                result = operand_a | operand_b;
                carry_flag = 1'b0;
                overflow_flag = 1'b0;
            end
            
            ALU_XOR: begin
                result = operand_a ^ operand_b;
                carry_flag = 1'b0;
                overflow_flag = 1'b0;
            end
            
            ALU_SLL: begin
                result = operand_a << operand_b[3:0];
                carry_flag = 1'b0;
                overflow_flag = 1'b0;
            end
            
            ALU_SRL: begin
                result = operand_a >> operand_b[3:0];
                carry_flag = 1'b0;
                overflow_flag = 1'b0;
            end
            
            ALU_SLT: begin
                result = ($signed(operand_a) < $signed(operand_b)) ? 16'b1 : 16'b0;
                carry_flag = 1'b0;
                overflow_flag = 1'b0;
            end
            
            default: begin
                result = 16'b0;
                carry_flag = 1'b0;
                overflow_flag = 1'b0;
            end
        endcase
    end

endmodule