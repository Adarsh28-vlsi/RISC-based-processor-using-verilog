module IFU (
    input clk,
    input reset,
    input branch,
    input [31:0] branchAddr,
    output reg [31:0] PC,
    output [31:0] instruction
);
    reg [31:0] InstrMem [0:255];

    initial begin
        // Example initialization, address 0, 4, 8, 12, 16 with hardcoded instructions
        InstrMem[0] = 32'hXXXXXXXX;
        InstrMem[1] = 32'hXXXXXXXX;
        InstrMem = 32'hXXXXXXXX;
        InstrMem = 32'hXXXXXXXX;
        InstrMem = 32'hXXXXXXXX;
    end

    assign instruction = InstrMem[PC[9:2]]; // Word aligned fetch

    always @(posedge clk or posedge reset) begin
        if (reset)
            PC <= 0;
        else if (branch)
            PC <= branchAddr;
        else
            PC <= PC + 4;
    end
endmodule
