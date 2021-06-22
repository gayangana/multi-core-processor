module control_unit(
    input clk,
    input z,
    input [15:0] instruction,
    input [1:0]status,
    output reg [1:0] alu_op,
    output reg end_process,

    output reg PC_read_en,
    output reg AR_read_en, 
    output reg IR_read_en, 
    output reg AC_read_en,
    output reg R_read_en,  
    output reg DM_read_en,
	output reg DR_read_en,
    output reg IM_read_en, 
    output reg A_read_en,
    output reg B_read_en,
    output reg C_read_en,

    output reg PC_write_en, 
    output reg AR_write_en, 
    output reg IR_write_en, 
    output reg AC_write_en, 
    output reg R_write_en,  
    output reg DM_write_en, 
    output reg DR_write_en,
    output reg IM_write_en, 
    output reg A_write_en,
    output reg B_write_en,
    output reg C_write_en,

    output reg PC_inc_en,
    output reg AC_inc_en,

    output reg AC_clear_en,
    output reg ALU_to_AC_write_en

);

    reg [16:0] state = 16'd0;

    parameter idle = 16'd0,

    fetch1 = 16'd1,
    fetch2 = 16'd2,
    fetch3 = 16'd3,
	fetch4 = 16'd4,
    fetch5 = 16'd5,
    fetch6 = 16'd6,

    ldac1 = 16'd7,
    ldacx = 16'd8,
    ldac2 = 16'd9,
    ldac3 = 16'd10,

    stac1 = 16'd11,
    stacx = 16'd12,
    stac2 = 16'd13,
    stac3 = 16'd14,
    

    mvacr1 = 16'd15,
    mvacc1 = 16'd44,

    mva1 = 16'd16,
    mvb1 = 16'd42,
    mvc1 = 16'd43,

    add1 = 16'd17,
	add2 = 16'd18,

    addm1 = 16'd19,
    addm2 = 16'd20,
    addm3 = 16'd21,
    addm4 = 16'd22,

    inac1 = 16'd23,

    sub1 = 16'd24,
    sub2 = 16'd25,

    mul1 = 16'd26,
    mul2 = 16'd27,

    mulm1 = 16'd28,
    mulm2 = 16'd29,
    mulm3 = 16'd30,
    mulm4 = 16'd31,

    clac1 = 16'd32,

    jump1 = 16'd33,
    jump2 = 16'd34,

    jpnz1 = 16'd35,
	jpnz2 = 16'd36,
    jpnz3 = 16'd37,
    jpnz4 = 16'd38,
    jpnzx = 16'd39,

    lda1 = 16'd45,
    lda2 = 16'd46,
    lda3 = 16'd47,
    lda4 = 16'd48,
    lda5 = 16'd49,
    lda6 = 16'd50,

    ldb1 = 16'd51,
    ldb2 = 16'd52,
    ldb3 = 16'd53,
    ldb4 = 16'd54,
    ldb5 = 16'd55,
    ldb6 = 16'd56,

    ldc1 = 16'd57,
    ldc2 = 16'd58,
    ldc3 = 16'd59,
    ldc4 = 16'd60,
    ldc5 = 16'd61,
    ldc6 = 16'd62,

    stc1 = 16'd63,
    stc2 = 16'd64,
    stc3 = 16'd65,
    stc4 = 16'd66,
    stc5 = 16'd67,
    stc6 = 16'd68,

    endop = 16'd40,
    no_op = 16'd41;

    

    

    always @(posedge clk)begin
        case (state)

            idle: begin
                alu_op   <= 3'd0;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                DR_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;

                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;

                AC_clear_en <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;

                end_process <= 1'b0;


                if (status == 2'b01)
                    state <= fetch1;
                else
                    state <= idle;
            end

            fetch1: begin
                alu_op   <= 3'd0;

                PC_read_en <= 1'b0;     
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                DR_read_en <= 1'b0;
                IM_read_en <= 1'b1;     //IM write data to bus (PC is pointed to address of IM)
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;    
                IR_write_en <= 1'b1;    //bus write data to IR
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;


                PC_inc_en <= 1'b1;      //PC=PC+1 (PC pointing to next instr)
                AC_inc_en <= 1'b0;

                AC_clear_en <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;


                state <= fetch2;
            end

            fetch2: begin
            
                alu_op   <= 3'd0;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                DR_read_en <= 1'b0;
                IM_read_en <= 1'b1;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;     

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;

                PC_inc_en <= 1'b0;      //PC = PC+1
                AC_inc_en <= 1'b0;

                AC_clear_en <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;


                state <= fetch3;
            end

            fetch3: begin
        
                alu_op   <= 3'd0;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;    
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                DR_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b1;
                IR_write_en <= 1'b0;    
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;

                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;

                AC_clear_en <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;


                state <= instruction;
            end

            // fetch4: begin
            
            //     alu_op   <= 3'd0;

            //     PC_read_en <= 1'b0;     //PC write data to bus 
            //     AR_read_en <= 1'b0;
            //     IR_read_en <= 1'b0;     //IR sends data to control unit
            //     AC_read_en <= 1'b0;
            //     R_read_en  <= 1'b0;
            //     DM_read_en <= 1'b0;
            //     IM_read_en <= 1'b0;

            //     PC_write_en <= 1'b0;
            //     AR_write_en <= 1'b0;    //bus write data to AR
            //     IR_write_en <= 1'b0;
            //     AC_write_en <= 1'b0;
            //     R_write_en  <= 1'b0;
            //     DM_write_en <= 1'b0;
            //     DR_write_en <= 1'b0;
            //     IM_write_en <= 1'b0;

            //     PC_inc_en <= 1'b0;
            //     AC_inc_en <= 1'b0;

            //      <= 1'b0;
            //     ALU_write_en       <= 1'b0;
                
            //      <= 1'b0;
            //     AC_clear_en <= 1'b0;


            //     state <= fetch5;
            // end

            // fetch5:begin
            //     alu_op   <= 3'd0;

            //     PC_read_en <= 1'b0;
            //     AR_read_en <= 1'b0;
            //     IR_read_en <= 1'b0;
            //     AC_read_en <= 1'b0;
            //     R_read_en  <= 1'b0;
            //     DM_read_en <= 1'b0;
            //     IM_read_en <= 1'b0;

            //     PC_write_en <= 1'b0;
            //     AR_write_en <= 1'b0;
            //     IR_write_en <= 1'b0;
            //     AC_write_en <= 1'b0;
            //     R_write_en  <= 1'b0;
            //     DM_write_en <= 1'b0;
            //     DR_write_en <= 1'b0;
            //     IM_write_en <= 1'b0;

            //     PC_inc_en <= 1'b0;
            //     AC_inc_en <= 1'b0;

            //      <= 1'b0;
            //     ALU_write_en       <= 1'b0;
                
            //      <= 1'b0;


            //     state <= fetch6;
            // end

            // fetch6:begin
            //     alu_op   <= 3'd0;

            //     PC_read_en <= 1'b0;
            //     AR_read_en <= 1'b0;
            //     IR_read_en <= 1'b0;
            //     AC_read_en <= 1'b0;
            //     R_read_en  <= 1'b0;
            //     DM_read_en <= 1'b0;
            //     IM_read_en <= 1'b0;

            //     PC_write_en <= 1'b0;
            //     AR_write_en <= 1'b0;
            //     IR_write_en <= 1'b0;
            //     AC_write_en <= 1'b0;
            //     R_write_en  <= 1'b0;
            //     DM_write_en <= 1'b0;
            //     DR_write_en <= 1'b0;
            //     IM_write_en <= 1'b0;

            //     PC_inc_en <= 1'b0;
            //     AC_inc_en <= 1'b0;

            //      <= 1'b0;
            //     ALU_write_en       <= 1'b0;
                
            //      <= 1'b0;

            //     state <= instruction;
            // end

            ldac1: begin
            
                alu_op   <= 3'd0;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b1;
                DR_read_en <= 1'b0;
                IM_read_en <= 1'b0; 
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;    

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;
                

                PC_inc_en <= 1'b0;      //PC=PC+1
                AC_inc_en <= 1'b0;

                AC_clear_en <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;

                state <= ldac2;
            end

            ldac2: begin
            
                alu_op   <= 3'd0;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                DR_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;     

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b1;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;

                PC_inc_en <= 1'b1;      
                AC_inc_en <= 1'b0;

                AC_clear_en <= 1'b0;

                state <= ldac3;
            end

            ldac3: begin
        
                alu_op   <= 3'd0;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;     //DM write data to bus
                DR_read_en <= 1'b1;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b1;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;

                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;

                AC_clear_en <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;

                state <= fetch1;
            end

            // ldac3: begin
  
            //     alu_op   <= 3'd0;

            //     PC_read_en <= 1'b0;
            //     AR_read_en <= 1'b0;
            //     IR_read_en <= 1'b0;
            //     AC_read_en <= 1'b0;     
            //     R_read_en  <= 1'b0;
            //     DM_read_en <= 1'b0;
            //     DR_read_en <= 1'b0;
            //     IM_read_en <= 1'b0;

            //     PC_write_en <= 1'b0;
            //     AR_write_en <= 1'b0;
            //     IR_write_en <= 1'b0;
            //     AC_write_en <= 1'b1;       //Bus write data to AC
            //     R_write_en  <= 1'b0;
            //     DM_write_en <= 1'b0;
            //     DR_write_en <= 1'b0;
            //     IM_write_en <= 1'b0;

            //     PC_inc_en <= 1'b0;
            //     AC_inc_en <= 1'b0;

            //      <= 1'b0;
            //     ALU_write_en       <= 1'b0;
                
            //      <= 1'b0;

            //     state <= fetch1;
            // end

            stac1: begin
                alu_op   <= 3'd0;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b1;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;     

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b1;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;

                PC_inc_en <= 1'b1;      //PC=PC+1
                AC_inc_en <= 1'b0;

                AC_clear_en <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;

                state <= stac2;
            end

            stac2: begin
            
                alu_op   <= 3'd0;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                DR_read_en <= 1'b1;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;    

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b1;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;

                PC_inc_en <= 1'b0;      
                AC_inc_en <= 1'b0;

                AC_clear_en <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;

                state <= fetch1;
            end

            
            lda1: begin
               alu_op   <= 3'd0;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b1;
                DR_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;

                PC_inc_en <= 1'b1;
                AC_inc_en <= 1'b0;

                AC_clear_en <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;

                state <= lda2; 
            end

            lda2: begin
               alu_op   <= 3'd0;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                DR_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b1;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;

                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;

                AC_clear_en <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;

                state <= lda3; 
            end

            lda3: begin
               alu_op   <= 3'd0;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                DR_read_en <= 1'b1;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b1;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;

                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;

                AC_clear_en <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;

                state <= lda4; 
            end

            lda4: begin
               alu_op   <= 3'd0;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b1;
                DR_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;

                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;

                AC_clear_en <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;

                state <= lda5; 
            end

            lda5: begin
               alu_op   <= 3'd0;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                DR_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b1;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;

                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;

                AC_clear_en <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;

                state <= lda6; 
            end

            lda6: begin
               alu_op   <= 3'd0;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                DR_read_en <= 1'b1;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b1;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;

                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;

                AC_clear_en <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;

                state <= fetch1; 
            end

            ldb1: begin
               alu_op   <= 3'd0;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b1;
                DR_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;

                PC_inc_en <= 1'b1;
                AC_inc_en <= 1'b0;

                AC_clear_en <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;

                state <= ldb2; 
            end

            ldb2: begin
               alu_op   <= 3'd0;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                DR_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b1;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;

                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;

                AC_clear_en <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;

                state <= ldb3; 
            end

            ldb3: begin
               alu_op   <= 3'd0;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                DR_read_en <= 1'b1;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b1;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;

                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;

                AC_clear_en <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;

                state <= ldb4; 
            end

            ldb4: begin
               alu_op   <= 3'd0;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b1;
                DR_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;

                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;

                AC_clear_en <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;

                state <= ldb5; 
            end

            ldb5: begin
               alu_op   <= 3'd0;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                DR_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b1;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;

                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;

                AC_clear_en <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;

                state <= ldb6; 
            end

            ldb6: begin
               alu_op   <= 3'd0;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                DR_read_en <= 1'b1;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b1;
                C_write_en  <= 1'b0;

                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;

                AC_clear_en <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;

                state <= fetch1; 
            end

            ldc1: begin
               alu_op   <= 3'd0;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b1;
                DR_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;

                PC_inc_en <= 1'b1;
                AC_inc_en <= 1'b0;

                AC_clear_en <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;

                state <= ldc2; 
            end

            ldc2: begin
               alu_op   <= 3'd0;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                DR_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b1;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;

                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;

                AC_clear_en <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;

                state <= ldc3; 
            end

            ldc3: begin
               alu_op   <= 3'd0;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                DR_read_en <= 1'b1;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b1;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;

                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;

                AC_clear_en <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;

                state <= ldc4; 
            end

            ldc4: begin
               alu_op   <= 3'd0;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b1;
                DR_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;

                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;

                AC_clear_en <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;

                state <= ldc5; 
            end

            ldc5: begin
               alu_op   <= 3'd0;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                DR_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b1;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;

                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;

                AC_clear_en <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;

                state <= ldc6; 
            end

            ldc6: begin
               alu_op   <= 3'd0;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                DR_read_en <= 1'b1;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b1;

                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;

                AC_clear_en <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;

                state <= fetch1; 
            end

            stc1: begin
               alu_op   <= 3'd0;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b1;
                DR_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;

                PC_inc_en <= 1'b1;
                AC_inc_en <= 1'b0;

                AC_clear_en <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;

                state <= stc2; 
            end

            stc2: begin
               alu_op   <= 3'd0;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                DR_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b1;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;

                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;

                AC_clear_en <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;

                state <= stc3; 
            end

            stc3: begin
               alu_op   <= 3'd0;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                DR_read_en <= 1'b1;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b1;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;

                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;

                AC_clear_en <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;

                state <= stc4; 
            end

            stc4: begin
               alu_op   <= 3'd0;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                DR_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b1;

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b1;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;

                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;

                AC_clear_en <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;

                state <= stc5; 
            end

            stc5: begin
               alu_op   <= 3'd0;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b1;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                DR_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b1;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;

                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;

                AC_clear_en <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;

                state <= stc6; 
            end

            stc6: begin
               alu_op   <= 3'd0;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                DR_read_en <= 1'b1;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b1;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;

                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;

                AC_clear_en <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;

                state <= fetch1; 
            end


            mvacr1: begin
                alu_op   <= 3'd0;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b1;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b1;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;

                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;

                AC_clear_en <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;

                state <= fetch1;
            end

            mvacc1: begin
                alu_op   <= 3'd0;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b1;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b1;

                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;

                AC_clear_en <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;

                state <= fetch1;
            end

            mva1: begin
                alu_op   <= 3'd0;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b1;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b1;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;

                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;

                AC_clear_en <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;

                state <= fetch1;
            end

            mvb1: begin
                alu_op   <= 3'd0;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b1;
                C_read_en  <= 1'b0;

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b1;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;

                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;

                AC_clear_en <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;

                state <= fetch1;
            end

            mvc1: begin
                alu_op   <= 3'd0;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b1;

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b1;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;

                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;

                AC_clear_en <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;

                state <= fetch1;
            end

            add1: begin
               alu_op   <= 3'd1;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;

                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;

                AC_clear_en <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;

                state <= add2;
            end

            add2: begin
               alu_op   <= 3'd0;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;

                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;

                AC_clear_en <= 1'b0;
                ALU_to_AC_write_en <= 1'b1;

                state <= fetch1;
            end

            // addm1: begin
            //     read_en  <= 16'b0000000000000000;       
            //     write_en <= 16'b0000000000000000;
            //     inc_en   <= 16'b0000000000000000;
            //     alu_op   <= 3'd0;
            //     state <= addm2;
            // end

            // addm2: begin
            //     read_en  <= 16'b0000000000000000;       
            //     write_en <= 16'b0000000000000000;
            //     inc_en   <= 16'b0000000000000000;
            //     alu_op   <= 3'd0;
            //     state <= addm3;
            // end

            // addm3: begin
            //     read_en  <= 16'b0000000000000000;       
            //     write_en <= 16'b0000000000000000;
            //     inc_en   <= 16'b0000000000000000;
            //     alu_op   <= 3'd0;
            //     state <= addm4;
            // end

            // addm4: begin
            //     read_en  <= 16'b0000000000000000;       
            //     write_en <= 16'b0000000000000000;
            //     inc_en   <= 16'b0000000000000000;
            //     alu_op   <= 3'd0;
            //     state <= fetch1;
            // end

            inac1: begin
                alu_op   <= 3'd0;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;

                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b1;      //AC = AC+1

                AC_clear_en <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;

                state <= fetch1;
            end

            sub1: begin
               alu_op   <= 3'd2;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;

                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;

                AC_clear_en <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;

                state <= sub2;
            end

            sub2: begin
               alu_op   <= 3'd0;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;

                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;

                AC_clear_en <= 1'b0;
                ALU_to_AC_write_en <= 1'b1;

                state <= fetch1;
            end

            mul1: begin
               alu_op   <= 3'd3;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;

                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;

                AC_clear_en <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;

                state <= mul2;
            end

            mul2: begin
               alu_op   <= 3'd0;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;

                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;

                AC_clear_en <= 1'b0;
                ALU_to_AC_write_en <= 1'b1;

                state <= fetch1;
            end

            // mulm1: begin
            //     read_en  <= 16'b0000000000000000;       
            //     write_en <= 16'b0000000000000000;
            //     inc_en   <= 16'b0000000000000000;
            //     alu_op   <= 3'd0;
            //     state <= mulm2;
            // end

            // mulm2: begin
            //     read_en  <= 16'b0000000000000000;       
            //     write_en <= 16'b0000000000000000;
            //     inc_en   <= 16'b0000000000000000;
            //     alu_op   <= 3'd0;
            //     state <= mulm3;
            // end

            // mulm3: begin
            //     read_en  <= 16'b0000000000000000;       
            //     write_en <= 16'b0000000000000000;
            //     inc_en   <= 16'b0000000000000000;
            //     alu_op   <= 3'd0;
            //     state <= mulm4;
            // end

            // mulm4: begin
            //     read_en  <= 16'b0000000000000000;       
            //     write_en <= 16'b0000000000000000;
            //     inc_en   <= 16'b0000000000000000;
            //     alu_op   <= 3'd0;
            //     state <= fetch1;
            // end

            clac1: begin
                alu_op   <= 3'd0;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;

                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;

                AC_clear_en <= 1'b1;
                ALU_to_AC_write_en <= 1'b0;

                state <= fetch1;
            end

            jpnz1: begin   //35
                if (z==1) begin
                    alu_op   <= 3'd0;

                    PC_read_en <= 1'b0;
                    AR_read_en <= 1'b0;
                    IR_read_en <= 1'b0;
                    AC_read_en <= 1'b0;
                    R_read_en  <= 1'b0;
                    DM_read_en <= 1'b0;
                    IM_read_en <= 1'b0;
                    A_read_en  <= 1'b0;
                    B_read_en  <= 1'b0;
                    C_read_en  <= 1'b0;

                    PC_write_en <= 1'b0;
                    AR_write_en <= 1'b0;
                    IR_write_en <= 1'b0;
                    AC_write_en <= 1'b0;
                    R_write_en  <= 1'b0;
                    DM_write_en <= 1'b0;
                    DR_write_en <= 1'b0;
                    IM_write_en <= 1'b0;
                    A_write_en  <= 1'b0;
                    B_write_en  <= 1'b0;
                    C_write_en  <= 1'b0;

                    PC_inc_en <= 1'b1;
                    AC_inc_en <= 1'b0;

                    AC_clear_en <= 1'b0;
                    ALU_to_AC_write_en <= 1'b0;

                    state <= jpnzx;
                end

                
                else begin
                    alu_op   <= 3'd0;

                    PC_read_en <= 1'b0;
                    AR_read_en <= 1'b1;
                    IR_read_en <= 1'b0;
                    AC_read_en <= 1'b0;
                    R_read_en  <= 1'b0;
                    DM_read_en <= 1'b0;
                    IM_read_en <= 1'b0;
                    A_read_en  <= 1'b0;
                    B_read_en  <= 1'b0;
                    C_read_en  <= 1'b0;     

                    PC_write_en <= 1'b1;
                    AR_write_en <= 1'b0;
                    IR_write_en <= 1'b0;
                    AC_write_en <= 1'b0;
                    R_write_en  <= 1'b0;
                    DM_write_en <= 1'b0;
                    DR_write_en <= 1'b0;
                    IM_write_en <= 1'b0;
                    A_write_en  <= 1'b0;
                    B_write_en  <= 1'b0;
                    C_write_en  <= 1'b0;

                    PC_inc_en <= 1'b0;
                    AC_inc_en <= 1'b0;

                    AC_clear_en <= 1'b0;
                    ALU_to_AC_write_en <= 1'b0;

                    state <= jpnz2;
                    
                end
            end

            jpnzx: begin
                    alu_op   <= 3'd0;

                    PC_read_en <= 1'b0;
                    AR_read_en <= 1'b0;
                    IR_read_en <= 1'b0;
                    AC_read_en <= 1'b0;
                    R_read_en  <= 1'b0;
                    DM_read_en <= 1'b0;
                    IM_read_en <= 1'b0;
                    A_read_en  <= 1'b0;
                    B_read_en  <= 1'b0;
                    C_read_en  <= 1'b0;

                    PC_write_en <= 1'b0;
                    AR_write_en <= 1'b0;
                    IR_write_en <= 1'b0;
                    AC_write_en <= 1'b0;
                    R_write_en  <= 1'b0;
                    DM_write_en <= 1'b0;
                    DR_write_en <= 1'b0;
                    IM_write_en <= 1'b0;
                    A_write_en  <= 1'b0;
                    B_write_en  <= 1'b0;
                    C_write_en  <= 1'b0;

                    PC_inc_en <= 1'b0;
                    AC_inc_en <= 1'b0;

                    AC_clear_en <= 1'b0;
                    ALU_to_AC_write_en <= 1'b0;

                    state <= fetch1;
                end


            jpnz2: begin
                alu_op   <= 3'd0;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;     

                PC_write_en <= 1'b0;  //Bus write to PC
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;

                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;

                AC_clear_en <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;

                state <= fetch1;
                
            end

            // jpnz3: begin
            //     alu_op   <= 3'd0;

            //     PC_read_en <= 1'b0;
            //     AR_read_en <= 1'b0;
            //     IR_read_en <= 1'b0;
            //     AC_read_en <= 1'b0;
            //     R_read_en  <= 1'b0;
            //     DM_read_en <= 1'b0;
            //     IM_read_en <= 1'b0;     

            //     PC_write_en <= 1'b0;  
            //     AR_write_en <= 1'b0;
            //     IR_write_en <= 1'b0;
            //     AC_write_en <= 1'b0;
            //     R_write_en  <= 1'b0;
            //     DM_write_en <= 1'b0;
            //     DR_write_en <= 1'b0;
            //     IM_write_en <= 1'b0;

            //     PC_inc_en <= 1'b0;
            //     AC_inc_en <= 1'b0;

            //     AC_clear_en <= 1'b0;
            //     ALU_to_AC_write_en <= 1'b0;

            //     state <= fetch1;
                
            // end


        
            // jmpz: begin                             //Check State Machine
            //     read_en  <= 16'b0000000000000000;       
            //     write_en <= 16'b0000000000000000;
            //     inc_en   <= 16'b0000000000000000;
            //     alu_op   <= 3'd0;

            //     if (z==1)
            //         state <= fetch1;
            //     else
            //         state <= jmpzn1;
            // end

            // jmpzn1: begin
            //     read_en  <= 16'b0000000000000000;       
            //     write_en <= 16'b0000000000000000;
            //     inc_en   <= 16'b0000000000000000;
            //     alu_op   <= 3'd0;
            //     state <= jmpzn2;
            // end

            // jmpzn2: begin
            //     read_en  <= 16'b0000000000000000;       
            //     write_en <= 16'b0000000000000000;
            //     inc_en   <= 16'b0000000000000000;
            //     alu_op   <= 3'd0;
            //     state <= fetch1;
            // end

            endop : begin
                end_process <= 1'b1;
                alu_op   <= 3'd0;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;

                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;

                AC_clear_en <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;

                state <= endop;
            end

            // default: begin
            //     read_en  <= 16'b0000000000000000;       
            //     write_en <= 16'b0000000000000000;
            //     inc_en   <= 16'b0000000000000000;
            //     alu_op   <= 3'd0;
            //     state <= fetch1;
            // end

        endcase
    end
endmodule