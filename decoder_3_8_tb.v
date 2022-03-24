module decoder_3_8_tb;
    reg E_tb;
    reg clka, clkb;
    reg [2:0] In_tb;              // 宣告In_tb為3位元
    wire [7:0] Out_tb;			  // 宣告Out_tb為8位元
    wire clka_out, clkb_out;

decoder_3_8 decoder_1(.E(E_tb), .In(In_tb), .Out(Out_tb));                               // 引用decoder_3_8生成訊號
clkgen clkgen_1(.clka(clka), .clkb(clkb), .clka_out(clka_out), .clkb_out(clkb_out));     // 引用clkgen生成訊號

initial begin   // 設長度為1數值為0的二進制
    clka = 1'b0; clkb = 1'b0; 
end
always begin
    #10 clka = ~clka;           // 每10秒將clka訊號反向
end
always begin
    #20 clkb = ~clkb;           // 每20秒將clkb訊號反向
end

initial begin                   // 給定狀態
    #0 E_tb = 0; In_tb = 3'b000;
    #10 E_tb = 1; In_tb = 3'b000;
    #10 E_tb = 1; In_tb = 3'b001;
    #10 E_tb = 1; In_tb = 3'b010;
    #10 E_tb = 1; In_tb = 3'b011;
    #10 E_tb = 1; In_tb = 3'b100;
    #10 E_tb = 1; In_tb = 3'b101;
    #10 E_tb = 1; In_tb = 3'b110;
    #10 E_tb = 1; In_tb = 3'b111;
    #10 $finish;
end

initial begin
    $dumpfile("decoder_3_8.vcd");  // 指定vcd檔名稱
    $dumpvars(0, decoder_1);       // 指定層數為0，紀錄decoder_1所有訊號
    $dumpvars(0, clkgen_1);        // 指定層數為0，紀錄clkgen_1所有訊號
end
endmodule