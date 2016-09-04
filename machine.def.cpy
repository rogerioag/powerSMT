/* This doesn't look like -*- C -*-, but it is!
 *
 * pisa.def - SimpleScalar portable ISA (pisa) machine definition
 *
 * This file is a part of the SimpleScalar tool suite written by
 * Todd M. Austin as a part of the Multiscalar Research Project.
 *  
 * The tool suite is currently maintained by Doug Burger and Todd M. Austin.
 * 
 * Copyright (C) 1994, 1995, 1996, 1997, 1998 by Todd M. Austin
 *
 * This source file is distributed "as is" in the hope that it will be
 * useful.  The tool set comes with no warranty, and no author or
 * distributor accepts any responsibility for the consequences of its
 * use. 
 * 
 * Everyone is granted permission to copy, modify and redistribute
 * this tool set under the following conditions:
 * 
 *    This source code is distributed for non-commercial use only. 
 *    Please contact the maintainer for restrictions applying to 
 *    commercial use.
 *
 *    Permission is granted to anyone to make or distribute copies
 *    of this source code, either as received or modified, in any
 *    medium, provided that all copyright notices, permission and
 *    nonwarranty notices are preserved, and that the distributor
 *    grants the recipient permission for further redistribution as
 *    permitted by this document.
 *
 *    Permission is granted to distribute this file in compiled
 *    or executable form under the same conditions that apply for
 *    source code, provided that either:
 *
 *    A. it is accompanied by the corresponding machine-readable
 *       source code,
 *    B. it is accompanied by a written offer, with no time limit,
 *       to give anyone a machine-readable copy of the corresponding
 *       source code in return for reimbursement of the cost of
 *       distribution.  This written offer must permit verbatim
 *       duplication by anyone, or
 *    C. it is distributed by someone who received only the
 *       executable form, and is accompanied by a copy of the
 *       written offer of source code that they received concurrently.
 *
 * In other words, you are welcome to use, share and improve this
 * source file.  You are forbidden to forbid anyone else to use, share
 * and improve what you give them.
 *
 * INTERNET: dburger@cs.wisc.edu
 * US Mail:  1210 W. Dayton Street, Madison, WI 53706
 *
 * $Id: pisa.def,v 1.7 1998/08/27 17:01:35 taustin Exp taustin $
 *
 * $Log: pisa.def,v $
 * Revision 1.7  1998/08/27 17:01:35  taustin
 * implemented host interface description in host.h
 * added target interface support
 * reorganized instruction semantics definitions; now using name-mangled
 *      macros, this approach is very portable (even works on MC VC++) and
 *      it allows C statements to portably implement instruction semantics
 * LWL/LWR/SWL/SWR semantics fixed in ss.def, these instruction now
 *       appear to work correctly on big- and little-endian machines, this
 *       fixes all previous problems with IJPEG failing during functional
 *       simulation
 * added support for fast shifts if host machine can successfully implement
 *       them, sysprobe tests if fast shifts work and then sets -DFAST_SRA and
 *       -DFAST_SRL accordingly; this also fixes shifts when the high order
 *       bit is set for some machines
 *
 *
 */

/* This file defines all aspects of the SimpleScalar instruction set
 * architecture.  Each instruction set in the architecture has a DEFINST()
 * macro call included below.  The contents of a instruction definition are
 * as follows:
 *
 *   DEFINST(<enum>,			<opcode>,
 *	     <opname>,			<operands>,
 *	     <fu_req>,			<iflags>,
 *	     <output deps...>,		<input deps...>,
 *	     <expr>)
 *
 * Where:
 *
 *   <enum>	- is an enumerator that is returned when an instruction is
 *		  decoded by SS_OP_ENUM()
 *   <opcode>	- is the opcode of this instruction
 *   <opname>   - name of this instruction as a string, used by disassembler
 *   <operands>	- specified the instruction operand fields and their printed
 * 		  order for disassembly, used by disassembler, the recognized
 *		  operand field are (the instruction format is detailed in
 *		  the header file ss.h):
 *		    J - target field
 *		    j - PC relative target (offset + PC)
 *		    s - S register field
 *		    b - S register field (base register)
 *		    t - T register field
 *		    d - D register field
 *		    S - S register field (FP register)
 *		    T - T register field (FP register)
 *		    D - D register field (FP register)
 *		    o - load address offset (offset)
 *		    i - signed immediate field value
 *		    u - unsigned immediate field value
 *		    U - upper immediate field value
 *		    H - shift amount immediate field value
 *		    B - break code
 *
 *   <fu_req>	- functional unit requirements for this instruction
 *   <iflags>	- instruction flags, accessible via the SS_OP_FLAGS()
 *		  macro, flags are defined with F_* prefix in ss.h
 *   <output deps...>
 *		- a list of up to two output dependency designators, the
 *		  following designators are recognized (place an DNA in any
 *		  unused fields:
 *		    DGPR(N)   - general purpose register N
 *		    DGPR_D(N) - double word general purpose register N
 *		    DCGPR(N)  - general purpose register conditional on
 *			        pre/post- increment/decrement mode
 *		    DFPR_L(N) - floating-point register N, as word
 *		    DFPR_F(N) - floating-point reg N, as single-prec float
 *		    DFPR_D(N) - floating-point reg N, as double-prec double
 *		    DHI	      - HI result register
 *		    DLO	      - LO result register
 *		    DFCC      - floating point condition codes
 *		    DCPC      - current PC
 *		    DNPC      - next PC
 *		    DNA	      - no dependence
 *
 *   <input deps...>
 *		- a list of up to three input dependency designators, the
 *		  designators are defined above (place an DNA in any unused
 *		  fields.
 *
 *   <expr>	- a C expression that implements the instruction being
 * 		  defined, the expression must modify all architected state
 *		  affected by the instruction's execution, by default, the
 *		  next PC (NPC) value defaults to the current PC (CPC) plus
 *		  SS_INST_SIZE, as a result, only taken branches need to set
 *		  NPC
 *
 *		  The following predefined macros are available for use in
 *		  DEFINST() instruction expressions to access the value of
 *		  instruction operand/opcode field values:
 *
 *		    RS	    - RS register field value
 *		    RT	    - RT register field value
 *		    RD	    - RD register field value
 *		    FS	    - RS register field value
 *		    FT	    - RT register field value
 *		    FD	    - RD register field value
 *		    BS	    - RS register field value
 *		    TARG    - jump target field value
 *		    OFS	    - signed offset field value
 *		    IMM	    - signed offset field value
 *		    UIMM    - unsigned offset field value
 *		    SHAMT   - shift amount field value
 *		    BCODE   - break code field value
 *
 *		  To facilitate the construction of performance simulators
 *		  (which may want to specialize their architected state
 *		  storage format), all architected register and memory state
 *		  is accessed through the following macros:
 *
 *		    GPR(N)         - read general purpose register N
 *		    SET_GPR(N,E)   - write general purpose register N with E
 *		    GPR_D(N)       - read double word general purpose reg N
 *		    SET_GPR_D(N,E) - write double word gen purpose reg N w/ E
 *		    FPR_L(N)       - read floating-point register N, as word
 *		    SET_FPR_L(N,E) - floating-point reg N, as word, with E
 *		    FPR_F(N)       - read FP reg N, as single-prec float
 *		    SET_FPR_F(N,E) - write FP reg N, as single-prec float w/ E
 *		    FPR_D(N)       - read FP reg N, as double-prec double
 *		    SET_FPR_D(N,E) - write FP reg N, as double-prec double w/E
 *		    HI	           - read HI result register
 *		    SET_HI(E)      - write HI result register with E
 *		    LO	           - read LO result register
 *		    SET_LO(E)      - write LO result register with E
 *		    FCC	           - read floating point condition codes
 *		    SET_FCC(E)     - write floating point condition codes w/ E
 *		    CPC	           - read current PC register
 *		    NPC	           - read next PC register
 *		    SET_NPC(E)     - write next PC register with E
 *		    TPC	           - read target PC register
 *		    SET_TPC(E)     - write target PC register with E
 *
 *		    READ_SIGNED_BYTE(A)   - read signed byte from address A
 *		    READ_UNSIGNED_BYTE(A) - read unsigned byte from address A
 *		    READ_SIGNED_HALF(A)   - read signed half from address A
 *		    READ_UNSIGNED_HALF(A) - read unsigned half from address A
 *		    READ_WORD(A)          - read word from address A
 *		    WRITE_BYTE(E,A)       - write byte value E to address A
 *		    WRITE_HALF(E,A)       - write half value E to address A
 *		    WRITE_WORD(E,A)       - write word value E to address A
 *
 *		  Finally, the following helper functions are available to
 *		  assist in the construction of instruction expressions:
 *
 *		    INC_DEC(E,N,S) - execute E and update N as per pre/post-
 *				     incr/decr addressing sementics for an
 *				     access of S bytes
 *		    OVER(X,Y)      - check for overflow for X+Y, both signed
 *		    UNDER(X,Y)	   - check for umderflow for X-Y, both signed
 *		    DIV0(N)	   - check for divide by zero, N is denom
 *		    INTALIGN(N)    - check double word int reg N alignment
 *		    FPALIGN(N)	   - check double word FP reg N alignment
 *		    TALIGN(T)	   - check jump target T alignment
 */

/* no operation */
#define NOP_IMPL							\
  {									\
    /* nada... */							\
  }
DEFINST(NOP,		0x00,
	"nop",		"",
	IntALU,		F_ICOMP,
	DNA, DNA,	DNA, DNA, DNA)

/*
 * control operations
 */

#define JUMP_IMPL							\
  {									\
    SET_TPC((CPC & 036000000000) | (TARG << 2));			\
    SET_NPC((CPC & 036000000000) | (TARG << 2));			\
  }
DEFINST(JUMP,			0x01,
	"j",			"J",
	NA, 			F_CTRL|F_UNCOND|F_DIRJMP,
	DNA, DNA, 		DNA, DNA, DNA)

#define JAL_IMPL							\
  {									\
    SET_TPC((CPC & 036000000000) | (TARG << 2));			\
    SET_NPC((CPC & 036000000000) | (TARG << 2));			\
    SET_GPR(31, CPC + 8);						\
  }
DEFINST(JAL,			0x02,
	"jal",			"J",
	IntALU,			F_CTRL|F_UNCOND|F_DIRJMP|F_CALL,
	DGPR(31), DNA,	 	DNA, DNA, DNA)

#define JR_IMPL								\
  {									\
    if (GPR(RS) & 0x7)							\
      DECLARE_FAULT(md_fault_alignment);				\
									\
    SET_TPC(GPR(RS));							\
    SET_NPC(GPR(RS));							\
  }
DEFINST(JR, 			0x03,
	"jr", 			"s", 
	NA, 			F_CTRL|F_UNCOND|F_INDIRJMP,
	DNA, DNA,		DGPR(RS), DNA, DNA)

