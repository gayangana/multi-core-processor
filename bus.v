module bus(
        input clk,

        input [15:0]PC_out,
        input [15:0]AR_out,
        input [15:0]AC_out,
        input [15:0]R_out,
        input [15:0]DM_out,
        input [15:0]IM_out,
        input PC_read_en,
        input AR_read_en,
        input AC_read_en,
        input R_read_en,
        input IM_read_en,
        input DM_read_en,
        output reg [15:0] bus
    );

    reg PC_read_en_i;
    reg AR_read_en_i;
    reg IR_read_en_i;
    reg AC_read_en_i;
    reg R_read_en_i;
    reg DM_read_en_i;
    reg IM_read_en_i;


    always @(posedge clk)begin
        PC_read_en_i <= PC_read_en;
        AR_read_en_i <= AR_read_en;
        AC_read_en_i <= AC_read_en;
        R_read_en_i <= R_read_en;
        IM_read_en_i <= IM_read_en;
        DM_read_en_i <= DM_read_en;
    end

    always @(posedge clk) begin
        if (PC_read_en == 1)
            bus <= PC_out;
        if (AR_read_en == 1)
            bus <= AR_out;
        if (AC_read_en == 1)
            bus <= AC_out;
        if (R_read_en == 1)
            bus <= R_out;
        if (IM_read_en_i == 1)
            bus <= IM_out;
        if (DM_read_en_i == 1)
            bus <= DM_out;

    end
endmodule