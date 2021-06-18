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
    output reg IM_read_en, 

    output reg PC_write_en, 
    output reg AR_write_en, 
    output reg IR_write_en, 
    output reg AC_write_en, 
    output reg R_write_en,  
    output reg DM_write_en, 
    output reg DM_addr_write_en,
    output reg IM_write_en, 

    output reg PC_inc_en,
    output reg AC_inc_en,

    output reg ALU_to_AC_write_en,
    output reg ALU_write_en,

    output reg AC_to_R_en

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
    

    mvac1 = 16'd15,

    mvr1 = 16'd16,

    add1 = 16'd17,
	add2 = 16'd18,

    addm1 = 16'd19,
    addm2 = 16'd20,
    addm3 = 16'd21,
    addm4 = 16'd22,

    inac1 = 16'd23,

    sub1 = 16'd24,

    mul1 = 16'd25,
    mul2 = 16'd39,

    mulm1 = 16'd26,
    mulm2 = 16'd27,
    mulm3 = 16'd28,
    mulm4 = 16'd29,

    clac1 = 16'd30,

    jump1 = 16'd31,
    jump2 = 16'd32,

    jmpz = 16'd33,
	jmpzp1 = 16'd34,
    jmpzn1 = 16'd35,
    jmpzn2 = 16'd36,

    endop = 16'd37,
    no_op = 16'd38;

    

    always @(posedge clk) begin
        if (state == endop)
            end_process <= 1'b1;
        
        else
            end_process <= 1'b0;
    end

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
                IM_read_en <= 1'b0;

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DM_addr_write_en <= 1'b0;
                IM_write_en <= 1'b0;

                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;

                ALU_to_AC_write_en <= 1'b0;
                ALU_write_en       <= 1'b0;
                
                AC_to_R_en <= 1'b0;


                if (status == 2'b01)
                    state <= fetch1;
                else
                    state <= idle;
            end

            fetch1: begin
                alu_op   <= 3'd0;

                PC_read_en <= 1'b1;     //PC write data to bus
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                IM_read_en <= 1'b0;

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b1;    //bus write data to AR
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DM_addr_write_en <= 1'b0;
                IM_write_en <= 1'b0;

                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;

                ALU_to_AC_write_en <= 1'b0;
                ALU_write_en       <= 1'b0;
                
                AC_to_R_en <= 1'b0;


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
                IM_read_en <= 1'b1;     //IM write data to bus

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DM_addr_write_en <= 1'b0;
                IM_write_en <= 1'b0;

                PC_inc_en <= 1'b1;      //PC = PC+1
                AC_inc_en <= 1'b0;

                ALU_to_AC_write_en <= 1'b0;
                ALU_write_en       <= 1'b0;
                
                AC_to_R_en <= 1'b0;


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
                IM_read_en <= 1'b0;

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b1;    //bus write data to IR
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DM_addr_write_en <= 1'b0;
                IM_write_en <= 1'b0;

                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;

                ALU_to_AC_write_en <= 1'b0;
                ALU_write_en       <= 1'b0;
                
                AC_to_R_en <= 1'b0;

                state <= fetch4;
            end

            fetch4: begin
            
                alu_op   <= 3'd0;

                PC_read_en <= 1'b1;     //PC write data to bus 
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b1;     //IR sends data to control unit
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                IM_read_en <= 1'b0;

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b1;    //bus write data to AR
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DM_addr_write_en <= 1'b0;
                IM_write_en <= 1'b0;

                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;

                ALU_to_AC_write_en <= 1'b0;
                ALU_write_en       <= 1'b0;
                
                AC_to_R_en <= 1'b0;

                state <= fetch5;
            end

            fetch5:begin
                alu_op   <= 3'd0;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                IM_read_en <= 1'b0;

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DM_addr_write_en <= 1'b0;
                IM_write_en <= 1'b0;

                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;

                ALU_to_AC_write_en <= 1'b0;
                ALU_write_en       <= 1'b0;
                
                AC_to_R_en <= 1'b0;


                state <= fetch6;
            end

            fetch6:begin
                alu_op   <= 3'd0;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                IM_read_en <= 1'b0;

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DM_addr_write_en <= 1'b0;
                IM_write_en <= 1'b0;

                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;

                ALU_to_AC_write_en <= 1'b0;
                ALU_write_en       <= 1'b0;
                
                AC_to_R_en <= 1'b0;

                state <= instruction;
            end

            ldac1: begin
            
                alu_op   <= 3'd0;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                IM_read_en <= 1'b1;     //IM write data to bus

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DM_addr_write_en <= 1'b0;
                IM_write_en <= 1'b0;

                PC_inc_en <= 1'b1;      //PC=PC+1
                AC_inc_en <= 1'b0;

                ALU_to_AC_write_en <= 1'b0;
                ALU_write_en       <= 1'b0;
                
                AC_to_R_en <= 1'b0;


                state <= ldacx;
            end

            ldacx: begin
            
                alu_op   <= 3'd0;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                IM_read_en <= 1'b0;     //IM write data to bus

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DM_addr_write_en <= 1'b0;
                IM_write_en <= 1'b0;

                PC_inc_en <= 1'b0;      //PC=PC+1
                AC_inc_en <= 1'b0;

                ALU_to_AC_write_en <= 1'b0;
                ALU_write_en       <= 1'b0;
                
                AC_to_R_en <= 1'b0;

                state <= ldac2;
            end

            ldac2: begin
        
                alu_op   <= 3'd0;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b1;     //DM write data to bus
                IM_read_en <= 1'b0;

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DM_addr_write_en <= 1'b0;
                IM_write_en <= 1'b0;

                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;

                ALU_to_AC_write_en <= 1'b0;
                ALU_write_en       <= 1'b0;
                
                AC_to_R_en <= 1'b0;

                state <= ldac3;
            end

            ldac3: begin
  
                alu_op   <= 3'd0;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;     
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                IM_read_en <= 1'b0;

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b1;       //Bus write data to AC
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DM_addr_write_en <= 1'b0;
                IM_write_en <= 1'b0;

                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;

                ALU_to_AC_write_en <= 1'b0;
                ALU_write_en       <= 1'b0;
                
                AC_to_R_en <= 1'b0;

                state <= fetch1;
            end

            stac1: begin
                alu_op   <= 3'd0;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                IM_read_en <= 1'b1;     //IM write data to bus

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DM_addr_write_en <= 1'b0;
                IM_write_en <= 1'b0;

                PC_inc_en <= 1'b1;      //PC=PC+1
                AC_inc_en <= 1'b0;

                ALU_to_AC_write_en <= 1'b0;
                ALU_write_en       <= 1'b0;
                
                AC_to_R_en <= 1'b0;


                state <= stacx;
            end

            stacx: begin
            
                alu_op   <= 3'd0;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                IM_read_en <= 1'b0;    

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DM_addr_write_en <= 1'b1;
                IM_write_en <= 1'b0;

                PC_inc_en <= 1'b0;      
                AC_inc_en <= 1'b0;

                ALU_to_AC_write_en <= 1'b0;
                ALU_write_en       <= 1'b0;
                
                AC_to_R_en <= 1'b0;

                state <= stac2;
            end

            stac2: begin
                alu_op   <= 3'd0;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;     
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b1;     //AC write data to bus
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                IM_read_en <= 1'b0;     

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DM_addr_write_en <= 1'b0;
                IM_write_en <= 1'b0;

                PC_inc_en <= 1'b0;      
                AC_inc_en <= 1'b0;

                ALU_to_AC_write_en <= 1'b0;
                ALU_write_en       <= 1'b0;
                
                AC_to_R_en <= 1'b0;

                state <= stac3;
            end

            stac3: begin
                alu_op   <= 3'd0;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b1;     //AC write data to bus
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                IM_read_en <= 1'b0;     

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b1;
                DM_addr_write_en <= 1'b0;
                IM_write_en <= 1'b0;

                PC_inc_en <= 1'b0;      
                AC_inc_en <= 1'b0;

                ALU_to_AC_write_en <= 1'b0;
                ALU_write_en       <= 1'b0;
                
                AC_to_R_en <= 1'b0;
                
                state <= fetch1;
            end

            mvac1: begin
                alu_op   <= 3'd0;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                IM_read_en <= 1'b0;

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DM_addr_write_en <= 1'b0;
                IM_write_en <= 1'b0;

                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;

                ALU_to_AC_write_en <= 1'b0;
                ALU_write_en       <= 1'b0;
                
                AC_to_R_en <= 1'b1;

                state <= fetch1;
            end

            // mvr1: begin
            //     read_en  <= 16'b0000000000000000;       
            //     write_en <= 16'b0000000000000000;
            //     inc_en   <= 16'b0000000000000000;
            //     alu_op   <= 3'd0;
            //     state <= fetch1;
            // end

            add1: begin
               alu_op   <= 3'd1;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                IM_read_en <= 1'b0;

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DM_addr_write_en <= 1'b0;
                IM_write_en <= 1'b0;

                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;

                ALU_to_AC_write_en <= 1'b0;
                ALU_write_en       <= 1'b1;
             
                AC_to_R_en <= 1'b0;

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

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DM_addr_write_en <= 1'b0;
                IM_write_en <= 1'b0;

                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;

                ALU_to_AC_write_en <= 1'b1;
                ALU_write_en       <= 1'b0;
             
                AC_to_R_en <= 1'b0;

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

            // inac1: begin
            //     read_en  <= 16'b0000000000000000;       
            //     write_en <= 16'b0000000000000000;
            //     inc_en   <= 16'b0000000000000000;
            //     alu_op   <= 3'd0;
            //     state <= fetch1;
            // end

            // sub1: begin
            //     read_en  <= 16'b0000000000000000;       
            //     write_en <= 16'b0000000000000000;
            //     inc_en   <= 16'b0000000000000000;
            //     alu_op   <= 3'd0;
            //     state <= fetch1;
            // end

            mul1: begin
               alu_op   <= 3'd3;

                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                IM_read_en <= 1'b0;

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DM_addr_write_en <= 1'b0;
                IM_write_en <= 1'b0;

                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;

                ALU_to_AC_write_en <= 1'b0;
                ALU_write_en       <= 1'b1;
             
                AC_to_R_en <= 1'b0;

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

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DM_addr_write_en <= 1'b0;
                IM_write_en <= 1'b0;

                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;

                ALU_to_AC_write_en <= 1'b1;
                ALU_write_en       <= 1'b0;
             
                AC_to_R_en <= 1'b0;

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

            // clac1: begin
            //     read_en  <= 16'b0000000000000000;       
            //     write_en <= 16'b0000000000000000;
            //     inc_en   <= 16'b0000000000000000;
            //     alu_op   <= 3'd0;
            //     state <= fetch1;
            // end

            // jump1: begin
            //     read_en  <= 16'b0000000000000000;       
            //     write_en <= 16'b0000000000000000;
            //     inc_en   <= 16'b0000000000000000;
            //     alu_op   <= 3'd0;
            //     state <= jump2;
            // end

            // jump2: begin
            //     read_en  <= 16'b0000000000000000;       
            //     write_en <= 16'b0000000000000000;
            //     inc_en   <= 16'b0000000000000000;
            //     alu_op   <= 3'd0;
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

            // endop : begin
            //     read_en  <= 16'b0000000000000000;       
            //     write_en <= 16'b0000000000000000;
            //     inc_en   <= 16'b0000000000000000;
            //     alu_op   <= 3'd0;
            //     state <= endop;
            // end

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