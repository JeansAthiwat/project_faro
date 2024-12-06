
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2021 09:31:37 PM
// Design Name: 
// Module Name: system
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


module system(
    output wire RsTx, //uart
    input wire RsRx, //uart
    input clk, //both
    output wire Hsync, Vsync, //vga
    output wire [3:0] vgaRed, vgaGreen, vgaBlue, //vga
    output [6:0] seg,
    output dp,
    output [3:0] an
    );

assign an=4'b1110;
uart uart(clk,RsRx,RsTx, seg);
vga vga(
    .clk(clk), .sw(sw),
    .push({btnL, btnU}),
    .hsync(Hsync), .vsync(Vsync),
    .rgb({vgaRed, vgaGreen, vgaBlue})
    );
endmodule

