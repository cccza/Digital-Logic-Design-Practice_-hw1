//透過二對四解碼器完成三對八解碼器
module decoder_2_4 (E ,In, Out);
input E;                               // 致能控制線
input [1:0] In;                        // 2個輸入端
output[3:0] Out;                       // 4個輸出端
wire[3:0] Out;                         // 4個輸出線
assign Out = E ? 1'b1 << In : 4'h0;   // E=0，Out=0000;E=1，Out的初始值為1，跟據In值，左移In個位元
endmodule

module decoder_3_8(E , In , Out);
input E;                         // 制能控制線
input [2:0] In;                  // 3個輸入端
output [7:0] Out;                // 8個輸出端
wire E1, G1, G2;                 // E1:In[2]反向線,G1:block1智能控制線,G2:block2智能控制線
not u1(E1, In[2]);               // 將In[2]反向，輸出為E1
and a1(G1, E, In[2]);            // 將E與In[2] and，輸出為G1
and a2(G2, E, E1);	             // 將E與E1 and，輸出為2
decoder_2_4 block1(G1, In[1 : 0], Out[7 : 4]);   // 引用decoder_2_4，E→G1，In→In[1:0]，Out→Out[7:4]
decoder_2_4 block2(G2, In[1 : 0], Out[3 : 0]);   // 引用decoder_2_4，E→G2，In→In[1:0]，Out→Out[3:0]
endmodule

module clkgen(clka, clkb, clka_out, clkb_out);
input clka, clkb;                  // 輸入脈波 clka,clkb
output clka_out, clkb_out;         // 輸出脈波 clka_out,clkb_out
reg clka_out, clkb_out;            // 將值存入暫存器
    always @(clka) begin           // always 循環執行
    clka_out = clka;
    end

    always @(clkb) begin
    clkb_out = clkb;
    end
endmodule
