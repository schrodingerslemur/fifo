# FIFO implementation
Module headers:
```systemverilog
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
```