#define JALR_IMPL							\
  {									\
    if (GPR(RS) & 0x7)							\
      DECLARE_FAULT(md_fault_alignment);				\
									\
    SET_GPR(RD, CPC + 8);						\
    SET_TPC(GPR(RS));							\
    SET_NPC(GPR(RS));							\
  }
DEFINST(JALR,	 		0x04,
	"jalr", 		"d,s",
	IntALU,			F_CTRL|F_UNCOND|F_INDIRJMP|F_CALL,
	DGPR(RD), DNA,		DGPR(RS), DNA, DNA)

#define BEQ_IMPL							\
  {									\
    SET_TPC(CPC + 8 + (OFS << 2));					\
    if (GPR(RS) == GPR(RT))						\
      SET_NPC(CPC + 8 + (OFS << 2));					\
  }
DEFINST(BEQ,			0x05,
	"beq",			"s,t,j",
	IntALU,			F_CTRL|F_COND|F_DIRJMP,
	DNA, DNA,		DGPR(RS), DGPR(RT), DNA)

#define BNE_IMPL							\
  {									\
    SET_TPC(CPC + 8 + (OFS << 2));					\
    if (GPR(RS) != GPR(RT))						\
      SET_NPC(CPC + 8 + (OFS << 2));					\
  }
DEFINST(BNE,			0x06,
	"bne",			"s,t,j",
	IntALU,			F_CTRL|F_COND|F_DIRJMP,
	DNA, DNA,		DGPR(RS), DGPR(RT), DNA)

#define BLEZ_IMPL							\
  {									\
    SET_TPC(CPC + 8 + (OFS << 2));					\
    if (GPR(RS) <= 0)							\
      SET_NPC(CPC + 8 + (OFS << 2));					\
  }
DEFINST(BLEZ,			0x07,
	"blez",			"s,j",
	IntALU,			F_CTRL|F_COND|F_DIRJMP,
	DNA, DNA,		DGPR(RS), DNA, DNA)

#define BGTZ_IMPL							\
  {									\
    SET_TPC(CPC + 8 + (OFS << 2));					\
    if (GPR(RS) > 0)							\
      SET_NPC(CPC + 8 + (OFS << 2));					\
  }
DEFINST(BGTZ,			0x08,
	"bgtz",			"s,j",
	IntALU,			F_CTRL|F_COND|F_DIRJMP,
	DNA, DNA,		DGPR(RS), DNA, DNA)

#define BLTZ_IMPL							\
  {									\
    SET_TPC(CPC + 8 + (OFS << 2));					\
    if (GPR(RS) < 0)							\
      SET_NPC(CPC + 8 + (OFS << 2));					\
  }
DEFINST(BLTZ,	 		0x09,
	"bltz", 		"s,j", 
	IntALU, 		F_CTRL|F_COND|F_DIRJMP,
	DNA, DNA,		DGPR(RS), DNA, DNA)

#define BGEZ_IMPL							\
  {									\
    SET_TPC(CPC + 8 + (OFS << 2));					\
    if (GPR(RS) >= 0)							\
      SET_NPC(CPC + 8 + (OFS << 2));					\
  }
DEFINST(BGEZ, 			0x0a,
	"bgez", 		"s,j", 
	IntALU, 		F_CTRL|F_COND|F_DIRJMP,
	DNA, DNA,		DGPR(RS), DNA, DNA)

#define BC1F_IMPL							\
  {									\
    SET_TPC(CPC + 8 + (OFS << 2));					\
    if (!FCC)								\
      SET_NPC(CPC + 8 + (OFS << 2));					\
  }
DEFINST(BC1F, 			0x0b,
	"bc1f", 		"j", 
	IntALU,			F_CTRL|F_COND|F_DIRJMP|F_FPCOND,
	DNA, DNA,		DFCC, DNA, DNA)

#define BC1T_IMPL							\
  {									\
    SET_TPC(CPC + 8 + (OFS << 2));					\
    if (FCC)								\
      SET_NPC(CPC + 8 + (OFS << 2));					\
  }
DEFINST(BC1T, 			0x0c,
	"bc1t", 		"j", 
	IntALU,			F_CTRL|F_COND|F_DIRJMP|F_FPCOND,
	DNA, DNA,		DFCC, DNA, DNA)


/*
 * load/store operations
 *
 * NOTE: the out-of-order issue simulator(s) require that load and store
 * address computation input dependencies be placed in slots 1 and 2 of
 * the input dependency list slot 0 is reserved for the input dependency
 * of store values for store instructions
 */

#define LB_IMPL								\
  {									\
    sbyte_t _result;							\
    enum md_fault_type _fault;						\
									\
    _result = READ_BYTE(GPR(BS) + OFS, _fault);				\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
    SET_GPR(RT, (word_t)(sword_t)_result);				\
  }
DEFINST(LB,			0x20,
	"lb",			"t,o(b)",
	RdPort,			F_MEM|F_LOAD|F_DISP,
	DGPR(RT), DNA,		DNA, DGPR(BS), DNA)

#define LBU_IMPL							\
  {									\
    byte_t _result;							\
    enum md_fault_type _fault;						\
									\
    _result = READ_BYTE(GPR(BS) + OFS, _fault);				\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
    SET_GPR(RT, (word_t)_result);					\
  }
DEFINST(LBU, 			0x22, 
	"lbu", 			"t,o(b)",
	RdPort, 		F_MEM|F_LOAD|F_DISP,
	DGPR(RT), DNA,		DNA, DGPR(BS), DNA)

#define LH_IMPL								\
  {									\
    shalf_t _result;							\
    enum md_fault_type _fault;						\
									\
    _result = READ_HALF(GPR(BS) + OFS, _fault);				\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
    SET_GPR(RT, (word_t)(sword_t)_result);				\
  }
DEFINST(LH, 			0x24,
	"lh",			"t,o(b)",
	RdPort,			F_MEM|F_LOAD|F_DISP,
	DGPR(RT), DNA,		DNA, DGPR(BS), DNA)

#define LHU_IMPL							\
  {									\
    half_t _result;							\
    enum md_fault_type _fault;						\
									\
    _result = READ_HALF(GPR(BS) + OFS, _fault);				\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
    SET_GPR(RT, (word_t)_result);					\
  }
DEFINST(LHU, 			0x26, 
	"lhu", 			"t,o(b)",
	RdPort, 		F_MEM|F_LOAD|F_DISP,
	DGPR(RT), DNA,		DNA, DGPR(BS), DNA)

#define LW_IMPL								\
  {									\
    word_t _result;							\
    enum md_fault_type _fault;						\
									\
    _result = READ_WORD(GPR(BS) + OFS, _fault);				\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
    SET_GPR(RT, _result);						\
  }
DEFINST(LW,			0x28,
	"lw", 			"t,o(b)",
	RdPort,			F_MEM|F_LOAD|F_DISP,
	DGPR(RT), DNA,		DNA, DGPR(BS), DNA)

#define DLW_IMPL							\
  {									\
    word_t _result_hi, _result_lo;					\
    enum md_fault_type _fault;						\
									\
    if ((RT) & 01)							\
      DECLARE_FAULT(md_fault_alignment);				\
									\
    _result_hi = READ_WORD(GPR(BS) + OFS, _fault);			\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
    _result_lo = READ_WORD(GPR(BS) + OFS + 4, _fault);			\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
									\
    SET_GPR(RT, _result_hi);						\
    SET_GPR((RT) + 1, _result_lo);					\
  }
DEFINST(DLW,			0x29,
	"dlw",			"t,o(b)",
	RdPort,			F_MEM|F_LOAD|F_DISP,
	DGPR_D(RT), DNA,	DNA, DGPR(BS), DNA)

#define L_S_IMPL							\
  {									\
    word_t _result;							\
    enum md_fault_type _fault;						\
									\
    _result = READ_WORD(GPR(BS) + OFS, _fault);				\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
    SET_FPR_L(FT, _result);						\
  }
DEFINST(L_S, 			0x2a,
	"l.s",			"T,o(b)",
	RdPort,			F_MEM|F_LOAD|F_DISP,
	DFPR_L(FT), DNA,	DNA, DGPR(BS), DNA)

#define L_D_IMPL							\
  {									\
    word_t _result_hi, _result_lo;					\
    enum md_fault_type _fault;						\
									\
    if ((FT) & 01)							\
      DECLARE_FAULT(md_fault_alignment);				\
									\
    _result_hi = READ_WORD(GPR(BS) + OFS, _fault);			\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
    _result_lo = READ_WORD(GPR(BS) + OFS + 4, _fault);			\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
									\
    SET_FPR_L(FT, _result_hi);						\
    SET_FPR_L((FT) + 1, _result_lo);					\
  }
DEFINST(L_D,			0x2b,
	"l.d",			"T,o(b)",
	RdPort,			F_MEM|F_LOAD|F_DISP,
	DFPR_D(FT), DNA,	DNA, DGPR(BS), DNA)

#ifdef BYTES_BIG_ENDIAN
#define LWL_IMPL							\
  {									\
    md_addr_t _temp_bs;							\
    word_t _lr_temp;							\
    enum md_fault_type _fault;						\
									\
    /* BS may == RT */							\
    _temp_bs = GPR(BS);							\
    _lr_temp = READ_WORD(WL_BASE(_temp_bs + OFS), _fault);		\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
									\
    SET_GPR(RT, ((GPR(RT) & WL_PROT_MASK1(_temp_bs + OFS))		\
		 | ((_lr_temp << (8 * WL_SIZE(_temp_bs + OFS)))		\
		    & ~WL_PROT_MASK1(_temp_bs + OFS))));		\
  }
DEFINST(LWL,			0x2c,
        "lwl",			"t,o(b)",
        RdPort,			F_MEM|F_LOAD|F_DISP,
        DGPR(RT), DNA,		DNA, DGPR(BS), DNA)

#define LWR_IMPL							\
  {									\
    md_addr_t _temp_bs;							\
    word_t _lr_temp;							\
    enum md_fault_type _fault;						\
									\
    /* BS may == RT */							\
    _temp_bs = GPR(BS);							\
    _lr_temp = READ_WORD(WR_BASE(_temp_bs + OFS), _fault);		\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
									\
    SET_GPR(RT, ((GPR(RT) & ~WR_PROT_MASK1(_temp_bs + OFS))		\
		 | ((_lr_temp >> (8 * (4 - WR_SIZE(_temp_bs + OFS))))	\
		    & WR_PROT_MASK1(_temp_bs + OFS))));			\
  }
DEFINST(LWR,			0x2d,
        "lwr",			"t,o(b)",
        RdPort,			F_MEM|F_LOAD|F_DISP,
        DGPR(RT), DNA,		DNA, DGPR(BS), DNA)
