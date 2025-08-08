// Register File Module
// 8 x 16-bit general purpose registers
// R0 is hardwired to zero

module register_file (
    input wire clk,
    input wire reset,
    input wire write_enable,
    input wire [2:0] read_addr1,
    input wire [2:0] read_addr2,
    input wire [2:0] write_addr,
    input wire [15:0] write_data,
    output wire [15:0] read_data1,
    output wire [15:0] read_data2
);

    // Register array - 8 registers of 16 bits each
    reg [15:0] registers [7:0];
    
    // Initialize registers
    integer i;
    always @(posedge reset) begin
        if (reset) begin
            for (i = 0; i < 8; i = i + 1) begin
                registers[i] <= 16'b0;
            end
        end
    end
    
    // Write operation
    always @(posedge clk) begin
        if (write_enable && write_addr != 3'b000) begin  // R0 is read-only
            registers[write_addr] <= write_data;
        end
    end
    
    // Read operations (combinational)
    assign read_data1 = (read_addr1 == 3'b000) ? 16'b0 : registers[read_addr1];
    assign read_data2 = (read_addr2 == 3'b000) ? 16'b0 : registers[read_addr2];

endmodule