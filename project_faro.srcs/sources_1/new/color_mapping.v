module color_mapping (
    input wire [3:0] color_index,  // 4-bit index to reference color
    output reg [11:0] rgb          // 12-bit RGB color output
);

    // ROM to hold the 16 color mappings
    reg [11:0] color_rom [0:15];  // 16 colors, each 12 bits wide

    // Load color mappings from an external file
    initial begin
        $readmemh("color_mapping.data", color_rom);  // Load 16 colors
    end

    // Map the index to the corresponding RGB value
    always @* begin
        rgb = color_rom[color_index];  // Fetch RGB value based on index
    end
endmodule