#else /* defined BYTES_LITTLE_ENDIAN */
#define LWL_IMPL							\
  {									\
    md_addr_t _temp_bs;							\
    word_t _lr_temp;							\
    enum md_fault_type _fault;						\
									\
    /* BS may == RT */							\
    _temp_bs = GPR(BS);							\
    _lr_temp = READ_WORD(WL_BASE(_temp_bs + OFS), _fault);		\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
									\
    SET_GPR(RT, ((GPR(RT) & WR_PROT_MASK1(_temp_bs + OFS))		\
		 | ((_lr_temp << (8 * (WL_SIZE(_temp_bs + OFS)-1)))	\
		    & ~WR_PROT_MASK1(_temp_bs + OFS))));		\
  }
DEFINST(LWL,			0x2c,
        "lwl",			"t,o(b)",
        RdPort,			F_MEM|F_LOAD|F_DISP,
        DGPR(RT), DNA,		DNA, DGPR(BS), DNA)

#define LWR_IMPL							\
  {									\
    md_addr_t _temp_bs;							\
    word_t _lr_temp;							\
    enum md_fault_type _fault;						\
									\
    /* BS may == RT */							\
    _temp_bs = GPR(BS);							\
    _lr_temp = READ_WORD(WR_BASE(_temp_bs + OFS), _fault);		\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
									\
    SET_GPR(RT, ((GPR(RT) & ~WL_PROT_MASK2(_temp_bs + OFS))		\
		 | ((_lr_temp >> (8 * (WR_SIZE(_temp_bs + OFS)-1)))	\
		    & WL_PROT_MASK2(_temp_bs + OFS))));			\
  }
DEFINST(LWR,			0x2d,
        "lwr",			"t,o(b)",
        RdPort,			F_MEM|F_LOAD|F_DISP,
        DGPR(RT), DNA,		DNA, DGPR(BS), DNA)
#endif
  
#if 0
#define LWL_IMPL							\
  {									\
    md_addr_t _temp_bs;							\
    word_t _lr_temp;							\
    enum md_fault_type _fault;						\
									\
    /* BS may == RT */							\
    _temp_bs = GPR(BS);							\
    _lr_temp = READ_WORD(WL_BASE(_temp_bs + OFS), _fault);		\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
									\
    SET_GPR(RT, ((GPR(RT) & WL_PROT_MASK(_temp_bs + OFS)) |		\
                      (_lr_temp & ~WL_PROT_MASK(_temp_bs + OFS))));	\
  }
DEFINST(LWL,			0x2c,
	"lwl",			"t,o(b)",
	RdPort,			F_MEM|F_LOAD|F_DISP,
	DGPR(RT), DNA,		DNA, DGPR(BS), DNA)
/* #else */
DEFINST(LWL,			0x2c,
	"lwl",			"t,o(b)",
	RdPort,			F_MEM|F_LOAD|F_DISP,
	DGPR(RT), DNA,		DNA, DGPR(BS), DNA,
	(ss_lr_temp[sn] = READ_WORD(WL_BASE(GPR(BS) + OFS)),
	 SET_GPR(RT, ((GPR(RT) & WL_PROT_MASK1(GPR(BS) + OFS)) |
		      ((ss_lr_temp[sn] << (8 * WL_SIZE(GPR(BS) + OFS))) 
		       & ~WL_PROT_MASK1(GPR(BS) + OFS))))))
#endif

#if 0
#define LWR_IMPL							\
  {									\
    md_addr_t _temp_bs;							\
    word_t _lr_temp;							\
    enum md_fault_type _fault;						\
									\
    /* BS may == RT */							\
    _temp_bs = GPR(BS);							\
    _lr_temp = READ_WORD(WR_BASE(_temp_bs + OFS), _fault);		\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
									\
    SET_GPR(RT, ((GPR(RT) & WR_PROT_MASK(_temp_bs + OFS)) |		\
                      (_lr_temp & ~WR_PROT_MASK(_temp_bs + OFS))));	\
  }
DEFINST(LWR,			0x2d,
	"lwr",			"t,o(b)",
	RdPort,			F_MEM|F_LOAD|F_DISP,
	DGPR(RT), DNA,		DNA, DGPR(BS), DNA)
/* #else */
DEFINST(LWR,			0x2d,
	"lwr",			"t,o(b)",
	RdPort,			F_MEM|F_LOAD|F_DISP,
	DGPR(RT), DNA,		DNA, DGPR(BS), DNA,
	(ss_lr_temp[sn] = READ_WORD(WR_BASE(GPR(BS) + OFS)),
	 SET_GPR(RT, ((GPR(RT) & ~WR_PROT_MASK1(GPR(BS) + OFS)) |
		      ((ss_lr_temp[sn] >> (8 * (4 - WR_SIZE(GPR(BS) + OFS)))) 
		       & WR_PROT_MASK1(GPR(BS) + OFS))))))
#endif

#define SB_IMPL								\
  {									\
    byte_t _src;							\
    enum md_fault_type _fault;						\
									\
    _src = (byte_t)(word_t)GPR(RT);					\
    WRITE_BYTE(_src, GPR(BS) + OFS, _fault);				\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
  }
DEFINST(SB, 			0x30, 
	"sb", 			"t,o(b)",
	WrPort, 		F_MEM|F_STORE|F_DISP,
	DNA, DNA,	 	DGPR(RT), DGPR(BS), DNA)

#define SH_IMPL								\
  {									\
    half_t _src;							\
    enum md_fault_type _fault;						\
									\
    _src = (half_t)(word_t)GPR(RT);					\
    WRITE_HALF(_src, GPR(BS) + OFS, _fault);				\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
  }
DEFINST(SH, 			0x32, 
	"sh", 			"t,o(b)",
	WrPort, 		F_MEM|F_STORE|F_DISP,
	DNA, DNA,	 	DGPR(RT), DGPR(BS), DNA)

#define SW_IMPL								\
  {									\
    word_t _src;							\
    enum md_fault_type _fault;						\
									\
    _src = (word_t)GPR(RT);						\
    WRITE_WORD(_src, GPR(BS) + OFS, _fault);				\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
  }
DEFINST(SW, 			0x34, 
	"sw", 			"t,o(b)",
	WrPort, 		F_MEM|F_STORE|F_DISP,
	DNA, DNA,	 	DGPR(RT), DGPR(BS), DNA)

/* FIXME: this code not fault-safe, yet... */
#define DSW_IMPL							\
  {									\
    enum md_fault_type _fault;						\
									\
    if ((RT) & 01)							\
      DECLARE_FAULT(md_fault_alignment);				\
									\
    WRITE_WORD(GPR(RT), GPR(BS) + OFS, _fault);				\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
    WRITE_WORD(GPR((RT) + 1), GPR(BS) + OFS + 4, _fault);		\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
  }
DEFINST(DSW,			0x35,
	"dsw",			"t,o(b)",
	WrPort,			F_MEM|F_STORE|F_DISP,
	DNA, DNA,		DGPR_D(RT), DGPR(BS), DNA)

/* FIXME: this code not fault-safe, yet... */
#define DSZ_IMPL							\
  {									\
    enum md_fault_type _fault;						\
									\
    WRITE_WORD(GPR(0), GPR(BS) + OFS, _fault);				\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
    WRITE_WORD(GPR(0), GPR(BS) + OFS + 4, _fault);			\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
  }
DEFINST(DSZ,			0x38,
	"dsz",			"o(b)",
	WrPort,			F_MEM|F_STORE|F_DISP,
	DNA, DNA,		DNA, DGPR(BS), DNA)

#define S_S_IMPL							\
  {									\
    enum md_fault_type _fault;						\
									\
    WRITE_WORD(FPR_L(FT), GPR(BS) + OFS, _fault);			\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
  }
DEFINST(S_S, 			0x36, 
	"s.s", 			"T,o(b)",
	WrPort, 		F_MEM|F_STORE|F_DISP,
	DNA, DNA,		DFPR_L(FT), DGPR(BS), DNA)

/* FIXME: this code not fault-safe, yet... */
#define S_D_IMPL							\
  {									\
    enum md_fault_type _fault;						\
									\
    if ((FT) & 01)							\
      DECLARE_FAULT(md_fault_alignment);				\
									\
    WRITE_WORD(FPR_L(FT), GPR(BS) + OFS, _fault);			\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
    WRITE_WORD(FPR_L((FT)+1), GPR(BS) + OFS + 4, _fault);		\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
  }
DEFINST(S_D,			0x37,
	"s.d",			"T,o(b)",
	WrPort,			F_MEM|F_STORE|F_DISP,
	DNA, DNA,		DFPR_D(FT), DGPR(BS), DNA)

#ifdef BYTES_BIG_ENDIAN
#define SWL_IMPL							\
  {									\
    word_t _lr_temp;							\
    enum md_fault_type _fault;						\
									\
    _lr_temp = READ_WORD(WL_BASE(GPR(BS) + OFS), _fault);		\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
									\
    _lr_temp = (((GPR(RT) >> (8 * WL_SIZE(GPR(BS) + OFS)))		\
		 & WL_PROT_MASK2(GPR(BS) + OFS))			\
		| (_lr_temp & ~WL_PROT_MASK2(GPR(BS) + OFS)));		\
    WRITE_WORD(_lr_temp, WL_BASE(GPR(BS) + OFS), _fault);		\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
  }
DEFINST(SWL,			0x39,
        "swl",			"t,o(b)",
        WrPort,			F_MEM|F_STORE|F_DISP,
        DNA, DNA,		DGPR(RT), DGPR(BS), DNA)

#define SWR_IMPL							\
  {									\
    word_t _lr_temp;							\
    enum md_fault_type _fault;						\
									\
    _lr_temp = READ_WORD(WR_BASE(GPR(BS) + OFS), _fault);		\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
									\
    _lr_temp = (((GPR(RT) << (8 * (4 - WR_SIZE(GPR(BS) + OFS))))	\
		 & ~WR_PROT_MASK2(GPR(BS) + OFS))			\
		| (_lr_temp & WR_PROT_MASK2(GPR(BS) + OFS)));		\
    WRITE_WORD(_lr_temp, WR_BASE(GPR(BS) + OFS), _fault);		\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
  }
DEFINST(SWR,			0x3a,
        "swr",			"t,o(b)",
        WrPort,			F_MEM|F_STORE|F_DISP,
        DNA, DNA,		DGPR(RT), DGPR(BS), DNA)
#else /* BYTES_LITTLE_ENDIAN */
#define SWL_IMPL							\
  {									\
    word_t _lr_temp;							\
    enum md_fault_type _fault;						\
									\
    _lr_temp = READ_WORD(WL_BASE(GPR(BS) + OFS), _fault);		\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
									\
    _lr_temp = (((GPR(RT) >> (8 * (4 - WR_SIZE(GPR(BS) + OFS))))	\
		 & WR_PROT_MASK2(GPR(BS) + OFS))			\
		| (_lr_temp & ~WR_PROT_MASK2(GPR(BS) + OFS)));		\
    WRITE_WORD(_lr_temp, WL_BASE(GPR(BS)+OFS), _fault);			\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
  }
