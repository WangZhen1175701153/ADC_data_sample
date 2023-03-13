`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/13 22:19:51
// Design Name: 
// Module Name: clock_uart
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


module clock_uart(
    input       clk_50m,
    output      clk_tx,
    output      clk_rx
    );
    reg [11:0] cn12 = 0;
    reg clk_tt = 0;
    reg  [11:0] cnt11 = 0;
    reg clk_rt = 0;
    //9600  send clock 50Mhz/9600 = 5208  
    always @(posedge clk_50m) begin
        if(cn12 == 2603)begin
            cn12 <= 0;
            clk_tt <= !clk_tt;
        end
        else cn12 <= cn12 +1;
    end
    //19200 50Mhz/19200 = 2604
    always @(posedge clk_50m) begin
        if(cn11 == 1301)begin
            cn11 <= 0;
            clk_rt <= !clk_rt;
        end
        else cn11 <= cn11 +1;
    end

    assign clk_tx = clk_tt;
    assign clk_rx = clk_rt;

endmodule
