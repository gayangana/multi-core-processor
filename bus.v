module bus(
        input clk,

        input [15:0]PC_out,
        input [15:0]AR_out,
        input [15:0]AC_out,
        input [15:0]R_out,
        input [15:0]DM_out,
        input [15:0]IM_out,
        input [15:0]DR_out,
        input PC_read_en,
        input AR_read_en,
        input AC_read_en,
        input R_read_en,
        input IM_read_en,
        input DM_read_en,
        input DR_read_en,
        output reg [15:0] bus
    );

    always @(IM_read_en or AR_read_en or DR_read_en or DM_read_en or AC_read_en or R_read_en) begin
        if (IM_read_en == 1'b1)
            assign bus = IM_out;
        if (DR_read_en == 1'b1)
            assign bus = DR_out;
        if (DM_read_en ==1'b1)
            assign bus = DM_out;
        if (AC_read_en == 1'b1)
            assign bus = AC_out;
        if (R_read_en == 1'b1)
            assign bus = R_out;
        if (AR_read_en == 1'b1)
            assign bus = AR_out;
    end
endmodule