DEFINST(SWL,			0x39,
        "swl",			"t,o(b)",
        WrPort,			F_MEM|F_STORE|F_DISP,
        DNA, DNA,		DGPR(RT), DGPR(BS), DNA)

#define SWR_IMPL							\
  {									\
    word_t _lr_temp;							\
    enum md_fault_type _fault;						\
									\
    _lr_temp = READ_WORD(WR_BASE(GPR(BS) + OFS), _fault);		\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
									\
    _lr_temp = (((GPR(RT) << (8 * (4 - WL_SIZE(GPR(BS) + OFS))))	\
		   & ~WL_PROT_MASK1(GPR(BS) + OFS))			\
		  | (_lr_temp & WL_PROT_MASK1(GPR(BS) + OFS)));		\
    WRITE_WORD(_lr_temp, WR_BASE(GPR(BS) + OFS), _fault);		\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
  }
DEFINST(SWR,			0x3a,
        "swr",			"t,o(b)",
        WrPort,			F_MEM|F_STORE|F_DISP,
        DNA, DNA,		DGPR(RT), DGPR(BS), DNA)
#endif

#if 0
#define SWL_IMPL							\
  {									\
    word_t _lr_temp;							\
    enum md_fault_type _fault;						\
									\
    _lr_temp = READ_WORD(WL_BASE(GPR(BS) + OFS), _fault);		\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
									\
    _lr_temp = ((GPR(RT) & ~WL_PROT_MASK(GPR(BS) + OFS)) |		\
                       (_lr_temp & WL_PROT_MASK(GPR(BS) + OFS)));	\
    WRITE_WORD(_lr_temp, WL_BASE(GPR(BS) + OFS), _fault);		\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
  }
DEFINST(SWL,			0x39,
	"swl",			"t,o(b)",
	WrPort,			F_MEM|F_STORE|F_DISP,
	DNA, DNA,		DGPR(RT), DGPR(BS), DNA)
/* #else */
DEFINST(SWL,			0x39,
	"swl",			"t,o(b)",
	WrPort,			F_MEM|F_STORE|F_DISP,
	DNA, DNA,		DGPR(RT), DGPR(BS), DNA,
	(ss_lr_temp[sn] = READ_WORD(WL_BASE(GPR(BS) + OFS)),
	 ss_lr_temp[sn] = (((GPR(RT) >> (8 * WL_SIZE(GPR(BS) + OFS))) 
			& WL_PROT_MASK2(GPR(BS) + OFS)) |
		       (ss_lr_temp[sn] & ~WL_PROT_MASK2(GPR(BS) + OFS))),
	 WRITE_WORD(ss_lr_temp[sn], WL_BASE(GPR(BS) + OFS))))
#endif

#if 0
#define SWR_IMPL							\
  {									\
    word_t _lr_temp;							\
    enum md_fault_type _fault;						\
									\
    _lr_temp = READ_WORD(WR_BASE(GPR(BS) + OFS), _fault);		\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
									\
    _lr_temp = ((GPR(RT) & ~WR_PROT_MASK(GPR(BS) + OFS)) |		\
                       (_lr_temp & WR_PROT_MASK(GPR(BS) + OFS)));	\
    WRITE_WORD(_lr_temp, WR_BASE(GPR(BS) + OFS), _fault);		\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
  }
DEFINST(SWR,			0x3a,
	"swr",			"t,o(b)",
	WrPort,			F_MEM|F_STORE|F_DISP,
	DNA, DNA,		DGPR(RT), DGPR(BS), DNA)
/* #else */
DEFINST(SWR,			0x3a,
	"swr",			"t,o(b)",
	WrPort,			F_MEM|F_STORE|F_DISP,
	DNA, DNA,		DGPR(RT), DGPR(BS), DNA,
	(ss_lr_temp[sn] = READ_WORD(WR_BASE(GPR(BS)+OFS)),
	 ss_lr_temp[sn] = (((GPR(RT) << (8 * (4 - WR_SIZE(GPR(BS) + OFS)))) 
			& ~WR_PROT_MASK2(GPR(BS)+OFS)) |
		       (ss_lr_temp[sn] & WR_PROT_MASK2(GPR(BS)+OFS))),
	 WRITE_WORD(ss_lr_temp[sn], WR_BASE(GPR(BS)+OFS))))
#endif

/* reg+reg loads and stores */

#define LB_RR_IMPL							\
  {									\
    sbyte_t _result;							\
    enum md_fault_type _fault;						\
									\
    _result = READ_BYTE(GPR(BS) + GPR(RD), _fault);			\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
									\
    SET_GPR(RT, (word_t)(sword_t)_result);				\
  }
DEFINST(LB_RR,			0xc0,
	"lb",			"t,(b+d)",
	RdPort,			F_MEM|F_LOAD|F_RR,
	DGPR(RT), DNA,		DNA, DGPR(BS), DGPR(RD))

#define LBU_RR_IMPL							\
  {									\
    byte_t _result;							\
    enum md_fault_type _fault;						\
									\
    _result = READ_BYTE(GPR(BS) + GPR(RD), _fault);			\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
									\
    SET_GPR(RT, (word_t)_result);					\
  }
DEFINST(LBU_RR,			0xc1, 
	"lbu", 			"t,(b+d)",
	RdPort, 		F_MEM|F_LOAD|F_RR,
	DGPR(RT), DNA,		DNA, DGPR(BS), DGPR(RD))

#define LH_RR_IMPL							\
  {									\
    shalf_t _result;							\
    enum md_fault_type _fault;						\
									\
    _result = READ_HALF(GPR(BS) + GPR(RD), _fault);			\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
									\
    SET_GPR(RT, (word_t)(sword_t)_result);				\
  }
DEFINST(LH_RR,	 		0xc2,
	"lh",			"t,(b+d)",
	RdPort,			F_MEM|F_LOAD|F_RR,
	DGPR(RT), DNA,		DNA, DGPR(BS), DGPR(RD))

#define LHU_RR_IMPL							\
  {									\
    half_t _result;							\
    enum md_fault_type _fault;						\
									\
    _result = READ_HALF(GPR(BS) + GPR(RD), _fault);			\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
									\
    SET_GPR(RT, (word_t)_result);					\
  }
DEFINST(LHU_RR,			0xc3, 
	"lhu", 			"t,(b+d)",
	RdPort, 		F_MEM|F_LOAD|F_RR,
	DGPR(RT), DNA,		DNA, DGPR(BS), DGPR(RD))

#define LW_RR_IMPL							\
  {									\
    word_t _result;							\
    enum md_fault_type _fault;						\
									\
    _result = READ_WORD(GPR(BS) + GPR(RD), _fault);			\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
									\
    SET_GPR(RT, _result);						\
  }
DEFINST(LW_RR,			0xc4,
	"lw", 			"t,(b+d)",
	RdPort,			F_MEM|F_LOAD|F_RR,
	DGPR(RT), DNA,		DNA, DGPR(BS), DGPR(RD))

#define DLW_RR_IMPL							\
  {									\
    word_t _result_hi, _result_lo;					\
    enum md_fault_type _fault;						\
									\
    if ((RT) & 01)							\
      DECLARE_FAULT(md_fault_alignment)					\
									\
    _result_hi = READ_WORD(GPR(BS) + GPR(RD), _fault);			\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
    _result_lo = READ_WORD(GPR(BS) + GPR(RD) + 4, _fault);		\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
									\
    SET_GPR(RT, _result_hi);						\
    SET_GPR((RT) + 1, _result_lo);					\
  }
DEFINST(DLW_RR,			0xce,
	"dlw",			"t,(b+d)",
	RdPort,			F_MEM|F_LOAD|F_RR,
	DGPR_D(RT), DNA,	DNA, DGPR(BS), DGPR(RD))

#define L_S_RR_IMPL							\
  {									\
    word_t _result;							\
    enum md_fault_type _fault;						\
									\
    _result = READ_WORD(GPR(BS) + GPR(RD), _fault);			\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
									\
    SET_FPR_L(FT, _result);						\
  }
DEFINST(L_S_RR,			0xc5,
	"l.s",	 		"T,(b+d)",
	RdPort,			F_MEM|F_LOAD|F_RR,
	DFPR_L(FT), DNA,	DNA, DGPR(BS), DGPR(RD))

#define L_D_RR_IMPL							\
  {									\
    word_t _result_hi, _result_lo;					\
    enum md_fault_type _fault;						\
									\
    if ((FT) & 01)							\
      DECLARE_FAULT(md_fault_alignment);				\
									\
    _result_hi = READ_WORD(GPR(BS) + GPR(RD), _fault);			\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
    _result_lo = READ_WORD(GPR(BS) + GPR(RD) + 4, _fault);		\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
									\
    SET_FPR_L(FT, _result_hi);						\
    SET_FPR_L((FT) + 1, _result_lo);					\
  }
DEFINST(L_D_RR,			0xcf,
	"l.d",			"T,(b+d)",
	RdPort,			F_MEM|F_LOAD|F_RR,
	DFPR_D(FT), DNA,	DNA, DGPR(BS), DGPR(RD))

#define SB_RR_IMPL							\
  {									\
    byte_t _src;							\
    enum md_fault_type _fault;						\
									\
    _src = (byte_t)(word_t)GPR(RT);					\
    WRITE_BYTE(_src, GPR(BS) + GPR(RD), _fault);			\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
  }
DEFINST(SB_RR, 			0xc6, 
	"sb", 			"t,(b+d)", 
	WrPort, 		F_MEM|F_STORE|F_RR,
	DNA, DNA,	 	DGPR(RT), DGPR(BS), DGPR(RD))

#define SH_RR_IMPL							\
  {									\
    half_t _src;							\
    enum md_fault_type _fault;						\
									\
    _src = (half_t)(word_t)GPR(RT);					\
    WRITE_HALF(_src, GPR(BS) + GPR(RD), _fault);			\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
  }
DEFINST(SH_RR,	 		0xc7, 
	"sh", 			"t,(b+d)", 
	WrPort,			F_MEM|F_STORE|F_RR,
	DNA, DNA,	 	DGPR(RT), DGPR(BS), DGPR(RD))

#define SW_RR_IMPL							\
  {									\
    word_t _src;							\
    enum md_fault_type _fault;						\
									\
    _src = (word_t)GPR(RT);						\
    WRITE_WORD(_src, GPR(BS) + GPR(RD), _fault);			\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
  }
DEFINST(SW_RR,	 		0xc8, 
	"sw", 			"t,(b+d)", 
	WrPort, 		F_MEM|F_STORE|F_RR,
	DNA, DNA,		DGPR(RT), DGPR(BS), DGPR(RD))

