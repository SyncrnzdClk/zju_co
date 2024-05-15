module CSSTE(
    input         clk_100mhz,
    input         RSTN,
    input  [3:0]  BTN_y,
    input  [15:0] SW,
    output [3:0]  Blue,
    output [3:0]  Green,
    output [3:0]  Red,
    output        HSYNC,
    output        VSYNC,
    output [15:0] LED_out,
    output [7:0] AN,
    output [7:0] segment
);

wire [3:0] u9_btn_ok;
wire [15:0] u9_sw_ok;
wire u9_rst;
wire sw10_dout;
wire sw2_dout;
wire sw8_dout;
wire [9:0] pc11_2_dout;
wire util_vector_logic_0_res;
wire util_vector_logic_1_res;
wire [31:0] u8_clkdiv;
wire u8_clk_cpu;
wire [31:0] U2_spo;
wire div6_dout;
wire div9_dout;
wire div11_dout;
wire [63:0] div31_31_dout;



wire [1:0] b2_0_dout;
wire [63:0] b64_0_dout;
wire [31:0] xlconcat_1_dout;
wire [29:0] PC31_2_Dout;
wire U1_CPU_MIO;
wire [31:0] U1_PC_out_IF;
wire [31:0] U1_PC_out_ID;
wire [31:0] U1_Inst_ID;
wire [31:0] U1_PC_out_Ex;
wire U1_MemRW_Ex;
wire U1_MemRW_Mem;
wire [31:0] U1_Addr_out;
wire [31:0] U1_Data_out;
wire [31:0] U1_Data_out_WB;
wire [31:0] U3_douta;
wire U10_counter0_OUT;
wire U10_counter1_OUT;
wire U10_counter2_OUT;
wire [31:0] U10_counter_out;
wire div20_Dout;
wire div1_Dout;
wire [31:0] U4_Cpu_data4bus;
wire [31:0] U4_ram_data_in;
wire [9:0] U4_ram_addr;
wire U4_data_ram_we;
wire U4_GPIOf0000000_we;
wire U4_GPIOe0000000_we;
wire U4_counter_we;
wire [31:0] U4_Peripheral_in;
wire [2:0] sw7_5_Dout;
wire div16_Dout;
wire div17_Dout;
wire div18_Dout;
wire [2:0] clk16_18_dout;
wire [1:0] U7_counter_set;
wire [7:0] U5_point_out;
wire [7:0] U5_LE_out;
wire [31:0] U5_Disp_num;
wire [15:0] U7_LED_out;
assign LED_out = U7_LED_out;
assign sw10_dout = u9_sw_ok[10];
assign sw2_dout = u9_sw_ok[2];
assign sw8_dout = u9_sw_ok[8];
assign pc11_2_dout = U1_PC_out_IF[11:2];
assign util_vector_logic_1_res = ~clk_100mhz;
assign util_vector_logic_0_res = ~u8_clk_cpu;
assign div6_dout = u8_clkdiv[6];
assign div9_dout = u8_clkdiv[9];
assign div11_dout = u8_clkdiv[11];
assign div31_31_dout = {u8_clkdiv,u8_clkdiv};
assign PC31_2_Dout = U1_PC_out_IF[31:2];
assign xlconcat_1_dout = {2'b0,PC31_2_Dout};
assign b64_0_dout = 0;
assign div20_Dout = u8_clkdiv[20];
assign div1_Dout = u8_clkdiv[1];
assign div16_Dout = u8_clkdiv[16];
assign div17_Dout = u8_clkdiv[17];
assign div18_Dout = u8_clkdiv[18];
assign sw7_5_Dout = u9_sw_ok[7:5];
SAnti_jitter U9(
    .clk(clk_100mhz),
    .RSTN(RSTN),
    .Key_y(BTN_y),
    .SW(SW),
    .BTN_OK(u9_btn_ok),
    .SW_OK(u9_sw_ok),
    .rst(u9_rst)
);
Rom_D_0 U2(
    .a(pc11_2_dout),
    .spo(U2_spo)
);
clk_div U8(
    .clk(clk_100mhz),
    .rst(u9_rst),
    .SW2(sw2_dout),
    .SW8(sw8_dout),
    .STEP(sw10_dout),
    .clkdiv(u8_clkdiv),
    .Clk_CPU(u8_clk_cpu)
);

Pipeline_CPU U1(
    .clk(u8_clk_cpu),
    .rst(u9_rst),
    .inst_IF(U2_spo),
    .Data_in(U4_Cpu_data4bus),
    .CPU_MIO(U1_CPU_MIO),
    .PC_out_IF(U1_PC_out_IF),
    .PC_out_ID(U1_PC_out_ID),
    .Inst_ID(U1_Inst_ID),
    .PC_out_Ex(U1_PC_out_Ex),
    .MemRW_Ex(U1_MemRW_Ex),
    .MemRW_Mem(U1_MemRW_Mem),
    .Data_out(U1_Data_out),
    .Addr_out(U1_Addr_out),
    .Data_out_WB(U1_Data_out_WB)
);
RAM U3(
.clka(~clk_100mhz),
.wea(U4_data_ram_we),
.addra(U4_ram_addr),
.dina(U4_ram_data_in),
.douta(U3_douta)
);

MIO_BUS U4(
.clk(clk_100mhz),
.rst(u9_rst),
.BTN(u9_btn_ok),
.SW(u9_sw_ok),
.mem_w(U1_MemRW_Ex),
.Cpu_data2bus(U1_Data_out),
.addr_bus(U1_Addr_out),
.ram_data_out(U3_douta),
.led_out(U7_LED_out),
.counter_out(U10_counter_out),
.counter0_out(U10_counter0_OUT),
.counter1_out(U10_counter1_OUT),
.counter2_out(U10_counter2_OUT),
.Cpu_data4bus(U4_Cpu_data4bus),
.ram_data_in(U4_ram_data_in),
.ram_addr(U4_ram_addr),
.data_ram_we(U4_data_ram_we),
.GPIOe0000000_we(U4_GPIOe0000000_we),
.GPIOf0000000_we(U4_GPIOf0000000_we),
.counter_we(U4_counter_we),
.Peripheral_in(U4_Peripheral_in)
);

Counter_x U10(
    .clk(~u8_clk_cpu),
    .rst(u9_rst),
    .clk0(div6_dout),
    .clk1(div9_dout),
    .clk2(div11_dout),
    .counter_we(U4_counter_we),
    .counter_val(U4_Peripheral_in),
    .counter_ch(U7_counter_set),
    .counter0_OUT(U10_counter0_OUT),
    .counter1_OUT(U10_counter1_OUT),
    .counter2_OUT(U10_counter2_OUT),
    .counter_out(U10_counter_out)
);


Multi_8CH32 U5(
    .clk(util_vector_logic_0_res),
    .rst(u9_rst),
    .EN(U4_GPIOf0000000_we),
    .Test(sw7_5_Dout),
    .point_in(div31_31_dout),
    .LES(b64_0_dout),
    .Data0(U4_Peripheral_in),
    .data1(xlconcat_1_dout),
    .data2(U2_spo),
    .data3(U10_counter_out),
    .data4(U1_Addr_out),
    .data5(U1_Data_out),
    .data6(U4_Cpu_data4bus),
    .data7(U1_PC_out_IF),

    .point_out(U5_point_out),
    .LE_out(U5_LE_out),
    .Disp_num(U5_Disp_num)
);


Seg7_Dev_v1_0 U6(
    .disp_num(U5_Disp_num),
    .point(U5_point_out),
    .les(U5_LE_out),
    .scan(clk16_18_dout),

    .AN(AN),
    .segment(segment)
);

SPIO U7(
    .clk(util_vector_logic_0_res),
    .rst(u9_rst),
    .Start(div20_Dout),
    .EN(U4_GPIOf0000000_we),
    .P_Data(U4_Peripheral_in),
    .counter_set(U7_counter_set),
    .LED_out(U7_LED_out)
);




VGA U11(
    .clk_25m(div1_Dout),
    .clk_100m(clk_100mhz),
    .rst(u9_rst),
    .PC_IF(U1_PC_out_IF),
    .Inst_IF(U2_spo),
    .PC_ID(U1_PC_out_ID),
    .Inst_ID(U1_Inst_ID),
    .PC_Ex(U1_PC_out_Ex),
    .MemRW_Ex(U1_MemRW_Ex),
    .MemRW_Mem(U1_MemRW_Mem),
    .Data_out(U1_Data_out),
    .Addr_out(U1_Addr_out),
    .Data_out_WB(U1_Data_out_WB),
    .hs(HSYNC),
    .vs(VSYNC),
    .vga_r(Red),
    .vga_g(Green),
    .vga_b(Blue)
);

assign clk16_18_dout = {div18_Dout, div17_Dout, div16_Dout};

endmodule
