/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_macros77_bcd (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  reg [11:0] bcd = 0;
  reg [3:0] counter = 0;
    
  assign uio_oe  = 1;
  assign uo_out  = bcd[7:0];
  assign uio_out [3:0] = bcd[11:8];  

  assign uio_out [7:4] = counter;

  integer i;
	
  always @(ui_in) begin
    bcd=0;		 	
      for (i=0;i<8;i=i+1) begin					
        if (bcd[3:0] >= 5) bcd[3:0] = bcd[3:0] + 3;	
    	if (bcd[7:4] >= 5) bcd[7:4] = bcd[7:4] + 3;
    	if (bcd[11:8] >= 5) bcd[11:8] = bcd[11:8] + 3;
        bcd = { bcd[10:0], ui_in[7-i] };		
    end
  end    

  always @(posedge clk) begin
      counter <= counter + 1;
  end

endmodule
