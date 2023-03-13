`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/13 22:08:14
// Design Name: 
// Module Name: uart_phy
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module uart_phy(
    input   clk,
    input   rst,
    input   rs232_rec,
    output rs232_txd
    );
    wire clk_tx,clk_rx;
    wire [7:0]  data;
    reg tx_en;
    reg cn14 = 0;

    //gen_clk
    clock_uart u1(
        .clk_50m(clk),
        .clk_tx(clk_tx),
        .clk_rx(clk_rx)
    );

    //uart_tx
    uart_tx u2(
        .clk_tx(clk_tx),
        .tx_en(tx_en),
        .data(data),
        .txd(rs232_txd)
    );

    //uart_rx
    uart_rx u3(
        .clk_rx(clk_rx),
        .rxd(rs232_rec),
        .data(data)
    );
    always @(posedge clk_tx) begin
        if (cn14 == 9599) begin
            cn14 <= 0;
        end
        else cn14 <= cn14 +1;
        if (cn14 == 0) begin
            tx_en <= 1'b1;
        end
        else tx_en <= 1'b0;
    end
endmodule
