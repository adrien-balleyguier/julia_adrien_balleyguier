// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.2 (lin64) Build 4029153 Fri Oct 13 20:13:54 MDT 2023
// Date        : Tue Mar 26 10:06:19 2024
// Host        : xps15-deb running 64-bit Debian GNU/Linux 12 (bookworm)
// Command     : write_verilog -force -mode funcsim -rename_top scalp_zynqps_scalp_axi_link_cplx_num_regs_0 -prefix
//               scalp_zynqps_scalp_axi_link_cplx_num_regs_0_ scalp_zynqps_scalp_axi_link_firmwareid_0_sim_netlist.v
// Design      : scalp_zynqps_scalp_axi_link_firmwareid_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z015clg485-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "scalp_zynqps_scalp_axi_link_firmwareid_0,scalp_axi_link,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* ip_definition_source = "package_project" *) 
(* x_core_info = "scalp_axi_link,Vivado 2023.2" *) 
(* NotValidForBitStream *)
module scalp_zynqps_scalp_axi_link_cplx_num_regs_0
   (SAxiSlvClkxCI,
    SAxiSlvRstxRANI,
    SAxiSlvARAddrxDI,
    SAxiSlvARValidxSI,
    SAxiSlvARReadyxSO,
    SAxiSlvRDataxDO,
    SAxiSlvRRespxDO,
    SAxiSlvRValidxSO,
    SAxiSlvRReadyxSI,
    SAxiSlvAWAddrxDI,
    SAxiSlvAWValidxSI,
    SAxiSlvAWReadyxSO,
    SAxiSlvWDataxDI,
    SAxiSlvWStrbxDI,
    SAxiSlvWValidxSI,
    SAxiSlvWReadyxSO,
    SAxiSlvBRespxDO,
    SAxiSlvBValidxSO,
    SAxiSlvBReadyxSI,
    SAxiMstClkxCO,
    SAxiMstRstxRANO,
    SAxiMstARAddrxDO,
    SAxiMstARValidxSO,
    SAxiMstARReadyxSI,
    SAxiMstRDataxDI,
    SAxiMstRRespxDI,
    SAxiMstRValidxSI,
    SAxiMstRReadyxSO,
    SAxiMstAWAddrxDO,
    SAxiMstAWValidxSO,
    SAxiMstAWReadyxSI,
    SAxiMstWDataxDO,
    SAxiMstWStrbxDO,
    SAxiMstWValidxSO,
    SAxiMstWReadyxSI,
    SAxiMstBRespxDI,
    SAxiMstBValidxSI,
    SAxiMstBReadyxSO);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 aximm_slv_clk CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME aximm_slv_clk, ASSOCIATED_RESET SAxiSlvRstxRANI, ASSOCIATED_BUSIF aximm_slv_if, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN /sys_clock_clk_out1, INSERT_VIP 0" *) input SAxiSlvClkxCI;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 aximm_slv_rst RST" *) (* x_interface_parameter = "XIL_INTERFACENAME aximm_slv_rst, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input SAxiSlvRstxRANI;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 aximm_slv_if ARADDR" *) (* x_interface_parameter = "XIL_INTERFACENAME aximm_slv_if, DATA_WIDTH 32, PROTOCOL AXI4LITE, ID_WIDTH 0, ADDR_WIDTH 32, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 0, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, MAX_BURST_LENGTH 1, PHASE 0.0, CLK_DOMAIN /sys_clock_clk_out1, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) input [31:0]SAxiSlvARAddrxDI;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 aximm_slv_if ARVALID" *) input SAxiSlvARValidxSI;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 aximm_slv_if ARREADY" *) output SAxiSlvARReadyxSO;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 aximm_slv_if RDATA" *) output [31:0]SAxiSlvRDataxDO;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 aximm_slv_if RRESP" *) output [1:0]SAxiSlvRRespxDO;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 aximm_slv_if RVALID" *) output SAxiSlvRValidxSO;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 aximm_slv_if RREADY" *) input SAxiSlvRReadyxSI;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 aximm_slv_if AWADDR" *) input [31:0]SAxiSlvAWAddrxDI;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 aximm_slv_if AWVALID" *) input SAxiSlvAWValidxSI;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 aximm_slv_if AWREADY" *) output SAxiSlvAWReadyxSO;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 aximm_slv_if WDATA" *) input [31:0]SAxiSlvWDataxDI;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 aximm_slv_if WSTRB" *) input [3:0]SAxiSlvWStrbxDI;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 aximm_slv_if WVALID" *) input SAxiSlvWValidxSI;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 aximm_slv_if WREADY" *) output SAxiSlvWReadyxSO;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 aximm_slv_if BRESP" *) output [1:0]SAxiSlvBRespxDO;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 aximm_slv_if BVALID" *) output SAxiSlvBValidxSO;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 aximm_slv_if BREADY" *) input SAxiSlvBReadyxSI;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 aximm_mst_clk CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME aximm_mst_clk, ASSOCIATED_RESET SAxiMstRstxRANO, ASSOCIATED_BUSIF aximm_mst_if, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN scalp_zynqps_scalp_axi_link_firmwareid_0_SAxiMstClkxCO, INSERT_VIP 0" *) output SAxiMstClkxCO;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 aximm_master_reset RST" *) (* x_interface_parameter = "XIL_INTERFACENAME aximm_master_reset, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) output SAxiMstRstxRANO;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 aximm_mst_if ARADDR" *) (* x_interface_parameter = "XIL_INTERFACENAME aximm_mst_if, DATA_WIDTH 32, PROTOCOL AXI4LITE, ID_WIDTH 0, ADDR_WIDTH 32, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 0, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, MAX_BURST_LENGTH 1, PHASE 0.0, CLK_DOMAIN scalp_zynqps_scalp_axi_link_firmwareid_0_SAxiMstClkxCO, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) output [31:0]SAxiMstARAddrxDO;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 aximm_mst_if ARVALID" *) output SAxiMstARValidxSO;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 aximm_mst_if ARREADY" *) input SAxiMstARReadyxSI;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 aximm_mst_if RDATA" *) input [31:0]SAxiMstRDataxDI;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 aximm_mst_if RRESP" *) input [1:0]SAxiMstRRespxDI;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 aximm_mst_if RVALID" *) input SAxiMstRValidxSI;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 aximm_mst_if RREADY" *) output SAxiMstRReadyxSO;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 aximm_mst_if AWADDR" *) output [31:0]SAxiMstAWAddrxDO;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 aximm_mst_if AWVALID" *) output SAxiMstAWValidxSO;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 aximm_mst_if AWREADY" *) input SAxiMstAWReadyxSI;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 aximm_mst_if WDATA" *) output [31:0]SAxiMstWDataxDO;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 aximm_mst_if WSTRB" *) output [3:0]SAxiMstWStrbxDO;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 aximm_mst_if WVALID" *) output SAxiMstWValidxSO;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 aximm_mst_if WREADY" *) input SAxiMstWReadyxSI;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 aximm_mst_if BRESP" *) input [1:0]SAxiMstBRespxDI;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 aximm_mst_if BVALID" *) input SAxiMstBValidxSI;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 aximm_mst_if BREADY" *) output SAxiMstBReadyxSO;

  wire SAxiMstARReadyxSI;
  wire SAxiMstAWReadyxSI;
  wire [1:0]SAxiMstBRespxDI;
  wire SAxiMstBValidxSI;
  wire [31:0]SAxiMstRDataxDI;
  wire [1:0]SAxiMstRRespxDI;
  wire SAxiMstRValidxSI;
  wire SAxiMstWReadyxSI;
  wire [31:0]SAxiSlvARAddrxDI;
  wire SAxiSlvARValidxSI;
  wire [31:0]SAxiSlvAWAddrxDI;
  wire SAxiSlvAWValidxSI;
  wire SAxiSlvBReadyxSI;
  wire SAxiSlvClkxCI;
  wire SAxiSlvRReadyxSI;
  wire SAxiSlvRstxRANI;
  wire [31:0]SAxiSlvWDataxDI;
  wire [3:0]SAxiSlvWStrbxDI;
  wire SAxiSlvWValidxSI;

  assign SAxiMstARAddrxDO[31:0] = SAxiSlvARAddrxDI;
  assign SAxiMstARValidxSO = SAxiSlvARValidxSI;
  assign SAxiMstAWAddrxDO[31:0] = SAxiSlvAWAddrxDI;
  assign SAxiMstAWValidxSO = SAxiSlvAWValidxSI;
  assign SAxiMstBReadyxSO = SAxiSlvBReadyxSI;
  assign SAxiMstClkxCO = SAxiSlvClkxCI;
  assign SAxiMstRReadyxSO = SAxiSlvRReadyxSI;
  assign SAxiMstRstxRANO = SAxiSlvRstxRANI;
  assign SAxiMstWDataxDO[31:0] = SAxiSlvWDataxDI;
  assign SAxiMstWStrbxDO[3:0] = SAxiSlvWStrbxDI;
  assign SAxiMstWValidxSO = SAxiSlvWValidxSI;
  assign SAxiSlvARReadyxSO = SAxiMstARReadyxSI;
  assign SAxiSlvAWReadyxSO = SAxiMstAWReadyxSI;
  assign SAxiSlvBRespxDO[1:0] = SAxiMstBRespxDI;
  assign SAxiSlvBValidxSO = SAxiMstBValidxSI;
  assign SAxiSlvRDataxDO[31:0] = SAxiMstRDataxDI;
  assign SAxiSlvRRespxDO[1:0] = SAxiMstRRespxDI;
  assign SAxiSlvRValidxSO = SAxiMstRValidxSI;
  assign SAxiSlvWReadyxSO = SAxiMstWReadyxSI;
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
