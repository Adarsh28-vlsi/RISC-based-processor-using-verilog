module RegisterFile (
    input clk,
    input RegWrite,
    input [4:0] rs1,
    input [4:0] rs2,
    input [4:0] rd,
    input [31:0] writeData,
    output reg [31:0] readData1,
    output reg [31:0] readData2
);
    reg [31:0] registers [0:31];

    always @(*) begin
        readData1 = (rs1 == 0) ? 0 : registers[rs1]; // x0 always 0
        readData2 = (rs2 == 0) ? 0 : registers[rs2];
    end

    always @(posedge clk) begin
        if (RegWrite && rd != 0)
            registers[rd] <= writeData; // No writes to x0
    end
endmodule
