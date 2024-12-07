`timescale 1ns / 1ps
module scan_code_to_ascii (
    input [7:0] scan_code,    // PS/2 Scan Code
    input shift,              // Shift key state (1 = active)
    output reg [7:0] ascii    // ASCII value output
);

    always @(*) begin
        case (scan_code)
            // Alphanumeric characters
            8'h1C: ascii = shift ? 8'h41 : 8'h61; // 'A' or 'a'
            8'h32: ascii = shift ? 8'h42 : 8'h62; // 'B' or 'b'
            8'h21: ascii = shift ? 8'h43 : 8'h63; // 'C' or 'c'
            8'h23: ascii = shift ? 8'h44 : 8'h64; // 'D' or 'd'
            8'h24: ascii = shift ? 8'h45 : 8'h65; // 'E' or 'e'
            8'h2B: ascii = shift ? 8'h46 : 8'h66; // 'F' or 'f'
            8'h34: ascii = shift ? 8'h47 : 8'h67; // 'G' or 'g'
            8'h33: ascii = shift ? 8'h48 : 8'h68; // 'H' or 'h'
            8'h43: ascii = shift ? 8'h49 : 8'h69; // 'I' or 'i'
            8'h3B: ascii = shift ? 8'h4A : 8'h6A; // 'J' or 'j'
            8'h42: ascii = shift ? 8'h4B : 8'h6B; // 'K' or 'k'
            8'h4B: ascii = shift ? 8'h4C : 8'h6C; // 'L' or 'l'
            8'h3A: ascii = shift ? 8'h4D : 8'h6D; // 'M' or 'm'
            8'h31: ascii = shift ? 8'h4E : 8'h6E; // 'N' or 'n'
            8'h44: ascii = shift ? 8'h4F : 8'h6F; // 'O' or 'o'
            8'h4D: ascii = shift ? 8'h50 : 8'h70; // 'P' or 'p'
            8'h15: ascii = shift ? 8'h51 : 8'h71; // 'Q' or 'q'
            8'h2D: ascii = shift ? 8'h52 : 8'h72; // 'R' or 'r'
            8'h1B: ascii = shift ? 8'h53 : 8'h73; // 'S' or 's'
            8'h2C: ascii = shift ? 8'h54 : 8'h74; // 'T' or 't'
            8'h3C: ascii = shift ? 8'h55 : 8'h75; // 'U' or 'u'
            8'h2A: ascii = shift ? 8'h56 : 8'h76; // 'V' or 'v'
            8'h1D: ascii = shift ? 8'h57 : 8'h77; // 'W' or 'w'
            8'h22: ascii = shift ? 8'h58 : 8'h78; // 'X' or 'x'
            8'h35: ascii = shift ? 8'h59 : 8'h79; // 'Y' or 'y'
            8'h1A: ascii = shift ? 8'h5A : 8'h7A; // 'Z' or 'z'

            // Numbers and special characters
            8'h45: ascii = shift ? 8'h29 : 8'h30; // ')' or '0'
            8'h16: ascii = shift ? 8'h21 : 8'h31; // '!' or '1'
            8'h1E: ascii = shift ? 8'h40 : 8'h32; // '@' or '2'
            8'h26: ascii = shift ? 8'h23 : 8'h33; // '#' or '3'
            8'h25: ascii = shift ? 8'h24 : 8'h34; // '$' or '4'
            8'h2E: ascii = shift ? 8'h25 : 8'h35; // '%' or '5'
            8'h36: ascii = shift ? 8'h5E : 8'h36; // '^' or '6'
            8'h3D: ascii = shift ? 8'h26 : 8'h37; // '&' or '7'
            8'h3E: ascii = shift ? 8'h2A : 8'h38; // '*' or '8'
            8'h46: ascii = shift ? 8'h28 : 8'h39; // '(' or '9'

            // Spacebar
            8'h29: ascii = 8'h20; // Space

            // Default case for unhandled scan codes
            default: ascii = 8'h00; // Null
        endcase
    end

endmodule
