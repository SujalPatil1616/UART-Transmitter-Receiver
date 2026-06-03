`timescale 1ns/1ps

module uart_transceiver_tb;

reg clk;
reg rst;
reg tx_start;
reg [7:0] data_in;

wire tx;
wire tx_busy;

wire [7:0] data_out;
wire rx_done;

uart_tx tx_inst (
    .clk(clk),
    .rst(rst),
    .tx_start(tx_start),
    .data_in(data_in),
    .tx(tx),
    .tx_busy(tx_busy)
);

uart_rx rx_inst (
    .clk(clk),
    .rst(rst),
    .rx(tx),
    .data_out(data_out),
    .rx_done(rx_done)
);

always #5 clk = ~clk;

initial begin
    clk = 0;
    rst = 1;
    tx_start = 0;
    data_in = 8'b10101010;

    #20;
    rst = 0;

    #20;
    tx_start = 1;

    #10;
    tx_start = 0;

    #300;

    $display("Sent Data     = %b", data_in);
    $display("Received Data = %b", data_out);

    $finish;
end

initial begin
    $dumpfile("uart_transceiver.vcd");
    $dumpvars(0, uart_transceiver_tb);
end

endmodule
