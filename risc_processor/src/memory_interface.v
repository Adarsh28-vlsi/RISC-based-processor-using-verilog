// Memory Interface
// Handles data memory read/write operations

module memory_interface (
    input wire clk,
    input wire reset,
    input wire mem_read,
    input wire mem_write,
    input wire [15:0] address,
    input wire [15:0] write_data,
    output reg [15:0] read_data,
    output reg mem_ready
);

    // Data memory - 4KB (2K words of 16 bits each)
    reg [15:0] data_memory [2047:0];
    
    // Memory initialization
    integer i;
    always @(posedge reset) begin
        if (reset) begin
            for (i = 0; i < 2048; i = i + 1) begin
                data_memory[i] <= 16'b0;
            end
            read_data <= 16'b0;
            mem_ready <= 1'b1;
        end
    end
    
    // Memory operations
    always @(posedge clk) begin
        if (!reset) begin
            mem_ready <= 1'b0;
            
            if (mem_read) begin
                // Read operation
                if (address[15:12] == 4'b0001) begin  // Data memory range 0x1000-0x1FFF
                    read_data <= data_memory[address[10:0]];
                end else begin
                    read_data <= 16'b0;  // Invalid address
                end
                mem_ready <= 1'b1;
            end
            
            else if (mem_write) begin
                // Write operation
                if (address[15:12] == 4'b0001) begin  // Data memory range 0x1000-0x1FFF
                    data_memory[address[10:0]] <= write_data;
                end
                mem_ready <= 1'b1;
            end
            
            else begin
                mem_ready <= 1'b1;
            end
        end
    end

endmodule