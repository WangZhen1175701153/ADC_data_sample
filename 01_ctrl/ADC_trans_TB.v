`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/12 17:44:32
// Design Name: 
// Module Name: ADC_trans_TB
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


module ADC_trans_TB(

    );
    wire  [15:0]   fifo_out;
    reg       clk = 1'b0;
    reg    [15:0]   uart_data_tx;
    always #5 begin
        clk <= ~clk;
    end   
    ADC_trans_top ADC_trans_top_inist(
        .sys_clk(clk),
        .data_tx_o(fifo_out)
    );
    always @(posedge clk) begin
        uart_data_tx <= fifo_out;
    end

endmodule
