module fifo
#(parameter int WIDTH)
(
    input  logic clock,
    input  logic reset,

    input  logic [WIDTH-1:0] wr_data,
    input  logic wr_en,

    output logic [WIDTH-1:0] rd_data,
    input  logic rd_en,

    output logic full, empty
);

endmodule: fifo
