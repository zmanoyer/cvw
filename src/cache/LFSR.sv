///////////////////////////////////////////
// cacheLRU.sv
//
// Written: Rose Thompson ross1728@gmail.com
// Created: 20 July 2021
// Modified: 20 January 2023
//
// Purpose: Implements Pseudo LRU. Tested for Powers of 2.
//
// Documentation: RISC-V System on Chip Design Chapter 7 (Figures 7.8 and 7.15 to 7.18)
//
// A component of the CORE-V-WALLY configurable RISC-V project.
// https://github.com/openhwgroup/cvw
//
// Copyright (C) 2021-23 Harvey Mudd College & Oklahoma State University
//
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
//
// Licensed under the Solderpad Hardware License v 2.1 (the “License”); you may not use this file 
// except in compliance with the License, or, at your option, the Apache License version 2.0. You 
// may obtain a copy of the License at
//
// https://solderpad.org/licenses/SHL-2.1/
//
// Unless required by applicable law or agreed to in writing, any work distributed under the 
// License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, 
// either express or implied. See the License for the specific language governing permissions 
// and limitations under the Lic////////////////////////////////////////////////////////////////////////////////////////////////

module LFSR #(parameter WIDTH = 4)
    (input logic clk, 
    input logic reset,
    input logic FlushStage, 
    input logic LRUWriteEn,
    output logic[WIDTH-1:0] q);

   logic 		    enable;
   assign enable = ~FlushStage & LRUWriteEn;
   logic [WIDTH-1:0] 	    next, val, curr;
   flopenl #(WIDTH) LFSReg(clk, reset, enable, next, val, curr);
   assign q = curr[WIDTH-1:0];
   
    assign next[WIDTH-2:0] = curr[WIDTH-1:1];
    if(WIDTH == 3)begin
      assign next[2] = curr[2] ^ curr[0];
    end
    else if(WIDTH == 4)begin
      assign next[3] = curr[3] ^ curr[0];
    end
    else if(WIDTH == 5)begin
      assign next[4] = curr[4] ^ curr[3] ^ curr[1] ^ curr[0];
    end
    else if(WIDTH == 6)begin
      assign next[5] = curr[5] ^ curr[4] ^ curr[2] ^ curr[1];
    end
    else if(WIDTH == 7)begin
      assign next[6] = curr[6] ^ curr[5] ^ curr[3] ^ curr[0];
    end
    else if(WIDTH == 8)begin
      assign next[7] = curr[7] ^ curr[5] ^ curr[2] ^ curr[1];
    end
    else if(WIDTH == 9)begin
      assign next[8] = curr[8] ^ curr[6] ^ curr[5] ^ curr[4] ^ curr[3] ^ curr[2];
    end
assign val[1:0] = 2'b10;
assign val[WIDTH-1:2] = '0; 
endmodule


