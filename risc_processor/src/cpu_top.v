// Top-level CPU module
// Integrates all processor components

module cpu_top (
    input wire clk,
    input wire reset,
    output wire [15:0] pc_out,
    output wire [15:0] instruction_out,
    output wire [15:0] alu_result_out,
    output wire zero_flag_out,
    output wire carry_flag_out,
    output wire overflow_flag_out
);

    // Internal signals
    wire [15:0] instruction;
    wire [15:0] pc;
    wire instruction_ready;
    
    // Control signals
    wire [3:0] alu_control;
    wire reg_write_enable;
    wire mem_read;
    wire mem_write;
    wire mem_to_reg;
    wire alu_src;
    wire branch;
    wire jump;
    wire [2:0] reg_write_addr;
    wire [7:0] immediate;
    wire [11:0] jump_addr;
    
    // Register file signals
    wire [2:0] rs1 = instruction[11:9];
    wire [2:0] rs2 = instruction[8:6];
    wire [15:0] reg_data1;
    wire [15:0] reg_data2;
    wire [15:0] reg_write_data;
    
    // ALU signals
    wire [15:0] alu_operand_a;
    wire [15:0] alu_operand_b;
    wire [15:0] alu_result;
    wire zero_flag;
    wire carry_flag;
    wire overflow_flag;
    
    // Memory signals
    wire [15:0] mem_address;
    wire [15:0] mem_read_data;
    wire mem_ready;
    
    // Instruction Fetch Unit
    instruction_fetch if_unit (
        .clk(clk),
        .reset(reset),
        .branch(branch),
        .jump(jump),
        .zero_flag(zero_flag),
        .branch_offset(immediate),
        .jump_address(jump_addr),
        .instruction(instruction),
        .pc(pc),
        .instruction_ready(instruction_ready)
    );
    
    // Control Unit
    control_unit ctrl_unit (
        .instruction(instruction),
        .alu_control(alu_control),
        .reg_write_enable(reg_write_enable),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .mem_to_reg(mem_to_reg),
        .alu_src(alu_src),
        .branch(branch),
        .jump(jump),
        .reg_write_addr(reg_write_addr),
        .immediate(immediate),
        .jump_addr(jump_addr)
    );
    
    // Register File
    register_file reg_file (
        .clk(clk),
        .reset(reset),
        .write_enable(reg_write_enable),
        .read_addr1(rs1),
        .read_addr2(rs2),
        .write_addr(reg_write_addr),
        .write_data(reg_write_data),
        .read_data1(reg_data1),
        .read_data2(reg_data2)
    );
    
    // ALU operand selection
    assign alu_operand_a = reg_data1;
    assign alu_operand_b = alu_src ? {{8{immediate[7]}}, immediate} : reg_data2;  // Sign-extend immediate
    
    // ALU
    alu alu_unit (
        .operand_a(alu_operand_a),
        .operand_b(alu_operand_b),
        .alu_control(alu_control),
        .result(alu_result),
        .zero_flag(zero_flag),
        .carry_flag(carry_flag),
        .overflow_flag(overflow_flag)
    );
    
    // Memory address calculation
    assign mem_address = alu_result + 16'h1000;  // Map to data memory space
    
    // Memory Interface
    memory_interface mem_if (
        .clk(clk),
        .reset(reset),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .address(mem_address),
        .write_data(reg_data2),  // Store data from rs2
        .read_data(mem_read_data),
        .mem_ready(mem_ready)
    );
    
    // Write-back data selection
    assign reg_write_data = mem_to_reg ? mem_read_data : alu_result;
    
    // Output assignments
    assign pc_out = pc;
    assign instruction_out = instruction;
    assign alu_result_out = alu_result;
    assign zero_flag_out = zero_flag;
    assign carry_flag_out = carry_flag;
    assign overflow_flag_out = overflow_flag;

endmodule