/* FIXME: this code not fault-safe, yet... */
#define DSW_RR_IMPL							\
  {									\
    enum md_fault_type _fault;						\
									\
    if ((RT) & 01)							\
      DECLARE_FAULT(md_fault_alignment);				\
									\
    WRITE_WORD(GPR(RT), GPR(BS) + GPR(RD), _fault);			\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
    WRITE_WORD(GPR((RT)+1), GPR(BS) + GPR(RD) + 4, _fault);		\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
  }
DEFINST(DSW_RR,			0xd0,
	"dsw",			"t,(b+d)",
	WrPort,			F_MEM|F_STORE|F_RR,
	DNA, DNA,		DGPR_D(RT), DGPR(BS), DGPR(RD))

/* FIXME: this code not fault-safe, yet... */
#define DSZ_RR_IMPL							\
  {									\
    enum md_fault_type _fault;						\
									\
    WRITE_WORD(GPR(0), GPR(BS) + GPR(RD), _fault);			\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
    WRITE_WORD(GPR(0), GPR(BS) + GPR(RD) + 4, _fault);			\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
  }
DEFINST(DSZ_RR,			0xd1,
	"dsz",			"(b+d)",
	WrPort,			F_MEM|F_STORE|F_RR,
	DNA, DNA,		DNA, DGPR(BS), DGPR(RD))

#define S_S_RR_IMPL							\
  {									\
    enum md_fault_type _fault;						\
									\
    WRITE_WORD(FPR_L(FT), GPR(BS) + GPR(RD), _fault);			\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
  }
DEFINST(S_S_RR,			0xc9, 
	"s.s",	 		"T,(b+d)", 
	WrPort, 		F_MEM|F_STORE|F_RR,
	DNA, DNA,		DFPR_L(FT), DGPR(BS), DGPR(RD))

/* FIXME: this code not fault-safe, yet... */
#define S_D_RR_IMPL							\
  {									\
    enum md_fault_type _fault;						\
									\
    if ((FT) & 01)							\
      DECLARE_FAULT(md_fault_alignment);				\
									\
    WRITE_WORD(FPR_L(FT), GPR(BS) + GPR(RD), _fault);			\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
    WRITE_WORD(FPR_L((FT)+1), GPR(BS) + GPR(RD) + 4, _fault);		\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
  }
DEFINST(S_D_RR,			0xd2,
	"s.d",			"T,(b+d)",
	WrPort,			F_MEM|F_STORE|F_RR,
	DNA, DNA,		DFPR_D(FT), DGPR(BS), DGPR(RD))


/* reg + reg + 4 addressing mode, used to synthesize `l.d r,(s+t)^++' */
/* FIXME: obsolete, but do not delete or predecoded state images will break! */
#define L_S_RR_R2_IMPL							\
  {									\
    word_t _result;							\
    enum md_fault_type _fault;						\
									\
    _result = READ_WORD(GPR(BS) + GPR(RD) + 4, _fault);			\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
									\
    SET_FPR_L(FT, _result);						\
  }
DEFINST(L_S_RR_R2,		0xca,
	"l.s.r2", 		"T,(b+d)",
	RdPort,			F_MEM|F_LOAD|F_RR,
	DFPR_L(FT), DNA,	DNA, DGPR(BS), DGPR(RD))


/* FIXME: obsolete, but do not delete or predecoded state images will break! */
#define S_S_RR_R2_IMPL							\
  {									\
    enum md_fault_type _fault;						\
									\
    WRITE_WORD(FPR_L(FT), GPR(BS) + GPR(RD) + 4, _fault);		\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
  }
DEFINST(S_S_RR_R2,		0xcb,
	"s.s.r2", 		"T,(b+d)", 
	WrPort, 		F_MEM|F_STORE|F_RR,
	DNA, DNA,		DFPR_L(FT), DGPR(BS), DGPR(RD))

/* FIXME: obsolete, but do not delete or predecoded state images will break! */
#define LW_RR_R2_IMPL							\
  {									\
    word_t _result;							\
    enum md_fault_type _fault;						\
									\
    _result = READ_WORD(GPR(BS) + GPR(RD) + 4, _fault);			\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
									\
    SET_GPR(RT, _result);						\
  }
DEFINST(LW_RR_R2,		0xcc,
	"lw.r2",		"t,(b+d)",
	RdPort,			F_MEM|F_LOAD|F_RR,
	DGPR(RT), DNA,		DNA, DGPR(BS), DGPR(RD))

/* FIXME: obsolete, but do not delete or predecoded state images will break! */
#define SW_RR_R2_IMPL							\
  {									\
    enum md_fault_type _fault;						\
									\
    WRITE_WORD(GPR(RT), GPR(BS) + GPR(RD) + 4, _fault);			\
    if (_fault != md_fault_none)					\
      DECLARE_FAULT(_fault);						\
  }
DEFINST(SW_RR_R2,		0xcd, 
	"sw.r2", 		"t,(b+d)",
	WrPort, 		F_MEM|F_STORE|F_RR,
	DNA, DNA,		DGPR(RT), DGPR(BS), DGPR(RD))


/*
 * Integer ALU operations
 */

#define ADD_IMPL							\
  {									\
    if (OVER(GPR(RS), GPR(RT)))						\
      DECLARE_FAULT(md_fault_overflow);					\
									\
    SET_GPR(RD, GPR(RS) + GPR(RT));					\
  }
DEFINST(ADD,	 		0x40,
	"add", 			"d,s,t",
	IntALU, 		F_ICOMP,
	DGPR(RD), DNA,		DGPR(RS), DGPR(RT), DNA)

#define ADDI_IMPL							\
  {									\
    if (OVER(GPR(RS), IMM))						\
      DECLARE_FAULT(md_fault_overflow);					\
									\
    SET_GPR(RT, GPR(RS) + IMM);						\
  }
DEFINST(ADDI,			0x41,
	"addi",			"t,s,i",
	IntALU,			F_ICOMP|F_IMM,
	DGPR(RT), DNA, 		DGPR(RS), DNA, DNA)

#define ADDU_IMPL							\
  {									\
    SET_GPR(RD, GPR(RS) + GPR(RT));					\
  }
DEFINST(ADDU, 			0x42,
	"addu", 		"d,s,t",
	IntALU, 		F_ICOMP,
	DGPR(RD), DNA,		DGPR(RS), DGPR(RT), DNA)

#define ADDIU_IMPL							\
  {									\
    SET_GPR(RT, GPR(RS) + IMM);						\
  }
DEFINST(ADDIU,			0x43,
	"addiu",		"t,s,i",
	IntALU,			F_ICOMP|F_IMM,
	DGPR(RT), DNA, 		DGPR(RS), DNA, DNA)

#define SUB_IMPL							\
  {									\
    if (UNDER(GPR(RS), GPR(RT)))					\
      DECLARE_FAULT(md_fault_overflow);					\
									\
    SET_GPR(RD, GPR(RS) - GPR(RT));					\
  }
DEFINST(SUB, 			0x44,
	"sub", 			"d,s,t",
	IntALU, 		F_ICOMP,
	DGPR(RD), DNA,		DGPR(RS), DGPR(RT), DNA)

#define SUBU_IMPL							\
  {									\
    SET_GPR(RD, GPR(RS) - GPR(RT));					\
  }
DEFINST(SUBU, 			0x45,
	"subu", 		"d,s,t",
	IntALU, 		F_ICOMP,
	DGPR(RD), DNA,		DGPR(RS), DGPR(RT), DNA)

#define MULT_IMPL							\
  {									\
    bool_t _sign1, _sign2;						\
    int _i;								\
    sword_t _op1, _op2;							\
									\
    /* HI,LO <- [rs] * [rt], integer product of [rs] & [rt] to HI/LO */	\
    _sign1 = _sign2 = FALSE;						\
    SET_HI(0);								\
    SET_LO(0);								\
    _op1 = GPR(RS);							\
    _op2 = GPR(RT);							\
									\
    /* for multiplication, treat -ve numbers as +ve numbers by		\
       converting 2's complement -ve numbers to ordinary notation */	\
    if (_op1 & 020000000000)						\
      {									\
	_sign1 = TRUE;							\
	_op1 = (~_op1) + 1;						\
      }									\
    if (_op2 & 020000000000)						\
      {									\
	_sign2 = TRUE;							\
	_op2 = (~_op2) + 1;						\
      }									\
    if (_op1 & 020000000000)						\
      SET_LO(_op2);							\
									\
    for (_i = 0; _i < 31; _i++)						\
      {									\
	SET_HI(HI << 1);						\
	SET_HI(HI + extractl(LO, 31, 1));				\
	SET_LO(LO << 1);						\
	if ((extractl(_op1, 30 - _i, 1)) == 1)				\
	  {								\
	    if (((unsigned)037777777777 - (unsigned)LO) < (unsigned)_op2)\
	      {								\
		SET_HI(HI + 1);						\
	      }								\
	    SET_LO(LO + _op2);						\
	  }								\
      }									\
									\
    /* take 2's complement of the result if the result is negative */	\
    if (_sign1 ^ _sign2)						\
      {									\
	SET_LO(~LO);							\
	SET_HI(~HI);							\
	if ((unsigned)LO == 037777777777)				\
	  {								\
	    SET_HI(HI + 1);						\
	  }								\
	SET_LO(LO + 1);							\
      }									\
  }
DEFINST(MULT, 			0x46,
	"mult", 		"s,t", 
	IntMULT, 		F_ICOMP|F_LONGLAT,
	DHI, DLO,		DGPR(RT), DGPR(RS), DNA)

#define MULTU_IMPL							\
  {									\
    int _i;								\
									\
    /* HI,LO <- [rs] * [rt], integer product of [rs] & [rt] to HI/LO */	\
    SET_HI(0);								\
    SET_LO(0);								\
    if (GPR(RS) & 020000000000)						\
      SET_LO(GPR(RT));							\
									\
    for (_i = 0; _i < 31; _i++)						\
      {									\
	SET_HI(HI << 1);						\
	SET_HI(HI + extractl(LO, 31, 1));				\
	SET_LO(LO << 1);						\
	if ((extractl(GPR(RS), 30 - _i, 1)) == 1)			\
	  {								\
	    if (((unsigned)037777777777 - (unsigned)LO) < (unsigned)GPR(RT))\
	      {								\
		SET_HI(HI + 1);						\
	      }								\
	    SET_LO(LO + GPR(RT));					\
	  }								\
      }									\
  }
DEFINST(MULTU, 			0x47,
	"multu", 		"s,t", 
	IntMULT, 		F_ICOMP|F_LONGLAT,
	DHI, DLO,		DGPR(RT), DGPR(RS), DNA)

#define DIV_IMPL							\
  {									\
    if (GPR(RT) == 0)							\
      DECLARE_FAULT(md_fault_div0);					\
									\
    SET_LO(GPR(RS) / GPR(RT));						\
    SET_HI(GPR(RS) % GPR(RT));						\
  }
