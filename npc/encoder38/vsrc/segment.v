module segment(
    input [2:0] code,
    output reg [7:0] segment_out
    );
    parameter num0 = 8'b1111_1101;
    parameter num1 = 8'b0110_0000;
    parameter num2 = 8'b1101_1010;
    parameter num3 = 8'b1111_0010;
    parameter num4 = 8'b0110_0110;
    parameter num5 = 8'b1011_0110;
    parameter num6 = 8'b1011_1110;
    parameter num7 = 8'b1110_0000;
    parameter num8 = 8'b1111_1111;
    parameter num9 = 8'b1111_0111;

    always @(code) begin
        case (code)
            3'b000: segment_out = ~num0;
            3'b001: segment_out = ~num1;
            3'b010: segment_out = ~num2;
            3'b011: segment_out = ~num3;
            3'b100: segment_out = ~num4;
            3'b101: segment_out = ~num5;
            3'b110: segment_out = ~num6;
            3'b111: segment_out = ~num7;
        endcase
    end

endmodule
