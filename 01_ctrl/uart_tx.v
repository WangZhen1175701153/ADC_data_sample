`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/13 22:26:46
// Design Name: 
// Module Name: uart_tx
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


module uart_tx(
    input       clk_tx,
    input       tx_en,
    input   [7:0]    data,
    output   reg   txd
    );
    //tx_en == 1,cn 10
    reg  [3:0] cn=0;
    always @(posedge clk_tx) begin
        if (cn > 4'd8) begin
            cn <= 0;
        end
        else if(tx_en == 1) begin
            cn <= cn +1;
        end
        else if (cn > 0) begin
            cn <= cn +1;
        end
    end 

    always @(*) 
        case (cn)
            1:txd<=0;
            2:txd<=data[0];
            3:txd<=data[1];
            4:txd<=data[2];
            5:txd<=data[3]; 
            6:txd<=data[4];
            7:txd<=data[5];
            8:txd<=data[6];
            9:txd<=data[7];
            // 2:txd<=data[0];
            default: txd<=1'b1;
        endcase
endmodule
