module uart_tx (
    input wire clk,
    input wire rst,
    input wire tx_start,
    input wire [7:0] data_in,
    output reg tx,
    output reg tx_busy
);

reg [3:0] bit_index;
reg [7:0] data_reg;
reg [1:0] state;

parameter IDLE  = 2'b00;
parameter START = 2'b01;
parameter DATA  = 2'b10;
parameter STOP  = 2'b11;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        state <= IDLE;
        tx <= 1'b1;
        tx_busy <= 1'b0;
        bit_index <= 0;
        data_reg <= 0;
    end
    else begin
        case(state)

            IDLE: begin
                tx <= 1'b1;
                tx_busy <= 1'b0;

                if(tx_start) begin
                    data_reg <= data_in;
                    state <= START;
                    tx_busy <= 1'b1;
                end
            end

            START: begin
                tx <= 1'b0;
                bit_index <= 0;
                state <= DATA;
            end

            DATA: begin
                tx <= data_reg[bit_index];

                if(bit_index == 7)
                    state <= STOP;
                else
                    bit_index <= bit_index + 1;
            end

            STOP: begin
                tx <= 1'b1;
                state <= IDLE;
            end

        endcase
    end
end

endmodule

module uart_rx (
    input wire clk,
    input wire rst,
    input wire rx,
    output reg [7:0] data_out,
    output reg rx_done
);

reg [3:0] bit_index;
reg [1:0] state;

parameter IDLE = 2'b00;
parameter DATA = 2'b01;
parameter STOP = 2'b10;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        state <= IDLE;
        bit_index <= 0;
        data_out <= 0;
        rx_done <= 0;
    end
    else begin
        case(state)

            IDLE: begin
                rx_done <= 0;

                if(rx == 0) begin
                    bit_index <= 0;
                    state <= DATA;
                end
            end

            DATA: begin
                data_out[bit_index] <= rx;

                if(bit_index == 7)
                    state <= STOP;
                else
                    bit_index <= bit_index + 1;
            end

            STOP: begin
                rx_done <= 1;
                state <= IDLE;
            end

        endcase
    end
end

endmodule