DEFINST(DIV, 			0x48,
	"div", 			"s,t", 
	IntDIV, 		F_ICOMP|F_LONGLAT,
	DHI, DLO,		DGPR(RT), DGPR(RS), DNA)

#define DIVU_IMPL							\
  {									\
    if (GPR(RT) == 0)							\
      DECLARE_FAULT(md_fault_div0);					\
									\
    SET_LO(((unsigned)GPR(RS)) / ((unsigned)GPR(RT)));			\
    SET_HI(((unsigned)GPR(RS)) % ((unsigned)GPR(RT)));			\
  }
DEFINST(DIVU, 			0x49,
	"divu", 		"s,t", 
	IntDIV, 		F_ICOMP|F_LONGLAT,
	DHI, DLO,		DGPR(RT), DGPR(RS), DNA)

#define MFHI_IMPL							\
  {									\
    SET_GPR(RD, HI);							\
  }
DEFINST(MFHI, 			0x4a,
	"mfhi", 		"d",
	IntALU, 		F_ICOMP,
	DGPR(RD), DNA,		DHI, DNA, DNA)

#define MTHI_IMPL							\
  {									\
    SET_HI(GPR(RS));							\
  }
DEFINST(MTHI, 			0x4b,
	"mthi", 		"s",
	IntALU, 		F_ICOMP,
	DHI, DNA,		DGPR(RS), DNA, DNA)

#define MFLO_IMPL							\
  {									\
    SET_GPR(RD, LO);							\
  }
DEFINST(MFLO, 			0x4c,
	"mflo", 		"d", 
	IntALU, 		F_ICOMP,
	DGPR(RD), DNA,		DLO, DNA, DNA)

#define MTLO_IMPL							\
  {									\
    SET_LO(GPR(RS));							\
  }
DEFINST(MTLO, 			0x4d,
	"mtlo", 		"s", 
	IntALU, 		F_ICOMP,
	DLO, DNA,		DGPR(RS), DNA, DNA)

/* AND conflicts with GNU defs */
#define AND__IMPL							\
  {									\
    SET_GPR(RD, GPR(RS) & GPR(RT));					\
  }
DEFINST(AND_, 			0x4e,
	"and", 			"d,s,t",
	IntALU, 		F_ICOMP,
	DGPR(RD), DNA,		DGPR(RS), DGPR(RT), DNA)

#define ANDI_IMPL							\
  {									\
    SET_GPR(RT, GPR(RS) & UIMM);					\
  }
DEFINST(ANDI,			0x4f,
	"andi",			"t,s,u",
	IntALU,			F_ICOMP|F_IMM,
	DGPR(RT), DNA,	 	DGPR(RS), DNA, DNA)

#define OR_IMPL								\
  {									\
    SET_GPR(RD, GPR(RS) | GPR(RT));					\
  }
DEFINST(OR, 			0x50,
	"or", 			"d,s,t",
	IntALU, 		F_ICOMP,
	DGPR(RD), DNA,		DGPR(RS), DGPR(RT), DNA)

#define ORI_IMPL							\
  {									\
    SET_GPR(RT, GPR(RS) | UIMM);					\
  }
DEFINST(ORI, 			0x51,
	"ori",			"t,s,u",
	IntALU,			F_ICOMP|F_IMM,
	DGPR(RT), DNA, 		DGPR(RS), DNA, DNA)

#define XOR_IMPL							\
  {									\
    SET_GPR(RD, GPR(RS) ^ GPR(RT));					\
  }
DEFINST(XOR, 			0x52,
	"xor", 			"d,s,t",
	IntALU, 		F_ICOMP,
	DGPR(RD), DNA,		DGPR(RS), DGPR(RT), DNA)

#define XORI_IMPL							\
  {									\
    SET_GPR(RT, GPR(RS) ^ UIMM);					\
  }
DEFINST(XORI, 			0x53,
	"xori",			"t,s,u",
	IntALU,			F_ICOMP|F_IMM,
	DGPR(RT), DNA, 		DGPR(RS), DNA, DNA)

#define NOR_IMPL							\
  {									\
    SET_GPR(RD, ~(GPR(RS) | GPR(RT)));					\
  }
DEFINST(NOR, 			0x54,
	"nor", 			"d,s,t",
	IntALU, 		F_ICOMP,
	DGPR(RD), DNA,		DGPR(RS), DGPR(RT), DNA)

#define SLL_IMPL							\
  {									\
    SET_GPR(RD, GPR(RT) << SHAMT);					\
  }
DEFINST(SLL, 			0x55,
	"sll", 			"d,t,H", 
	IntALU, 		F_ICOMP,
	DGPR(RD), DNA,		DGPR(RT), DNA, DNA)

#define SLLV_IMPL							\
  {									\
    SET_GPR(RD, GPR(RT) << (GPR(RS) & 037));				\
  }
DEFINST(SLLV, 			0x56,
	"sllv", 		"d,t,s", 
	IntALU, 		F_ICOMP,
	DGPR(RD), DNA,		DGPR(RT), DGPR(RS), DNA)

#ifdef FAST_SRL
#define SRL_IMPL							\
  {									\
    SET_GPR(RD, ((unsigned)GPR(RT)) >> SHAMT);				\
  }
#else /* !FAST_SRL */
#define SRL_IMPL							\
  {									\
    /* C standard says >> is implementation specific;			\
       could be SRL, SRA, or dependent on signdness of operand */	\
    if ((SHAMT) != 0)							\
      {									\
	word_t _rd;							\
									\
	_rd = (((unsigned)GPR(RT)) >> 1) & ~0x80000000;	/* first bit */	\
	SET_GPR(RD, (_rd >> ((SHAMT) - 1)));		/* rest */	\
      }									\
    else								\
      {									\
	SET_GPR(RD, GPR(RT));						\
      }									\
  }
#endif /* FAST_SRL */
DEFINST(SRL, 			0x57,
	"srl", 			"d,t,H", 
	IntALU, 		F_ICOMP,
	DGPR(RD), DNA,		DGPR(RT), DNA, DNA)

#ifdef FAST_SRL
#define SRLV_IMPL							\
  {									\
    SET_GPR(RD, ((unsigned)GPR(RT)) >> (GPR(RS) & 037));		\
  }
#else /* !FAST_SRL */
#define SRLV_IMPL							\
  {									\
    int _shamt = GPR(RS) & 037;						\
									\
    /* C standard says >> is implementation specific;			\
       could be SRL, SRA, or dependent on signdness of operand */	\
    if (_shamt != 0)							\
      {									\
	word_t _rd;							\
									\
	_rd = (((unsigned)GPR(RT)) >> 1) & ~0x80000000;	/* first bit */	\
	SET_GPR(RD, (_rd >> (_shamt - 1)));		/* rest */	\
      }									\
    else								\
      {									\
	SET_GPR(RD, GPR(RT));						\
      }									\
  }
#endif /* FAST_SRL */
DEFINST(SRLV, 			0x58,
	"srlv", 		"d,t,s", 
	IntALU, 		F_ICOMP,
	DGPR(RD), DNA,		DGPR(RT), DGPR(RS), DNA)

#ifdef FAST_SRA
#define SRA_IMPL							\
  {									\
    SET_GPR(RD, ((signed)GPR(RT)) >> SHAMT);				\
  }
#else /* !FAST_SRA */
#define SRA_IMPL							\
  {									\
    int _i;								\
									\
    /* C standard says >> is implementation specific;			\
       could be SRL, SRA, or dependent on sign-ness of operand */	\
    /* rd <- [rt] >> SHAMT */						\
    if (GPR(RT) & 0x80000000)						\
      {									\
        SET_GPR(RD, GPR(RT));						\
        for (_i = 0; _i < SHAMT; _i++)					\
	  {								\
	    SET_GPR(RD, (GPR(RD) >> 1) | 0x80000000);			\
	  }								\
      }									\
    else								\
      {									\
	SET_GPR(RD, GPR(RT) >> SHAMT);					\
      }									\
  }
#endif /* FAST_SRA */
DEFINST(SRA, 			0x59,
	"sra", 			"d,t,H", 
	IntALU, 		F_ICOMP,
	DGPR(RD), DNA,		DGPR(RT), DNA, DNA)

#ifdef FAST_SRA
#define SRAV_IMPL							\
  {									\
    SET_GPR(RD, ((signed)GPR(RT)) >> (GPR(RS) & 037));			\
  }
#else /* !FAST_SRA */
#define SRAV_IMPL							\
  {									\
    int _i;								\
    int _shamt = GPR(RS) & 037;						\
									\
    /* C standard says >> is implementation specific;			\
       could be SRL, SRA, or dependent on sign-ness of operand */	\
    /* rd <- [rt] >> SHAMT */						\
    if (GPR(RT) & 0x80000000)						\
      {									\
        SET_GPR(RD, GPR(RT));						\
        for (_i = 0; _i < _shamt; _i++)					\
	  {								\
	    SET_GPR(RD, (GPR(RD) >> 1) | 0x80000000);			\
	  }								\
      }									\
    else								\
      {									\
	SET_GPR(RD, GPR(RT) >> _shamt);					\
      }									\
  }
#endif /* FAST_SRA */
DEFINST(SRAV, 			0x5a,
	"srav", 		"d,t,s",
	IntALU, 		F_ICOMP,
	DGPR(RD), DNA,		DGPR(RT), DGPR(RS), DNA)

#define SLT_IMPL							\
  {									\
    if (GPR(RS) < GPR(RT))						\
      SET_GPR(RD, 1);							\
    else								\
      SET_GPR(RD, 0);							\
  }
DEFINST(SLT,			0x5b,
	"slt", 			"d,s,t",
	IntALU, 		F_ICOMP,
	DGPR(RD), DNA,		DGPR(RS), DGPR(RT), DNA)

#define SLTI_IMPL							\
  {									\
    if (GPR(RS) < IMM)							\
      SET_GPR(RT, 1);							\
    else								\
      SET_GPR(RT, 0);							\
  }
DEFINST(SLTI, 			0x5c,
	"slti",			"t,s,i",
	IntALU,			F_ICOMP|F_IMM,
	DGPR(RT), DNA, 		DGPR(RS), DNA, DNA)

#define SLTU_IMPL							\
  {									\
    if (((unsigned)GPR(RS)) < ((unsigned)GPR(RT)))			\
      SET_GPR(RD, 1);							\
    else								\
      SET_GPR(RD, 0);							\
  }
DEFINST(SLTU, 			0x5d,
	"sltu", 		"d,s,t",
	IntALU, 		F_ICOMP,
	DGPR(RD), DNA,		DGPR(RS), DGPR(RT), DNA)

#define SLTIU_IMPL							\
  {									\
    if ((unsigned)GPR(RS) < (unsigned)IMM)				\
      SET_GPR(RT, 1);							\
    else								\
      SET_GPR(RT, 0);							\
  }
