//This file defines the parameters used in the alu
package definitions;
    
// Instruction map
    const logic [2:0]kADD  = 5'b00000;
    const logic [2:0]kSUB  = 5'b00001;
    const logic [2:0]kXOR  = 5'b00010;
    const logic [2:0]kAND  = 5'b00011;
    const logic [2:0]kSLL  = 5'b00100;
    const logic [2:0]kSRL  = 5'b00101;
    const logic [2:0]kCMP  = 5'b00110;
    const logic [2:0]kBE  = 5'b00111;
    const logic [2:0]kBL  = 5'b01000;
    const logic [2:0]kBG  = 5'b01001;
    const logic [2:0]kBA  = 5'b01010;
    const logic [2:0]kMOV  = 5'b01011; 
    const logic [2:0]kLD  = 5'b01100;
    const logic [2:0]kST  = 5'b01101;
    const logic [2:0]kDON  = 5'b01110;
// enum names will appear in timing diagram
    typedef enum logic[3:0] {
        ADD, SUB, XOR, AND, SLL, SRL, CMP, BE, BL, BG, BA, MOV, LD, ST, DON
         } op_mne;
    
endpackage // definitions
