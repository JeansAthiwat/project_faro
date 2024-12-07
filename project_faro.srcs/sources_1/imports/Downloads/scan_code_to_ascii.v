`timescale 1ns / 1ps
module scan_code_to_ascii (
    input [7:0] scan_code,    // PS/2 Scan Code
    input shift,              // Shift key state (1 = active)
    output reg [6:0] ascii    // ASCII value output
);

    always @(*) begin
        case (scan_code)
            // Alphanumeric characters
            8'h1C: ascii = shift ? 7'h41 : 7'h61; // 'A' or 'a'
            8'h32: ascii = shift ? 7'h42 : 7'h62; // 'B' or 'b'
            8'h21: ascii = shift ? 7'h43 : 7'h63; // 'C' or 'c'
            8'h23: ascii = shift ? 7'h44 : 7'h64; // 'D' or 'd'
            8'h24: ascii = shift ? 7'h45 : 7'h65; // 'E' or 'e'
            8'h2B: ascii = shift ? 7'h46 : 7'h66; // 'F' or 'f'
            8'h34: ascii = shift ? 7'h47 : 7'h67; // 'G' or 'g'
            8'h33: ascii = shift ? 7'h48 : 7'h68; // 'H' or 'h'
            8'h43: ascii = shift ? 7'h49 : 7'h69; // 'I' or 'i'
            8'h3B: ascii = shift ? 7'h4A : 7'h6A; // 'J' or 'j'
            8'h42: ascii = shift ? 7'h4B : 7'h6B; // 'K' or 'k'
            8'h4B: ascii = shift ? 7'h4C : 7'h6C; // 'L' or 'l'
            8'h3A: ascii = shift ? 7'h4D : 7'h6D; // 'M' or 'm'
            8'h31: ascii = shift ? 7'h4E : 7'h6E; // 'N' or 'n'
            8'h44: ascii = shift ? 7'h4F : 7'h6F; // 'O' or 'o'
            8'h4D: ascii = shift ? 7'h50 : 7'h70; // 'P' or 'p'
            8'h15: ascii = shift ? 7'h51 : 7'h71; // 'Q' or 'q'
            8'h2D: ascii = shift ? 7'h52 : 7'h72; // 'R' or 'r'
            8'h1B: ascii = shift ? 7'h53 : 7'h73; // 'S' or 's'
            8'h2C: ascii = shift ? 7'h54 : 7'h74; // 'T' or 't'
            8'h3C: ascii = shift ? 7'h55 : 7'h75; // 'U' or 'u'
            8'h2A: ascii = shift ? 7'h56 : 7'h76; // 'V' or 'v'
            8'h1D: ascii = shift ? 7'h57 : 7'h77; // 'W' or 'w'
            8'h22: ascii = shift ? 7'h58 : 7'h78; // 'X' or 'x'
            8'h35: ascii = shift ? 7'h59 : 7'h79; // 'Y' or 'y'
            8'h1A: ascii = shift ? 7'h5A : 7'h7A; // 'Z' or 'z'

            // Numbers and special characters
            8'h45: ascii = shift ? 7'h29 : 7'h30; // ')' or '0'
            8'h16: ascii = shift ? 7'h21 : 7'h31; // '!' or '1'
            8'h1E: ascii = shift ? 7'h40 : 7'h32; // '@' or '2'
            8'h26: ascii = shift ? 7'h23 : 7'h33; // '#' or '3'
            8'h25: ascii = shift ? 7'h24 : 7'h34; // '$' or '4'
            8'h2E: ascii = shift ? 7'h25 : 7'h35; // '%' or '5'
            8'h36: ascii = shift ? 7'h5E : 7'h36; // '^' or '6'
            8'h3D: ascii = shift ? 7'h26 : 7'h37; // '&' or '7'
            8'h3E: ascii = shift ? 7'h2A : 7'h38; // '*' or '8'
            8'h46: ascii = shift ? 7'h28 : 7'h39; // '(' or '9'

            // Spacebar
            8'h29: ascii = 7'h20; // Space
            8'h5A: ascii = 7'h0d; // enter

            // Default case for unhandled scan codes
            default: ascii = 7'h00; // Null
        endcase
    end

endmodule
