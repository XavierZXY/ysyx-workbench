module encoder38 (
        input [7:0] binary_input,
        input enable_in,
        output reg [2:0] code_output,
        output [7:0] segment_out,
        output reg indicator
    );

    always @(binary_input or enable_in) begin
        code_output = 3'b000; // Initialize the code output
        if (binary_input != 8'b00000000) begin
            indicator = 1'b1; // Set the indicator to 1
            if (enable_in) begin
                casez(binary_input)
                    8'b1zzz_zzzz:
                        code_output = 3'b111;
                    8'b01zz_zzzz:
                        code_output = 3'b110;
                    8'b001z_zzzz:
                        code_output = 3'b101;
                    8'b0001_zzzz:
                        code_output = 3'b100;
                    8'b0000_1zzz:
                        code_output = 3'b011;
                    8'b0000_01zz:
                        code_output = 3'b010;
                    8'b0000_001z:
                        code_output = 3'b001;
                    8'b0000_0001:
                        code_output = 3'b000;
                    default:
                        code_output = 3'b000;
                endcase
            end
        end
        else begin
            code_output = 3'b000;
            indicator = 1'b0; // Set the indicator to 0
        end
    end

    segment u_segment(
        .code(code_output),
        .segment_out(segment_out)
    );

endmodule