DEFINST(SLTIU,			0x5e,
	"sltiu",		"t,s,i",
	IntALU,			F_ICOMP|F_IMM,
	DGPR(RT), DNA, 		DGPR(RS), DNA, DNA)


/*
 * Floating Point ALU operations
 */

#define FADD_S_IMPL							\
  {									\
    if (((FD) & 01) || ((FS) & 01) || ((FT) & 01))			\
      DECLARE_FAULT(md_fault_alignment);				\
									\
    SET_FPR_F(FD, FPR_F(FS) + FPR_F(FT));				\
  }
DEFINST(FADD_S,			0x70,
	"add.s",		"D,S,T",
	FloatADD,		F_FCOMP,
	DFPR_F(FD), DNA,	DFPR_F(FS), DFPR_F(FT), DNA)

#define FADD_D_IMPL							\
  {									\
    if (((FD) & 01) || ((FS) & 01) || ((FT) & 01))			\
      DECLARE_FAULT(md_fault_alignment);				\
									\
    SET_FPR_D(FD, FPR_D(FS) + FPR_D(FT));				\
  }
DEFINST(FADD_D,			0x71,
	"add.d",		"D,S,T",
	FloatADD,		F_FCOMP,
	DFPR_D(FD), DNA,	DFPR_D(FS), DFPR_D(FT), DNA)

#define FSUB_S_IMPL							\
  {									\
    if (((FD) & 01) || ((FS) & 01) || ((FT) & 01))			\
      DECLARE_FAULT(md_fault_alignment);				\
									\
    SET_FPR_F(FD, FPR_F(FS) - FPR_F(FT));				\
  }
DEFINST(FSUB_S,			0x72,
	"sub.s",		"D,S,T",
	FloatADD, 		F_FCOMP,
	DFPR_F(FD), DNA,	DFPR_F(FS), DFPR_F(FT), DNA)

#define FSUB_D_IMPL							\
  {									\
    if (((FD) & 01) || ((FS) & 01) || ((FT) & 01))			\
      DECLARE_FAULT(md_fault_alignment);				\
									\
    SET_FPR_D(FD, FPR_D(FS) - FPR_D(FT));				\
  }
DEFINST(FSUB_D,			0x73,
	"sub.d",		"D,S,T",
	FloatADD, 		F_FCOMP,
	DFPR_D(FD), DNA,	DFPR_D(FS), DFPR_D(FT), DNA)

#define FMUL_S_IMPL							\
  {									\
    if (((FD) & 01) || ((FS) & 01) || ((FT) & 01))			\
      DECLARE_FAULT(md_fault_alignment);				\
									\
    SET_FPR_F(FD, FPR_F(FS) * FPR_F(FT));				\
  }
DEFINST(FMUL_S,			0x74,
	"mul.s",		"D,S,T",
	FloatMULT, 		F_FCOMP|F_LONGLAT,
	DFPR_F(FD), DNA,	DFPR_F(FS), DFPR_F(FT), DNA)

#define FMUL_D_IMPL							\
  {									\
    if (((FD) & 01) || ((FS) & 01) || ((FT) & 01))			\
      DECLARE_FAULT(md_fault_alignment);				\
									\
    SET_FPR_D(FD, FPR_D(FS) * FPR_D(FT));				\
  }
DEFINST(FMUL_D, 		0x75,
	"mul.d",		"D,S,T",
	FloatMULT, 		F_FCOMP|F_LONGLAT,
	DFPR_D(FD), DNA,	DFPR_D(FS), DFPR_D(FT), DNA)

#define FDIV_S_IMPL							\
  {									\
    if (((FD) & 01) || ((FS) & 01) || ((FT) & 01))			\
      DECLARE_FAULT(md_fault_alignment);				\
    if (FPR_F(FT) == 0.0)						\
      DECLARE_FAULT(md_fault_div0);					\
									\
    SET_FPR_F(FD, FPR_F(FS) / FPR_F(FT));				\
  }
DEFINST(FDIV_S,			0x76,
	"div.s",		"D,S,T",
	FloatDIV,		F_FCOMP|F_LONGLAT,
	DFPR_F(FD), DNA,	DFPR_F(FS), DFPR_F(FT), DNA)

#define FDIV_D_IMPL							\
  {									\
    if (((FD) & 01) || ((FS) & 01) || ((FT) & 01))			\
      DECLARE_FAULT(md_fault_alignment);				\
    if (FPR_D(FT) == 0.0)						\
      DECLARE_FAULT(md_fault_div0);					\
									\
    SET_FPR_D(FD, FPR_D(FS) / FPR_D(FT));				\
  }
DEFINST(FDIV_D,			0x77,
	"div.d",		"D,S,T",
	FloatDIV,		F_FCOMP|F_LONGLAT,
	DFPR_D(FD), DNA,	DFPR_D(FS), DFPR_D(FT), DNA)

#define FABS_S_IMPL							\
  {									\
    if (((FD) & 01) || ((FS) & 01))					\
      DECLARE_FAULT(md_fault_alignment);				\
									\
    SET_FPR_F(FD, (sfloat_t)fabs((dfloat_t)FPR_F(FS)));			\
  }
DEFINST(FABS_S,			0x78,
	"abs.s",		"D,S",
	FloatADD,		F_FCOMP,
	DFPR_F(FD), DNA,	DFPR_F(FS), DNA, DNA)

#define FABS_D_IMPL							\
  {									\
    if (((FD) & 01) || ((FS) & 01))					\
      DECLARE_FAULT(md_fault_alignment);				\
									\
    SET_FPR_D(FD, fabs(FPR_D(FS)));					\
  }
DEFINST(FABS_D,			0x79,
	"abs.d",		"D,S",
	FloatADD,		F_FCOMP,
	DFPR_D(FD), DNA,	DFPR_D(FS), DNA, DNA)

#define FMOV_S_IMPL							\
  {									\
    if (((FD) & 01) || ((FS) & 01))					\
      DECLARE_FAULT(md_fault_alignment);				\
									\
    SET_FPR_F(FD, FPR_F(FS));						\
  }
DEFINST(FMOV_S,			0x7a,
	"mov.s",		"D,S",
	FloatADD,		F_FCOMP,
	DFPR_F(FD), DNA,	DFPR_F(FS), DNA, DNA)

#define FMOV_D_IMPL							\
  {									\
    if (((FD) & 01) || ((FS) & 01))					\
      DECLARE_FAULT(md_fault_alignment);				\
									\
    SET_FPR_D(FD, FPR_D(FS));						\
  }
DEFINST(FMOV_D,			0x7b,
	"mov.d",		"D,S",
	FloatADD,		F_FCOMP,
	DFPR_D(FD), DNA,	DFPR_D(FS), DNA, DNA)

#define FNEG_S_IMPL							\
  {									\
    if (((FD) & 01) || ((FS) & 01))					\
      DECLARE_FAULT(md_fault_alignment);				\
									\
    SET_FPR_F(FD, -FPR_F(FS));						\
  }
DEFINST(FNEG_S,			0x7c,
	"neg.s",		"D,S",
	FloatADD,		F_FCOMP,
	DFPR_F(FD), DNA,	DFPR_F(FS), DNA, DNA)

#define FNEG_D_IMPL							\
  {									\
    if (((FD) & 01) || ((FS) & 01))					\
      DECLARE_FAULT(md_fault_alignment);				\
									\
    SET_FPR_D(FD, -FPR_D(FS));						\
  }
DEFINST(FNEG_D,			0x7d,
	"neg.d",		"D,S",
	FloatADD,		F_FCOMP,
	DFPR_D(FD), DNA,	DFPR_D(FS), DNA, DNA)

#define CVT_S_D_IMPL							\
  {									\
    if (((FD) & 01) || ((FS) & 01))					\
      DECLARE_FAULT(md_fault_alignment);				\
									\
    SET_FPR_F(FD, (float)FPR_D(FS));					\
  }
DEFINST(CVT_S_D,		0x80, 
	"cvt.s.d", 		"D,S",
	FloatCVT,		F_FCOMP,
	DFPR_F(FD), DNA,	DFPR_D(FS), DNA, DNA)

#define CVT_S_W_IMPL							\
  {									\
    if (((FD) & 01) || ((FS) & 01))					\
      DECLARE_FAULT(md_fault_alignment);				\
									\
    SET_FPR_F(FD, (float)FPR_L(FS));					\
  }
DEFINST(CVT_S_W,		0x81,
	"cvt.s.w", 		"D,S",
	FloatCVT,		F_FCOMP,
	DFPR_F(FD), DNA,	DFPR_L(FS), DNA, DNA)

#define CVT_D_S_IMPL							\
  {									\
    if (((FD) & 01) || ((FS) & 01))					\
      DECLARE_FAULT(md_fault_alignment);				\
									\
    SET_FPR_D(FD, (dfloat_t)FPR_F(FS));					\
  }
DEFINST(CVT_D_S,		0x82,
	"cvt.d.s",		"D,S",
	FloatCVT,		F_FCOMP,
	DFPR_D(FD), DNA,	DFPR_F(FS), DNA, DNA)

#define CVT_D_W_IMPL							\
  {									\
    if (((FD) & 01) || ((FS) & 01))					\
      DECLARE_FAULT(md_fault_alignment);				\
									\
    SET_FPR_D(FD, (dfloat_t)FPR_L(FS));					\
  }
DEFINST(CVT_D_W,		0x83,
	"cvt.d.w",		"D,S",
	FloatCVT,		F_FCOMP,
	DFPR_D(FD), DNA,	DFPR_L(FS), DNA, DNA)

#define CVT_W_S_IMPL							\
  {									\
    if (((FD) & 01) || ((FS) & 01))					\
      DECLARE_FAULT(md_fault_alignment);				\
									\
    SET_FPR_L(FD, (sword_t)FPR_F(FS));					\
  }
DEFINST(CVT_W_S,		0x84,
	"cvt.w.s", 		"D,S",
	FloatCVT,		F_FCOMP,
	DFPR_L(FD), DNA,	DFPR_F(FS), DNA, DNA)

#define CVT_W_D_IMPL							\
  {									\
    if (((FD) & 01) || ((FS) & 01))					\
      DECLARE_FAULT(md_fault_alignment);				\
									\
    SET_FPR_L(FD, (sword_t)FPR_D(FS));					\
  }
DEFINST(CVT_W_D,		0x85,
	"cvt.w.d", 		"D,S",
	FloatCVT,		F_FCOMP,
	DFPR_L(FD), DNA,	DFPR_D(FS), DNA, DNA)

#define C_EQ_S_IMPL							\
  {									\
    if (((FS) & 01) || ((FT) & 01))					\
      DECLARE_FAULT(md_fault_alignment);				\
									\
    SET_FCC(FPR_F(FS) == FPR_F(FT));					\
  }
