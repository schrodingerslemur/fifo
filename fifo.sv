module fifo #(
    parameter int WIDTH = 32,
    parameter int DEPTH = 16
)
(
    input  logic clock,
    input  logic reset,

    input  logic [WIDTH-1:0] wr_data,
    input  logic wr_en,

    output logic [WIDTH-1:0] rd_data,
    input  logic rd_en,

    output logic full, empty
);
    // Time scale
    timeunit 1ns; timeprecision 100ps;

    // Local parameters
    localparam ADDR_WIDTH = $clog2(DEPTH);

    // Registers
    logic [WIDTH-1:0] mem [DEPTH];

    // Pointers
    logic [ADDR_WIDTH-1:0] wr_ptr, rd_ptr;
    logic last_op_was_write;

    // Write logic
    always_ff @(posedge clock, posedge reset) begin
        if (reset)
            wr_ptr <= 0;
        else begin
            if (wr_en && !full) begin
                mem[wr_ptr] <= wr_data;
                wr_ptr <= wr_ptr + 1; // wraps around
            end
        end
    end

    // Read logic
    always_ff @(posedge clock, posedge reset) begin
        if (reset)
            rd_ptr <= 0;
        else begin
            if (rd_en && !empty) begin
                rd_data <= mem[rd_ptr];
                rd_ptr <= rd_ptr + 1; // wraps around
            end
        end
    end

    // Last operation tracking
    always_ff @(posedge clock, posedge reset) begin
        if (reset)
            last_op_was_write <= 1'b0;
        else begin
            if (wr_en && !full)
                last_op_was_write <= 1'b1;
            else if (rd_en && !empty)
                last_op_was_write <= 1'b0;
        end
    end

    // Full and empty logic
    assign full  = (wr_ptr == rd_ptr) && last_op_was_write;
    assign empty = (wr_ptr == rd_ptr) && !last_op_was_write;

endmodule: fifo
