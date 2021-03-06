module imem(
  input       [7:0] PC,
  output logic[8:0] iptr);
  always_comb begin
  
   case(PC)
                                 // PRODUCT
    0:  iptr = 'b000_000_001;    // ld r2, [1]
    1:  iptr = 'b000_000_010;    // ld r3, [2]   
    2:  iptr = 'b000_000_011;    // loop: and r6, 1, r3
    3:  iptr = 'b000_000_100;    // cmp r6, r0
    4:  iptr = 'b000_000_101;    // be  shift
    5:  iptr = 'b000_000_110;    // add r5, r2, r5  
    6:  iptr = 'b000_000_111;    // add r4, rO, r4  
    7:  iptr = 'b000_001_000;    // add   r4, r1, r4  
    8:  iptr = 'b000_001_001;    // shift:    and r6, r2, 128
    9:  iptr = 'b000_111_110;	 // srl r6, 7, r6 
    
    10: iptr = 'b000_001_010;    // sll r2, 1, r2 
    11: iptr = 'b000_001_011;    // sll   r1, 1, r1 
    12: iptr = 'b000_001_100;    // add r1, r6, r1  
    13: iptr = 'b000_001_101;    // srl   r3, 1, r3 
    14: iptr = 'b000_001_110;    // add   r7, 1, r7
    15: iptr = 'b000_001_111;    // cmp   r7, 8     
    16: iptr = 'b000_010_000;    // bl  loop    
    17: iptr = 'b000_010_001;    // bg  lowerloop   
    18: iptr = 'b000_010_010;    // ld  r3, [3]   
    19: iptr = 'b000_010_011;    // mov r2, r5    
    20: iptr = 'b000_010_100;    // mov   r1, r4  
    
    21: iptr = 'b000_111_100;	 // mov r5, r0
    22: iptr = 'b000_111_101;	 // mov r4, r0
    
    23: iptr = 'b000_010_101;    // lowerloop:  cmp r7, 16      
    24: iptr = 'b000_010_110;    // bl  loop   
    25: iptr = 'b000_010_111;    // st  [5], r5   
    26: iptr = 'b000_011_000;    // st  r4, [4]   
    27: iptr = 'b000_000_000;    // done
    
    
    	                         // STRING MATCH
    28: iptr = 'b000_011_001;    // stringLoop: ld  r1, [32 + r3] 
    29: iptr = 'b000_011_010;    // ld  r2, 6 
    30: iptr = 'b000_011_011;    // mov r7, 15   
    
    31: iptr = 'b000_111_101;	 // mov r4, 0
    
    32: iptr = 'b000_011_100;    // matchLoop: and r6, r7, r1  
    33: iptr = 'b000_011_101;    // xor r6, r2, r6
    34: iptr = 'b000_011_110;    // cmp r6, 0   
    35: iptr = 'b000_011_111;    // be  found   
    36: iptr = 'b000_001_010;    // sll   r2, 1, r2 
    37: iptr = 'b000_100_000;    // sll r7, 1, r7 
    38: iptr = 'b000_100_001;    // add   r4, 1, r4 
    39: iptr = 'b000_100_010;    // cmp   r4, 5   
    40: iptr = 'b000_100_011;    // bl  matchLoop
    41: iptr = 'b000_100_100;    // ba  incJ     
    42: iptr = 'b000_100_101;    // found: add r5, 1, r5 
    43: iptr = 'b000_100_110;    // incJ:     add   r3, 1, r3 
    44: iptr = 'b000_100_111;    // cmp r3, 64    
    45: iptr = 'b000_101_000;    // bl  stringLoop  
    46: iptr = 'b000_101_001;    // st  r5, [7]   
    47: iptr = 'b000_000_000;    // done

                                 // CLOSEST PAIR
    48: iptr = 'b000_101_010;    // mov     r1, 255
    49: iptr = 'b000_101_100;	 // mov		r2, 1
    
    50: iptr = 'b000_101_011;    // outer: ld   r4, [128+r2]   
   
    51: iptr = 'b000_111_111; 	 // mov r3, 0
    
    52: iptr = 'b000_101_101;    // inner: ld   r5, [128 + r3]
    53: iptr = 'b000_101_110;    // cmp  r4, r5 
    54: iptr = 'b000_101_111;    // bg   ijSub 
    55: iptr = 'b000_110_000;    // sub  r5, r5, r4
    56: iptr = 'b000_110_001;    // ba   compDist
    57: iptr = 'b000_110_010;    // ijSub: sub r5, r4, r5
    58: iptr = 'b000_110_011;    // compDist: cmp r1, r5
    59: iptr = 'b000_110_100;    // bl   incJ  
    60: iptr = 'b000_110_101;    // mov  r1, r5
    61: iptr = 'b000_100_110;    // incJ: add     r3, 1, r3 
    62: iptr = 'b000_110_110;    // cmp  r3, r2
    63: iptr = 'b000_110_111;    // bl   inner
    64: iptr = 'b000_111_000;    // add  r2, 1, r2
    65: iptr = 'b000_111_001;    // cmp  r2, 20
    66: iptr = 'b000_111_010;    // bl   outer
    67: iptr = 'b000_111_011;    // st   r1, [127]
    68: iptr = 'b000_000_000;    // done 

    endcase
  end
endmodule