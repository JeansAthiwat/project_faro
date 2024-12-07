module screen_painter (
    input wire [9:0] x,             // Horizontal coordinate
    input wire [9:0] y,             // Vertical coordinate
    input wire video_on,            // Signal indicating video output is active
    output reg [11:0] rgb          // 12-bit RGB output
);

    // Declare the screen ROM (to hold color indices)
    reg [1:0] screen_rom [0:307199];  // 640x480 screen, 2 bits per pixel (307200 total pixels)

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
                // Color mapping: 4 colors
                2'b00: rgb = 12'hFFF; // White
                2'b01: rgb = 12'h055; // Blue
                2'b10: rgb = 12'hF00; // Red
                2'b11: rgb = 12'h0F0; // Green
                
                default: rgb = 12'h000;    // Default to black if invalid (shouldn't happen)
            endcase
        end
    end

endmodule
