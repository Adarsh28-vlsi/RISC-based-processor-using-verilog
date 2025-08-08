// Control Unit
// Decodes instructions and generates control signals

module control_unit (
    input wire [15:0] instruction,
    output reg [3:0] alu_control,
    output reg reg_write_enable,
    output reg mem_read,
    output reg mem_write,
    output reg mem_to_reg,
    output reg alu_src,
    output reg branch,
    output reg jump,
    output reg [2:0] reg_write_addr,
    output reg [7:0] immediate,
    output reg [11:0] jump_addr
);

    // Instruction fields
    wire [3:0] opcode = instruction[15:12];
    wire [2:0] rs1 = instruction[11:9];
    wire [2:0] rs2 = instruction[8:6];
    wire [2:0] rd = instruction[5:3];
    wire [7:0] imm8 = instruction[7:0];
    wire [5:0] imm6 = instruction[5:0];
    wire [11:0] addr12 = instruction[11:0];

    // Instruction opcodes
    parameter OP_ADD  = 4'b0000;
    parameter OP_SUB  = 4'b0001;
    parameter OP_AND  = 4'b0010;
    parameter OP_OR   = 4'b0011;
    parameter OP_XOR  = 4'b0100;
    parameter OP_SLL  = 4'b0101;
    parameter OP_SRL  = 4'b0110;
    parameter OP_SLT  = 4'b0111;
    parameter OP_ADDI = 4'b1000;
    parameter OP_ANDI = 4'b1001;
    parameter OP_ORI  = 4'b1010;
    parameter OP_LW   = 4'b1011;
    parameter OP_SW   = 4'b1100;
    parameter OP_BEQ  = 4'b1101;
    parameter OP_JMP  = 4'b1110;
    parameter OP_NOP  = 4'b1111;

    always @(*) begin
        // Default values
        alu_control = 4'b0000;
        reg_write_enable = 1'b0;
        mem_read = 1'b0;
        mem_write = 1'b0;
        mem_to_reg = 1'b0;
        alu_src = 1'b0;
        branch = 1'b0;
        jump = 1'b0;
        reg_write_addr = 3'b000;
        immediate = 8'b0;
        jump_addr = 12'b0;

        case (opcode)
            OP_ADD: begin
                alu_control = 4'b0000;      // ALU_ADD
                reg_write_enable = 1'b1;
                reg_write_addr = rd;
                alu_src = 1'b0;             // Use register
            end
            
            OP_SUB: begin
                alu_control = 4'b0001;      // ALU_SUB
                reg_write_enable = 1'b1;
                reg_write_addr = rd;
                alu_src = 1'b0;
            end
            
            OP_AND: begin
                alu_control = 4'b0010;      // ALU_AND
                reg_write_enable = 1'b1;
                reg_write_addr = rd;
                alu_src = 1'b0;
            end
            
            OP_OR: begin
                alu_control = 4'b0011;      // ALU_OR
                reg_write_enable = 1'b1;
                reg_write_addr = rd;
                alu_src = 1'b0;
            end
            
            OP_XOR: begin
                alu_control = 4'b0100;      // ALU_XOR
                reg_write_enable = 1'b1;
                reg_write_addr = rd;
                alu_src = 1'b0;
            end
            
            OP_SLL: begin
                alu_control = 4'b0101;      // ALU_SLL
                reg_write_enable = 1'b1;
                reg_write_addr = rd;
                alu_src = 1'b0;
            end
            
            OP_SRL: begin
                alu_control = 4'b0110;      // ALU_SRL
                reg_write_enable = 1'b1;
                reg_write_addr = rd;
                alu_src = 1'b0;
            end
            
            OP_SLT: begin
                alu_control = 4'b0111;      // ALU_SLT
                reg_write_enable = 1'b1;
                reg_write_addr = rd;
                alu_src = 1'b0;
            end
            
            OP_ADDI: begin
                alu_control = 4'b0000;      // ALU_ADD
                reg_write_enable = 1'b1;
                reg_write_addr = rs1;       // Write back to rs1
                alu_src = 1'b1;             // Use immediate
                immediate = imm8;
            end
            
            OP_ANDI: begin
                alu_control = 4'b0010;      // ALU_AND
                reg_write_enable = 1'b1;
                reg_write_addr = rs1;
                alu_src = 1'b1;
                immediate = imm8;
            end
            
            OP_ORI: begin
                alu_control = 4'b0011;      // ALU_OR
                reg_write_enable = 1'b1;
                reg_write_addr = rs1;
                alu_src = 1'b1;
                immediate = imm8;
            end
            
            OP_LW: begin
                alu_control = 4'b0000;      // ALU_ADD for address calculation
                reg_write_enable = 1'b1;
                reg_write_addr = rs1;
                mem_read = 1'b1;
                mem_to_reg = 1'b1;
                alu_src = 1'b1;
                immediate = imm8;
            end
            
            OP_SW: begin
                alu_control = 4'b0000;      // ALU_ADD for address calculation
                mem_write = 1'b1;
                alu_src = 1'b1;
                immediate = {{2{imm6[5]}}, imm6};  // Sign-extend 6-bit immediate to 8 bits
            end
            
            OP_BEQ: begin
                branch = 1'b1;
                immediate = imm8;
            end
            
            OP_JMP: begin
                jump = 1'b1;
                jump_addr = addr12;
            end
            
            OP_NOP: begin
                // All signals remain at default (no operation)
            end
            
            default: begin
                // All signals remain at default
            end
        endcase
    end

endmodule