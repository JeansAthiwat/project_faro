module screen_painter (
    input wire [9:0] x,             // Horizontal coordinate
    input wire [9:0] y,             // Vertical coordinate
    input wire video_on,            // Signal indicating video output is active
    output reg [11:0] rgb          // 12-bit RGB output
);

    // Color mapping: 4 colors
    reg [11:0] color_rom [0:3];    // ROM with 4 colors

    // Declare the screen ROM (to hold color indices)
    reg [1:0] screen_rom [0:307199];  // 640x480 screen, 2 bits per pixel (307200 total pixels)

    // Initialize the color ROM with your color values
    initial begin
        color_rom[0] = 12'hFFF; // White
        color_rom[1] = 12'h055; // Blue
        color_rom[2] = 12'hF00; // Red
        color_rom[3] = 12'h0F0; // Green
    end 

    // Load screen data from an external file (color index for each pixel)
    initial begin
        $readmemb("screen_data.data", screen_rom);  // Load screen data
    end

    // Calculate the 1D index from x, y coordinates
    wire [18:0] index = (y * 640) + x;  // 640 pixels per row

    // RGB multiplexing logic
    always @* begin
        if (~video_on) begin
            rgb = 12'h000; // Display blank screen (black)
        end else begin
            // Fetch the color index from screen_rom and map it to the actual color
            case (screen_rom[index])
                2'b00: rgb = color_rom[0]; // White
                2'b01: rgb = color_rom[1]; // Blue
                2'b10: rgb = color_rom[2]; // Red
                2'b11: rgb = color_rom[3]; // Green
                default: rgb = 12'h000;    // Default to black if invalid (shouldn't happen)
            endcase
        end
    end

endmodule
