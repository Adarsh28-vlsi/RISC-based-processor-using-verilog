// Instruction Fetch Unit
// Manages program counter and fetches instructions from memory

module instruction_fetch (
    input wire clk,
    input wire reset,
    input wire branch,
    input wire jump,
    input wire zero_flag,
    input wire [7:0] branch_offset,
    input wire [11:0] jump_address,
    output reg [15:0] instruction,
    output reg [15:0] pc,
    output reg instruction_ready
);

    // Instruction memory - 4KB (2K words of 16 bits each)
    reg [15:0] instruction_memory [2047:0];
    
    // Program counter
    reg [15:0] pc_next;
    
    // Memory initialization with some sample instructions
    integer i;
    always @(posedge reset) begin
        if (reset) begin
            pc <= 16'b0;
            instruction <= 16'b0;
            instruction_ready <= 1'b0;
            
            // Initialize instruction memory
            for (i = 0; i < 2048; i = i + 1) begin
                instruction_memory[i] <= 16'hFFFF;  // NOP instructions
            end
            
            // Sample program: Add two numbers and store result
            instruction_memory[0] <= 16'h8210;   // ADDI R1, R1, 16  (Load 16 into R1)
            instruction_memory[1] <= 16'h8420;   // ADDI R2, R2, 32  (Load 32 into R2)
            instruction_memory[2] <= 16'h0249;   // ADD R3, R1, R2   (R3 = R1 + R2)
            instruction_memory[3] <= 16'hC0C0;   // SW R3, 0(R0)     (Store R3 to address 0x1000)
            instruction_memory[4] <= 16'hFFFF;   // NOP
        end
    end
    
    // Program counter logic
    always @(*) begin
        if (jump) begin
            pc_next = {4'b0, jump_address};
        end else if (branch && zero_flag) begin
            pc_next = pc + {{8{branch_offset[7]}}, branch_offset};  // Sign-extend branch offset
        end else begin
            pc_next = pc + 1;
        end
    end
    
    // Instruction fetch
    always @(posedge clk) begin
        if (reset) begin
            pc <= 16'b0;
            instruction <= 16'b0;
            instruction_ready <= 1'b0;
        end else begin
            pc <= pc_next;
            
            // Fetch instruction from memory
            if (pc[15:12] == 4'b0000) begin  // Instruction memory range 0x0000-0x0FFF
                instruction <= instruction_memory[pc[10:0]];
                instruction_ready <= 1'b1;
            end else begin
                instruction <= 16'hFFFF;  // NOP for invalid address
                instruction_ready <= 1'b1;
            end
        end
    end

endmodule