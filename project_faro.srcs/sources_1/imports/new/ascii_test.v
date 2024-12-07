`timescale 1ns / 1ps

module ascii_test(
    input clk,                 // Clock signal
    input reset,               // Reset signal
    input we,                  // Write enable signal from UART
    input [7:0] data,          // 8-bit data from UART
    input video_on,            // Video on/off signal
    input [9:0] x, y,          // Current pixel coordinates
    input lang,                // Language state: 0 (English), 1 (Thai)
    output reg [11:0] rgb      // RGB output
);

    // Parameters and declarations
    parameter MEMSIZE = 256;      // Increased memory size (256 locations)
    reg [6:0] mem[MEMSIZE - 1:0]; // 7-bit memory array
    reg [7:0] itr;                // Memory index for writing (8 bits)

    // Signals for ASCII ROM
    wire [10:0] rom_addr;         // 11-bit text ROM address
    wire [6:0] ascii_char;        // 7-bit ASCII character code
    wire [3:0] char_row;          // 4-bit row of ASCII character
    wire [2:0] bit_addr;          // Column number of ROM data
    wire [7:0] rom_data_en;          // 8-bit row data from text ROM
    wire [7:0] rom_data_th;          // 8-bit row data from text ROM
    wire ascii_bit_en,ascii_bit_th, plot;         // ASCII ROM bit and plot signal
    
    integer i = 0;                  // Loop counter

    // Initialize memory
    initial begin
        itr = 8'b00000000;
        for (i = 0; i < MEMSIZE; i = i + 1) begin
            mem[i] = 7'h00;         // Initialize all memory locations to 7'h00
        end
    end


    // SCREEN UI PAINTER MODULE INSTANCE
//    wire [11:0] painter_rgb; // Output RGB from screen_painter
//    screen_painter ui_painter (
//        .x(x),
//        .y(y),
//        .video_on(video_on),
//        .rgb(painter_rgb)
//    );
    
    // ASCII ROM instance
    ascii_rom_en rom_en(.clk(clk), .addr(rom_addr), .data(rom_data_en));
    
    // ASCII ROM TH instance
    ascii_rom_th rom_th(.clk(clk), .addr(rom_addr), .data(rom_data_th));
        
    // ASCII ROM address and data interface
    assign rom_addr = {ascii_char, char_row};   // ROM address
    assign ascii_bit_en = rom_data_en[~bit_addr];     // Reverse bit order for ASCII character
    assign ascii_bit_th = rom_data_th[~bit_addr];     // Reverse bit order for ASCII character
    assign char_row = y[3:0];                   // Row number of ASCII character
    assign bit_addr = x[2:0];                   // Column number of ASCII character

    // Memory access: Adjusted for 32 columns per row

//    assign ascii_char = mem[(x[7:3]) + 32 * (y[6:4])]; // 32 columns, 8 rows (grid of 32x8)
    assign ascii_char = mem[((x[7:3] + 8) % 32) + (32 * ((y[6:4] + 5)%8))]; // 32 columns, 8 rows (grid of 32x8)
//    assign ascii_char = mem[((x[7:3] + 8) % 32) + (32 * y[6:4])]; // 32 columns, 8 rows (grid of 32x8)

//    assign ascii_char = mem[((x[7:3] + 8) & 5'b11111) + 32 * ((y[6:4] + 5) & 3'b111)];
    
    // Plot signal update for larger display area
    
    // (assign plot if char bit is not 0)
    assign plot = ((x >= 192 && x < 448) && (y >= 176 && y < 304)) 
                  ? (lang == 1'b0 ? ascii_bit_en : ascii_bit_th) 
                  : 1'b0;


// Memory write logic
always @(posedge we or posedge reset) begin
    if (reset) begin
        itr = 8'b00000000;
        for (i = 0; i < MEMSIZE; i = i + 1) begin
            mem[i] <= 7'h00;         // Initialize all memory locations to 7'h00
        end
    end else if (we) begin
        if (data[6:0] == 13) begin // Enter key
            // Move to the start of the next row
            itr <= (((itr / 32) + 1) * 32); // Increment row and set to first column
            if (itr >= (MEMSIZE - 32)) // Prevent overflow
                itr <= 8'b0; // Wrap around to the start
        end else begin
            // Write data to memory and increment cursor
            mem[itr] <= data[6:0];
            itr <= itr + 1; // Move to the next position

            // Wrap to the start of the next row if end of row is reached
            if ((itr % 32) == 31) // End of row (32 characters per row)
                itr <= (((itr / 32) + 1) * 32); // Move to the first column of the next row

            // Prevent overflow
            if (itr >= MEMSIZE)
                itr <= 8'b0; // Wrap around to the start
        end
    end
end

    // RGB multiplexing logic
    always @* begin
        if (~video_on)
            rgb = 12'h000; // Display blank screen
        else if (plot)
            rgb = 12'h000; // Blue letters
//        else if (painter_rgb != 12'h000)
//            rgb = painter_rgb; // Use UI painter's output for non-zero          
        else
            rgb = 12'hFFF; // White background
    end
endmodule
