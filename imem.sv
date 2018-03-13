module imem(
  input       [7:0] PC,
  output logic[8:0] iptr);
  always_comb begin
  
   case(PC)
                                 // A * B * C
/*  // ignore this i just wanted to try smthg out
    0:    iptr = 'b000_011_011;		// mov r7, 15
    1:    iptr = 'b000_001_110;    // add   r7, 1, r7
    2:    iptr = 'b000_001_110;    // add   r7, 1, r7
    2:    iptr = 'b000_010_101;		// cmp r7, 16
    2:    iptr = 'b000_011_101;		// mov r1, 15
    0:    iptr = 'b000_001_110;    // add   r7, 1, r7
    0:    iptr = 9'b000_111_100; 		// add r7, 5, r7 (60)
    1:    iptr = 9'b000_111_000; 		// add r2, 1, r2 (56)
    2:    iptr = 9'b000_001_110;    // add   r7, 1, r7   (14)
    3:    iptr = 9'b000_000_000;	// done 
*/
  
    0:  iptr = 'b000_000_001;    // ld r2, [1]
    1:  iptr = 'b000_000_010;    // ld r3, [2]   
    2:  iptr = 'b000_000_011;    // loop: and r6, 1, r3
    3:  iptr = 'b000_000_100;    // cmp r6, r0
    4:  iptr = 'b000_000_101;    // be  shift
    5:  iptr = 'b000_000_110;    // add r5, r2, r5  
    6:  iptr = 'b000_000_111;    // add r4, rO, r4  
    7:  iptr = 'b000_001_000;    // add   r4, r1, r4  
    8:  iptr = 'b000_001_001;    // shift:    and r6, r2, 128
    9:  iptr = 'b000_001_010;    // sll r2, 1, r2 
    10: iptr = 'b000_001_011;    // sll   r1, 1, r1 
    11: iptr = 'b000_001_100;    // add r1, r6, r1  
    12: iptr = 'b000_001_101;    // srl   r3, 1, r3 
    13: iptr = 'b000_001_110;    // add   r7, 1, r7
    14: iptr = 'b000_001_111;    // cmp   r7, 8     
    15: iptr = 'b000_010_000;    // bl  loop    
    16: iptr = 'b000_010_001;    // bg  lowerloop   
    17: iptr = 'b000_010_010;    // ld  r3, [3]   
    18: iptr = 'b000_010_011;    // mov r2, r5    
    19: iptr = 'b000_010_100;    // mov   r1, r4  
    
    20: iptr = 'b000_111_000;	// mov r5, r0
    
    21: iptr = 'b000_010_101;    // lowerloop:  cmp r7, 16      
    22: iptr = 'b000_010_110;    // bl  loop   
    23: iptr = 'b000_010_111;    // st  [5], r5   
    24: iptr = 'b000_011_000;    // st  r4, [4]   
    25: iptr = 'b000_000_000;    // done
    
                                 // string match
    26: iptr = 'b000_011_001;    // stringLoop: ld  r1, [32 + r3] 
    27: iptr = 'b000_011_010;    // ld  r2, 6 
    28: iptr = 'b000_011_011;    // mov r7, 15   
    29: iptr = 'b000_011_100;    // matchLoop: and r6, r7, r1  
    30: iptr = 'b000_011_101;    // xor r6, r2, r6  
    31: iptr = 'b000_011_110;    // cmp r6, 0   
    32: iptr = 'b000_011_111;    // be  found   
    33: iptr = 'b000_001_010;    // sll   r2, 1, r2 
    34: iptr = 'b000_100_000;    // sll r7, 1, r7 
    35: iptr = 'b000_100_001;    // add   r4, 1, r4 
    36: iptr = 'b000_100_010;    // cmp   r4, 5   
    37: iptr = 'b000_100_011;    // bl  matchLoop
    38: iptr = 'b000_100_100;    // ba  incJ     
    39: iptr = 'b000_100_101;    // found: add r5, 1, r5 
    40: iptr = 'b000_100_110;    // incJ:     add   r3, 1, r3 
    41: iptr = 'b000_100_111;    // cmp r3, 64    
    42: iptr = 'b000_101_000;    // bl  stringLoop  
    43: iptr = 'b000_101_001;    // st  r5, [7]   
    44: iptr = 'b000_000_000;    // done

                                 // closest pair
    45: iptr = 'b000_101_010;    // mov     r1, 255
    46: iptr = 'b000_101_011;    // outer: ld   r4, [128+r2]   
    47: iptr = 'b000_101_100;    // add  r3, r2, 1  
    48: iptr = 'b000_101_101;    // inner: ld   r5, [128 + r3]
    49: iptr = 'b000_101_110;    // cmp  r4, r5 
    50: iptr = 'b000_101_111;    // bg   ijSub 
    51: iptr = 'b000_110_000;    // sub  r5, r5, r4
    52: iptr = 'b000_110_001;    // ba   compDist
    53: iptr = 'b000_110_010;    // ijSub: sub r5, r4, r5
    54: iptr = 'b000_110_011;    // compDist: cmp r1, r5
    55: iptr = 'b000_110_100;    // bl   incJ  
    56: iptr = 'b000_110_101;    // mov  r1, r5
    57: iptr = 'b000_100_110;    // incJ: add     r3, 1, r3 
    58: iptr = 'b000_110_110;    // cmp  r3, 20
    59: iptr = 'b000_110_111;    // bl   inner
    60: iptr = 'b000_111_000;    // add  r2, 1, r2
    61: iptr = 'b000_111_001;    // cmp  r2, 19
    62: iptr = 'b000_111_010;    // bl   outer
    63: iptr = 'b000_111_011;    // st   r1, [127]
    64: iptr = 'b000_000_000;    // done 

    endcase
  end
endmodule