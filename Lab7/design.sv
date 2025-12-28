// Control FSM Design
module control (
  input  logic        clk,
  input  logic        rst_,       // active-low reset
  input  logic [2:0]  opcode,     // CPU operation code
  input  logic        zero,       // accumulator zero flag
  output logic        mem_rd,
  output logic        load_ir,
  output logic        halt,
  output logic        inc_pc,
  output logic        load_ac,
  output logic        load_pc,
  output logic        mem_wr
);
  // Enumerations for State and Opcode
  typedef enum logic [2:0] {
    HLT = 3'b000,
    SKZ = 3'b001,
    ADD = 3'b010,
    AND = 3'b011,
    XOR = 3'b100,
    LDA = 3'b101,
    STO = 3'b110,
    JMP = 3'b111
  } opcode_t;

  typedef enum logic [2:0] {
    INST_ADDR,   // 0  (0 0 0 ) 
    INST_FETCH,  // 1
    INST_LOAD,   // 2
    IDLE,        // 3
    OP_ADDR,     // 4
    OP_FETCH,    // 5
    ALU_OP,      // 6
    STORE        // 7
  } state_t;

  state_t  current_state, next_state;
  opcode_t op;

  // State Register (Sequential Logic)
  always_ff @(posedge clk or negedge rst_) begin
    if (!rst_)
      current_state <= INST_ADDR;
    else
      current_state <= next_state;
  end

  // Next State Logic (Sequential Order)
  always_comb begin
    unique case (current_state)
      INST_ADDR:   next_state = INST_FETCH;
      INST_FETCH:  next_state = INST_LOAD;
      INST_LOAD:   next_state = IDLE;
      IDLE:        next_state = OP_ADDR;
      OP_ADDR:     next_state = OP_FETCH;
      OP_FETCH:    next_state = ALU_OP;
      ALU_OP:      next_state = STORE;
      STORE:       next_state = INST_ADDR;
      default:     next_state = INST_ADDR;
    endcase
  end

  // Output Logic (Combinational)
  always_comb begin
    // Default outputs = 0
    mem_rd  = 0;
    load_ir = 0;
    halt    = 0;
    inc_pc  = 0;
    load_ac = 0;
    load_pc = 0;
    mem_wr  = 0;

    // decode opcode
    op = opcode_t'(opcode);

    unique case (current_state)
      INST_ADDR: begin
        // Default
      end
      INST_FETCH: begin
        mem_rd  = 1;
      end
      INST_LOAD, IDLE: begin
        mem_rd  = 1;
        load_ir = 1;
      end
      OP_ADDR: begin
        if (op == HLT)
          halt = 1;
        inc_pc = 1;
      end
      OP_FETCH: begin
        if (op == ADD || op == AND || op == XOR || op == LDA)
          mem_rd  = 1;
      end
      ALU_OP: begin
        if (op == ADD || op == AND || op == XOR || op == LDA)
          begin
            mem_rd  = 1;
            load_ac = 1;
          end
        if (op == SKZ && zero)
          inc_pc = 1;
        if (op == JMP)
          load_pc = 1;
      end
      STORE: begin
        if (op == ADD || op == AND || op == XOR || op == LDA)
          begin
            mem_rd  = 1;
            load_ac = 1;
          end
        if (op == JMP)
          begin
          inc_pc = 1;
          load_pc = 1;
          end
        if (op == STO)
          mem_wr = 1;
      end
    endcase
  end
endmodule
