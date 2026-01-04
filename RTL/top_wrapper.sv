`timescale 1ns/1ps

module top_wrapper (
    // Primary inputs
    input  logic                    clk,
    input  logic                    rst_n,
    
    // CPU interface inputs
    input  logic                    cpu_req_valid,
    input  logic                    cpu_req_rw,
    input  logic [31:0]             cpu_req_addr,
    input  logic [31:0]             cpu_req_wdata,
    
    // Memory interface inputs
    input  logic                    mem_resp_valid,
    input  logic [127:0]            mem_resp_rdata,
    
    // CPU interface outputs
    output logic                    cpu_resp_valid,
    output logic [31:0]             cpu_resp_rdata,
    
    // Memory interface outputs
    output logic                    mem_req_valid,
    output logic                    mem_req_rw,
    output logic [31:0]             mem_req_addr,
    output logic [127:0]            mem_req_wdata
);

    // Internal nets (between pads and core)
    wire wclk, wrst_n;
    wire wcpu_req_valid, wcpu_req_rw;
    wire [31:0] wcpu_req_addr, wcpu_req_wdata;
    wire wmem_resp_valid;
    wire [127:0] wmem_resp_rdata;
    wire wcpu_resp_valid;
    wire [31:0] wcpu_resp_rdata;
    wire wmem_req_valid, wmem_req_rw;
    wire [31:0] wmem_req_addr;
    wire [127:0] wmem_req_wdata;

    // =============================================================
    // Clock Pad (Crystal Oscillator Cell)
    // =============================================================
    PDXOE3DG clk_pad (
        .E(1'b1),          // Enable always high
        .XIN(clk),           // External clock input
        .XC(wclk),          // Clock to core
        .XOUT()             // Not used
    );

    // =============================================================
    // Reset Pad (Active Low) - Input Pad
    // =============================================================
    PDDW16DGZ rst_pad (
        .OEN(1'b1),         // Disable output (input mode)
        .I(1'b1),           // Disable output driver
        .PAD(rst_n),        // External reset
        .REN(1'b1),         // Enable input buffer
        .C(wrst_n)          // Reset to core
    );

    // =============================================================
    // CPU Interface Input Pads (32-bit address + 32-bit data + 2 control)
    // =============================================================
    // cpu_req_valid
    PDDW16DGZ cpu_req_valid_pad (
        .OEN(1'b1), .I(1'b1), .PAD(cpu_req_valid), .REN(1'b1), .C(wcpu_req_valid)
    );
    
    // cpu_req_rw
    PDDW16DGZ cpu_req_rw_pad (
        .OEN(1'b1), .I(1'b1), .PAD(cpu_req_rw), .REN(1'b1), .C(wcpu_req_rw)
    );
    
    // cpu_req_addr[31:0]
	PDDW16DGZ cpu_addr_pad0 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_addr[0]), .REN(1'b1), .C(wcpu_req_addr[0]));
	PDDW16DGZ cpu_addr_pad1 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_addr[1]), .REN(1'b1), .C(wcpu_req_addr[1]));
	PDDW16DGZ cpu_addr_pad2 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_addr[2]), .REN(1'b1), .C(wcpu_req_addr[2]));
	PDDW16DGZ cpu_addr_pad3 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_addr[3]), .REN(1'b1), .C(wcpu_req_addr[3]));
	PDDW16DGZ cpu_addr_pad4 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_addr[4]), .REN(1'b1), .C(wcpu_req_addr[4]));
	PDDW16DGZ cpu_addr_pad5 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_addr[5]), .REN(1'b1), .C(wcpu_req_addr[5]));
	PDDW16DGZ cpu_addr_pad6 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_addr[6]), .REN(1'b1), .C(wcpu_req_addr[6]));
	PDDW16DGZ cpu_addr_pad7 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_addr[7]), .REN(1'b1), .C(wcpu_req_addr[7]));
	PDDW16DGZ cpu_addr_pad8 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_addr[8]), .REN(1'b1), .C(wcpu_req_addr[8]));
	PDDW16DGZ cpu_addr_pad9 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_addr[9]), .REN(1'b1), .C(wcpu_req_addr[9]));
	PDDW16DGZ cpu_addr_pad10 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_addr[10]), .REN(1'b1), .C(wcpu_req_addr[10]));
	PDDW16DGZ cpu_addr_pad11 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_addr[11]), .REN(1'b1), .C(wcpu_req_addr[11]));
	PDDW16DGZ cpu_addr_pad12 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_addr[12]), .REN(1'b1), .C(wcpu_req_addr[12]));
	PDDW16DGZ cpu_addr_pad13 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_addr[13]), .REN(1'b1), .C(wcpu_req_addr[13]));
	PDDW16DGZ cpu_addr_pad14 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_addr[14]), .REN(1'b1), .C(wcpu_req_addr[14]));
	PDDW16DGZ cpu_addr_pad15 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_addr[15]), .REN(1'b1), .C(wcpu_req_addr[15]));
	PDDW16DGZ cpu_addr_pad16 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_addr[16]), .REN(1'b1), .C(wcpu_req_addr[16]));
	PDDW16DGZ cpu_addr_pad17 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_addr[17]), .REN(1'b1), .C(wcpu_req_addr[17]));
	PDDW16DGZ cpu_addr_pad18 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_addr[18]), .REN(1'b1), .C(wcpu_req_addr[18]));
	PDDW16DGZ cpu_addr_pad19 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_addr[19]), .REN(1'b1), .C(wcpu_req_addr[19]));
	PDDW16DGZ cpu_addr_pad20 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_addr[20]), .REN(1'b1), .C(wcpu_req_addr[20]));
	PDDW16DGZ cpu_addr_pad21 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_addr[21]), .REN(1'b1), .C(wcpu_req_addr[21]));
	PDDW16DGZ cpu_addr_pad22 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_addr[22]), .REN(1'b1), .C(wcpu_req_addr[22]));
	PDDW16DGZ cpu_addr_pad23 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_addr[23]), .REN(1'b1), .C(wcpu_req_addr[23]));
	PDDW16DGZ cpu_addr_pad24 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_addr[24]), .REN(1'b1), .C(wcpu_req_addr[24]));
	PDDW16DGZ cpu_addr_pad25 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_addr[25]), .REN(1'b1), .C(wcpu_req_addr[25]));
	PDDW16DGZ cpu_addr_pad26 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_addr[26]), .REN(1'b1), .C(wcpu_req_addr[26]));
	PDDW16DGZ cpu_addr_pad27 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_addr[27]), .REN(1'b1), .C(wcpu_req_addr[27]));
	PDDW16DGZ cpu_addr_pad28 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_addr[28]), .REN(1'b1), .C(wcpu_req_addr[28]));
	PDDW16DGZ cpu_addr_pad29 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_addr[29]), .REN(1'b1), .C(wcpu_req_addr[29]));
	PDDW16DGZ cpu_addr_pad30 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_addr[30]), .REN(1'b1), .C(wcpu_req_addr[30]));
	PDDW16DGZ cpu_addr_pad31 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_addr[31]), .REN(1'b1), .C(wcpu_req_addr[31]));



    
    // cpu_req_wdata[31:0]

	PDDW16DGZ cpu_wdata_pad0 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_wdata[0]), .REN(1'b1), .C(wcpu_req_wdata[0]));
	PDDW16DGZ cpu_wdata_pad1 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_wdata[1]), .REN(1'b1), .C(wcpu_req_wdata[1]));
	PDDW16DGZ cpu_wdata_pad2 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_wdata[2]), .REN(1'b1), .C(wcpu_req_wdata[2]));
	PDDW16DGZ cpu_wdata_pad3 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_wdata[3]), .REN(1'b1), .C(wcpu_req_wdata[3]));
	PDDW16DGZ cpu_wdata_pad4 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_wdata[4]), .REN(1'b1), .C(wcpu_req_wdata[4]));
	PDDW16DGZ cpu_wdata_pad5 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_wdata[5]), .REN(1'b1), .C(wcpu_req_wdata[5]));
	PDDW16DGZ cpu_wdata_pad6 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_wdata[6]), .REN(1'b1), .C(wcpu_req_wdata[6]));
	PDDW16DGZ cpu_wdata_pad7 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_wdata[7]), .REN(1'b1), .C(wcpu_req_wdata[7]));
	PDDW16DGZ cpu_wdata_pad8 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_wdata[8]), .REN(1'b1), .C(wcpu_req_wdata[8]));
	PDDW16DGZ cpu_wdata_pad9 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_wdata[9]), .REN(1'b1), .C(wcpu_req_wdata[9]));
	PDDW16DGZ cpu_wdata_pad10 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_wdata[10]), .REN(1'b1), .C(wcpu_req_wdata[10]));
	PDDW16DGZ cpu_wdata_pad11 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_wdata[11]), .REN(1'b1), .C(wcpu_req_wdata[11]));
	PDDW16DGZ cpu_wdata_pad12 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_wdata[12]), .REN(1'b1), .C(wcpu_req_wdata[12]));
	PDDW16DGZ cpu_wdata_pad13 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_wdata[13]), .REN(1'b1), .C(wcpu_req_wdata[13]));
	PDDW16DGZ cpu_wdata_pad14 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_wdata[14]), .REN(1'b1), .C(wcpu_req_wdata[14]));
	PDDW16DGZ cpu_wdata_pad15 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_wdata[15]), .REN(1'b1), .C(wcpu_req_wdata[15]));
	PDDW16DGZ cpu_wdata_pad16 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_wdata[16]), .REN(1'b1), .C(wcpu_req_wdata[16]));
	PDDW16DGZ cpu_wdata_pad17 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_wdata[17]), .REN(1'b1), .C(wcpu_req_wdata[17]));
	PDDW16DGZ cpu_wdata_pad18 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_wdata[18]), .REN(1'b1), .C(wcpu_req_wdata[18]));
	PDDW16DGZ cpu_wdata_pad19 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_wdata[19]), .REN(1'b1), .C(wcpu_req_wdata[19]));
	PDDW16DGZ cpu_wdata_pad20 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_wdata[20]), .REN(1'b1), .C(wcpu_req_wdata[20]));
	PDDW16DGZ cpu_wdata_pad21 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_wdata[21]), .REN(1'b1), .C(wcpu_req_wdata[21]));
	PDDW16DGZ cpu_wdata_pad22 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_wdata[22]), .REN(1'b1), .C(wcpu_req_wdata[22]));
	PDDW16DGZ cpu_wdata_pad23 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_wdata[23]), .REN(1'b1), .C(wcpu_req_wdata[23]));
	PDDW16DGZ cpu_wdata_pad24 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_wdata[24]), .REN(1'b1), .C(wcpu_req_wdata[24]));
	PDDW16DGZ cpu_wdata_pad25 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_wdata[25]), .REN(1'b1), .C(wcpu_req_wdata[25]));
	PDDW16DGZ cpu_wdata_pad26 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_wdata[26]), .REN(1'b1), .C(wcpu_req_wdata[26]));
	PDDW16DGZ cpu_wdata_pad27 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_wdata[27]), .REN(1'b1), .C(wcpu_req_wdata[27]));
	PDDW16DGZ cpu_wdata_pad28 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_wdata[28]), .REN(1'b1), .C(wcpu_req_wdata[28]));
	PDDW16DGZ cpu_wdata_pad29 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_wdata[29]), .REN(1'b1), .C(wcpu_req_wdata[29]));
	PDDW16DGZ cpu_wdata_pad30 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_wdata[30]), .REN(1'b1), .C(wcpu_req_wdata[30]));
	PDDW16DGZ cpu_wdata_pad31 (.OEN(1'b1), .I(1'b1), .PAD(cpu_req_wdata[31]), .REN(1'b1), .C(wcpu_req_wdata[31]));



    // =============================================================
    // Memory Response Input Pads (1 control + 128-bit data)
    // =============================================================
    // mem_resp_valid
    PDDW16DGZ mem_resp_valid_pad (
        .OEN(1'b1), .I(1'b1), .PAD(mem_resp_valid), .REN(1'b1), .C(wmem_resp_valid)
    );
    
    // mem_resp_rdata[127:0]

	PDDW16DGZ mem_rdata_pad0 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[0]), .REN(1'b1), .C(wmem_resp_rdata[0]));
	PDDW16DGZ mem_rdata_pad1 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[1]), .REN(1'b1), .C(wmem_resp_rdata[1]));
	PDDW16DGZ mem_rdata_pad2 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[2]), .REN(1'b1), .C(wmem_resp_rdata[2]));
	PDDW16DGZ mem_rdata_pad3 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[3]), .REN(1'b1), .C(wmem_resp_rdata[3]));
	PDDW16DGZ mem_rdata_pad4 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[4]), .REN(1'b1), .C(wmem_resp_rdata[4]));
	PDDW16DGZ mem_rdata_pad5 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[5]), .REN(1'b1), .C(wmem_resp_rdata[5]));
	PDDW16DGZ mem_rdata_pad6 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[6]), .REN(1'b1), .C(wmem_resp_rdata[6]));
	PDDW16DGZ mem_rdata_pad7 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[7]), .REN(1'b1), .C(wmem_resp_rdata[7]));
	PDDW16DGZ mem_rdata_pad8 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[8]), .REN(1'b1), .C(wmem_resp_rdata[8]));
	PDDW16DGZ mem_rdata_pad9 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[9]), .REN(1'b1), .C(wmem_resp_rdata[9]));
	PDDW16DGZ mem_rdata_pad10 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[10]), .REN(1'b1), .C(wmem_resp_rdata[10]));
	PDDW16DGZ mem_rdata_pad11 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[11]), .REN(1'b1), .C(wmem_resp_rdata[11]));
	PDDW16DGZ mem_rdata_pad12 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[12]), .REN(1'b1), .C(wmem_resp_rdata[12]));
	PDDW16DGZ mem_rdata_pad13 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[13]), .REN(1'b1), .C(wmem_resp_rdata[13]));
	PDDW16DGZ mem_rdata_pad14 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[14]), .REN(1'b1), .C(wmem_resp_rdata[14]));
	PDDW16DGZ mem_rdata_pad15 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[15]), .REN(1'b1), .C(wmem_resp_rdata[15]));
	PDDW16DGZ mem_rdata_pad16 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[16]), .REN(1'b1), .C(wmem_resp_rdata[16]));
	PDDW16DGZ mem_rdata_pad17 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[17]), .REN(1'b1), .C(wmem_resp_rdata[17]));
	PDDW16DGZ mem_rdata_pad18 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[18]), .REN(1'b1), .C(wmem_resp_rdata[18]));
	PDDW16DGZ mem_rdata_pad19 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[19]), .REN(1'b1), .C(wmem_resp_rdata[19]));
	PDDW16DGZ mem_rdata_pad20 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[20]), .REN(1'b1), .C(wmem_resp_rdata[20]));
	PDDW16DGZ mem_rdata_pad21 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[21]), .REN(1'b1), .C(wmem_resp_rdata[21]));
	PDDW16DGZ mem_rdata_pad22 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[22]), .REN(1'b1), .C(wmem_resp_rdata[22]));
	PDDW16DGZ mem_rdata_pad23 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[23]), .REN(1'b1), .C(wmem_resp_rdata[23]));
	PDDW16DGZ mem_rdata_pad24 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[24]), .REN(1'b1), .C(wmem_resp_rdata[24]));
	PDDW16DGZ mem_rdata_pad25 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[25]), .REN(1'b1), .C(wmem_resp_rdata[25]));
	PDDW16DGZ mem_rdata_pad26 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[26]), .REN(1'b1), .C(wmem_resp_rdata[26]));
	PDDW16DGZ mem_rdata_pad27 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[27]), .REN(1'b1), .C(wmem_resp_rdata[27]));
	PDDW16DGZ mem_rdata_pad28 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[28]), .REN(1'b1), .C(wmem_resp_rdata[28]));
	PDDW16DGZ mem_rdata_pad29 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[29]), .REN(1'b1), .C(wmem_resp_rdata[29]));
	PDDW16DGZ mem_rdata_pad30 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[30]), .REN(1'b1), .C(wmem_resp_rdata[30]));
	PDDW16DGZ mem_rdata_pad31 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[31]), .REN(1'b1), .C(wmem_resp_rdata[31]));
	PDDW16DGZ mem_rdata_pad32  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[32]),  .REN(1'b1), .C(wmem_resp_rdata[32]));
	PDDW16DGZ mem_rdata_pad33  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[33]),  .REN(1'b1), .C(wmem_resp_rdata[33]));
	PDDW16DGZ mem_rdata_pad34  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[34]),  .REN(1'b1), .C(wmem_resp_rdata[34]));
	PDDW16DGZ mem_rdata_pad35  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[35]),  .REN(1'b1), .C(wmem_resp_rdata[35]));
	PDDW16DGZ mem_rdata_pad36  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[36]),  .REN(1'b1), .C(wmem_resp_rdata[36]));
	PDDW16DGZ mem_rdata_pad37  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[37]),  .REN(1'b1), .C(wmem_resp_rdata[37]));
	PDDW16DGZ mem_rdata_pad38  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[38]),  .REN(1'b1), .C(wmem_resp_rdata[38]));
	PDDW16DGZ mem_rdata_pad39  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[39]),  .REN(1'b1), .C(wmem_resp_rdata[39]));
	PDDW16DGZ mem_rdata_pad40  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[40]),  .REN(1'b1), .C(wmem_resp_rdata[40]));
	PDDW16DGZ mem_rdata_pad41  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[41]),  .REN(1'b1), .C(wmem_resp_rdata[41]));
	PDDW16DGZ mem_rdata_pad42  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[42]),  .REN(1'b1), .C(wmem_resp_rdata[42]));
	PDDW16DGZ mem_rdata_pad43  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[43]),  .REN(1'b1), .C(wmem_resp_rdata[43]));
	PDDW16DGZ mem_rdata_pad44  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[44]),  .REN(1'b1), .C(wmem_resp_rdata[44]));
	PDDW16DGZ mem_rdata_pad45  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[45]),  .REN(1'b1), .C(wmem_resp_rdata[45]));
	PDDW16DGZ mem_rdata_pad46  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[46]),  .REN(1'b1), .C(wmem_resp_rdata[46]));
	PDDW16DGZ mem_rdata_pad47  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[47]),  .REN(1'b1), .C(wmem_resp_rdata[47]));
	PDDW16DGZ mem_rdata_pad48  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[48]),  .REN(1'b1), .C(wmem_resp_rdata[48]));
	PDDW16DGZ mem_rdata_pad49  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[49]),  .REN(1'b1), .C(wmem_resp_rdata[49]));
	PDDW16DGZ mem_rdata_pad50  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[50]),  .REN(1'b1), .C(wmem_resp_rdata[50]));
	PDDW16DGZ mem_rdata_pad51  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[51]),  .REN(1'b1), .C(wmem_resp_rdata[51]));
	PDDW16DGZ mem_rdata_pad52  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[52]),  .REN(1'b1), .C(wmem_resp_rdata[52]));
	PDDW16DGZ mem_rdata_pad53  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[53]),  .REN(1'b1), .C(wmem_resp_rdata[53]));
	PDDW16DGZ mem_rdata_pad54  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[54]),  .REN(1'b1), .C(wmem_resp_rdata[54]));
	PDDW16DGZ mem_rdata_pad55  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[55]),  .REN(1'b1), .C(wmem_resp_rdata[55]));
	PDDW16DGZ mem_rdata_pad56  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[56]),  .REN(1'b1), .C(wmem_resp_rdata[56]));
	PDDW16DGZ mem_rdata_pad57  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[57]),  .REN(1'b1), .C(wmem_resp_rdata[57]));
	PDDW16DGZ mem_rdata_pad58  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[58]),  .REN(1'b1), .C(wmem_resp_rdata[58]));
	PDDW16DGZ mem_rdata_pad59  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[59]),  .REN(1'b1), .C(wmem_resp_rdata[59]));
	PDDW16DGZ mem_rdata_pad60  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[60]),  .REN(1'b1), .C(wmem_resp_rdata[60]));
	PDDW16DGZ mem_rdata_pad61  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[61]),  .REN(1'b1), .C(wmem_resp_rdata[61]));
	PDDW16DGZ mem_rdata_pad62  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[62]),  .REN(1'b1), .C(wmem_resp_rdata[62]));
	PDDW16DGZ mem_rdata_pad63  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[63]),  .REN(1'b1), .C(wmem_resp_rdata[63]));
	PDDW16DGZ mem_rdata_pad64  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[64]),  .REN(1'b1), .C(wmem_resp_rdata[64]));
	PDDW16DGZ mem_rdata_pad65  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[65]),  .REN(1'b1), .C(wmem_resp_rdata[65]));
	PDDW16DGZ mem_rdata_pad66  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[66]),  .REN(1'b1), .C(wmem_resp_rdata[66]));
	PDDW16DGZ mem_rdata_pad67  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[67]),  .REN(1'b1), .C(wmem_resp_rdata[67]));
	PDDW16DGZ mem_rdata_pad68  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[68]),  .REN(1'b1), .C(wmem_resp_rdata[68]));
	PDDW16DGZ mem_rdata_pad69  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[69]),  .REN(1'b1), .C(wmem_resp_rdata[69]));
	PDDW16DGZ mem_rdata_pad70  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[70]),  .REN(1'b1), .C(wmem_resp_rdata[70]));
	PDDW16DGZ mem_rdata_pad71  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[71]),  .REN(1'b1), .C(wmem_resp_rdata[71]));
	PDDW16DGZ mem_rdata_pad72  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[72]),  .REN(1'b1), .C(wmem_resp_rdata[72]));
	PDDW16DGZ mem_rdata_pad73  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[73]),  .REN(1'b1), .C(wmem_resp_rdata[73]));
	PDDW16DGZ mem_rdata_pad74  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[74]),  .REN(1'b1), .C(wmem_resp_rdata[74]));
	PDDW16DGZ mem_rdata_pad75  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[75]),  .REN(1'b1), .C(wmem_resp_rdata[75]));
	PDDW16DGZ mem_rdata_pad76  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[76]),  .REN(1'b1), .C(wmem_resp_rdata[76]));
	PDDW16DGZ mem_rdata_pad77  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[77]),  .REN(1'b1), .C(wmem_resp_rdata[77]));
	PDDW16DGZ mem_rdata_pad78  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[78]),  .REN(1'b1), .C(wmem_resp_rdata[78]));
	PDDW16DGZ mem_rdata_pad79  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[79]),  .REN(1'b1), .C(wmem_resp_rdata[79]));
	PDDW16DGZ mem_rdata_pad80  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[80]),  .REN(1'b1), .C(wmem_resp_rdata[80]));
	PDDW16DGZ mem_rdata_pad81  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[81]),  .REN(1'b1), .C(wmem_resp_rdata[81]));
	PDDW16DGZ mem_rdata_pad82  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[82]),  .REN(1'b1), .C(wmem_resp_rdata[82]));
	PDDW16DGZ mem_rdata_pad83  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[83]),  .REN(1'b1), .C(wmem_resp_rdata[83]));
	PDDW16DGZ mem_rdata_pad84  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[84]),  .REN(1'b1), .C(wmem_resp_rdata[84]));
	PDDW16DGZ mem_rdata_pad85  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[85]),  .REN(1'b1), .C(wmem_resp_rdata[85]));
	PDDW16DGZ mem_rdata_pad86  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[86]),  .REN(1'b1), .C(wmem_resp_rdata[86]));
	PDDW16DGZ mem_rdata_pad87  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[87]),  .REN(1'b1), .C(wmem_resp_rdata[87]));
	PDDW16DGZ mem_rdata_pad88  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[88]),  .REN(1'b1), .C(wmem_resp_rdata[88]));
	PDDW16DGZ mem_rdata_pad89  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[89]),  .REN(1'b1), .C(wmem_resp_rdata[89]));
	PDDW16DGZ mem_rdata_pad90  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[90]),  .REN(1'b1), .C(wmem_resp_rdata[90]));
	PDDW16DGZ mem_rdata_pad91  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[91]),  .REN(1'b1), .C(wmem_resp_rdata[91]));
	PDDW16DGZ mem_rdata_pad92  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[92]),  .REN(1'b1), .C(wmem_resp_rdata[92]));
	PDDW16DGZ mem_rdata_pad93  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[93]),  .REN(1'b1), .C(wmem_resp_rdata[93]));
	PDDW16DGZ mem_rdata_pad94  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[94]),  .REN(1'b1), .C(wmem_resp_rdata[94]));
	PDDW16DGZ mem_rdata_pad95  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[95]),  .REN(1'b1), .C(wmem_resp_rdata[95]));
	PDDW16DGZ mem_rdata_pad96  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[96]),  .REN(1'b1), .C(wmem_resp_rdata[96]));
	PDDW16DGZ mem_rdata_pad97  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[97]),  .REN(1'b1), .C(wmem_resp_rdata[97]));
	PDDW16DGZ mem_rdata_pad98  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[98]),  .REN(1'b1), .C(wmem_resp_rdata[98]));
	PDDW16DGZ mem_rdata_pad99  (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[99]),  .REN(1'b1), .C(wmem_resp_rdata[99]));
	PDDW16DGZ mem_rdata_pad100 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[100]), .REN(1'b1), .C(wmem_resp_rdata[100]));
	PDDW16DGZ mem_rdata_pad101 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[101]), .REN(1'b1), .C(wmem_resp_rdata[101]));
	PDDW16DGZ mem_rdata_pad102 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[102]), .REN(1'b1), .C(wmem_resp_rdata[102]));
	PDDW16DGZ mem_rdata_pad103 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[103]), .REN(1'b1), .C(wmem_resp_rdata[103]));
	PDDW16DGZ mem_rdata_pad104 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[104]), .REN(1'b1), .C(wmem_resp_rdata[104]));
	PDDW16DGZ mem_rdata_pad105 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[105]), .REN(1'b1), .C(wmem_resp_rdata[105]));
	PDDW16DGZ mem_rdata_pad106 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[106]), .REN(1'b1), .C(wmem_resp_rdata[106]));
	PDDW16DGZ mem_rdata_pad107 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[107]), .REN(1'b1), .C(wmem_resp_rdata[107]));
	PDDW16DGZ mem_rdata_pad108 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[108]), .REN(1'b1), .C(wmem_resp_rdata[108]));
	PDDW16DGZ mem_rdata_pad109 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[109]), .REN(1'b1), .C(wmem_resp_rdata[109]));
	PDDW16DGZ mem_rdata_pad110 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[110]), .REN(1'b1), .C(wmem_resp_rdata[110]));
	PDDW16DGZ mem_rdata_pad111 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[111]), .REN(1'b1), .C(wmem_resp_rdata[111]));
	PDDW16DGZ mem_rdata_pad112 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[112]), .REN(1'b1), .C(wmem_resp_rdata[112]));
	PDDW16DGZ mem_rdata_pad113 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[113]), .REN(1'b1), .C(wmem_resp_rdata[113]));
	PDDW16DGZ mem_rdata_pad114 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[114]), .REN(1'b1), .C(wmem_resp_rdata[114]));
	PDDW16DGZ mem_rdata_pad115 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[115]), .REN(1'b1), .C(wmem_resp_rdata[115]));
	PDDW16DGZ mem_rdata_pad116 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[116]), .REN(1'b1), .C(wmem_resp_rdata[116]));
	PDDW16DGZ mem_rdata_pad117 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[117]), .REN(1'b1), .C(wmem_resp_rdata[117]));
	PDDW16DGZ mem_rdata_pad118 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[118]), .REN(1'b1), .C(wmem_resp_rdata[118]));
	PDDW16DGZ mem_rdata_pad119 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[119]), .REN(1'b1), .C(wmem_resp_rdata[119]));
	PDDW16DGZ mem_rdata_pad120 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[120]), .REN(1'b1), .C(wmem_resp_rdata[120]));
	PDDW16DGZ mem_rdata_pad121 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[121]), .REN(1'b1), .C(wmem_resp_rdata[121]));
	PDDW16DGZ mem_rdata_pad122 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[122]), .REN(1'b1), .C(wmem_resp_rdata[122]));
	PDDW16DGZ mem_rdata_pad123 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[123]), .REN(1'b1), .C(wmem_resp_rdata[123]));
	PDDW16DGZ mem_rdata_pad124 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[124]), .REN(1'b1), .C(wmem_resp_rdata[124]));
	PDDW16DGZ mem_rdata_pad125 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[125]), .REN(1'b1), .C(wmem_resp_rdata[125]));
	PDDW16DGZ mem_rdata_pad126 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[126]), .REN(1'b1), .C(wmem_resp_rdata[126]));
	PDDW16DGZ mem_rdata_pad127 (.OEN(1'b1), .I(1'b1), .PAD(mem_resp_rdata[127]), .REN(1'b1), .C(wmem_resp_rdata[127]));


    // =============================================================
    // CPU Response Output Pads (1 control + 32-bit data)
    // =============================================================
    // cpu_resp_valid
    PDDW16DGZ cpu_resp_valid_pad (
        .OEN(1'b0),         // Enable output
        .I(wcpu_resp_valid), // From core
        .PAD(cpu_resp_valid), // To external
        .REN(1'b0),         // Not used for output
        .C()                // Not used for output
    );
    
    // cpu_resp_rdata[31:0]

	PDDW16DGZ cpu_resp_data_pad0 (.OEN(1'b0), .I(wcpu_resp_rdata[0]), .PAD(cpu_resp_rdata[0]), .REN(1'b0), .C());
	PDDW16DGZ cpu_resp_data_pad1 (.OEN(1'b0), .I(wcpu_resp_rdata[1]), .PAD(cpu_resp_rdata[1]), .REN(1'b0), .C());
	PDDW16DGZ cpu_resp_data_pad2 (.OEN(1'b0), .I(wcpu_resp_rdata[2]), .PAD(cpu_resp_rdata[2]), .REN(1'b0), .C());
	PDDW16DGZ cpu_resp_data_pad3 (.OEN(1'b0), .I(wcpu_resp_rdata[3]), .PAD(cpu_resp_rdata[3]), .REN(1'b0), .C());
	PDDW16DGZ cpu_resp_data_pad4 (.OEN(1'b0), .I(wcpu_resp_rdata[4]), .PAD(cpu_resp_rdata[4]), .REN(1'b0), .C());
	PDDW16DGZ cpu_resp_data_pad5 (.OEN(1'b0), .I(wcpu_resp_rdata[5]), .PAD(cpu_resp_rdata[5]), .REN(1'b0), .C());
	PDDW16DGZ cpu_resp_data_pad6 (.OEN(1'b0), .I(wcpu_resp_rdata[6]), .PAD(cpu_resp_rdata[6]), .REN(1'b0), .C());
	PDDW16DGZ cpu_resp_data_pad7 (.OEN(1'b0), .I(wcpu_resp_rdata[7]), .PAD(cpu_resp_rdata[7]), .REN(1'b0), .C());
	PDDW16DGZ cpu_resp_data_pad8 (.OEN(1'b0), .I(wcpu_resp_rdata[8]), .PAD(cpu_resp_rdata[8]), .REN(1'b0), .C());
	PDDW16DGZ cpu_resp_data_pad9 (.OEN(1'b0), .I(wcpu_resp_rdata[9]), .PAD(cpu_resp_rdata[9]), .REN(1'b0), .C());
	PDDW16DGZ cpu_resp_data_pad10 (.OEN(1'b0), .I(wcpu_resp_rdata[10]), .PAD(cpu_resp_rdata[10]), .REN(1'b0), .C());
	PDDW16DGZ cpu_resp_data_pad11 (.OEN(1'b0), .I(wcpu_resp_rdata[11]), .PAD(cpu_resp_rdata[11]), .REN(1'b0), .C());
	PDDW16DGZ cpu_resp_data_pad12 (.OEN(1'b0), .I(wcpu_resp_rdata[12]), .PAD(cpu_resp_rdata[12]), .REN(1'b0), .C());
	PDDW16DGZ cpu_resp_data_pad13 (.OEN(1'b0), .I(wcpu_resp_rdata[13]), .PAD(cpu_resp_rdata[13]), .REN(1'b0), .C());
	PDDW16DGZ cpu_resp_data_pad14 (.OEN(1'b0), .I(wcpu_resp_rdata[14]), .PAD(cpu_resp_rdata[14]), .REN(1'b0), .C());
	PDDW16DGZ cpu_resp_data_pad15 (.OEN(1'b0), .I(wcpu_resp_rdata[15]), .PAD(cpu_resp_rdata[15]), .REN(1'b0), .C());
	PDDW16DGZ cpu_resp_data_pad16 (.OEN(1'b0), .I(wcpu_resp_rdata[16]), .PAD(cpu_resp_rdata[16]), .REN(1'b0), .C());
	PDDW16DGZ cpu_resp_data_pad17 (.OEN(1'b0), .I(wcpu_resp_rdata[17]), .PAD(cpu_resp_rdata[17]), .REN(1'b0), .C());
	PDDW16DGZ cpu_resp_data_pad18 (.OEN(1'b0), .I(wcpu_resp_rdata[18]), .PAD(cpu_resp_rdata[18]), .REN(1'b0), .C());
	PDDW16DGZ cpu_resp_data_pad19 (.OEN(1'b0), .I(wcpu_resp_rdata[19]), .PAD(cpu_resp_rdata[19]), .REN(1'b0), .C());
	PDDW16DGZ cpu_resp_data_pad20 (.OEN(1'b0), .I(wcpu_resp_rdata[20]), .PAD(cpu_resp_rdata[20]), .REN(1'b0), .C());
	PDDW16DGZ cpu_resp_data_pad21 (.OEN(1'b0), .I(wcpu_resp_rdata[21]), .PAD(cpu_resp_rdata[21]), .REN(1'b0), .C());
	PDDW16DGZ cpu_resp_data_pad22 (.OEN(1'b0), .I(wcpu_resp_rdata[22]), .PAD(cpu_resp_rdata[22]), .REN(1'b0), .C());
	PDDW16DGZ cpu_resp_data_pad23 (.OEN(1'b0), .I(wcpu_resp_rdata[23]), .PAD(cpu_resp_rdata[23]), .REN(1'b0), .C());
	PDDW16DGZ cpu_resp_data_pad24 (.OEN(1'b0), .I(wcpu_resp_rdata[24]), .PAD(cpu_resp_rdata[24]), .REN(1'b0), .C());
	PDDW16DGZ cpu_resp_data_pad25 (.OEN(1'b0), .I(wcpu_resp_rdata[25]), .PAD(cpu_resp_rdata[25]), .REN(1'b0), .C());
	PDDW16DGZ cpu_resp_data_pad26 (.OEN(1'b0), .I(wcpu_resp_rdata[26]), .PAD(cpu_resp_rdata[26]), .REN(1'b0), .C());
	PDDW16DGZ cpu_resp_data_pad27 (.OEN(1'b0), .I(wcpu_resp_rdata[27]), .PAD(cpu_resp_rdata[27]), .REN(1'b0), .C());
	PDDW16DGZ cpu_resp_data_pad28 (.OEN(1'b0), .I(wcpu_resp_rdata[28]), .PAD(cpu_resp_rdata[28]), .REN(1'b0), .C());
	PDDW16DGZ cpu_resp_data_pad29 (.OEN(1'b0), .I(wcpu_resp_rdata[29]), .PAD(cpu_resp_rdata[29]), .REN(1'b0), .C());
	PDDW16DGZ cpu_resp_data_pad30 (.OEN(1'b0), .I(wcpu_resp_rdata[30]), .PAD(cpu_resp_rdata[30]), .REN(1'b0), .C());
	PDDW16DGZ cpu_resp_data_pad31 (.OEN(1'b0), .I(wcpu_resp_rdata[31]), .PAD(cpu_resp_rdata[31]), .REN(1'b0), .C());



    // =============================================================
    // Memory Request Output Pads (2 control + 32-bit addr + 128-bit data)
    // =============================================================
    // mem_req_valid

    PDDW16DGZ mem_req_valid_pad (
        .OEN(1'b0), .I(wmem_req_valid), .PAD(mem_req_valid), .REN(1'b0), .C()
    );
    
    // mem_req_rw
    PDDW16DGZ mem_req_rw_pad (
        .OEN(1'b0), .I(wmem_req_rw), .PAD(mem_req_rw), .REN(1'b0), .C()
    );
    
    // mem_req_addr[31:0]

	PDDW16DGZ mem_addr_pad0 (.OEN(1'b0), .I(wmem_req_addr[0]), .PAD(mem_req_addr[0]), .REN(1'b0), .C());
	PDDW16DGZ mem_addr_pad1 (.OEN(1'b0), .I(wmem_req_addr[1]), .PAD(mem_req_addr[1]), .REN(1'b0), .C());
	PDDW16DGZ mem_addr_pad2 (.OEN(1'b0), .I(wmem_req_addr[2]), .PAD(mem_req_addr[2]), .REN(1'b0), .C());
	PDDW16DGZ mem_addr_pad3 (.OEN(1'b0), .I(wmem_req_addr[3]), .PAD(mem_req_addr[3]), .REN(1'b0), .C());
	PDDW16DGZ mem_addr_pad4 (.OEN(1'b0), .I(wmem_req_addr[4]), .PAD(mem_req_addr[4]), .REN(1'b0), .C());
	PDDW16DGZ mem_addr_pad5 (.OEN(1'b0), .I(wmem_req_addr[5]), .PAD(mem_req_addr[5]), .REN(1'b0), .C());
	PDDW16DGZ mem_addr_pad6 (.OEN(1'b0), .I(wmem_req_addr[6]), .PAD(mem_req_addr[6]), .REN(1'b0), .C());
	PDDW16DGZ mem_addr_pad7 (.OEN(1'b0), .I(wmem_req_addr[7]), .PAD(mem_req_addr[7]), .REN(1'b0), .C());
	PDDW16DGZ mem_addr_pad8 (.OEN(1'b0), .I(wmem_req_addr[8]), .PAD(mem_req_addr[8]), .REN(1'b0), .C());
	PDDW16DGZ mem_addr_pad9 (.OEN(1'b0), .I(wmem_req_addr[9]), .PAD(mem_req_addr[9]), .REN(1'b0), .C());
	PDDW16DGZ mem_addr_pad10 (.OEN(1'b0), .I(wmem_req_addr[10]), .PAD(mem_req_addr[10]), .REN(1'b0), .C());
	PDDW16DGZ mem_addr_pad11 (.OEN(1'b0), .I(wmem_req_addr[11]), .PAD(mem_req_addr[11]), .REN(1'b0), .C());
	PDDW16DGZ mem_addr_pad12 (.OEN(1'b0), .I(wmem_req_addr[12]), .PAD(mem_req_addr[12]), .REN(1'b0), .C());
	PDDW16DGZ mem_addr_pad13 (.OEN(1'b0), .I(wmem_req_addr[13]), .PAD(mem_req_addr[13]), .REN(1'b0), .C());
	PDDW16DGZ mem_addr_pad14 (.OEN(1'b0), .I(wmem_req_addr[14]), .PAD(mem_req_addr[14]), .REN(1'b0), .C());
	PDDW16DGZ mem_addr_pad15 (.OEN(1'b0), .I(wmem_req_addr[15]), .PAD(mem_req_addr[15]), .REN(1'b0), .C());
	PDDW16DGZ mem_addr_pad16 (.OEN(1'b0), .I(wmem_req_addr[16]), .PAD(mem_req_addr[16]), .REN(1'b0), .C());
	PDDW16DGZ mem_addr_pad17 (.OEN(1'b0), .I(wmem_req_addr[17]), .PAD(mem_req_addr[17]), .REN(1'b0), .C());
	PDDW16DGZ mem_addr_pad18 (.OEN(1'b0), .I(wmem_req_addr[18]), .PAD(mem_req_addr[18]), .REN(1'b0), .C());
	PDDW16DGZ mem_addr_pad19 (.OEN(1'b0), .I(wmem_req_addr[19]), .PAD(mem_req_addr[19]), .REN(1'b0), .C());
	PDDW16DGZ mem_addr_pad20 (.OEN(1'b0), .I(wmem_req_addr[20]), .PAD(mem_req_addr[20]), .REN(1'b0), .C());
	PDDW16DGZ mem_addr_pad21 (.OEN(1'b0), .I(wmem_req_addr[21]), .PAD(mem_req_addr[21]), .REN(1'b0), .C());
	PDDW16DGZ mem_addr_pad22 (.OEN(1'b0), .I(wmem_req_addr[22]), .PAD(mem_req_addr[22]), .REN(1'b0), .C());
	PDDW16DGZ mem_addr_pad23 (.OEN(1'b0), .I(wmem_req_addr[23]), .PAD(mem_req_addr[23]), .REN(1'b0), .C());
	PDDW16DGZ mem_addr_pad24 (.OEN(1'b0), .I(wmem_req_addr[24]), .PAD(mem_req_addr[24]), .REN(1'b0), .C());
	PDDW16DGZ mem_addr_pad25 (.OEN(1'b0), .I(wmem_req_addr[25]), .PAD(mem_req_addr[25]), .REN(1'b0), .C());
	PDDW16DGZ mem_addr_pad26 (.OEN(1'b0), .I(wmem_req_addr[26]), .PAD(mem_req_addr[26]), .REN(1'b0), .C());
	PDDW16DGZ mem_addr_pad27 (.OEN(1'b0), .I(wmem_req_addr[27]), .PAD(mem_req_addr[27]), .REN(1'b0), .C());
	PDDW16DGZ mem_addr_pad28 (.OEN(1'b0), .I(wmem_req_addr[28]), .PAD(mem_req_addr[28]), .REN(1'b0), .C());
	PDDW16DGZ mem_addr_pad29 (.OEN(1'b0), .I(wmem_req_addr[29]), .PAD(mem_req_addr[29]), .REN(1'b0), .C());
	PDDW16DGZ mem_addr_pad30 (.OEN(1'b0), .I(wmem_req_addr[30]), .PAD(mem_req_addr[30]), .REN(1'b0), .C());
	PDDW16DGZ mem_addr_pad31 (.OEN(1'b0), .I(wmem_req_addr[31]), .PAD(mem_req_addr[31]), .REN(1'b0), .C());

    
    // mem_req_wdata[127:0]

	PDDW16DGZ mem_wdata_pad0 (.OEN(1'b0), .I(wmem_req_wdata[0]), .PAD(mem_req_wdata[0]), .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad1 (.OEN(1'b0), .I(wmem_req_wdata[1]), .PAD(mem_req_wdata[1]), .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad2 (.OEN(1'b0), .I(wmem_req_wdata[2]), .PAD(mem_req_wdata[2]), .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad3 (.OEN(1'b0), .I(wmem_req_wdata[3]), .PAD(mem_req_wdata[3]), .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad4 (.OEN(1'b0), .I(wmem_req_wdata[4]), .PAD(mem_req_wdata[4]), .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad5 (.OEN(1'b0), .I(wmem_req_wdata[5]), .PAD(mem_req_wdata[5]), .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad6 (.OEN(1'b0), .I(wmem_req_wdata[6]), .PAD(mem_req_wdata[6]), .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad7 (.OEN(1'b0), .I(wmem_req_wdata[7]), .PAD(mem_req_wdata[7]), .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad8 (.OEN(1'b0), .I(wmem_req_wdata[8]), .PAD(mem_req_wdata[8]), .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad9 (.OEN(1'b0), .I(wmem_req_wdata[9]), .PAD(mem_req_wdata[9]), .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad10 (.OEN(1'b0), .I(wmem_req_wdata[10]), .PAD(mem_req_wdata[10]), .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad11 (.OEN(1'b0), .I(wmem_req_wdata[11]), .PAD(mem_req_wdata[11]), .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad12 (.OEN(1'b0), .I(wmem_req_wdata[12]), .PAD(mem_req_wdata[12]), .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad13 (.OEN(1'b0), .I(wmem_req_wdata[13]), .PAD(mem_req_wdata[13]), .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad14 (.OEN(1'b0), .I(wmem_req_wdata[14]), .PAD(mem_req_wdata[14]), .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad15 (.OEN(1'b0), .I(wmem_req_wdata[15]), .PAD(mem_req_wdata[15]), .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad16 (.OEN(1'b0), .I(wmem_req_wdata[16]), .PAD(mem_req_wdata[16]), .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad17 (.OEN(1'b0), .I(wmem_req_wdata[17]), .PAD(mem_req_wdata[17]), .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad18 (.OEN(1'b0), .I(wmem_req_wdata[18]), .PAD(mem_req_wdata[18]), .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad19 (.OEN(1'b0), .I(wmem_req_wdata[19]), .PAD(mem_req_wdata[19]), .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad20 (.OEN(1'b0), .I(wmem_req_wdata[20]), .PAD(mem_req_wdata[20]), .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad21 (.OEN(1'b0), .I(wmem_req_wdata[21]), .PAD(mem_req_wdata[21]), .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad22 (.OEN(1'b0), .I(wmem_req_wdata[22]), .PAD(mem_req_wdata[22]), .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad23 (.OEN(1'b0), .I(wmem_req_wdata[23]), .PAD(mem_req_wdata[23]), .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad24 (.OEN(1'b0), .I(wmem_req_wdata[24]), .PAD(mem_req_wdata[24]), .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad25 (.OEN(1'b0), .I(wmem_req_wdata[25]), .PAD(mem_req_wdata[25]), .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad26 (.OEN(1'b0), .I(wmem_req_wdata[26]), .PAD(mem_req_wdata[26]), .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad27 (.OEN(1'b0), .I(wmem_req_wdata[27]), .PAD(mem_req_wdata[27]), .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad28 (.OEN(1'b0), .I(wmem_req_wdata[28]), .PAD(mem_req_wdata[28]), .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad29 (.OEN(1'b0), .I(wmem_req_wdata[29]), .PAD(mem_req_wdata[29]), .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad30 (.OEN(1'b0), .I(wmem_req_wdata[30]), .PAD(mem_req_wdata[30]), .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad31 (.OEN(1'b0), .I(wmem_req_wdata[31]), .PAD(mem_req_wdata[31]), .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad32  (.OEN(1'b0), .I(wmem_req_wdata[32]),  .PAD(mem_req_wdata[32]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad33  (.OEN(1'b0), .I(wmem_req_wdata[33]),  .PAD(mem_req_wdata[33]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad34  (.OEN(1'b0), .I(wmem_req_wdata[34]),  .PAD(mem_req_wdata[34]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad35  (.OEN(1'b0), .I(wmem_req_wdata[35]),  .PAD(mem_req_wdata[35]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad36  (.OEN(1'b0), .I(wmem_req_wdata[36]),  .PAD(mem_req_wdata[36]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad37  (.OEN(1'b0), .I(wmem_req_wdata[37]),  .PAD(mem_req_wdata[37]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad38  (.OEN(1'b0), .I(wmem_req_wdata[38]),  .PAD(mem_req_wdata[38]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad39  (.OEN(1'b0), .I(wmem_req_wdata[39]),  .PAD(mem_req_wdata[39]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad40  (.OEN(1'b0), .I(wmem_req_wdata[40]),  .PAD(mem_req_wdata[40]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad41  (.OEN(1'b0), .I(wmem_req_wdata[41]),  .PAD(mem_req_wdata[41]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad42  (.OEN(1'b0), .I(wmem_req_wdata[42]),  .PAD(mem_req_wdata[42]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad43  (.OEN(1'b0), .I(wmem_req_wdata[43]),  .PAD(mem_req_wdata[43]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad44  (.OEN(1'b0), .I(wmem_req_wdata[44]),  .PAD(mem_req_wdata[44]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad45  (.OEN(1'b0), .I(wmem_req_wdata[45]),  .PAD(mem_req_wdata[45]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad46  (.OEN(1'b0), .I(wmem_req_wdata[46]),  .PAD(mem_req_wdata[46]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad47  (.OEN(1'b0), .I(wmem_req_wdata[47]),  .PAD(mem_req_wdata[47]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad48  (.OEN(1'b0), .I(wmem_req_wdata[48]),  .PAD(mem_req_wdata[48]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad49  (.OEN(1'b0), .I(wmem_req_wdata[49]),  .PAD(mem_req_wdata[49]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad50  (.OEN(1'b0), .I(wmem_req_wdata[50]),  .PAD(mem_req_wdata[50]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad51  (.OEN(1'b0), .I(wmem_req_wdata[51]),  .PAD(mem_req_wdata[51]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad52  (.OEN(1'b0), .I(wmem_req_wdata[52]),  .PAD(mem_req_wdata[52]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad53  (.OEN(1'b0), .I(wmem_req_wdata[53]),  .PAD(mem_req_wdata[53]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad54  (.OEN(1'b0), .I(wmem_req_wdata[54]),  .PAD(mem_req_wdata[54]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad55  (.OEN(1'b0), .I(wmem_req_wdata[55]),  .PAD(mem_req_wdata[55]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad56  (.OEN(1'b0), .I(wmem_req_wdata[56]),  .PAD(mem_req_wdata[56]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad57  (.OEN(1'b0), .I(wmem_req_wdata[57]),  .PAD(mem_req_wdata[57]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad58  (.OEN(1'b0), .I(wmem_req_wdata[58]),  .PAD(mem_req_wdata[58]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad59  (.OEN(1'b0), .I(wmem_req_wdata[59]),  .PAD(mem_req_wdata[59]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad60  (.OEN(1'b0), .I(wmem_req_wdata[60]),  .PAD(mem_req_wdata[60]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad61  (.OEN(1'b0), .I(wmem_req_wdata[61]),  .PAD(mem_req_wdata[61]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad62  (.OEN(1'b0), .I(wmem_req_wdata[62]),  .PAD(mem_req_wdata[62]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad63  (.OEN(1'b0), .I(wmem_req_wdata[63]),  .PAD(mem_req_wdata[63]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad64  (.OEN(1'b0), .I(wmem_req_wdata[64]),  .PAD(mem_req_wdata[64]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad65  (.OEN(1'b0), .I(wmem_req_wdata[65]),  .PAD(mem_req_wdata[65]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad66  (.OEN(1'b0), .I(wmem_req_wdata[66]),  .PAD(mem_req_wdata[66]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad67  (.OEN(1'b0), .I(wmem_req_wdata[67]),  .PAD(mem_req_wdata[67]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad68  (.OEN(1'b0), .I(wmem_req_wdata[68]),  .PAD(mem_req_wdata[68]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad69  (.OEN(1'b0), .I(wmem_req_wdata[69]),  .PAD(mem_req_wdata[69]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad70  (.OEN(1'b0), .I(wmem_req_wdata[70]),  .PAD(mem_req_wdata[70]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad71  (.OEN(1'b0), .I(wmem_req_wdata[71]),  .PAD(mem_req_wdata[71]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad72  (.OEN(1'b0), .I(wmem_req_wdata[72]),  .PAD(mem_req_wdata[72]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad73  (.OEN(1'b0), .I(wmem_req_wdata[73]),  .PAD(mem_req_wdata[73]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad74  (.OEN(1'b0), .I(wmem_req_wdata[74]),  .PAD(mem_req_wdata[74]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad75  (.OEN(1'b0), .I(wmem_req_wdata[75]),  .PAD(mem_req_wdata[75]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad76  (.OEN(1'b0), .I(wmem_req_wdata[76]),  .PAD(mem_req_wdata[76]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad77  (.OEN(1'b0), .I(wmem_req_wdata[77]),  .PAD(mem_req_wdata[77]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad78  (.OEN(1'b0), .I(wmem_req_wdata[78]),  .PAD(mem_req_wdata[78]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad79  (.OEN(1'b0), .I(wmem_req_wdata[79]),  .PAD(mem_req_wdata[79]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad80  (.OEN(1'b0), .I(wmem_req_wdata[80]),  .PAD(mem_req_wdata[80]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad81  (.OEN(1'b0), .I(wmem_req_wdata[81]),  .PAD(mem_req_wdata[81]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad82  (.OEN(1'b0), .I(wmem_req_wdata[82]),  .PAD(mem_req_wdata[82]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad83  (.OEN(1'b0), .I(wmem_req_wdata[83]),  .PAD(mem_req_wdata[83]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad84  (.OEN(1'b0), .I(wmem_req_wdata[84]),  .PAD(mem_req_wdata[84]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad85  (.OEN(1'b0), .I(wmem_req_wdata[85]),  .PAD(mem_req_wdata[85]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad86  (.OEN(1'b0), .I(wmem_req_wdata[86]),  .PAD(mem_req_wdata[86]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad87  (.OEN(1'b0), .I(wmem_req_wdata[87]),  .PAD(mem_req_wdata[87]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad88  (.OEN(1'b0), .I(wmem_req_wdata[88]),  .PAD(mem_req_wdata[88]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad89  (.OEN(1'b0), .I(wmem_req_wdata[89]),  .PAD(mem_req_wdata[89]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad90  (.OEN(1'b0), .I(wmem_req_wdata[90]),  .PAD(mem_req_wdata[90]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad91  (.OEN(1'b0), .I(wmem_req_wdata[91]),  .PAD(mem_req_wdata[91]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad92  (.OEN(1'b0), .I(wmem_req_wdata[92]),  .PAD(mem_req_wdata[92]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad93  (.OEN(1'b0), .I(wmem_req_wdata[93]),  .PAD(mem_req_wdata[93]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad94  (.OEN(1'b0), .I(wmem_req_wdata[94]),  .PAD(mem_req_wdata[94]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad95  (.OEN(1'b0), .I(wmem_req_wdata[95]),  .PAD(mem_req_wdata[95]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad96  (.OEN(1'b0), .I(wmem_req_wdata[96]),  .PAD(mem_req_wdata[96]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad97  (.OEN(1'b0), .I(wmem_req_wdata[97]),  .PAD(mem_req_wdata[97]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad98  (.OEN(1'b0), .I(wmem_req_wdata[98]),  .PAD(mem_req_wdata[98]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad99  (.OEN(1'b0), .I(wmem_req_wdata[99]),  .PAD(mem_req_wdata[99]),  .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad100 (.OEN(1'b0), .I(wmem_req_wdata[100]), .PAD(mem_req_wdata[100]), .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad101 (.OEN(1'b0), .I(wmem_req_wdata[101]), .PAD(mem_req_wdata[101]), .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad102 (.OEN(1'b0), .I(wmem_req_wdata[102]), .PAD(mem_req_wdata[102]), .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad103 (.OEN(1'b0), .I(wmem_req_wdata[103]), .PAD(mem_req_wdata[103]), .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad104 (.OEN(1'b0), .I(wmem_req_wdata[104]), .PAD(mem_req_wdata[104]), .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad105 (.OEN(1'b0), .I(wmem_req_wdata[105]), .PAD(mem_req_wdata[105]), .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad106 (.OEN(1'b0), .I(wmem_req_wdata[106]), .PAD(mem_req_wdata[106]), .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad107 (.OEN(1'b0), .I(wmem_req_wdata[107]), .PAD(mem_req_wdata[107]), .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad108 (.OEN(1'b0), .I(wmem_req_wdata[108]), .PAD(mem_req_wdata[108]), .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad109 (.OEN(1'b0), .I(wmem_req_wdata[109]), .PAD(mem_req_wdata[109]), .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad110 (.OEN(1'b0), .I(wmem_req_wdata[110]), .PAD(mem_req_wdata[110]), .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad111 (.OEN(1'b0), .I(wmem_req_wdata[111]), .PAD(mem_req_wdata[111]), .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad112 (.OEN(1'b0), .I(wmem_req_wdata[112]), .PAD(mem_req_wdata[112]), .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad113 (.OEN(1'b0), .I(wmem_req_wdata[113]), .PAD(mem_req_wdata[113]), .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad114 (.OEN(1'b0), .I(wmem_req_wdata[114]), .PAD(mem_req_wdata[114]), .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad115 (.OEN(1'b0), .I(wmem_req_wdata[115]), .PAD(mem_req_wdata[115]), .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad116 (.OEN(1'b0), .I(wmem_req_wdata[116]), .PAD(mem_req_wdata[116]), .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad117 (.OEN(1'b0), .I(wmem_req_wdata[117]), .PAD(mem_req_wdata[117]), .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad118 (.OEN(1'b0), .I(wmem_req_wdata[118]), .PAD(mem_req_wdata[118]), .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad119 (.OEN(1'b0), .I(wmem_req_wdata[119]), .PAD(mem_req_wdata[119]), .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad120 (.OEN(1'b0), .I(wmem_req_wdata[120]), .PAD(mem_req_wdata[120]), .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad121 (.OEN(1'b0), .I(wmem_req_wdata[121]), .PAD(mem_req_wdata[121]), .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad122 (.OEN(1'b0), .I(wmem_req_wdata[122]), .PAD(mem_req_wdata[122]), .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad123 (.OEN(1'b0), .I(wmem_req_wdata[123]), .PAD(mem_req_wdata[123]), .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad124 (.OEN(1'b0), .I(wmem_req_wdata[124]), .PAD(mem_req_wdata[124]), .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad125 (.OEN(1'b0), .I(wmem_req_wdata[125]), .PAD(mem_req_wdata[125]), .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad126 (.OEN(1'b0), .I(wmem_req_wdata[126]), .PAD(mem_req_wdata[126]), .REN(1'b0), .C());
	PDDW16DGZ mem_wdata_pad127 (.OEN(1'b0), .I(wmem_req_wdata[127]), .PAD(mem_req_wdata[127]), .REN(1'b0), .C());

    // =============================================================
    // Power Pads (VDD and VSS) - Placeholders
    // =============================================================
    // These will be instantiated in the .io file
    // PVDDIDGZ vdd_pad_inst ();
    // PVSSIDGZ vss_pad_inst ();
    // PCORNER corner_pad_inst ();

    // =============================================================
    // Core Cache Design Instance
    // =============================================================
    top #(
        .ADDR_WIDTH(32),
        .DATA_WIDTH(32),
        .LINE_BYTES(16),
        .CACHE_BYTES(256),
        .VICTIM_TAG_WIDTH(27)
    ) victim_cache_core (
        .clk(wclk),
        .rst_n(wrst_n),
        
        // CPU interface
        .cpu_req_valid(wcpu_req_valid),
        .cpu_req_rw(wcpu_req_rw),
        .cpu_req_addr(wcpu_req_addr),
        .cpu_req_wdata(wcpu_req_wdata),
        
        .cpu_resp_valid(wcpu_resp_valid),
        .cpu_resp_rdata(wcpu_resp_rdata),
        
        // Memory interface
        .mem_req_valid(wmem_req_valid),
        .mem_req_rw(wmem_req_rw),
        .mem_req_addr(wmem_req_addr),
        .mem_req_wdata(wmem_req_wdata),
        
        .mem_resp_valid(wmem_resp_valid),
        .mem_resp_rdata(wmem_resp_rdata)
    );

endmodule