DEFINST(C_EQ_S,			0x90,
	"c.eq.s", 		"S,T",
	FloatCMP,		F_FCOMP,
	DFCC, DNA,		DFPR_F(FS), DFPR_F(FT), DNA)

#define C_EQ_D_IMPL							\
  {									\
    if (((FS) & 01) || ((FT) & 01))					\
      DECLARE_FAULT(md_fault_alignment);				\
									\
    SET_FCC(FPR_D(FS) == FPR_D(FT));					\
  }
DEFINST(C_EQ_D,			0x91,
	"c.eq.d", 		"S,T",
	FloatCMP,		F_FCOMP,
	DFCC, DNA,		DFPR_D(FS), DFPR_D(FT), DNA)

#define C_LT_S_IMPL							\
  {									\
    if (((FS) & 01) || ((FT) & 01))					\
      DECLARE_FAULT(md_fault_alignment);				\
									\
    SET_FCC(FPR_F(FS) < FPR_F(FT));					\
  }
DEFINST(C_LT_S,			0x92,
	"c.lt.s", 		"S,T",
	FloatCMP,		F_FCOMP,
	DFCC, DNA,		DFPR_F(FS), DFPR_F(FT), DNA)

#define C_LT_D_IMPL							\
  {									\
    if (((FS) & 01) || ((FT) & 01))					\
      DECLARE_FAULT(md_fault_alignment);				\
									\
    SET_FCC(FPR_D(FS) < FPR_D(FT));					\
  }
DEFINST(C_LT_D,			0x93,
	"c.lt.d", 		"S,T",
	FloatCMP,		F_FCOMP,
	DFCC, DNA,		DFPR_D(FS), DFPR_D(FT), DNA)

#define C_LE_S_IMPL							\
  {									\
    if (((FS) & 01) || ((FT) & 01))					\
      DECLARE_FAULT(md_fault_alignment);				\
									\
    SET_FCC(FPR_F(FS) <= FPR_F(FT));					\
  }
DEFINST(C_LE_S,			0x94,
	"c.le.s", 		"S,T",
	FloatCMP,		F_FCOMP,
	DFCC, DNA,		DFPR_F(FS), DFPR_F(FT), DNA)

#define C_LE_D_IMPL							\
  {									\
    if (((FS) & 01) || ((FT) & 01))					\
      DECLARE_FAULT(md_fault_alignment);				\
									\
    SET_FCC(FPR_D(FS) <= FPR_D(FT));					\
  }
DEFINST(C_LE_D,			0x95,
	"c.le.d", 		"S,T",
	FloatCMP,		F_FCOMP,
	DFCC, DNA,		DFPR_D(FS), DFPR_D(FT), DNA)

#define FSQRT_S_IMPL							\
  {									\
    if (((FD) & 01) || ((FS) & 01))					\
      DECLARE_FAULT(md_fault_alignment);				\
									\
    SET_FPR_F(FD, (sfloat_t)sqrt((dfloat_t)FPR_F(FS)));			\
  }
DEFINST(FSQRT_S,		0x96,
	"sqrt.s",		"D,S",
	FloatSQRT,		F_FCOMP|F_LONGLAT,
	DFPR_F(FD), DNA,	DFPR_F(FS), DNA, DNA)

#define FSQRT_D_IMPL							\
  {									\
    if (((FD) & 01) || ((FS) & 01))					\
      DECLARE_FAULT(md_fault_alignment);				\
									\
    SET_FPR_D(FD, sqrt(FPR_D(FS)));					\
  }
DEFINST(FSQRT_D,		0x97,
	"sqrt.d",		"D,S",
	FloatSQRT,		F_FCOMP|F_LONGLAT,
	DFPR_D(FD), DNA,	DFPR_D(FS), DNA, DNA)


/*
 * miscellaneous
 */

#define SYSCALL_IMPL							\
  {									\
    SYSCALL(inst);							\
  }
DEFINST(SYSCALL, 		0xa0,
	"syscall", 		"",
	NA, 			F_TRAP,
	DNA, DNA,		DNA, DNA, DNA)

#define BREAK_IMPL							\
  {									\
    /* NOTE: these are decoded speculatively, as they occur in integer	\
       divide sequences, however, they should NEVER be executed under	\
       non-exception conditions */					\
    DECLARE_FAULT(md_fault_break);					\
  }

DEFINST(BREAK,			0xa1,
	"break",		"B",
	NA,			F_TRAP,
	DNA, DNA,		DNA, DNA, DNA)

#define LUI_IMPL							\
  {									\
    SET_GPR(RT, UIMM << 16);						\
  }
DEFINST(LUI, 			0xa2,
	"lui",			"t,U",
	IntALU,			F_ICOMP,
	DGPR(RT), DNA, 		DNA, DNA, DNA)

#define MFC1_IMPL							\
  {									\
    SET_GPR(RT, FPR_L(FS));						\
  }
DEFINST(MFC1,	 		0xa3,
	"mfc1", 		"t,S",
	IntALU, 		F_ICOMP,
	DGPR(RT), DNA,		DFPR_L(FS), DNA, DNA)

#define DMFC1_IMPL							\
  {									\
    if (((RT) & 01) || ((FS) & 01))					\
      DECLARE_FAULT(md_fault_alignment);				\
									\
    SET_GPR(RT, FPR_L(FS));						\
    SET_GPR((RT)+1, FPR_L((FS)+1));					\
  }
DEFINST(DMFC1, 			0xa7,
	"dmfc1",		"t,S",
	IntALU,			F_ICOMP,
	DGPR_D(RT), DNA, 	DFPR_D(FS), DNA, DNA)

#define CFC1_IMPL							\
  {									\
    /* FIXME: is this needed??? */					\
  }
DEFINST(CFC1, 			0xa4,
	"cfc1", 		"t,S",
	IntALU, 		F_ICOMP,
	DNA, DNA,		DNA, DNA, DNA)

#define MTC1_IMPL							\
  {									\
    SET_FPR_L(FS, GPR(RT));						\
  }
DEFINST(MTC1, 			0xa5,
	"mtc1", 		"t,S",
	IntALU, 		F_ICOMP,
	DFPR_L(FS), DNA,	DGPR(RT), DNA, DNA)

#define DMTC1_IMPL							\
  {									\
    if (((FS) & 01) || ((RT) & 01))					\
      DECLARE_FAULT(md_fault_alignment);				\
									\
    SET_FPR_L(FS, GPR(RT));						\
    SET_FPR_L((FS)+1, GPR((RT)+1));					\
  }
DEFINST(DMTC1,	 		0xa8,
	"dmtc1",		"t,S",
	IntALU,			F_ICOMP,
	DFPR_D(FS), DNA,	DGPR_D(RT), DNA, DNA)

#define CTC1_IMPL							\
  {									\
    /* FIXME: is this needed??? */					\
  }
DEFINST(CTC1, 			0xa6,
	"ctc1", 		"t,S",
	IntALU, 		F_ICOMP,
	DNA, DNA,		DNA, DNA, DNA)


/* clean up all definitions... */
#undef NOP_IMPL
#undef JUMP_IMPL
#undef JAL_IMPL
#undef JR_IMPL
#undef JALR_IMPL
#undef BEQ_IMPL
#undef BNE_IMPL
#undef BLEZ_IMPL
#undef BGTZ_IMPL
#undef BLTZ_IMPL
#undef BGEZ_IMPL
#undef BC1F_IMPL
#undef BC1T_IMPL
#undef LB_IMPL
#undef LBU_IMPL
#undef LH_IMPL
#undef LHU_IMPL
#undef LW_IMPL
#undef DLW_IMPL
#undef L_S_IMPL
#undef L_D_IMPL
#undef SB_IMPL
#undef SH_IMPL
#undef SW_IMPL
#undef DSW_IMPL
#undef DSZ_IMPL
#undef S_S_IMPL
#undef S_D_IMPL
#undef LB_RR_IMPL
#undef LBU_RR_IMPL
#undef LH_RR_IMPL
#undef LHU_RR_IMPL
#undef LW_RR_IMPL
#undef DLW_RR_IMPL
#undef L_S_RR_IMPL
#undef L_D_RR_IMPL
#undef SB_RR_IMPL
#undef SH_RR_IMPL
#undef SW_RR_IMPL
#undef DSW_RR_IMPL
#undef DSZ_RR_IMPL
#undef S_S_RR_IMPL
#undef S_D_RR_IMPL
#undef L_S_RR_R2_IMPL
#undef S_S_RR_R2_IMPL
#undef LW_RR_R2_IMPL
#undef SW_RR_R2_IMPL
#undef ADD_IMPL
#undef ADDI_IMPL
#undef ADDU_IMPL
#undef ADDIU_IMPL
#undef SUB_IMPL
#undef SUBU_IMPL
#undef MULT_IMPL
#undef MULTU_IMPL
#undef DIV_IMPL
#undef DIVU_IMPL
#undef MFHI_IMPL
#undef MTHI_IMPL
#undef MFLO_IMPL
#undef MTLO_IMPL
#undef AND__IMPL
#undef ANDI_IMPL
#undef OR_IMPL
#undef ORI_IMPL
#undef XOR_IMPL
#undef XORI_IMPL
#undef NOR_IMPL
#undef SLL_IMPL
#undef SLLV_IMPL
#undef SRL_IMPL
#undef SRLV_IMPL
#undef SRA_IMPL
#undef SRAV_IMPL
#undef SLT_IMPL
#undef SLTI_IMPL
#undef SLTU_IMPL
#undef SLTIU_IMPL
#undef FADD_S_IMPL
#undef FADD_D_IMPL
#undef FSUB_S_IMPL
#undef FSUB_D_IMPL
#undef FMUL_S_IMPL
#undef FMUL_D_IMPL
#undef FDIV_S_IMPL
#undef FDIV_D_IMPL
#undef FABS_S_IMPL
#undef FABS_D_IMPL
#undef FMOV_S_IMPL
#undef FMOV_D_IMPL
#undef FNEG_S_IMPL
#undef FNEG_D_IMPL
#undef CVT_S_D_IMPL
#undef CVT_S_W_IMPL
#undef CVT_D_S_IMPL
#undef CVT_D_W_IMPL
#undef CVT_W_S_IMPL
#undef CVT_W_D_IMPL
#undef C_EQ_S_IMPL
#undef C_EQ_D_IMPL
#undef C_LT_S_IMPL
#undef C_LT_D_IMPL
#undef C_LE_S_IMPL
#undef C_LE_D_IMPL
#undef FSQRT_S_IMPL
#undef FSQRT_D_IMPL
#undef SYSCALL_IMPL
#undef BREAK_IMPL
#undef LUI_IMPL
#undef MFC1_IMPL
#undef DMFC1_IMPL
#undef CFC1_IMPL
#undef MTC1_IMPL
#undef DMTC1_IMPL
#undef CTC1_IMPL

#undef DEFINST
#undef DEFLINK
#undef CONNECT
