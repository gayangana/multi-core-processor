module bus(
        input clk,

        input [15:0]PC_out,
        input [15:0]AR_out,
        input [15:0]AC_out,
        input [15:0]R_out,
        input [15:0]DM_out,
        input [15:0]IM_out,
        input [15:0]DR_out,
        input [15:0]A_out,
        input [15:0]B_out,
        input [15:0]C_out,
        input [15:0]D_out,
        input PC_read_en,
        input AR_read_en,
        input AC_read_en,
        input R_read_en,
        input IM_read_en,
        input DM_read_en,
        input DR_read_en,
        input A_read_en,
        input B_read_en,
        input C_read_en,
        input D_read_en,
        output reg [15:0] bus
    );	
	
	

    // always @(*) begin
    //     if (IM_read_en == 1'b1)
    //         assign bus = IM_out;
    //     else if (DR_read_en == 1'b1)
    //         assign bus = DR_out;
    //     else if (DM_read_en ==1'b1)
    //         assign bus = DM_out;
    //     else if (AC_read_en == 1'b1)
    //         assign bus = AC_out;
    //     else if (R_read_en == 1'b1)
    //         assign bus = R_out;
    //     else if (AR_read_en == 1'b1)
    //         assign bus = AR_out;
    //     else if (A_read_en == 1'b1)
    //         assign bus = A_out;
    //     else if (B_read_en == 1'b1)
    //         assign bus = B_out;
    //     else if (C_read_en == 1'b1)
    //         assign bus = C_out;
    // end

    always @(*) begin
        if (IM_read_en == 1'b1)
             bus = IM_out;
        else if (DR_read_en == 1'b1)
             bus = DR_out;
        else if (DM_read_en ==1'b1)
             bus = DM_out;
        else if (AC_read_en == 1'b1)
             bus = AC_out;
        else if (R_read_en == 1'b1)
             bus = R_out;
        else if (AR_read_en == 1'b1)
             bus = AR_out;
        else if (A_read_en == 1'b1)
             bus = A_out;
        else if (B_read_en == 1'b1)
             bus = B_out;
        else if (C_read_en == 1'b1)
             bus = C_out;
        else if (D_read_en == 1'b1)
             bus = D_out;
    end



endmodule