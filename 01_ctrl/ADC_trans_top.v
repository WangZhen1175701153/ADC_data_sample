`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/12 09:36:34
// Design Name: 
// Module Name: ADC_trans_top
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


module ADC_trans_top(
    input   sys_clk,
    output [15:0] data_tx_o

    );
    wire clk_out1; //50Mhz
    wire clk_out2; //50Mhz
    wire clk_out3; //100Mhz
    wire rst;
    wire [15:0] uart_data_i;
      clk_wiz_0 clk_wiz_inist
   (
    // Clock out ports
    .clk_out1(clk_out1),     // output clk_out1 50Mhz
    .clk_out2(clk_out2),     // output clk_out2 50Mhz
    .clk_out3(clk_out3),     // output clk_out3 100Mhz
    // Status and control signals
    .locked(locked),       // output locked
   // Clock in ports
    .clk_in1(sys_clk));      // input clk_in1

    data_gen data_gen_inist(
    .clk_i_50Mhz(clk_out1),
    .rst(rst),
    .data_o(uart_data_i)
    );
    reg [15:0] data_out;
    reg read_fifo;
    wire rd_en;
    wire [15:0] dout;
    fifo_generator_0 fifo_inist (
  .clk(clk_out2),      // input wire clk
  .srst(~rst),    // input wire srst
  .din(uart_data_i),      // input wire [15 : 0] din
  .wr_en(1'b1),  // input wire wr_en
  .rd_en(rd_en),  // input wire rd_en
  .dout(dout),    // output wire [15 : 0] dout
  .full(full),    // output wire full
  .empty(empty)  // output wire empty
);
  // fifo 控制读写使能  
    always @(posedge clk_out2) begin
      if (!rst) begin
        data_out <= 0;
        read_fifo <= 0;
      end
      else if(!empty)begin
        read_fifo <= 1;
      end
      else
        begin
          read_fifo <= 0;
        end
    end
    always @(posedge clk_out2) begin
      if (!rst) begin
        data_out <= 0;
      end
      else if(rd_en)begin
        data_out <= dout;
      end
    end
    assign rd_en = read_fifo;
    assign rst = locked;
    assign data_tx_o = data_out;
  // 串口发送数据准备
  reg [7:0] uart_tx_data;
  reg       tx_cnt;
  always @(clk_out3) begin
    if (!rst)begin
      uart_tx_data <= 0;
      tx_cnt <=0;
    end
    else begin
      case(tx_cnt)
        3'b0: begin
          uart_tx_data <= data_tx_o[0:7];
          tx_cnt <= tx_cnt + 1'b1;
        end
        3'b1: begin
          uart_tx_data <= data_tx_o[8:15];
          tx_cnt <= 0;
        end
        // 3'b2: begin
        //   tx_cnt <= tx_cnt + 1'b1;
        // end
      endcase
    end
  end
endmodule
