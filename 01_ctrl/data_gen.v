`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/12 09:58:59
// Design Name: 
// Module Name: data_gen
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


module data_gen(
    input   clk_i_50Mhz,
    input   rst,
    output [15:0] data_o
    );

    reg [14:0]  counter = 0;
    reg [15:0]  data_o_r = 0;
    always @(posedge clk_i_50Mhz) begin
        if (!rst) begin
            counter <= 0;
        end
        else
            begin
                if (counter > 16384) begin
                    counter <=1'b0;
                end else begin
                    counter <= counter +1'b1;
                end
            end
    end
    always @(posedge clk_i_50Mhz) begin
        data_o_r <= counter;
    end
    assign data_o = data_o_r;
endmodule
