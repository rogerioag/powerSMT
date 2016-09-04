/* I inclued this copyright since we're using Cacti for some stuff */

/*------------------------------------------------------------
 *  Copyright 1994 Digital Equipment Corporation and Steve Wilton
 *                         All Rights Reserved
 *
 * Permission to use, copy, and modify this software and its documentation is
 * hereby granted only under the following terms and conditions.  Both the
 * above copyright notice and this permission notice must appear in all copies
 * of the software, derivative works or modified versions, and any portions
 * thereof, and both notices must appear in supporting documentation.
 *
 * Users of this software agree to the terms and conditions set forth herein,
 * and hereby grant back to Digital a non-exclusive, unrestricted, royalty-
 * free right and license under any changes, enhancements or extensions
 * made to the core functions of the software, including but not limited to
 * those affording compatibility with other hardware or software
 * environments, but excluding applications which incorporate this software.
 * Users further agree to use their best efforts to return to Digital any
 * such changes, enhancements or extensions that they make and inform Digital
 * of noteworthy uses of this software.  Correspondence should be provided
 * to Digital at:
 *
 *                       Director of Licensing
 *                       Western Research Laboratory
 *                       Digital Equipment Corporation
 *                       100 Hamilton Avenue
 *                       Palo Alto, California  94301
 *
 * This software may be distributed (but not offered for sale or transferred
 * for compensation) to third parties, provided such third parties agree to
 * abide by the terms and conditions of this notice.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND DIGITAL EQUIPMENT CORP. DISCLAIMS ALL
 * WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING ALL IMPLIED WARRANTIES
 * OF MERCHANTABILITY AND FITNESS.   IN NO EVENT SHALL DIGITAL EQUIPMENT
 * CORPORATION BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
 * DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR
 * PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS
 * ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS
 * SOFTWARE.
 *------------------------------------------------------------*/

#include <math.h>
#include "power.h"
#include "machine.h"
#include "cache.h"
#include <assert.h>


extern double Sense2Powerfactor;
extern double LowSwingPowerfactor;

extern double  MSCALE;


extern double GEN_POWER_FACTOR ;
extern double CSCALE;	/* wire capacitance scaling factor */
extern double RSCALE	;/* wire resistance scaling factor */
extern double LSCALE		;	/* length (feature) scaling factor */
extern double ASCALE  ;	/* area scaling factor */
extern double VSCALE		;	/* voltage scaling factor */
extern double VTSCALE	;		/* threshold voltage scaling factor */
extern double SSCALE	;	/* sense voltage scaling factor */
extern double TECH_LENGTH    ;         /* TECH LENGTH */
extern double Mhz  ;
extern double GEN_POWER_SCALE ;

/*
  * CMOS 0.8um model parameters
  *   - from Appendix II of Cacti tech report
  */


/* corresponds to 8um of m3 @ 225ff/um */
extern double Cwordmetal                                 ; 

/*extern double Corresponds to 16um of m2 @ 275ff/um */
extern double Cbitmetal    ; 

/* corresponds to 1um of m2 @ 275ff/um */
extern double Cmetal   ;

extern double CM3metal  ;
extern double CM2metal  ;

/*  Cmetal 1.222e-15 */

/* fF/um2 at 1.5V */
extern double Cndiffarea ;		/* FIXME: ??? */

/* fF/um2 at 1.5V */
extern double Cpdiffarea ;		/* FIXME: ??? */

/* fF/um at 1.5V */
extern double Cndiffside ;		/* in general this does not scale */

/* fF/um at 1.5V */
extern double Cpdiffside ;		/* in general this does not scale */

/* fF/um at 1.5V */
extern double Cndiffovlp   ;		/* FIXME: by depth??? */

/* fF/um at 1.5V */
extern double Cpdiffovlp   ;		/* FIXME: by depth??? */

/* fF/um assuming 25% Miller effect */
extern double Cnoxideovlp ;		/* FIXME: by depth??? */

/* fF/um assuming 25% Miller effect */
extern double Cpoxideovlp ;		/* FIXME: by depth??? */

/* um */
extern double Leff         ; 

/* fF/um2 */
extern double Cgate        ;		/* FIXME: ??? */

/* fF/um2 */
extern double Cgatepass    ;		/* FIXME: ??? */

/* note that the value ofextern double Cgatepass will be different depending on 
   whether or not the source and drain are at different potentials or
   the same potential.  The two values were averaged */

/* fF/um */
extern double Cpolywire	 ; 

/* ohms*um of channel width */
extern double Rnchannelstatic   ; 

/* ohms*um of channel width */
extern double Rpchannelstatic ; 

extern double Rnchannelon ; 

extern double Rpchannelon; 

/* corresponds to 16um of m2 @ 48mO/sq */
extern double Rbitmetal ; 

/* corresponds to  8um of m3 @ 24mO/sq */
extern double Rwordmetal; 

extern double Vdd   ; 

/* other stuff (from tech report, appendix 1) */


extern double Period   ; 

extern double krise ; 
extern double tsensedata   ; 
extern double tsensetag  ; 
extern double tfalldata; 
extern double tfalltag; 
extern double Vbitpre  ; 
extern double Vt	 ; 
extern double Vbitsense  ; 
extern double Powerfactor ;

extern double SensePowerfactor3   ; 
extern double SensePowerfactor2  ; 
extern double SensePowerfactor ; 

extern double AF   ;
extern double POPCOUNT_AF ; 

/* Threshold voltages (as a proportion of Vdd)
   If you don't know them, set all values to 0.5 */

extern double VSINV          ;  
extern double VTHINV100x60  ;   /* inverter with p00,n0 */
extern double VTHNAND60x90   ;  /* nand with p=60 and three n=90 */
extern double VTHNOR12x4x1    ;  /* nor with p=12, n=4, 1 input */
extern double VTHNOR12x4x2    ; /* nor with p=12, n=4, 2 inputs */
extern double VTHNOR12x4x3    ; /* nor with p=12, n=4, 3 inputs */
extern double VTHNOR12x4x4    ; /* nor with p=12, n=4, 4 inputs */
extern double VTHOUTDRINV    ;
extern double VTHOUTDRNOR   ;
extern double VTHOUTDRNAND  ;
extern double VTHOUTDRIVE   ;
extern double VTHCOMPINV    ;
extern double VTHMUXDRV1    ;
extern double VTHMUXDRV2    ;
extern double VTHMUXDRV3    ;
extern double VTHEVALINV    ;
extern double VTHSENSEEXTDRV   ;

/* transistor widths in um (as described in tech report, appendix 1) */
extern double Wdecdrivep 	 ; 
extern double Wdecdriven 	 ; 
extern double Wdec3to8n 	 ; 
extern double Wdec3to8p 	 ; 
extern double WdecNORn 	 ; 
extern double WdecNORp 	 ; 
extern double Wdecinvn 	 ; 
extern double Wdecinvp	 ; 

extern double Wworddrivemax 	 ; 
extern double Wmemcella 	 ; 
extern double Wmemcellr 	 ; 
extern double Wmemcellw 	 ; 
extern double Wmemcellbscale 	;		/* means 2x bigger than Wmemcella */
extern double Wbitpreequ 	 ; 

extern double Wbitmuxn 	 ; 
extern double WsenseQ1to4 	 ; 
extern double Wcompinvp1  	 ; 
extern double Wcompinvn1  	 ; 
extern double Wcompinvp2  	 ; 
extern double Wcompinvn2  	 ; 
extern double Wcompinvp3  	 ; 
extern double Wcompinvn3  	 ; 
extern double Wevalinvp  	 ; 
extern double Wevalinvn  	 ; 

extern double Wcompn	  	 ; 
extern double Wcompp	  	 ; 
extern double Wcomppreequ    ; 
extern double Wmuxdrv12n  	 ; 
extern double Wmuxdrv12p  	 ; 
extern double WmuxdrvNANDn   ; 
extern double WmuxdrvNANDp   ; 
extern double WmuxdrvNORn  	 ; 
extern double WmuxdrvNORp 	 ; 
extern double Wmuxdrv3n    ; 
extern double Wmuxdrv3p    ; 
extern double Woutdrvseln    ; 
extern double Woutdrvselp    ; 
extern double Woutdrvnandn    ; 
extern double Woutdrvnandp    ; 
extern double Woutdrvnorn    ; 
extern double Woutdrvnorp    ; 
extern double Woutdrivern    ; 
extern double Woutdriverp     ; 

extern double Wcompcellpd2    ; 
extern double Wcompdrivern    ; 
extern double Wcompdriverp    ; 
extern double Wcomparen2      ; 
extern double Wcomparen1      ; 
extern double Wmatchpchg      ; 
extern double Wmatchinvn      ; 
extern double Wmatchinvp      ; 
extern double Wmatchnandn     ; 
extern double Wmatchnandp     ; 
extern double Wmatchnorn     ; 
extern double Wmatchnorp     ; 

extern double WSelORn         ; 
extern double WSelORprequ     ; 
extern double WSelPn          ; 
extern double WSelPp          ; 
extern double WSelEnn         ; 
extern double WSelEnp         ; 

extern double Wsenseextdrv1p    ; 
extern double Wsenseextdrv1n    ; 
extern double Wsenseextdrv2p    ; 
extern double Wsenseextdrv2n    ; 


/* bit width of RAM cell in um */
extern double BitWidth     ; 

/* bit height of RAM cell in um */
extern double BitHeight     ; 

extern double Cout	     ; 

/* Sizing of cells and spacings */
extern double RatCellHeight    ; 
extern double RatCellWidth     ; 
extern double RatShiftRegWidth  ; 
extern double RatNumShift      ;
extern double BitlineSpacing   ; 
extern double WordlineSpacing   ; 

extern double RegCellHeight    ; 
extern double RegCellWidth     ; 

extern double CamCellHeight    ; 
extern double CamCellWidth     ; 
extern double MatchlineSpacing  ; 
extern double TaglineSpacing   ; 

/* ALU POWER NUMBERS for .18um 733Mhz */
/* normalize to cap from W */
extern double  NORMALIZE_SCALE    ; 
/* normalize .18um cap to other gen's cap, then xPowerfactor */
extern double   POWER_SCALE   ; 
extern double  I_ADD         ; 
extern double  I_ADD32      ; 
extern double  I_MULT16      ; 
extern double  I_SHIFT      ; 
extern double  I_LOGIC     ; 
extern double  F_ADD     ; 
extern double  F_MULT    ;


/* Added by PowerSMT */
extern double I_MULT;					/* integer multiply */
extern double I_DIV;						/* integer divide */
extern double F_DIV;						/* floating point divider */
extern double F_DIV_MULT;			/* floating point divide and multiply */

extern double RD_PORT;					/* memory read port */
extern double WR_PORT;					/* memory write port */
extern double F_CMP;						/* floating point comparator */
extern double F_CVT;						/* floating point<->integer converter */
extern double F_SQRT;					/* floating point square root */
/* Added by PowerSMT */

extern double I_ADD_CLOCK; 
extern double I_MULT_CLOCK; 
extern double I_SHIFT_CLOCK; 
extern double I_LOGIC_CLOCK; 
extern double F_ADD_CLOCK; 
extern double F_MULT_CLOCK; 

/* Added by PowerSMT */
extern double I_DIV_CLOCK;
extern double F_DIV_CLOCK;
extern double F_MULT_CLOCK;
extern double F_DIV_MULT_CLOCK;
extern double RD_PORT_CLOCK;
extern double WR_PORT_CLOCK;
extern double F_CMP_CLOCK;
extern double F_CVT_CLOCK;
extern double F_SQRT_CLOCK;
 /* Added by PowerSMT */

/* Added by PowerSMT */
extern int il1_banks_num;
extern int dl1_banks_num;

extern int l2_banks_num;

extern int il1_modules_num;

extern char *ruulsq_opt;


/* Added by PowerSMT */




/* set scale for crossover (vdd->gnd) currents */
double crossover_scaling = 1.2;
/* set non-ideal turnoff percentage */
double turnoff_factor = 0.1;


/*----------------------------------------------------------------------*/

/* static power model results */
power_result_type power;

int pow2(int x) {
	return ((int)pow(2.0, (double)x));
}

double logfour(x)
	double x; {
	if (x<=0)
		fprintf(stderr,"%e\n",x);
	return ( (double) (log(x)/log(4.0)) );
}

/* safer pop count to validate the fast algorithm */
int pop_count_slow(quad_t bits) {
	int count = 0;
	quad_t tmpbits = bits;
	while (tmpbits) {
		if (tmpbits & 1)
			++count;
		tmpbits >>= 1;
	}
	return count;
}

/* fast pop count */
int pop_count(quad_t bits) {
#define T unsigned long long
#define ONES ((T)(-1)) 
#define TWO(k) ((T)1 << (k)) 
#define CYCL(k) (ONES/(1 + (TWO(TWO(k))))) 
#define BSUM(x,k) ((x)+=(x) >> TWO(k), (x) &= CYCL(k)) 
	quad_t x = bits;
	x = (x & CYCL(0)) + ((x>>TWO(0)) & CYCL(0));
	x = (x & CYCL(1)) + ((x>>TWO(1)) & CYCL(1));
	BSUM(x,2);
	BSUM(x,3);
	BSUM(x,4);
	BSUM(x,5);
	
	// fprintf(stdout,"pop_count: %g\n", x);	
	
	return x;
}

int opcode_length = 8;
int inst_length = 32;

extern int ruu_decode_width;
extern int ruu_issue_width;
extern int ruu_commit_width;
extern int RUU_size;
extern int LSQ_size;
extern int data_width;
extern int res_ialu;
extern int res_fpalu;
extern int res_memport;

/* Added by PowerSMT */
extern int res_imult;
extern int res_fpmult;
extern int res_divmult;
extern int res_homo;
/* Added by PowerSMT */

int nvreg_width;
int npreg_width;

extern int bimod_config[];

extern struct cache_t *cache_dl1;
extern struct cache_t *cache_il1;
extern struct cache_t *cache_dl2;

extern struct cache_t *dtlb;
extern struct cache_t *itlb;

/* 2-level predictor config (<l1size> <l2size> <hist_size> <xor>) */
extern int twolev_config[];

/* combining predictor config (<meta_table_size> */
extern int comb_config[];

/* return address stack (RAS) size */
extern int ras_size;

/* BTB predictor config (<num_sets> <associativity>) */
extern int btb_config[];

double global_clockcap;

static double rename_power[MAX_SLOTS] = { 0 };
static double bpred_power[MAX_SLOTS] = { 0 };
static double window_power[MAX_SLOTS] = { 0 };
static double lsq_power[MAX_SLOTS] = { 0 };
static double regfile_power[MAX_SLOTS] = { 0 };
static double icache_power[MAX_SLOTS] = { 0 };
static double dcache_power[MAX_SLOTS] = { 0 };
static double dcache2_power[MAX_SLOTS] = { 0 };

/* PowerSMT Added */
// static double alu_power[MAX_SLOTS] = { 0 };
// static double falu_power[MAX_SLOTS] = { 0 };

static double ialu_power[MAX_SLOTS] = { 0 };				/* integer-ALU, instructions classes treated (ICT): IntALU */
static double imult_div_power[MAX_SLOTS] = { 0 };		/* integer-MULT/DIV, integer multiplier/divider, ICT: IntMULT, IntDIV */
static double mem_port_power[MAX_SLOTS] = { 0 };		/* memory-port, ICT: RdPort, WrPort */
static double fpalu_power[MAX_SLOTS] = { 0 };				/* FP-ALU, floating point adder/subtractor, ITC: FloatADD, FloatCMP, FloatCVT */
static double fpmult_div_power[MAX_SLOTS] = { 0 };	/* FP-MULT/DIV, floating point multiplier/divider, ICT: FloatMULT, FloatDIV, 
 														 FloatSQRT */
static double divmult_power[MAX_SLOTS] = { 0 };			/* DIV/MULT, divider/multiplier, ICT: IntALU, FloatADD, FloatCMP, FloatCVT, 
 														 IntMULT, IntDIV, FloatMULT, FloatDIV, FloatSQRT */
static double homo_power[MAX_SLOTS] = { 0 };				

/* PowerSMT Added */


static double resultbus_power[MAX_SLOTS] = { 0 };
static double clock_power[MAX_SLOTS] = { 0 };

static double rename_power_cc1[MAX_SLOTS] = { 0 };
static double bpred_power_cc1[MAX_SLOTS] = { 0 };
static double window_power_cc1[MAX_SLOTS] = { 0 };
static double lsq_power_cc1[MAX_SLOTS] = { 0 };
static double regfile_power_cc1[MAX_SLOTS] = { 0 };
static double icache_power_cc1[MAX_SLOTS] = { 0 };
static double dcache_power_cc1[MAX_SLOTS] = { 0 };
static double dcache2_power_cc1[MAX_SLOTS] = { 0 };

/* PowerSMT Added */
// static double alu_power_cc1[MAX_SLOTS] = { 0 };

static double ialu_power_cc1[MAX_SLOTS] = { 0 };				/* integer-ALU, instructions classes treated (ICT): IntALU */
static double imult_div_power_cc1[MAX_SLOTS] = { 0 };		/* integer-MULT/DIV, integer multiplier/divider, ICT: IntMULT, IntDIV */
static double mem_port_power_cc1[MAX_SLOTS] = { 0 };		/* memory-port, ICT: RdPort, WrPort */
static double fpalu_power_cc1[MAX_SLOTS] = { 0 };				/* FP-ALU, floating point adder/subtractor, ITC: FloatADD, FloatCMP, FloatCVT */
static double fpmult_div_power_cc1[MAX_SLOTS] = { 0 };	/* FP-MULT/DIV, floating point multiplier/divider, ICT: FloatMULT, FloatDIV, 
 														 FloatSQRT */
static double divmult_power_cc1[MAX_SLOTS] = { 0 };			/* DIV/MULT, divider/multiplier, ICT: IntALU, FloatADD, FloatCMP, FloatCVT, 
 														 IntMULT, IntDIV, FloatMULT, FloatDIV, FloatSQRT */
static double homo_power_cc1[MAX_SLOTS] = { 0 };				

/* PowerSMT Added */

static double resultbus_power_cc1[MAX_SLOTS] = { 0 };
static double clock_power_cc1[MAX_SLOTS] = { 0 };

static double rename_power_cc2[MAX_SLOTS] = { 0 };
static double bpred_power_cc2[MAX_SLOTS] = { 0 };
static double window_power_cc2[MAX_SLOTS] = { 0 };
static double lsq_power_cc2[MAX_SLOTS] = { 0 };
static double regfile_power_cc2[MAX_SLOTS] = { 0 };
static double icache_power_cc2[MAX_SLOTS] = { 0 };
static double dcache_power_cc2[MAX_SLOTS] = { 0 };
static double dcache2_power_cc2[MAX_SLOTS] = { 0 };

/* PowerSMT Added */
// static double alu_power_cc2[MAX_SLOTS] = { 0 };
static double ialu_power_cc2[MAX_SLOTS] = { 0 };				/* integer-ALU, instructions classes treated (ICT): IntALU */
static double imult_div_power_cc2[MAX_SLOTS] = { 0 };		/* integer-MULT/DIV, integer multiplier/divider, ICT: IntMULT, IntDIV */
static double mem_port_power_cc2[MAX_SLOTS] = { 0 };		/* memory-port, ICT: RdPort, WrPort */
static double fpalu_power_cc2[MAX_SLOTS] = { 0 };				/* FP-ALU, floating point adder/subtractor, ITC: FloatADD, FloatCMP, FloatCVT */
static double fpmult_div_power_cc2[MAX_SLOTS] = { 0 };	/* FP-MULT/DIV, floating point multiplier/divider, ICT: FloatMULT, FloatDIV, 
 														 FloatSQRT */
static double divmult_power_cc2[MAX_SLOTS] = { 0 };			/* DIV/MULT, divider/multiplier, ICT: IntALU, FloatADD, FloatCMP, FloatCVT, 
 														 IntMULT, IntDIV, FloatMULT, FloatDIV, FloatSQRT */
static double homo_power_cc2[MAX_SLOTS] = { 0 };				

/* PowerSMT Added */

static double resultbus_power_cc2[MAX_SLOTS] = { 0 };
static double clock_power_cc2[MAX_SLOTS] = { 0 };

static double rename_power_cc3[MAX_SLOTS] = { 0 };
static double bpred_power_cc3[MAX_SLOTS] = { 0 };
static double window_power_cc3[MAX_SLOTS] = { 0 };
static double lsq_power_cc3[MAX_SLOTS] = { 0 };
static double regfile_power_cc3[MAX_SLOTS] = { 0 };
static double icache_power_cc3[MAX_SLOTS] = { 0 };
static double dcache_power_cc3[MAX_SLOTS] = { 0 };
static double dcache2_power_cc3[MAX_SLOTS] = { 0 };

/* PowerSMT Added */
// static double alu_power_cc3[MAX_SLOTS] = { 0 };
static double ialu_power_cc3[MAX_SLOTS] = { 0 };				/* integer-ALU, instructions classes treated (ICT): IntALU */
static double imult_div_power_cc3[MAX_SLOTS] = { 0 };		/* integer-MULT/DIV, integer multiplier/divider, ICT: IntMULT, IntDIV */
static double mem_port_power_cc3[MAX_SLOTS] = { 0 };		/* memory-port, ICT: RdPort, WrPort */
static double fpalu_power_cc3[MAX_SLOTS] = { 0 };				/* FP-ALU, floating point adder/subtractor, ITC: FloatADD, FloatCMP, FloatCVT */
static double fpmult_div_power_cc3[MAX_SLOTS] = { 0 };	/* FP-MULT/DIV, floating point multiplier/divider, ICT: FloatMULT, FloatDIV, 
 														 FloatSQRT */
static double divmult_power_cc3[MAX_SLOTS] = { 0 };			/* DIV/MULT, divider/multiplier, ICT: IntALU, FloatADD, FloatCMP, FloatCVT, 
 														 IntMULT, IntDIV, FloatMULT, FloatDIV, FloatSQRT */
static double homo_power_cc3[MAX_SLOTS] = { 0 };				

/* PowerSMT Added */

static double resultbus_power_cc3[MAX_SLOTS] = { 0 };
static double clock_power_cc3[MAX_SLOTS] = { 0 };

static double total_cycle_power[MAX_SLOTS] = { 0 };
static double total_cycle_power_cc1[MAX_SLOTS] = { 0 };
static double total_cycle_power_cc2[MAX_SLOTS] = { 0 };
static double total_cycle_power_cc3[MAX_SLOTS] = { 0 };

static double last_single_total_cycle_power_cc1[MAX_SLOTS] = { 0 };
static double last_single_total_cycle_power_cc2[MAX_SLOTS] = { 0 };
static double last_single_total_cycle_power_cc3[MAX_SLOTS] = { 0 };
static double current_total_cycle_power_cc1[MAX_SLOTS] = { 0 };
static double current_total_cycle_power_cc2[MAX_SLOTS] = { 0 };
static double current_total_cycle_power_cc3[MAX_SLOTS] = { 0 };

static double max_cycle_power_cc1[MAX_SLOTS] = { 0 };
static double max_cycle_power_cc2[MAX_SLOTS] = { 0 };
static double max_cycle_power_cc3[MAX_SLOTS] = { 0 };

extern counter_t rename_access[MAX_SLOTS];
extern counter_t bpred_access[MAX_SLOTS];
extern counter_t window_access[MAX_SLOTS];
extern counter_t lsq_access[MAX_SLOTS];
extern counter_t regfile_access[MAX_SLOTS];
extern counter_t icache_access[MAX_SLOTS];
extern counter_t dcache_access[MAX_SLOTS];
extern counter_t dcache2_access[MAX_SLOTS];

/* PowerSMT Added */
// extern counter_t alu_access[MAX_SLOTS];
// extern counter_t ialu_access[MAX_SLOTS];
// extern counter_t falu_access[MAX_SLOTS];
extern counter_t fus_num_access[MAX_SLOTS];
extern counter_t fus_access[MAX_SLOTS][NUM_FU_CLASSES];
/* PowerSMT Added */

extern counter_t resultbus_access[MAX_SLOTS];

extern counter_t window_selection_access[MAX_SLOTS];
extern counter_t window_wakeup_access[MAX_SLOTS];
extern counter_t window_preg_access[MAX_SLOTS];
extern counter_t lsq_preg_access[MAX_SLOTS];
extern counter_t lsq_wakeup_access[MAX_SLOTS];
extern counter_t lsq_store_data_access[MAX_SLOTS];
extern counter_t lsq_load_data_access[MAX_SLOTS];

extern counter_t window_total_pop_count_cycle[MAX_SLOTS];
extern counter_t window_num_pop_count_cycle[MAX_SLOTS];
extern counter_t lsq_total_pop_count_cycle[MAX_SLOTS];
extern counter_t lsq_num_pop_count_cycle[MAX_SLOTS];
extern counter_t regfile_total_pop_count_cycle[MAX_SLOTS];
extern counter_t regfile_num_pop_count_cycle[MAX_SLOTS];
extern counter_t resultbus_total_pop_count_cycle[MAX_SLOTS];
extern counter_t resultbus_num_pop_count_cycle[MAX_SLOTS];

static counter_t total_rename_access[MAX_SLOTS] = { 0 };
static counter_t total_bpred_access[MAX_SLOTS] = { 0 };
static counter_t total_window_access[MAX_SLOTS] = { 0 };
static counter_t total_lsq_access[MAX_SLOTS] = { 0 };
static counter_t total_regfile_access[MAX_SLOTS] = { 0 };
static counter_t total_icache_access[MAX_SLOTS] = { 0 };
static counter_t total_dcache_access[MAX_SLOTS] = { 0 };
static counter_t total_dcache2_access[MAX_SLOTS] = { 0 };

/* PowerSMT Added */
// static counter_t total_alu_access[MAX_SLOTS] = { 0 };
static counter_t total_fus_access[MAX_SLOTS] = { 0 };
/* PowerSMT Added */

static counter_t total_resultbus_access[MAX_SLOTS] = { 0 };

static counter_t max_rename_access[MAX_SLOTS] = { 0 };
static counter_t max_bpred_access[MAX_SLOTS] = { 0 };
static counter_t max_window_access[MAX_SLOTS] = { 0 };
static counter_t max_lsq_access[MAX_SLOTS] = { 0 };
static counter_t max_regfile_access[MAX_SLOTS] = { 0 };
static counter_t max_icache_access[MAX_SLOTS] = { 0 };
static counter_t max_dcache_access[MAX_SLOTS] = { 0 };
static counter_t max_dcache2_access[MAX_SLOTS] = { 0 };

/* PowerSMT Added */
// static counter_t max_alu_access[MAX_SLOTS] = { 0 };
static counter_t max_fus_access[MAX_SLOTS] = { 0 };
/* PowerSMT Added */

static counter_t max_resultbus_access[MAX_SLOTS] = { 0 };


extern int process_num;


/* Initialize all variables of wattch model */
void init_all_variables_power_model()
{
	int sn; /* slot's number */
	
	for (sn=0; sn<process_num; sn++) {
		/* Initialize all power variables */
		init_power_variables(sn);
		/* Initialize access stats */
		// clear_access_stats(sn);
	}
}

/*
 * Initialize the power variables to one process instance.
 * */
void init_power_variables(int sn)
{
	rename_power[sn] = 0.0;
	bpred_power[sn] = 0.0;
	window_power[sn] = 0.0;
	lsq_power[sn] = 0.0;
	regfile_power[sn] = 0.0;
	icache_power[sn] = 0.0;
	dcache_power[sn] = 0.0;
	dcache2_power[sn] = 0.0;
	/* PowerSMT Added */
	// alu_power[sn] = 0.0;
	// falu_power[sn] = 0.0;
	ialu_power[sn] = 0.0;
	imult_div_power[sn] = 0.0; 
	mem_port_power[sn] = 0.0;
	fpalu_power[sn] = 0.0;
	fpmult_div_power[sn] = 0.0;  
	divmult_power[sn] = 0.0; 
	homo_power[sn] = 0.0;
	/* PowerSMT Added */
	
	resultbus_power[sn] = 0.0;
	clock_power[sn] = 0.0;
	
	rename_power_cc1[sn] = 0.0;
	bpred_power_cc1[sn] = 0.0;
	window_power_cc1[sn] = 0.0;
	lsq_power_cc1[sn] = 0.0;
	regfile_power_cc1[sn] = 0.0;
	icache_power_cc1[sn] = 0.0;
	dcache_power_cc1[sn] = 0.0;
	dcache2_power_cc1[sn] = 0.0;
	/* PowerSMT Added */
	// alu_power_cc1[sn] = 0.0;
	ialu_power_cc1[sn] = 0.0;
	imult_div_power_cc1[sn] = 0.0; 
	mem_port_power_cc1[sn] = 0.0;
	fpalu_power_cc1[sn] = 0.0;
	fpmult_div_power_cc1[sn] = 0.0;  
	divmult_power_cc1[sn] = 0.0; 
	homo_power_cc1[sn] = 0.0;
	/* PowerSMT Added */
	resultbus_power_cc1[sn] = 0.0;
	clock_power_cc1[sn] = 0.0;
	
	rename_power_cc2[sn] = 0.0;
	bpred_power_cc2[sn] = 0.0;
	window_power_cc2[sn] = 0.0;
	lsq_power_cc2[sn] = 0.0;
	regfile_power_cc2[sn] = 0.0;
	icache_power_cc2[sn] = 0.0;
	dcache_power_cc2[sn] = 0.0;
	dcache2_power_cc2[sn] = 0.0;
	/* PowerSMT Added */
	// alu_power_cc2[sn] = 0.0;
	ialu_power_cc2[sn] = 0.0;
	imult_div_power_cc2[sn] = 0.0; 
	mem_port_power_cc2[sn] = 0.0;
	fpalu_power_cc2[sn] = 0.0;
	fpmult_div_power_cc2[sn] = 0.0;  
	divmult_power_cc2[sn] = 0.0; 
	homo_power_cc2[sn] = 0.0;
	/* PowerSMT Added */
	resultbus_power_cc2[sn] = 0.0;
	clock_power_cc2[sn] = 0.0;
	
	rename_power_cc3[sn] = 0.0;
	bpred_power_cc3[sn] = 0.0;
	window_power_cc3[sn] = 0.0;
	lsq_power_cc3[sn] = 0.0;
	regfile_power_cc3[sn] = 0.0;
	icache_power_cc3[sn] = 0.0;
	dcache_power_cc3[sn] = 0.0;
	dcache2_power_cc3[sn] = 0.0;
	/* PowerSMT Added */
	// alu_power_cc3[sn] = 0.0;
	ialu_power_cc3[sn] = 0.0;
	imult_div_power_cc3[sn] = 0.0; 
	mem_port_power_cc3[sn] = 0.0;
	fpalu_power_cc3[sn] = 0.0;
	fpmult_div_power_cc3[sn] = 0.0;  
	divmult_power_cc3[sn] = 0.0; 
	homo_power_cc3[sn] = 0.0;
	/* PowerSMT Added */
	resultbus_power_cc3[sn] = 0.0;
	clock_power_cc3[sn] = 0.0;
	
	total_cycle_power[sn] = 0.0;
	total_cycle_power_cc1[sn] = 0.0;
	total_cycle_power_cc2[sn] = 0.0;
	total_cycle_power_cc3[sn] = 0.0;
	
	last_single_total_cycle_power_cc1[sn] = 0.0;
	last_single_total_cycle_power_cc2[sn] = 0.0;
	last_single_total_cycle_power_cc3[sn] = 0.0;
	current_total_cycle_power_cc1[sn] = 0.0;
	current_total_cycle_power_cc2[sn] = 0.0;
	current_total_cycle_power_cc3[sn] = 0.0;
	
	max_cycle_power_cc1[sn] = 0.0;
	max_cycle_power_cc2[sn] = 0.0;
	max_cycle_power_cc3[sn] = 0.0;
	
}

void clear_access_stats(int sn)
{
	int fuc; /* functional unit class according enum md_fu_class*/
	
	rename_access[sn] = 0;
	bpred_access[sn] = 0;
	window_access[sn] = 0;
	lsq_access[sn] = 0;
	regfile_access[sn] = 0;
	icache_access[sn] = 0;
	dcache_access[sn] = 0;
	dcache2_access[sn] = 0;
	
	/* PowerSMT Added */
	// alu_access[sn] = 0;
	// ialu_access[sn] = 0;
	// falu_access[sn] = 0;
	fus_num_access[sn] = 0;
	for (fuc=0; fuc<NUM_FU_CLASSES; fuc++) {
			fus_access[sn][fuc] = 0;			
	}
	
	/* PowerSMT Added */
	
	resultbus_access[sn] = 0;
	
	window_preg_access[sn] = 0;
	window_selection_access[sn] = 0;
	window_wakeup_access[sn] = 0;
	lsq_store_data_access[sn] = 0;
	lsq_load_data_access[sn] = 0;
	lsq_wakeup_access[sn] = 0;
	lsq_preg_access[sn] = 0;
	
	window_total_pop_count_cycle[sn] = 0;
	window_num_pop_count_cycle[sn] = 0;
	
	lsq_total_pop_count_cycle[sn] = 0;
	lsq_num_pop_count_cycle[sn] = 0;
	
	regfile_total_pop_count_cycle[sn] = 0;
	regfile_num_pop_count_cycle[sn] = 0;
	
	resultbus_total_pop_count_cycle[sn] = 0;
	resultbus_num_pop_count_cycle[sn] = 0;
}

/* compute bitline activity factors which we use to scale bitline power 
 Here it is very important whether we assume 0's or 1's are
 responsible for dissipating power in pre-charged stuctures. (since
 most of the bits are 0's, we assume the design is power-efficient
 enough to allow 0's to _not_ discharge 
 */
double compute_af(counter_t num_pop_count_cycle, counter_t total_pop_count_cycle, int pop_width) {
	double avg_pop_count;
	double af, af_b;

	if (num_pop_count_cycle)
		avg_pop_count = (double)total_pop_count_cycle / (double)num_pop_count_cycle;
	else
		avg_pop_count = 0;

	af = avg_pop_count / (double)pop_width;

	af_b = 1.0 - af;

	/* printf("af == %f%%, af_b == %f%%, total_pop == %d, num_pop == %d\n",100*af,100*af_b,total_pop_count_cycle,num_pop_count_cycle);*/

	return (af_b);
}

/* compute power statistics on each cycle, for each conditional clocking style.  Obviously
 most of the speed penalty comes here, so if you don't want per-cycle power estimates
 you could post-process 

 See README.wattch for details on the various clock gating styles.

 */
void update_power_stats(int sn, signed long long nrCycle){
	double window_af_b, lsq_af_b, regfile_af_b, resultbus_af_b;
	
	/*fprintf(stdout,"\n");
	fprintf(stdout," |-icache_bank_selector: %g\n", power.icache_bank_selector);
	fprintf(stdout," |-dcache_bank_selector: %g\n", power.dcache_bank_selector);
	fprintf(stdout," |-fetch_ifq_selector: %g\n", power.fetch_ifq_selector);
	fprintf(stdout," |-decode_ruu_selector: %g\n", power.decode_ruu_selector);
	fprintf(stdout," |-issue_ruu_selector: %g\n", power.issue_ruu_selector);		
	fprintf(stdout," |-writeback_ruu_selector: %g\n", power.writeback_ruu_selector);
	fprintf(stdout," |-rob_selector: %g\n", power.rob_selector); 
	fprintf(stdout," |-itlb_selector: %g\n", power.itlb_selector);
	fprintf(stdout," |-dtlb_selector: %g\n", power.dtlb_selector);
	fprintf(stdout," |-btb_selector: %g\n", power.btb_selector);*/
	

#ifdef DYNAMIC_AF
	window_af_b = compute_af(window_num_pop_count_cycle[sn], window_total_pop_count_cycle[sn], data_width);
		
	lsq_af_b = compute_af(lsq_num_pop_count_cycle[sn], lsq_total_pop_count_cycle[sn], data_width);
		
	regfile_af_b = compute_af(regfile_num_pop_count_cycle[sn], regfile_total_pop_count_cycle[sn], data_width);

	resultbus_af_b = compute_af(resultbus_num_pop_count_cycle[sn], resultbus_total_pop_count_cycle[sn], data_width);
#endif
		rename_power[sn] += power.rename_power;
		bpred_power[sn] += power.bpred_power;
		window_power[sn] += power.window_power;
		lsq_power[sn] += power.lsq_power;
		regfile_power[sn] += power.regfile_power;
		/* PowerSMT Added */
		// icache_power[sn] += power.icache_power + power.itlb;
		// dcache_power[sn] += power.dcache_power + power.dtlb;
		icache_power[sn] += power.icache_power + power.itlb + power.icache_bank_selector;
		dcache_power[sn] += power.dcache_power + power.dtlb + power.dcache_bank_selector;
		/* PowerSMT Added */
		dcache2_power[sn] += power.dcache2_power + power.cachel2_bank_selector;
			
		/* PowerSMT Added */
		/* PowerSMT alteration, because variability fu architecture */
		// alu_power[sn] += power.ialu_power + power.falu_power;
		// falu_power[sn] += power.falu_power;
		// First Modification.
		// alu_power[sn] += power.ialu_power + power.falu_power + power.imult_power;
		// falu_power[sn] += power.falu_power + power.divmult_power + power.fpmult_power;
		
		ialu_power[sn] 		+= power.ialu_power; 		/* integer ALU */
		imult_div_power[sn] += power.imult_div_power; 
		mem_port_power[sn] 	+= power.mem_port_power;
		fpalu_power[sn] 	+= power.fpalu_power;
		fpmult_div_power[sn] += power.fpmult_div_power;  
		divmult_power[sn] 	+= power.divmult_power; 
		homo_power[sn] 		+= power.homo_power;
		/* PowerSMT Added */
		
		resultbus_power[sn] += power.resultbus;
		clock_power[sn] += power.clock_power;
		
		total_rename_access[sn] += rename_access[sn];
		total_bpred_access[sn] += bpred_access[sn];
		total_window_access[sn] += window_access[sn];
		total_lsq_access[sn] += lsq_access[sn];
		total_regfile_access[sn] += regfile_access[sn];
		total_icache_access[sn] += icache_access[sn];
		total_dcache_access[sn] += dcache_access[sn];
		total_dcache2_access[sn] += dcache2_access[sn];
		
		/* PowerSMT Added */
		// total_alu_access[sn] += alu_access[sn];
		total_fus_access[sn] += fus_num_access[sn];
		
		/* PowerSMT Added */
		
		total_resultbus_access[sn] += resultbus_access[sn];
		
		max_rename_access[sn] = MAX(rename_access[sn],max_rename_access[sn]);
		max_bpred_access[sn] = MAX(bpred_access[sn],max_bpred_access[sn]);
		max_window_access[sn] = MAX(window_access[sn],max_window_access[sn]);
		max_lsq_access[sn] = MAX(lsq_access[sn],max_lsq_access[sn]);
		max_regfile_access[sn] = MAX(regfile_access[sn],max_regfile_access[sn]);
		max_icache_access[sn] = MAX(icache_access[sn],max_icache_access[sn]);
		max_dcache_access[sn] = MAX(dcache_access[sn],max_dcache_access[sn]);
		max_dcache2_access[sn] = MAX(dcache2_access[sn],max_dcache2_access[sn]);
		/* PowerSMT Added */
		// max_alu_access[sn] = MAX(alu_access[sn],max_alu_access[sn]);
		max_fus_access[sn] = MAX(fus_num_access[sn],max_fus_access[sn]);
		/* PowerSMT Added */
		
		max_resultbus_access[sn] = MAX(resultbus_access[sn],max_resultbus_access[sn]);
		
		if (rename_access[sn]) {
			rename_power_cc1[sn] += power.rename_power;
			rename_power_cc2[sn] += ((double)rename_access[sn]/(double)ruu_decode_width)*power.rename_power;
			rename_power_cc3[sn] += ((double)rename_access[sn]/(double)ruu_decode_width)*power.rename_power;
		} else
			rename_power_cc3[sn] += turnoff_factor * power.rename_power;
		
		if (bpred_access[sn]) {
			if (bpred_access[sn] <= 2)
				bpred_power_cc1[sn] += power.bpred_power;
			else
				bpred_power_cc1[sn] += ((double)bpred_access[sn]/2.0) * power.bpred_power;
				bpred_power_cc2[sn] += ((double)bpred_access[sn]/2.0) * power.bpred_power;
				bpred_power_cc3[sn] += ((double)bpred_access[sn]/2.0) * power.bpred_power;
		} else
			bpred_power_cc3[sn] += turnoff_factor * power.bpred_power;
		
		
	#ifdef STATIC_AF
		if(window_preg_access[sn]) {
			if(window_preg_access[sn] <= 3 * ruu_issue_width)
				window_power_cc1[sn] += power.rs_power;
			else
				window_power_cc1[sn] += ((double)window_preg_access[sn]/(3.0*(double)ruu_issue_width))*power.rs_power;
			
			window_power_cc2[sn] += ((double)window_preg_access[sn]/(3.0*(double)ruu_issue_width))*power.rs_power;
			window_power_cc3[sn] += ((double)window_preg_access[sn]/(3.0*(double)ruu_issue_width))*power.rs_power;
		}
		else
			window_power_cc3[sn] += turnoff_factor * power.rs_power;
	#elif defined(DYNAMIC_AF)
		
		// fprintf(stdout,"window_preg_access: %g\n", window_preg_access[sn]);
		// fprintf(stdout,"power.rs_power_nobit: %g\n", power.rs_power_nobit);
		// fprintf(stdout,"power.rs_bitline: %g\n", power.rs_bitline);
		
		if (window_preg_access[sn]) {
			if (window_preg_access[sn] <= 3 * ruu_issue_width)
				window_power_cc1[sn] += power.rs_power_nobit + window_af_b * power.rs_bitline;
			else
				window_power_cc1[sn] += ((double)window_preg_access[sn]/(3.0*(double)ruu_issue_width))
							*(power.rs_power_nobit + window_af_b*power.rs_bitline);
			
			window_power_cc2[sn] += ((double)window_preg_access[sn]/(3.0*(double)ruu_issue_width))
					*(power.rs_power_nobit + window_af_b*power.rs_bitline);
			window_power_cc3[sn] += ((double)window_preg_access[sn]/(3.0*(double)ruu_issue_width))
					*(power.rs_power_nobit + window_af_b*power.rs_bitline);
		} else
			window_power_cc3[sn] += turnoff_factor * power.rs_power;
	#else
		panic("no AF-style defined\n");
	#endif
		
		// fprintf(stdout,"power.selection: %g\n", power.selection);
		
		if (window_selection_access[sn]) {
			if (window_selection_access[sn] <= ruu_issue_width)
				window_power_cc1[sn] += power.selection + power.issue_ruu_selector;
			else
				window_power_cc1[sn] += ((double)window_selection_access[sn]/((double)ruu_issue_width)) * (power.selection + power.issue_ruu_selector);
			
			window_power_cc2[sn] += ((double)window_selection_access[sn]/((double)ruu_issue_width)) * (power.selection + power.issue_ruu_selector);
			window_power_cc3[sn] += ((double)window_selection_access[sn]/((double)ruu_issue_width)) * (power.selection + power.issue_ruu_selector);
		} else
				window_power_cc3[sn] += turnoff_factor * (power.selection + power.issue_ruu_selector);
			
		// fprintf(stdout,"power.wakeup_power: %g\n", power.wakeup_power);
		
		if (window_wakeup_access[sn]) {
			if (window_wakeup_access[sn] <= ruu_issue_width)
				window_power_cc1[sn] += power.wakeup_power;
			else
				window_power_cc1[sn] += ((double)window_wakeup_access[sn]/((double)ruu_issue_width))*power.wakeup_power;
			
			window_power_cc2[sn] += ((double)window_wakeup_access[sn]/((double)ruu_issue_width))*power.wakeup_power;
			window_power_cc3[sn] += ((double)window_wakeup_access[sn]/((double)ruu_issue_width))*power.wakeup_power;
		} else
			window_power_cc3[sn] += turnoff_factor*power.wakeup_power;
		
		if (lsq_wakeup_access[sn]) {
			if (lsq_wakeup_access[sn] <= res_memport)
				lsq_power_cc1[sn] += power.lsq_wakeup_power;
			else
				lsq_power_cc1[sn] += ((double)lsq_wakeup_access[sn]/((double)res_memport))*power.lsq_wakeup_power;
				lsq_power_cc2[sn] += ((double)lsq_wakeup_access[sn]/((double)res_memport))*power.lsq_wakeup_power;
				lsq_power_cc3[sn] += ((double)lsq_wakeup_access[sn]/((double)res_memport))*power.lsq_wakeup_power;
		} else
				lsq_power_cc3[sn] += turnoff_factor*power.lsq_wakeup_power;
		
		
	#ifdef STATIC_AF
		if(lsq_preg_access[sn]) {
			if(lsq_preg_access[sn] <= res_memport)
				lsq_power_cc1[sn] += power.lsq_rs_power;
			else
				lsq_power_cc1[sn] += ((double)lsq_preg_access[sn]/((double)res_memport))*power.lsq_rs_power;
			
			lsq_power_cc2[sn] += ((double)lsq_preg_access[sn]/((double)res_memport))*power.lsq_rs_power;
			lsq_power_cc3[sn] += ((double)lsq_preg_access[sn]/((double)res_memport))*power.lsq_rs_power;
		}
		else
			lsq_power_cc3[sn] += turnoff_factor*power.lsq_rs_power;
	#else
		if (lsq_preg_access[sn]) {
			if (lsq_preg_access[sn] <= res_memport)
				lsq_power_cc1[sn] += power.lsq_rs_power_nobit + lsq_af_b*power.lsq_rs_bitline;
			else
				lsq_power_cc1[sn] += ((double)lsq_preg_access[sn]/((double)res_memport))
					*(power.lsq_rs_power_nobit + lsq_af_b*power.lsq_rs_bitline);
			lsq_power_cc2[sn] += ((double)lsq_preg_access[sn]/((double)res_memport))
					*(power.lsq_rs_power_nobit + lsq_af_b*power.lsq_rs_bitline);
			lsq_power_cc3[sn] += ((double)lsq_preg_access[sn]/((double)res_memport))
					*(power.lsq_rs_power_nobit + lsq_af_b*power.lsq_rs_bitline);
		} else
			lsq_power_cc3[sn] += turnoff_factor*power.lsq_rs_power;
	#endif
		
		
	#ifdef STATIC_AF
		if(regfile_access[sn]) {
			if(regfile_access[sn] <= (3.0*ruu_commit_width))
				regfile_power_cc1[sn] += power.regfile_power;
			else
				regfile_power_cc1[sn] += ((double)regfile_access[sn]/(3.0*(double)ruu_commit_width))*power.regfile_power;
			
			regfile_power_cc2[sn] += ((double)regfile_access[sn]/(3.0*(double)ruu_commit_width))*power.regfile_power;
			regfile_power_cc3[sn] += ((double)regfile_access[sn]/(3.0*(double)ruu_commit_width))*power.regfile_power;
		}
		else
			regfile_power_cc3[sn] += turnoff_factor*power.regfile_power;
	#else
		if (regfile_access[sn]) {
			if (regfile_access[sn] <= (3.0*ruu_commit_width))
				regfile_power_cc1[sn] += power.regfile_power_nobit + regfile_af_b *power.regfile_bitline;
			else
				regfile_power_cc1[sn]	+= ((double)regfile_access[sn]/(3.0*(double)ruu_commit_width)) 
					* (power.regfile_power_nobit + regfile_af_b*power.regfile_bitline);
			
			regfile_power_cc2[sn] += ((double)regfile_access[sn]/(3.0*(double)ruu_commit_width))
					*(power.regfile_power_nobit + regfile_af_b*power.regfile_bitline);
			regfile_power_cc3[sn] += ((double)regfile_access[sn]/(3.0*(double)ruu_commit_width))
					*(power.regfile_power_nobit + regfile_af_b*power.regfile_bitline);
		} else
			regfile_power_cc3[sn] += turnoff_factor*power.regfile_power;
	#endif
		
		if (icache_access[sn]) {
			/* don't scale icache because we assume 1 line is fetched, unless fetch stalls */
			icache_power_cc1[sn] += power.icache_power + power.itlb + power.icache_bank_selector;
			icache_power_cc2[sn] += power.icache_power + power.itlb + power.icache_bank_selector;
			icache_power_cc3[sn] += power.icache_power + power.itlb + power.icache_bank_selector;
		} else
			icache_power_cc3[sn] += turnoff_factor*(power.icache_power + power.itlb + power.icache_bank_selector);
		
		if (dcache_access[sn]) {
			if (dcache_access[sn] <= res_memport)
				dcache_power_cc1[sn] += power.dcache_power + power.dtlb + power.dcache_bank_selector;
			else 
				dcache_power_cc1[sn] += ((double)dcache_access[sn]/(double)res_memport)
						*(power.dcache_power + power.dtlb + power.dcache_bank_selector);
				dcache_power_cc2[sn] += ((double)dcache_access[sn]/(double)res_memport)
						*(power.dcache_power + power.dtlb + power.dcache_bank_selector);
				dcache_power_cc3[sn] += ((double)dcache_access[sn]/(double)res_memport)
						*(power.dcache_power + power.dtlb + power.dcache_bank_selector);
		} else
				dcache_power_cc3[sn] += turnoff_factor*(power.dcache_power + power.dtlb + power.dcache_bank_selector);
		
		if (dcache2_access[sn]) {
			if (dcache2_access[sn] <= res_memport)
				dcache2_power_cc1[sn] += power.dcache2_power + power.cachel2_bank_selector;
			else
				dcache2_power_cc1[sn] += ((double)dcache2_access[sn]/(double)res_memport)
						* (power.dcache2_power + power.cachel2_bank_selector );
			
			dcache2_power_cc2[sn] += ((double)dcache2_access[sn]/(double)res_memport)
						* (power.dcache2_power + power.cachel2_bank_selector);
			dcache2_power_cc3[sn] += ((double)dcache2_access[sn]/(double)res_memport)
						* (power.dcache2_power + power.cachel2_bank_selector);
		} else
			dcache2_power_cc3[sn] += turnoff_factor * (power.dcache2_power + power.cachel2_bank_selector);
		
		/* PowerSMT Added */
		/*if (alu_access[sn]) {
			if (ialu_access[sn])
				alu_power_cc1[sn] += power.ialu_power;
			else
				alu_power_cc3[sn] += turnoff_factor*power.ialu_power;
			
			if (falu_access[sn])
				alu_power_cc1[sn] += power.falu_power;
			else
				alu_power_cc3[sn] += turnoff_factor*power.falu_power;
			
			alu_power_cc2[sn] += ((double)ialu_access[sn]/(double)res_ialu)*power.ialu_power+((double)falu_access[sn]/(double)res_fpalu)*power.falu_power;
			alu_power_cc3[sn] += ((double)ialu_access[sn]/(double)res_ialu)*power.ialu_power+((double)falu_access[sn]/(double)res_fpalu)*power.falu_power;
		} else
				alu_power_cc3[sn] += turnoff_factor*(power.ialu_power + power.falu_power);*/
		
		/* Functional Units */
		if (fus_num_access[sn]) {
			if (fus_access[sn][IntALU])
				ialu_power_cc1[sn] += power.ialu_power;
			else
				ialu_power_cc3[sn] += turnoff_factor*power.ialu_power;
					
			if (fus_access[sn][FloatADD] || fus_access[sn][FloatCMP] || fus_access[sn][FloatCVT])
				fpalu_power_cc1[sn] += power.fpalu_power;
			else
				fpalu_power_cc3[sn] += turnoff_factor*power.fpalu_power;
					
			ialu_power_cc2[sn] += ((double)fus_access[sn][IntALU]/(double)res_ialu)*power.ialu_power;
			ialu_power_cc3[sn] += ((double)fus_access[sn][IntALU]/(double)res_ialu)*power.ialu_power;
			
			fpalu_power_cc2[sn] += ((double)(fus_access[sn][FloatADD] + fus_access[sn][FloatCMP] + fus_access[sn][FloatCVT])/(double)res_fpalu)*power.fpalu_power;
			fpalu_power_cc3[sn] += ((double)(fus_access[sn][FloatADD] + fus_access[sn][FloatCMP] + fus_access[sn][FloatCVT])/(double)res_fpalu)*power.fpalu_power;
			
			/* imult_div */
			if (fus_access[sn][IntMULT] || fus_access[sn][IntDIV])
				imult_div_power_cc1[sn] += power.imult_div_power;
			else
				imult_div_power_cc3[sn] += turnoff_factor*power.imult_div_power;
								
			imult_div_power_cc2[sn] += ((double)(fus_access[sn][IntMULT] + fus_access[sn][IntDIV])/(double)res_imult)*power.imult_div_power;
			imult_div_power_cc3[sn] += ((double)(fus_access[sn][IntMULT] + fus_access[sn][IntDIV])/(double)res_imult)*power.imult_div_power;
						
			
			/* mem_port */
			if (fus_access[sn][RdPort] || fus_access[sn][WrPort])
				mem_port_power_cc1[sn] += power.mem_port_power;
			else
				mem_port_power_cc3[sn] += turnoff_factor*power.mem_port_power;
										
			mem_port_power_cc2[sn] += ((double)(fus_access[sn][RdPort] + fus_access[sn][WrPort])/(double)res_imult)*power.mem_port_power;
			mem_port_power_cc3[sn] += ((double)(fus_access[sn][RdPort] + fus_access[sn][WrPort])/(double)res_imult)*power.mem_port_power;
					
			
			/* fpmult_div */  
			if (fus_access[sn][FloatMULT] || fus_access[sn][FloatDIV] || fus_access[sn][FloatSQRT])
				fpmult_div_power_cc1[sn] += power.fpmult_div_power;
			else
				fpmult_div_power_cc3[sn] += turnoff_factor*power.fpmult_div_power;
													
			fpmult_div_power_cc2[sn] += ((double)(fus_access[sn][FloatMULT] + fus_access[sn][FloatDIV] + fus_access[sn][FloatSQRT])/(double)res_memport)*power.fpmult_div_power;
			fpmult_div_power_cc3[sn] += ((double)(fus_access[sn][FloatMULT] + fus_access[sn][FloatDIV] + fus_access[sn][FloatSQRT])/(double)res_memport)*power.fpmult_div_power;		
			
			/* divmult */
			if (fus_access[sn][IntALU] || fus_access[sn][FloatADD] || fus_access[sn][FloatCMP] ||
				fus_access[sn][FloatCVT] || fus_access[sn][IntMULT] || fus_access[sn][IntDIV] ||
				fus_access[sn][FloatMULT] || fus_access[sn][FloatDIV] || fus_access[sn][FloatSQRT])
				
				divmult_power_cc1[sn] += power.divmult_power;
			else
				divmult_power_cc3[sn] += turnoff_factor*power.divmult_power;
													
			divmult_power_cc2[sn] += ((double)(fus_access[sn][IntALU] + fus_access[sn][FloatADD] + fus_access[sn][FloatCMP] + fus_access[sn][FloatCVT] + fus_access[sn][IntMULT] + fus_access[sn][IntDIV] + fus_access[sn][FloatMULT] + fus_access[sn][FloatDIV] + fus_access[sn][FloatSQRT])/(double)res_divmult)*power.divmult_power;
			divmult_power_cc3[sn] += ((double)(fus_access[sn][IntALU] + fus_access[sn][FloatADD] + fus_access[sn][FloatCMP] + fus_access[sn][FloatCVT] + fus_access[sn][IntMULT] + fus_access[sn][IntDIV] + fus_access[sn][FloatMULT] + fus_access[sn][FloatDIV] + fus_access[sn][FloatSQRT])/(double)res_divmult)*power.divmult_power;			
			
			/* homo */	
			if (fus_access[sn][IntALU] || fus_access[sn][FloatADD] || fus_access[sn][FloatCMP] ||
				fus_access[sn][FloatCVT] || fus_access[sn][IntMULT] || fus_access[sn][IntDIV] ||
				fus_access[sn][FloatMULT] || fus_access[sn][FloatDIV] || fus_access[sn][FloatSQRT] ||
				fus_access[sn][RdPort] || fus_access[sn][WrPort])
				
				homo_power_cc1[sn] += power.homo_power;
			else
				homo_power_cc3[sn] += turnoff_factor*power.homo_power;
													
			homo_power_cc2[sn] += ((double)(fus_access[sn][FloatMULT] + fus_access[sn][FloatDIV] + fus_access[sn][FloatSQRT] + fus_access[sn][RdPort] + fus_access[sn][WrPort])/(double)res_homo)*power.homo_power;
			homo_power_cc3[sn] += ((double)(fus_access[sn][FloatMULT] + fus_access[sn][FloatDIV] + fus_access[sn][FloatSQRT] + fus_access[sn][RdPort] + fus_access[sn][WrPort])/(double)res_homo)*power.homo_power;			
			
		} else{
			ialu_power_cc3[sn] += turnoff_factor*(power.ialu_power);
			fpalu_power_cc3[sn] += turnoff_factor*(power.fpalu_power);
			
			imult_div_power_cc3[sn] += turnoff_factor*(power.imult_div_power);
			mem_port_power_cc3[sn] += turnoff_factor*(power.mem_port_power);
			fpmult_div_power_cc3[sn] += turnoff_factor*(power.fpmult_div_power);
			divmult_power_cc3[sn] += turnoff_factor*(power.divmult_power);
			homo_power_cc3[sn] += turnoff_factor*(power.homo_power);
		}
		
		/* PowerSMT Added */
		
		
	#ifdef STATIC_AF
		if(resultbus_access[sn]) {
			assert(ruu_issue_width != 0);
			if(resultbus_access[sn] <= ruu_issue_width) {
				resultbus_power_cc1[sn] += power.resultbus;
			}
			else {
				resultbus_power_cc1[sn] += ((double)resultbus_access[sn]/(double)ruu_issue_width)*power.resultbus;
			}
			resultbus_power_cc2[sn] += ((double)resultbus_access[sn]/(double)ruu_issue_width)*power.resultbus;
			resultbus_power_cc3[sn] += ((double)resultbus_access[sn]/(double)ruu_issue_width)*power.resultbus;
		}
		else
			resultbus_power_cc3[sn] += turnoff_factor*power.resultbus;
	#else
		if (resultbus_access[sn]) {
			assert(ruu_issue_width != 0);
			if (resultbus_access[sn] <= ruu_issue_width) {
				resultbus_power_cc1[sn] += resultbus_af_b*power.resultbus;
			} else {
				resultbus_power_cc1[sn] += ((double)resultbus_access[sn]/(double)ruu_issue_width)
						* resultbus_af_b * power.resultbus;
			}
			resultbus_power_cc2[sn] += ((double)resultbus_access[sn]/(double)ruu_issue_width)
					* resultbus_af_b * power.resultbus;
			resultbus_power_cc3[sn] += ((double)resultbus_access[sn]/(double)ruu_issue_width)
					* resultbus_af_b * power.resultbus;
		} else
			resultbus_power_cc3[sn] += turnoff_factor*power.resultbus;
	#endif
		
		total_cycle_power[sn] = rename_power[sn] + bpred_power[sn] + window_power[sn] +lsq_power[sn] + 
								regfile_power[sn] + icache_power[sn] + dcache_power[sn] + ialu_power[sn] + 
								imult_div_power[sn] + mem_port_power[sn] + fpalu_power[sn] + fpmult_div_power[sn] + 
								homo_power[sn] + divmult_power[sn] + resultbus_power[sn];
		
		total_cycle_power_cc1[sn] = rename_power_cc1[sn] + bpred_power_cc1[sn] + window_power_cc1[sn] + 
								lsq_power_cc1[sn] + regfile_power_cc1[sn] + icache_power_cc1[sn] + 
		            dcache_power_cc1[sn] + ialu_power_cc1[sn] + imult_div_power_cc1[sn] + 
		            mem_port_power_cc1[sn] + fpalu_power_cc1[sn] + fpmult_div_power_cc1[sn] + 
		            homo_power_cc1[sn] + divmult_power_cc1[sn] + resultbus_power_cc1[sn];
		
		total_cycle_power_cc2[sn] = rename_power_cc2[sn] + bpred_power_cc2[sn] + window_power_cc2[sn] +
								lsq_power_cc2[sn] + regfile_power_cc2[sn] + icache_power_cc2[sn] + 
								dcache_power_cc2[sn] + ialu_power_cc2[sn] + imult_div_power_cc2[sn] + 
		            mem_port_power_cc2[sn] + fpalu_power_cc2[sn] + fpmult_div_power_cc2[sn] + 
		            homo_power_cc2[sn] + divmult_power_cc2[sn] + resultbus_power_cc2[sn];
		
		total_cycle_power_cc3[sn] = rename_power_cc3[sn] + bpred_power_cc3[sn] + window_power_cc3[sn] + 
								lsq_power_cc3[sn] + regfile_power_cc3[sn] + icache_power_cc3[sn] + 
								dcache_power_cc3[sn] + ialu_power_cc3[sn] + imult_div_power_cc3[sn] + 
		            mem_port_power_cc3[sn] + fpalu_power_cc3[sn] + fpmult_div_power_cc3[sn] + 
		            homo_power_cc3[sn] + divmult_power_cc3[sn] + resultbus_power_cc3[sn];
		
		clock_power_cc1[sn] += power.clock_power*(total_cycle_power_cc1[sn]/total_cycle_power[sn]);
		clock_power_cc2[sn] += power.clock_power*(total_cycle_power_cc2[sn]/total_cycle_power[sn]);
		clock_power_cc3[sn] += power.clock_power*(total_cycle_power_cc3[sn]/total_cycle_power[sn]);
		
		total_cycle_power_cc1[sn] += clock_power_cc1[sn];
		total_cycle_power_cc2[sn] += clock_power_cc2[sn];
		total_cycle_power_cc3[sn] +=  clock_power_cc3[sn];
		
		current_total_cycle_power_cc1[sn] = total_cycle_power_cc1[sn] - last_single_total_cycle_power_cc1[sn];
		current_total_cycle_power_cc2[sn] = total_cycle_power_cc2[sn] - last_single_total_cycle_power_cc2[sn];
		current_total_cycle_power_cc3[sn] = total_cycle_power_cc3[sn] - last_single_total_cycle_power_cc3[sn];
		
		max_cycle_power_cc1[sn] = MAX(max_cycle_power_cc1[sn], current_total_cycle_power_cc1[sn]);
		max_cycle_power_cc2[sn] = MAX(max_cycle_power_cc2[sn], current_total_cycle_power_cc2[sn]);
		max_cycle_power_cc3[sn] = MAX(max_cycle_power_cc3[sn], current_total_cycle_power_cc3[sn]);
		
		last_single_total_cycle_power_cc1[sn] = total_cycle_power_cc1[sn];
		last_single_total_cycle_power_cc2[sn] = total_cycle_power_cc2[sn];
		last_single_total_cycle_power_cc3[sn] = total_cycle_power_cc3[sn];
		
		/*if(nrCycle % 1000000 == 0){
			fprintf(stdout,"alu_power_cc1: %f\n", alu_power_cc1[sn]);
			fprintf(stdout,"alu_power_cc2: %f\n", alu_power_cc2[sn]);
			fprintf(stdout,"alu_power_cc3: %f\n", alu_power_cc3[sn]);
			
			fprintf(stdout,"bpred_power_cc1: %f\n", bpred_power_cc1[sn]);
			fprintf(stdout,"bpred_power_cc2: %f\n", bpred_power_cc2[sn]);
			fprintf(stdout,"bpred_power_cc3: %f\n", bpred_power_cc3[sn]);
			
			fprintf(stdout,"clock_power_cc1: %f\n", clock_power_cc1[sn]);
			fprintf(stdout,"clock_power_cc2: %f\n", clock_power_cc2[sn]);
			fprintf(stdout,"clock_power_cc3: %f\n", clock_power_cc3[sn]);
			
			fprintf(stdout,"dcache2_power_cc1: %f\n", dcache2_power_cc1[sn]);
			fprintf(stdout,"dcache2_power_cc2: %f\n", dcache2_power_cc2[sn]);
			fprintf(stdout,"dcache2_power_cc3: %f\n", dcache2_power_cc3[sn]);
			
			fprintf(stdout,"dcache_power_cc1: %f\n", dcache_power_cc1[sn]);
			fprintf(stdout,"dcache_power_cc2: %f\n", dcache_power_cc2[sn]);
			fprintf(stdout,"dcache_power_cc3: %f\n", dcache_power_cc3[sn]);
			
			fprintf(stdout,"icache_power_cc1: %f\n", icache_power_cc1[sn]);
			fprintf(stdout,"icache_power_cc2: %f\n", icache_power_cc2[sn]);
			fprintf(stdout,"icache_power_cc3: %f\n", icache_power_cc3[sn]);
			
			fprintf(stdout,"lsq_power_cc1: %f\n", lsq_power_cc1[sn]);
			fprintf(stdout,"lsq_power_cc2: %f\n", lsq_power_cc2[sn]);
			fprintf(stdout,"lsq_power_cc3: %f\n", lsq_power_cc3[sn]);
			
			fprintf(stdout,"max_cycle_power_cc1: %f\n", max_cycle_power_cc1[sn]);
			fprintf(stdout,"max_cycle_power_cc2: %f\n", max_cycle_power_cc2[sn]);
			fprintf(stdout,"max_cycle_power_cc3: %f\n", max_cycle_power_cc3[sn]);
			
			fprintf(stdout,"regfile_power_cc1: %f\n", regfile_power_cc1[sn]);
			fprintf(stdout,"regfile_power_cc2: %f\n", regfile_power_cc2[sn]);
			fprintf(stdout,"regfile_power_cc3: %f\n", regfile_power_cc3[sn]);
			
			fprintf(stdout,"rename_power_cc1: %f\n", rename_power_cc1[sn]);
			fprintf(stdout,"rename_power_cc2: %f\n", rename_power_cc2[sn]);
			fprintf(stdout,"rename_power_cc3: %f\n", rename_power_cc3[sn]);
			
			fprintf(stdout,"resultbus_power_cc1: %f\n",resultbus_power_cc1[sn]);
			fprintf(stdout,"resultbus_power_cc2: %f\n",resultbus_power_cc2[sn]);
			fprintf(stdout,"resultbus_power_cc3: %f\n",resultbus_power_cc3[sn]);
			
			fprintf(stdout,"window_power_cc1: %f\n", window_power_cc1[sn]);
		  fprintf(stdout,"window_power_cc2: %f\n", window_power_cc2[sn]);
		  fprintf(stdout,"window_power_cc3: %f\n", window_power_cc3[sn]);
		}*/ 
	
}

void power_reg_stats(struct stat_sdb_t *sdb) /* stats database */
{
	char stat_name[64];
	char formula_name[512];
	int sn = 0;
	
	for (sn=0; sn<process_num; sn++) {
	
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "rename_power_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of rename unit", &rename_power[sn], 0, NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "bpred_power_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of bpred unit", &bpred_power[sn], 0, NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "window_power_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of instruction window", &window_power[sn], 0, NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "lsq_power_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of load/store queue", &lsq_power[sn], 0, NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "regfile_power_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of arch. regfile", &regfile_power[sn], 0, NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "icache_power_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of icache", &icache_power[sn], 0, NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "dcache_power_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of dcache", &dcache_power[sn], 0, NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "dcache2_power_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of dcache2", &dcache2_power[sn], 0, NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "ialu_power_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of alu", &ialu_power[sn], 0, NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "imult_div_power_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of imult_div FU", &imult_div_power[sn], 0, NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "mem_port_power_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of memory port FU", &mem_port_power[sn], 0, NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "fpalu_power_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of fpalu", &fpalu_power[sn], 0, NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "fpmult_div_power_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of fpmult_div", &fpmult_div_power[sn], 0, NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "divmult_power_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of divmult", &divmult_power[sn], 0, NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "homo_power_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of homo FU", &homo_power[sn], 0, NULL, sn);
		 
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "resultbus_power_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of resultbus", &resultbus_power[sn], 0, NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "clock_power_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of clock", &clock_power[sn], 0, NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_rename_power_%s", itoa[sn]);
		sprintf(formula_name, "rename_power_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of rename unit", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_bpred_power_%s", itoa[sn]);
		sprintf(formula_name, "bpred_power_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of bpred unit", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_window_power_%s", itoa[sn]);
		sprintf(formula_name, "window_power_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of instruction window", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_lsq_power_%s", itoa[sn]);
		sprintf(formula_name, "lsq_power_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of lsq", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_regfile_power_%s", itoa[sn]);
		sprintf(formula_name, "regfile_power_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of arch. regfile", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_icache_power_%s", itoa[sn]);
		sprintf(formula_name, "icache_power_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of icache", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_dcache_power_%s", itoa[sn]);
		sprintf(formula_name, "dcache_power_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of dcache", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_dcache2_power_%s", itoa[sn]);
		sprintf(formula_name, "dcache2_power_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of dcache2", formula_name, /* format */NULL, sn);
		
		/* PowerSMT Added */
		// bzero(stat_name, sizeof(char) * 64);
		// bzero(formula_name, sizeof(char) * 512);
		// sprintf(stat_name, "avg_alu_power_%s", itoa[sn]);
		// sprintf(formula_name, "alu_power_%s/sim_cycle", itoa[sn]);
		// stat_reg_formula(sdb, stat_name, "avg power usage of ialu", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_ialu_power_%s", itoa[sn]);
		sprintf(formula_name, "ialu_power_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of ialu FU", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_fpalu_power_%s", itoa[sn]);
		sprintf(formula_name, "fpalu_power_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of fpalu FU", formula_name, /* format */NULL, sn);
		
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_imult_div_power_%s", itoa[sn]);
		sprintf(formula_name, "imult_div_power_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of imult_div FU", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_mem_port_power_%s", itoa[sn]);
		sprintf(formula_name, "mem_port_power_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of mem_port FU", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_fpmult_div_power_%s", itoa[sn]);
		sprintf(formula_name, "fpmult_div_power_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of fpmult_div FU", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_divmult_power_%s", itoa[sn]);
		sprintf(formula_name, "divmult_power_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of divmult FU", formula_name, /* format */NULL, sn);
				
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_homo_power_%s", itoa[sn]);
		sprintf(formula_name, "homo_power_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of homo FU", formula_name, /* format */NULL, sn);		
				  
		/* PowerSMT Added */
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_resultbus_power_%s", itoa[sn]);
		sprintf(formula_name, "resultbus_power_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of resultbus", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_clock_power_%s", itoa[sn]);
		sprintf(formula_name, "clock_power_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of clock", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "fetch_stage_power_%s", itoa[sn]);
		sprintf(formula_name, "icache_power_%s + bpred_power_%s", itoa[sn], itoa[sn]);
		stat_reg_formula(sdb, stat_name, "total power usage of fetch stage", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "dispatch_stage_power_%s", itoa[sn]);
		sprintf(formula_name, "rename_power_%s", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "total power usage of dispatch stage", formula_name, /* format */NULL, sn);
		
		/* PowerSMT Added */
		// bzero(stat_name, sizeof(char) * 64);
		// bzero(formula_name, sizeof(char) * 512);
		// sprintf(stat_name, "issue_stage_power_%s", itoa[sn]);
		// sprintf(formula_name, "resultbus_power_%s + alu_power_%s + dcache_power_%s + dcache2_power_%s + window_power_%s + lsq_power_%s", itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn]);
		// stat_reg_formula(sdb, stat_name, "total power usage of issue stage", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "issue_stage_power_%s", itoa[sn]);
		sprintf(formula_name, "resultbus_power_%s + ialu_power_%s + imult_div_power_%s + mem_port_power_%s + fpalu_power_%s + fpmult_div_power_%s + divmult_power_%s + homo_power_%s + dcache_power_%s + dcache2_power_%s + window_power_%s + lsq_power_%s", itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn]);
		stat_reg_formula(sdb, stat_name, "total power usage of issue stage", formula_name, /* format */NULL, sn);
		/* PowerSMT Added */
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_fetch_power_%s", itoa[sn]);
		sprintf(formula_name, "(icache_power_%s + bpred_power_%s)/sim_cycle", itoa[sn], itoa[sn]);
		stat_reg_formula(sdb, stat_name, "average power of fetch unit per cycle", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_dispatch_power_%s", itoa[sn]);
		sprintf(formula_name, "(rename_power_%s)/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "average power of dispatch unit per cycle", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_issue_power_%s", itoa[sn]);
		sprintf(formula_name, "(resultbus_power_%s + ialu_power_%s + imult_div_power_%s + mem_port_power_%s + fpalu_power_%s + fpmult_div_power_%s + divmult_power_%s + homo_power_%s + dcache_power_%s + dcache2_power_%s + window_power_%s + lsq_power_%s)/sim_cycle", itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn]);
		stat_reg_formula(sdb, stat_name, "average power of issue unit per cycle", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "total_power_%s", itoa[sn]);
		sprintf(formula_name, "(rename_power_%s + bpred_power_%s + window_power_%s + lsq_power_%s + regfile_power_%s + icache_power_%s + resultbus_power_%s + clock_power_%s + ialu_power_%s + imult_div_power_%s + mem_port_power_%s + fpalu_power_%s + fpmult_div_power_%s + divmult_power_%s + homo_power_%s + dcache_power_%s + dcache2_power_%s)", itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn]);
		stat_reg_formula(sdb, stat_name, "total power per cycle", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_total_power_cycle_%s", itoa[sn]);
		sprintf(formula_name, "(rename_power_%s + bpred_power_%s + window_power_%s + lsq_power_%s + regfile_power_%s + icache_power_%s + resultbus_power_%s + clock_power_%s + ialu_power_%s + imult_div_power_%s + mem_port_power_%s + fpalu_power_%s + fpmult_div_power_%s + divmult_power_%s + homo_power_%s + dcache_power_%s + dcache2_power_%s)/sim_cycle", itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn]);
		stat_reg_formula(sdb, stat_name, "average total power per cycle", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_total_power_cycle_nofp_nod2_%s", itoa[sn]);
		sprintf(formula_name, "(rename_power_%s + bpred_power_%s + window_power_%s + lsq_power_%s + regfile_power_%s + icache_power_%s + resultbus_power_%s + clock_power_%s + ialu_power_%s + imult_div_power_%s + mem_port_power_%s + dcache_power_%s - fpalu_power_%s - fpmult_div_power_%s - divmult_power_%s - homo_power_%s )/sim_cycle", itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn]);
		stat_reg_formula(sdb, stat_name, "average total power per cycle", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_total_power_insn_%s", itoa[sn]);
		sprintf(formula_name, "(rename_power_%s + bpred_power_%s + window_power_%s + lsq_power_%s + regfile_power_%s + icache_power_%s + resultbus_power_%s + clock_power_%s + ialu_power_%s + imult_div_power_%s + mem_port_power_%s + fpalu_power_%s + fpmult_div_power_%s + divmult_power_%s + homo_power_%s + dcache_power_%s + dcache2_power_%s)/sim_total_insn_%s", itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn]);
		stat_reg_formula(sdb, stat_name, "average total power per insn", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_total_power_insn_nofp_nod2_%s", itoa[sn]);
		sprintf(formula_name, "(rename_power_%s + bpred_power_%s + window_power_%s + lsq_power_%s + regfile_power_%s + icache_power_%s + resultbus_power_%s + clock_power_%s + ialu_power_%s + imult_div_power_%s + mem_port_power_%s + dcache_power_%s - fpalu_power_%s - fpmult_div_power_%s - divmult_power_%s - homo_power_%s )/sim_total_insn_%s", itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn]);
		stat_reg_formula(sdb, stat_name, "average total power per insn", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "rename_power_cc1_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of rename unit_cc1", &rename_power_cc1[sn], 0, NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "bpred_power_cc1_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of bpred unit_cc1", &bpred_power_cc1[sn], 0, NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "window_power_cc1_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of instruction window_cc1", &window_power_cc1[sn], 0, NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "lsq_power_cc1_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of lsq_cc1", &lsq_power_cc1[sn], 0, NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "regfile_power_cc1_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of arch. regfile_cc1", &regfile_power_cc1[sn], 0, NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "icache_power_cc1_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of icache_cc1", &icache_power_cc1[sn], 0, NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "dcache_power_cc1_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of dcache_cc1", &dcache_power_cc1[sn], 0, NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "dcache2_power_cc1_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of dcache2_cc1", &dcache2_power_cc1[sn], 0, NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "ialu_power_cc1_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of alu_cc1", &ialu_power_cc1[sn], 0, NULL, sn);
		
		
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "imult_div_power_cc1_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of imult_div_cc1 FU", &imult_div_power_cc1[sn], 0, NULL, sn);
				
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "mem_port_power_cc1_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of memory-port_cc1 FU", &mem_port_power_cc1[sn], 0, NULL, sn);
				
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "fpalu_power_cc1_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of fpalu_cc1", &fpalu_power_cc1[sn], 0, NULL, sn);
				
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "fpmult_div_power_cc1_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of fpmult_div_cc1", &fpmult_div_power_cc1[sn], 0, NULL, sn);
			
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "divmult_power_cc1_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of divmult_cc1", &divmult_power_cc1[sn], 0, NULL, sn);
				
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "homo_power_cc1_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of homo_cc1 FU", &homo_power_cc1[sn], 0, NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "resultbus_power_cc1_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of resultbus_cc1", &resultbus_power_cc1[sn], 0, NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "clock_power_cc1_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of clock_cc1", &clock_power_cc1[sn], 0, NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_rename_power_cc1_%s", itoa[sn]);
		sprintf(formula_name, "rename_power_cc1_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of rename unit_cc1", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_bpred_power_cc1_%s", itoa[sn]);
		sprintf(formula_name, "bpred_power_cc1_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of bpred unit_cc1", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_window_power_cc1_%s", itoa[sn]);
		sprintf(formula_name, "window_power_cc1_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of instruction window_cc1", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_lsq_power_cc1_%s", itoa[sn]);
		sprintf(formula_name, "lsq_power_cc1_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of lsq_cc1", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_regfile_power_cc1_%s", itoa[sn]);
		sprintf(formula_name, "regfile_power_cc1_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of arch. regfile_cc1", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_icache_power_cc1_%s", itoa[sn]);
		sprintf(formula_name, "icache_power_cc1_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of icache_cc1", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_dcache_power_cc1_%s", itoa[sn]);
		sprintf(formula_name, "dcache_power_cc1_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of dcache_cc1", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_dcache2_power_cc1_%s", itoa[sn]);
		sprintf(formula_name, "dcache2_power_cc1_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of dcache2_cc1", formula_name, /* format */NULL, sn);
	
		/* PowerSMT Added */
		// bzero(stat_name, sizeof(char) * 64);
		// bzero(formula_name, sizeof(char) * 512);
		// sprintf(stat_name, "avg_alu_power_cc1_%s", itoa[sn]);
		// sprintf(formula_name, "alu_power_cc1_%s/sim_cycle", itoa[sn]);
		// stat_reg_formula(sdb, stat_name, "avg power usage of alu_cc1", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_ialu_power_cc1_%s", itoa[sn]);
		sprintf(formula_name, "ialu_power_cc1_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of ialu_cc1", formula_name, /* format */NULL, sn);
				
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_fpalu_power_cc1_%s", itoa[sn]);
		sprintf(formula_name, "fpalu_power_cc1_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of fpalu_cc1 FU", formula_name, /* format */NULL, sn);
				
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_imult_div_power_cc1_%s", itoa[sn]);
		sprintf(formula_name, "imult_div_power_cc1_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of imult_div_cc1 FU", formula_name, /* format */NULL, sn);
						
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_mem_port_power_cc1_%s", itoa[sn]);
		sprintf(formula_name, "mem_port_power_cc1_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of mem_port_cc1 FU", formula_name, /* format */NULL, sn);
						
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_fpmult_div_power_cc1_%s", itoa[sn]);
		sprintf(formula_name, "fpmult_div_power_cc1_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of fpmult_div_cc1 FU", formula_name, /* format */NULL, sn);
						
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_divmult_power_cc1_%s", itoa[sn]);
		sprintf(formula_name, "divmult_power_cc1_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of divmult_cc1 FU", formula_name, /* format */NULL, sn);
								
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_homo_power_cc1_%s", itoa[sn]);
		sprintf(formula_name, "homo_power_cc1_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of homo_cc1 FU", formula_name, /* format */NULL, sn);		
		/* PowerSMT Added */		
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_resultbus_power_cc1_%s", itoa[sn]);
		sprintf(formula_name, "resultbus_power_cc1_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of resultbus_cc1", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_clock_power_cc1_%s", itoa[sn]);
		sprintf(formula_name, "clock_power_cc1_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of clock_cc1", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "fetch_stage_power_cc1_%s", itoa[sn]);
		sprintf(formula_name, "icache_power_cc1_%s + bpred_power_cc1_%s", itoa[sn], itoa[sn]);
		stat_reg_formula(sdb, stat_name, "total power usage of fetch stage_cc1", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "dispatch_stage_power_cc1_%s", itoa[sn]);
		sprintf(formula_name, "rename_power_cc1_%s", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "total power usage of dispatch stage_cc1", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "issue_stage_power_cc1_%s", itoa[sn]);
		sprintf(formula_name, "resultbus_power_cc1_%s + ialu_power_cc1_%s + imult_div_power_cc1_%s + mem_port_power_cc1_%s + fpalu_power_cc1_%s + fpmult_div_power_cc1_%s + divmult_power_cc1_%s + homo_power_cc1_%s + dcache_power_cc1_%s + dcache2_power_cc1_%s + lsq_power_cc1_%s + window_power_cc1_%s", itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn]);
		stat_reg_formula(sdb, stat_name, "total power usage of issue stage_cc1", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_fetch_power_cc1_%s", itoa[sn]);
		sprintf(formula_name, "(icache_power_cc1_%s + bpred_power_cc1_%s)/sim_cycle", itoa[sn], itoa[sn]);
		stat_reg_formula(sdb, stat_name, "average power of fetch unit per cycle_cc1", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_dispatch_power_cc1_%s", itoa[sn]);
		sprintf(formula_name, "(rename_power_cc1_%s)/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "average power of dispatch unit per cycle_cc1", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_issue_power_cc1_%s", itoa[sn]);
		sprintf(formula_name, "(resultbus_power_cc1_%s + ialu_power_%s + imult_div_power_%s + mem_port_power_%s + fpalu_power_%s + fpmult_div_power_%s + divmult_power_%s + homo_power_%s + dcache_power_cc1_%s + dcache2_power_cc1_%s + lsq_power_cc1_%s + window_power_cc1_%s)/sim_cycle", itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn]);
		stat_reg_formula(sdb, stat_name, "average power of issue unit per cycle_cc1", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "total_power_cycle_cc1_%s", itoa[sn]);
		sprintf(formula_name, "(rename_power_cc1_%s + bpred_power_cc1_%s + lsq_power_cc1_%s + window_power_cc1_%s + regfile_power_cc1_%s + icache_power_cc1_%s + resultbus_power_cc1_%s + clock_power_cc1_%s + ialu_power_%s + imult_div_power_%s + mem_port_power_%s + fpalu_power_%s + fpmult_div_power_%s + divmult_power_%s + homo_power_%s + dcache_power_cc1_%s + dcache2_power_cc1_%s)", itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn]);
		stat_reg_formula(sdb, stat_name, "total power per cycle_cc1", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_total_power_cycle_cc1_%s", itoa[sn]);
		sprintf(formula_name, "(rename_power_cc1_%s + bpred_power_cc1_%s + lsq_power_cc1_%s + window_power_cc1_%s + regfile_power_cc1_%s + icache_power_cc1_%s + resultbus_power_cc1_%s + clock_power_cc1_%s + ialu_power_%s + imult_div_power_%s + mem_port_power_%s + fpalu_power_%s + fpmult_div_power_%s + divmult_power_%s + homo_power_%s + dcache_power_cc1_%s + dcache2_power_cc1_%s)/sim_cycle", itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn]);
		stat_reg_formula(sdb, stat_name, "average total power per cycle_cc1", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_total_power_insn_cc1_%s", itoa[sn]);
		sprintf(formula_name, "(rename_power_cc1_%s + bpred_power_cc1_%s + lsq_power_cc1_%s + window_power_cc1_%s + regfile_power_cc1_%s + icache_power_cc1_%s + resultbus_power_cc1_%s + clock_power_cc1_%s + ialu_power_%s + imult_div_power_%s + mem_port_power_%s + fpalu_power_%s + fpmult_div_power_%s + divmult_power_%s + homo_power_%s + dcache_power_cc1_%s + dcache2_power_cc1_%s)/sim_total_insn_%s", itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn]);
		stat_reg_formula(sdb, stat_name, "average total power per insn_cc1", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "rename_power_cc2_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of rename unit_cc2", &rename_power_cc2[sn], 0, NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "bpred_power_cc2_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of bpred unit_cc2", &bpred_power_cc2[sn], 0, NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "window_power_cc2_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of instruction window_cc2", &window_power_cc2[sn], 0, NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "lsq_power_cc2_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of lsq_cc2", &lsq_power_cc2[sn], 0, NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "regfile_power_cc2_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of arch. regfile_cc2", &regfile_power_cc2[sn], 0, NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "icache_power_cc2_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of icache_cc2", &icache_power_cc2[sn], 0, NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "dcache_power_cc2_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of dcache_cc2", &dcache_power_cc2[sn], 0, NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "dcache2_power_cc2_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of dcache2_cc2", &dcache2_power_cc2[sn], 0, NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "ialu_power_cc2_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of alu_cc2", &ialu_power_cc2[sn], 0, NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "imult_div_power_cc2_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of imult_div_cc2 FU", &imult_div_power_cc2[sn], 0, NULL, sn);
					
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "mem_port_power_cc2_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of memory-port_cc2 FU", &mem_port_power_cc2[sn], 0, NULL, sn);
						
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "fpalu_power_cc2_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of fpalu_cc2", &fpalu_power_cc2[sn], 0, NULL, sn);
						
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "fpmult_div_power_cc2_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of fpmult_div_cc2", &fpmult_div_power_cc2[sn], 0, NULL, sn);
					
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "divmult_power_cc2_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of divmult_cc2", &divmult_power_cc2[sn], 0, NULL, sn);
					
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "homo_power_cc2_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of homo_cc2 FU", &homo_power_cc2[sn], 0, NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "resultbus_power_cc2_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of resultbus_cc2", &resultbus_power_cc2[sn], 0, NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "clock_power_cc2_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of clock_cc2", &clock_power_cc2[sn], 0, NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_rename_power_cc2_%s", itoa[sn]);
		sprintf(formula_name, "rename_power_cc2_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of rename unit_cc2", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_bpred_power_cc2_%s", itoa[sn]);
		sprintf(formula_name, "bpred_power_cc2_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of bpred unit_cc2", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_window_power_cc2_%s", itoa[sn]);
		sprintf(formula_name, "window_power_cc2_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of instruction window_cc2", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_lsq_power_cc2_%s", itoa[sn]);
		sprintf(formula_name, "lsq_power_cc2_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of instruction lsq_cc2", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_regfile_power_cc2_%s", itoa[sn]);
		sprintf(formula_name, "regfile_power_cc2_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of arch. regfile_cc2", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_icache_power_cc2_%s", itoa[sn]);
		sprintf(formula_name, "icache_power_cc2_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of icache_cc2", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_dcache_power_cc2_%s", itoa[sn]);
		sprintf(formula_name, "dcache_power_cc2_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of dcache_cc2", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_dcache2_power_cc2_%s", itoa[sn]);
		sprintf(formula_name, "dcache2_power_cc2_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of dcache2_cc2", formula_name, /* format */NULL, sn);
		
		/* PowerSMT Added */
		// bzero(stat_name, sizeof(char) * 64);
		// bzero(formula_name, sizeof(char) * 512);
		// sprintf(stat_name, "avg_alu_power_cc2_%s", itoa[sn]);
		// sprintf(formula_name, "alu_power_cc2_%s/sim_cycle", itoa[sn]);
		// stat_reg_formula(sdb, stat_name, "avg power usage of alu_cc2", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_ialu_power_cc2_%s", itoa[sn]);
		sprintf(formula_name, "ialu_power_cc2_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of ialu_cc2", formula_name, /* format */NULL, sn);
					
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_fpalu_power_cc2_%s", itoa[sn]);
		sprintf(formula_name, "fpalu_power_cc2_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of fpalu_cc2 FU", formula_name, /* format */NULL, sn);
					
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_imult_div_power_cc2_%s", itoa[sn]);
		sprintf(formula_name, "imult_div_power_cc2_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of imult_div_cc2 FU", formula_name, /* format */NULL, sn);
							
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_mem_port_power_cc2_%s", itoa[sn]);
		sprintf(formula_name, "mem_port_power_cc2_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of mem_port_cc2 FU", formula_name, /* format */NULL, sn);
							
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_fpmult_div_power_cc2_%s", itoa[sn]);
		sprintf(formula_name, "fpmult_div_power_cc2_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of fpmult_div_cc2 FU", formula_name, /* format */NULL, sn);
							
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_divmult_power_cc2_%s", itoa[sn]);
		sprintf(formula_name, "divmult_power_cc2_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of divmult_cc2 FU", formula_name, /* format */NULL, sn);
									
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_homo_power_cc2_%s", itoa[sn]);
		sprintf(formula_name, "homo_power_cc2_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of homo_cc2 FU", formula_name, /* format */NULL, sn);		
									  
		/* PowerSMT Added */
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_resultbus_power_cc2_%s", itoa[sn]);
		sprintf(formula_name, "resultbus_power_cc2_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of resultbus_cc2", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_clock_power_cc2_%s", itoa[sn]);
		sprintf(formula_name, "clock_power_cc2_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of clock_cc2", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "fetch_stage_power_cc2_%s", itoa[sn]);
		sprintf(formula_name, "icache_power_cc2_%s + bpred_power_cc2_%s", itoa[sn], itoa[sn]);
		stat_reg_formula(sdb, stat_name, "total power usage of fetch stage_cc2", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "dispatch_stage_power_cc2_%s", itoa[sn]);
		sprintf(formula_name, "rename_power_cc2_%s", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "total power usage of dispatch stage_cc2", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "issue_stage_power_cc2_%s", itoa[sn]);
		sprintf(formula_name, "resultbus_power_cc2_%s + ialu_power_cc2_%s + imult_div_power_cc2_%s + mem_port_power_cc2_%s + fpalu_power_cc2_%s + fpmult_div_power_cc2_%s + divmult_power_cc2_%s + homo_power_cc2_%s + dcache_power_cc2_%s + dcache2_power_cc2_%s + lsq_power_cc2_%s + window_power_cc2_%s", itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn]);
		stat_reg_formula(sdb, stat_name, "total power usage of issue stage_cc2", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_fetch_power_cc2_%s", itoa[sn]);
		sprintf(formula_name, "(icache_power_cc2_%s + bpred_power_cc2_%s)/sim_cycle", itoa[sn], itoa[sn]);
		stat_reg_formula(sdb, stat_name, "average power of fetch unit per cycle_cc2", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_dispatch_power_cc2_%s", itoa[sn]);
		sprintf(formula_name, "(rename_power_cc2_%s)/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "average power of dispatch unit per cycle_cc2", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_issue_power_cc2_%s", itoa[sn]);
		sprintf(formula_name, "(resultbus_power_cc2_%s + ialu_power_cc2_%s + imult_div_power_cc2_%s + mem_port_power_cc2_%s + fpalu_power_cc2_%s + fpmult_div_power_cc2_%s + divmult_power_cc2_%s + homo_power_cc2_%s + dcache_power_cc2_%s + dcache2_power_cc2_%s + lsq_power_cc2_%s + window_power_cc2_%s)/sim_cycle", itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn]);
		stat_reg_formula(sdb, stat_name, "average power of issue unit per cycle_cc2", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "total_power_cycle_cc2_%s", itoa[sn]);
		sprintf(formula_name, "(rename_power_cc2_%s + bpred_power_cc2_%s + lsq_power_cc2_%s + window_power_cc2_%s + regfile_power_cc2_%s + icache_power_cc2_%s + resultbus_power_cc2_%s + clock_power_cc2_%s + ialu_power_cc2_%s + imult_div_power_cc2_%s + mem_port_power_cc2_%s + fpalu_power_cc2_%s + fpmult_div_power_cc2_%s + divmult_power_cc2_%s + homo_power_cc2_%s + dcache_power_cc2_%s + dcache2_power_cc2_%s)", itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn]);
		stat_reg_formula(sdb, stat_name, "total power per cycle_cc2", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_total_power_cycle_cc2_%s", itoa[sn]);
		sprintf(formula_name, "(rename_power_cc2_%s + bpred_power_cc2_%s + lsq_power_cc2_%s + window_power_cc2_%s + regfile_power_cc2_%s + icache_power_cc2_%s + resultbus_power_cc2_%s + clock_power_cc2_%s + ialu_power_cc2_%s + imult_div_power_cc2_%s + mem_port_power_cc2_%s + fpalu_power_cc2_%s + fpmult_div_power_cc2_%s + divmult_power_cc2_%s + homo_power_cc2_%s + dcache_power_cc2_%s + dcache2_power_cc2_%s)/sim_cycle", itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn]);
		stat_reg_formula(sdb, stat_name, "average total power per cycle_cc2", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_total_power_insn_cc2_%s", itoa[sn]);
		sprintf(formula_name, "(rename_power_cc2_%s + bpred_power_cc2_%s + lsq_power_cc2_%s + window_power_cc2_%s + regfile_power_cc2_%s + icache_power_cc2_%s + resultbus_power_cc2_%s + clock_power_cc2_%s + ialu_power_cc2_%s + imult_div_power_cc2_%s + mem_port_power_cc2_%s + fpalu_power_cc2_%s + fpmult_div_power_cc2_%s + divmult_power_cc2_%s + homo_power_cc2_%s + dcache_power_cc2_%s + dcache2_power_cc2_%s)/sim_total_insn_%s", itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn]);
		stat_reg_formula(sdb, stat_name, "average total power per insn_cc2", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "rename_power_cc3_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of rename unit_cc3", &rename_power_cc3[sn], 0, NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "bpred_power_cc3_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of bpred unit_cc3", &bpred_power_cc3[sn], 0, NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "window_power_cc3_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of instruction window_cc3", &window_power_cc3[sn], 0, NULL, sn);
	
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "lsq_power_cc3_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of lsq_cc3", &lsq_power_cc3[sn], 0, NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "regfile_power_cc3_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of arch. regfile_cc3", &regfile_power_cc3[sn], 0, NULL, sn);
	
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "icache_power_cc3_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of icache_cc3", &icache_power_cc3[sn], 0, NULL, sn);
	
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "dcache_power_cc3_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of dcache_cc3", &dcache_power_cc3[sn], 0, NULL, sn);
	
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "dcache2_power_cc3_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of dcache2_cc3", &dcache2_power_cc3[sn], 0, NULL, sn);
	
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "ialu_power_cc3_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of alu_cc3", &ialu_power_cc3[sn], 0, NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "imult_div_power_cc3_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of imult_div_cc3 FU", &imult_div_power_cc3[sn], 0, NULL, sn);
						
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "mem_port_power_cc3_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of memory-port_cc3 FU", &mem_port_power_cc3[sn], 0, NULL, sn);
						
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "fpalu_power_cc3_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of fpalu_cc3", &fpalu_power_cc3[sn], 0, NULL, sn);
						
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "fpmult_div_power_cc3_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of fpmult_div_cc3", &fpmult_div_power_cc3[sn], 0, NULL, sn);
					
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "divmult_power_cc3_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of divmult_cc3", &divmult_power_cc3[sn], 0, NULL, sn);
						
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "homo_power_cc3_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of homo_cc3 FU", &homo_power_cc3[sn], 0, NULL, sn);
		
	
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "resultbus_power_cc3_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of resultbus_cc3", &resultbus_power_cc3[sn], 0, NULL, sn);
	
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "clock_power_cc3_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "total power usage of clock_cc3", &clock_power_cc3[sn], 0, NULL, sn);
	
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_rename_power_cc3_%s", itoa[sn]);
		sprintf(formula_name, "rename_power_cc3_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of rename unit_cc3", formula_name, /* format */NULL, sn);
	
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_bpred_power_cc3_%s", itoa[sn]);
		sprintf(formula_name, "bpred_power_cc3_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of bpred unit_cc3", formula_name, /* format */NULL, sn);
	
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_window_power_cc3_%s", itoa[sn]);
		sprintf(formula_name, "window_power_cc3_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of instruction window_cc3", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_lsq_power_cc3_%s", itoa[sn]);
		sprintf(formula_name, "lsq_power_cc3_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of instruction lsq_cc3", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_regfile_power_cc3_%s", itoa[sn]);
		sprintf(formula_name, "regfile_power_cc3_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of arch. regfile_cc3", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_icache_power_cc3_%s", itoa[sn]);
		sprintf(formula_name, "icache_power_cc3_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of icache_cc3", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_dcache_power_cc3_%s", itoa[sn]);
		sprintf(formula_name, "dcache_power_cc3_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of dcache_cc3", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_dcache2_power_cc3_%s", itoa[sn]);
		sprintf(formula_name, "dcache2_power_cc3_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of dcache2_cc3", formula_name, /* format */NULL, sn);
		
		/* PowerSMT Added */
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_ialu_power_cc3_%s", itoa[sn]);
		sprintf(formula_name, "ialu_power_cc3_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of ialu_cc3", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_fpalu_power_cc3_%s", itoa[sn]);
		sprintf(formula_name, "fpalu_power_cc3_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of fpalu_cc3 FU", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_imult_div_power_cc3_%s", itoa[sn]);
		sprintf(formula_name, "imult_div_power_cc3_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of imult_div_cc3 FU", formula_name, /* format */NULL, sn);
				
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_mem_port_power_cc3_%s", itoa[sn]);
		sprintf(formula_name, "mem_port_power_cc3_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of mem_port_cc3 FU", formula_name, /* format */NULL, sn);
				
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_fpmult_div_power_cc3_%s", itoa[sn]);
		sprintf(formula_name, "fpmult_div_power_cc3_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of fpmult_div_cc3 FU", formula_name, /* format */NULL, sn);
				
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_divmult_power_cc3_%s", itoa[sn]);
		sprintf(formula_name, "divmult_power_cc3_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of divmult_cc3 FU", formula_name, /* format */NULL, sn);
						
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_homo_power_cc3_%s", itoa[sn]);
		sprintf(formula_name, "homo_power_cc3_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of homo_cc3 FU", formula_name, /* format */NULL, sn);		
						  
		/* PowerSMT Added */
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_resultbus_power_cc3_%s", itoa[sn]);
		sprintf(formula_name, "resultbus_power_cc3_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of resultbus_cc3", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_clock_power_cc3_%s", itoa[sn]);
		sprintf(formula_name, "clock_power_cc3_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg power usage of clock_cc3", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "fetch_stage_power_cc3_%s", itoa[sn]);
		sprintf(formula_name, "icache_power_cc3_%s + bpred_power_cc3_%s", itoa[sn], itoa[sn]);
		stat_reg_formula(sdb, stat_name, "total power usage of fetch stage_cc3", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "dispatch_stage_power_cc3_%s", itoa[sn]);
		sprintf(formula_name, "rename_power_cc3_%s", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "total power usage of dispatch stage_cc3", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "issue_stage_power_cc3_%s", itoa[sn]);
		sprintf(formula_name, "resultbus_power_cc3_%s + ialu_power_cc3_%s + imult_div_power_cc3_%s + mem_port_power_cc3_%s + fpalu_power_cc3_%s + fpmult_div_power_cc3_%s + divmult_power_cc3_%s + homo_power_cc3_%s + dcache_power_cc3_%s + dcache2_power_cc3_%s + lsq_power_cc3_%s + window_power_cc3_%s", itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn]);
		stat_reg_formula(sdb, stat_name, "total power usage of issue stage_cc3", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_fetch_power_cc3_%s", itoa[sn]);
		sprintf(formula_name, "(icache_power_cc3_%s + bpred_power_cc3_%s)/ sim_cycle", itoa[sn], itoa[sn]);
		stat_reg_formula(sdb, stat_name, "average power of fetch unit per cycle_cc3", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_dispatch_power_cc3_%s", itoa[sn]);
		sprintf(formula_name, "(rename_power_cc3_%s)/ sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "average power of dispatch unit per cycle_cc3", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_issue_power_cc3_%s", itoa[sn]);
		sprintf(formula_name, "(resultbus_power_cc3_%s + ialu_power_cc3_%s + imult_div_power_cc3_%s + mem_port_power_cc3_%s + fpalu_power_cc3_%s + fpmult_div_power_cc3_%s + divmult_power_cc3_%s + homo_power_cc3_%s + dcache_power_cc3_%s + dcache2_power_cc3_%s + lsq_power_cc3_%s + window_power_cc3_%s)/ sim_cycle", itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn]);
		stat_reg_formula(sdb, stat_name, "average power of issue unit per cycle_cc3", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "total_power_cycle_cc3_%s", itoa[sn]);
		sprintf(formula_name, "(rename_power_cc3_%s + bpred_power_cc3_%s + lsq_power_cc3_%s + window_power_cc3_%s + regfile_power_cc3_%s + icache_power_cc3_%s + resultbus_power_cc3_%s + clock_power_cc3_%s + ialu_power_cc3_%s + imult_div_power_cc3_%s + mem_port_power_cc3_%s + fpalu_power_cc3_%s + fpmult_div_power_cc3_%s + divmult_power_cc3_%s + homo_power_cc3_%s + dcache_power_cc3_%s + dcache2_power_cc3_%s)", itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn]);
		stat_reg_formula(sdb, stat_name, "total power per cycle_cc3", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_total_power_cycle_cc3_%s", itoa[sn]);
		sprintf(formula_name, "(rename_power_cc3_%s + bpred_power_cc3_%s + lsq_power_cc3_%s + window_power_cc3_%s + regfile_power_cc3_%s + icache_power_cc3_%s + resultbus_power_cc3_%s + clock_power_cc3_%s + ialu_power_cc3_%s + imult_div_power_cc3_%s + mem_port_power_cc3_%s + fpalu_power_cc3_%s + fpmult_div_power_cc3_%s + divmult_power_cc3_%s + homo_power_cc3_%s + dcache_power_cc3_%s + dcache2_power_cc3_%s)/sim_cycle", itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn]);
		stat_reg_formula(sdb, stat_name, "average total power per cycle_cc3", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_total_power_insn_cc3_%s", itoa[sn]);
		sprintf(formula_name, "(rename_power_cc3_%s + bpred_power_cc3_%s + lsq_power_cc3_%s + window_power_cc3_%s + regfile_power_cc3_%s + icache_power_cc3_%s + resultbus_power_cc3_%s + clock_power_cc3_%s + ialu_power_cc3_%s + imult_div_power_cc3_%s + mem_port_power_cc3_%s + fpalu_power_cc3_%s + fpmult_div_power_cc3_%s + divmult_power_cc3_%s + homo_power_cc3_%s + dcache_power_cc3_%s + dcache2_power_cc3_%s)/sim_total_insn_%s", itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn], itoa[sn]);
		stat_reg_formula(sdb, stat_name, "average total power per insn_cc3", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "total_rename_access_%s", itoa[sn]);
		stat_reg_counter(sdb, stat_name, "total number accesses of rename unit", &total_rename_access[sn], 0, NULL,sn);
		
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "total_bpred_access_%s", itoa[sn]);
		stat_reg_counter(sdb, stat_name, "total number accesses of bpred unit", &total_bpred_access[sn], 0, NULL,sn);
		
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "total_window_access_%s", itoa[sn]);
		stat_reg_counter(sdb, stat_name, "total number accesses of instruction window", &total_window_access[sn], 0, NULL,sn);
		
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "total_lsq_access_%s", itoa[sn]);
		stat_reg_counter(sdb, stat_name, "total number accesses of load/store queue", &total_lsq_access[sn], 0, NULL,sn);
	
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "total_regfile_access_%s", itoa[sn]);
		stat_reg_counter(sdb, stat_name, "total number accesses of arch. regfile", &total_regfile_access[sn], 0, NULL,sn);
	
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "total_icache_access_%s", itoa[sn]);
		stat_reg_counter(sdb, stat_name, "total number accesses of icache", &total_icache_access[sn], 0, NULL,sn);
	
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "total_dcache_access_%s", itoa[sn]);
		stat_reg_counter(sdb, stat_name, "total number accesses of dcache", &total_dcache_access[sn], 0, NULL,sn);
	
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "total_dcache2_access_%s", itoa[sn]);
		stat_reg_counter(sdb, stat_name, "total number accesses of dcache2", &total_dcache2_access[sn], 0, NULL,sn);
	
		/* PowerSMT Added */
		// bzero(stat_name, sizeof(char) * 64);
		// sprintf(stat_name, "total_alu_access_%s", itoa[sn]);
		// stat_reg_counter(sdb, stat_name, "total number accesses of alu", &total_alu_access[sn], 0, NULL,sn);
		
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "total_fus_access_%s", itoa[sn]);
		stat_reg_counter(sdb, stat_name, "total number accesses of Functional Units", &total_fus_access[sn], 0, NULL,sn);
		/* PowerSMT Added */
		
	
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "total_resultbus_access_%s", itoa[sn]);
		stat_reg_counter(sdb, stat_name, "total number accesses of resultbus", &total_resultbus_access[sn], 0, NULL,sn);
	
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_rename_access_%s", itoa[sn]);
		sprintf(formula_name, "total_rename_access_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg number accesses of rename unit", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_bpred_access_%s", itoa[sn]);
		sprintf(formula_name, "total_bpred_access_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg number accesses of bpred unit", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_window_access_%s", itoa[sn]);
		sprintf(formula_name, "total_window_access_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg number accesses of instruction window", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_lsq_access_%s", itoa[sn]);
		sprintf(formula_name, "total_lsq_access_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg number accesses of lsq", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_regfile_access_%s", itoa[sn]);
		sprintf(formula_name, "total_regfile_access_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg number accesses of arch. regfile", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_icache_access_%s", itoa[sn]);
		sprintf(formula_name, "total_icache_access_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg number accesses of icache", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_dcache_access_%s", itoa[sn]);
		sprintf(formula_name, "total_dcache_access_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg number accesses of dcache", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_dcache2_access_%s", itoa[sn]);
		sprintf(formula_name, "total_dcache2_access_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg number accesses of dcache2", formula_name, /* format */NULL, sn);
		
		/* PowerSMT Added */
		// bzero(stat_name, sizeof(char) * 64);
		// bzero(formula_name, sizeof(char) * 512);
		// sprintf(stat_name, "avg_alu_access_%s", itoa[sn]);
		// sprintf(formula_name, "total_alu_access_%s/sim_cycle", itoa[sn]);
		// stat_reg_formula(sdb, stat_name, "avg number accesses of alu", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_fus_access_%s", itoa[sn]);
		sprintf(formula_name, "total_fus_access_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg number accesses of functional units", formula_name, /* format */NULL, sn);
		/* PowerSMT Added */
		
		bzero(stat_name, sizeof(char) * 64);
		bzero(formula_name, sizeof(char) * 512);
		sprintf(stat_name, "avg_resultbus_access_%s", itoa[sn]);
		sprintf(formula_name, "total_resultbus_access_%s/sim_cycle", itoa[sn]);
		stat_reg_formula(sdb, stat_name, "avg number accesses of resultbus", formula_name, /* format */NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "max_rename_access_%s", itoa[sn]);
		stat_reg_counter(sdb, stat_name, "max number accesses of rename unit", &max_rename_access[sn], 0, NULL,sn);
	
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "max_bpred_access_%s", itoa[sn]);
		stat_reg_counter(sdb, stat_name, "max number accesses of bpred unit", &max_bpred_access[sn], 0, NULL,sn);
	
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "max_window_access_%s", itoa[sn]);
		stat_reg_counter(sdb, stat_name, "max number accesses of instruction window", &max_window_access[sn], 0, NULL,sn);
	
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "max_lsq_access_%s", itoa[sn]);
		stat_reg_counter(sdb, stat_name, "max number accesses of load/store queue", &max_lsq_access[sn], 0, NULL,sn);
	
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "max_regfile_access_%s", itoa[sn]);
		stat_reg_counter(sdb, stat_name, "max number accesses of arch. regfile", &max_regfile_access[sn], 0, NULL,sn);
	
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "max_icache_access_%s", itoa[sn]);
		stat_reg_counter(sdb, stat_name, "max number accesses of icache", &max_icache_access[sn], 0, NULL,sn);
	
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "max_dcache_access_%s", itoa[sn]);
		stat_reg_counter(sdb, stat_name, "max number accesses of dcache", &max_dcache_access[sn], 0, NULL,sn);
	
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "max_dcache2_access_%s", itoa[sn]);
		stat_reg_counter(sdb, stat_name, "max number accesses of dcache2", &max_dcache2_access[sn], 0, NULL,sn);
	
		/* PowerSMT Added */
		// bzero(stat_name, sizeof(char) * 64);
		// sprintf(stat_name, "max_alu_access_%s", itoa[sn]);
		// stat_reg_counter(sdb, stat_name, "max number accesses of alu", &max_alu_access[sn], 0, NULL,sn);
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "max_fus_access_%s", itoa[sn]);
		stat_reg_counter(sdb, stat_name, "max number accesses of Functional Units", &max_fus_access[sn], 0, NULL,sn);
		/* PowerSMT Added */
		
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "max_resultbus_access_%s", itoa[sn]);
		stat_reg_counter(sdb, stat_name, "max number accesses of resultbus", &max_resultbus_access[sn], 0, NULL,sn);
		
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "max_cycle_power_cc1_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "maximum cycle power usage of cc1", &max_cycle_power_cc1[sn], 0, NULL, sn);
		
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "max_cycle_power_cc2_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "maximum cycle power usage of cc2", &max_cycle_power_cc2[sn], 0, NULL, sn);
	
		bzero(stat_name, sizeof(char) * 64);
		sprintf(stat_name, "max_cycle_power_cc3_%s", itoa[sn]);
		stat_reg_double(sdb, stat_name, "maximum cycle power usage of cc3", &max_cycle_power_cc3[sn], 0, NULL, sn);
		
		/*Teste*/
			// struct stat_stat_t *stat;
			// for (stat=sdb->stats; stat != NULL; stat=stat->next)
			//  stat_print_stat(sdb, stat, stdout);
		/*Teste*/
	}
}

/* this routine takes the number of rows and cols of an array structure
 and attemps to make it make it more of a reasonable circuit structure
 by trying to make the number of rows and cols as close as possible.
 (scaling both by factors of 2 in opposite directions).  it returns
 a scale factor which is the amount that the rows should be divided
 by and the columns should be multiplied by.
 */
int squarify(int rows, int cols) {
	int scale_factor = 1;

	if (rows == cols)
		return 1;

	/*
	 printf("init rows == %d\n",rows);
	 printf("init cols == %d\n",cols);
	 */

	while (rows > cols) {
		rows = rows/2;
		cols = cols*2;

		/*
		 printf("rows == %d\n",rows);
		 printf("cols == %d\n",cols);
		 printf("scale_factor == %d (2^ == %d)\n\n",scale_factor,(int)pow(2.0,(double)scale_factor));
		 */

		if (rows/2<= cols)
			return ((int)pow(2.0,(double)scale_factor));
		scale_factor++;
	}

	return 1;
}

/* could improve squarify to work when rows < cols */

double squarify_new(int rows, int cols) {
	double scale_factor = 0.0;

	if (rows==cols)
		return (pow(2.0,scale_factor));

	while (rows > cols) {
		rows = rows/2;
		cols = cols*2;
		if (rows <= cols)
			return (pow(2.0,scale_factor));
		scale_factor++;
	}

	while (cols > rows) {
		rows = rows*2;
		cols = cols/2;
		if (cols <= rows)
			return (pow(2.0,scale_factor));
		scale_factor--;
	}

	return 1;

}

void dump_power_stats(power)
	power_result_type *power; {
		
	// fprintf(stdout,"In dump_power_stats\n");	
		
		
	double total_power;
	double bpred_power;
	double rename_power;
	double rat_power;
	double dcl_power;
	double lsq_power;
	double window_power;
	double wakeup_power;
	double rs_power;
	double lsq_wakeup_power;
	double lsq_rs_power;
	double regfile_power;
	double reorder_power;
	double icache_power;
	double dcache_power;
	double dcache2_power;
	double dtlb_power;
	double itlb_power;
	double ambient_power = 2.0;

	icache_power = power->icache_power;

	dcache_power = power->dcache_power;

	dcache2_power = power->dcache2_power;

	itlb_power = power->itlb;
	dtlb_power = power->dtlb;

	bpred_power = power->btb + power->local_predict+ power->global_predict+power->chooser+ power->ras;

	rat_power = power->rat_decoder +power->rat_wordline+ power->rat_bitline+ power->rat_senseamp;

	dcl_power = power->dcl_compare + power->dcl_pencode;

	rename_power = power->rat_power + power->dcl_power+ power->inst_decoder_power;

	wakeup_power = power->wakeup_tagdrive + power->wakeup_tagmatch+power->wakeup_ormatch;

	rs_power = power->rs_decoder +power->rs_wordline+ power->rs_bitline+ power->rs_senseamp;

	window_power = wakeup_power + rs_power + power->selection;

	lsq_rs_power = power->lsq_rs_decoder +power->lsq_rs_wordline+ power->lsq_rs_bitline+ power->lsq_rs_senseamp;

	lsq_wakeup_power = power->lsq_wakeup_tagdrive +power->lsq_wakeup_tagmatch+ power->lsq_wakeup_ormatch;

	lsq_power = lsq_wakeup_power + lsq_rs_power;

	reorder_power = power->reorder_decoder +power->reorder_wordline+ power->reorder_bitline+power->reorder_senseamp;

	regfile_power = power->regfile_decoder +power->regfile_wordline+ power->regfile_bitline+power->regfile_senseamp;

	total_power = bpred_power + rename_power + window_power +regfile_power + power->resultbus+lsq_power + icache_power +dcache_power + dcache2_power + dtlb_power +itlb_power + power->clock_power+power->ialu_power+ power->fpalu_power;

	fprintf(stderr,"\nProcessor Parameters:\n");
	fprintf(stderr,"Issue Width: %d\n",ruu_issue_width);
	fprintf(stderr,"Window Size: %d\n",RUU_size);
	fprintf(stderr,"Number of Virtual Registers: %d\n",MD_NUM_IREGS);
	fprintf(stderr,"Number of Physical Registers: %d\n",RUU_size);
	fprintf(stderr,"Datapath Width: %d\n",data_width);

	fprintf(stderr,"Total Power Consumption: %g\n",total_power+ambient_power);
	fprintf(stderr,"Branch Predictor Power Consumption: %g  (%.3g%%)\n",bpred_power,100*bpred_power/total_power);
	fprintf(stderr," branch target buffer power (W): %g\n",power->btb);
	fprintf(stderr," local predict power (W): %g\n",power->local_predict);
	fprintf(stderr," global predict power (W): %g\n",power->global_predict);
	fprintf(stderr," chooser power (W): %g\n",power->chooser);
	fprintf(stderr," RAS power (W): %g\n",power->ras);
	fprintf(stderr,"Rename Logic Power Consumption: %g  (%.3g%%)\n",rename_power,100*rename_power/total_power);
	fprintf(stderr," Instruction Decode Power (W): %g\n",power->inst_decoder_power);
	fprintf(stderr," RAT decode_power (W): %.8g\n",power->rat_decoder);
	fprintf(stderr," RAT wordline_power (W): %g\n",power->rat_wordline);
	fprintf(stderr," RAT bitline_power (W): %g\n",power->rat_bitline);
	fprintf(stderr," DCL Comparators (W): %g\n",power->dcl_compare);
	fprintf(stderr,"Instruction Window Power Consumption: %g  (%.3g%%)\n",window_power,100*window_power/total_power);
	fprintf(stderr," tagdrive (W): %g\n",power->wakeup_tagdrive);
	fprintf(stderr," tagmatch (W): %g\n",power->wakeup_tagmatch);
	fprintf(stderr," Selection Logic (W): %g\n",power->selection);
	fprintf(stderr," decode_power (W): %g\n",power->rs_decoder);
	fprintf(stderr," wordline_power (W): %g\n",power->rs_wordline);
	fprintf(stderr," bitline_power (W): %g\n",power->rs_bitline);
	fprintf(stderr,"Load/Store Queue Power Consumption: %g  (%.3g%%)\n",lsq_power,100*lsq_power/total_power);
	fprintf(stderr," tagdrive (W): %g\n",power->lsq_wakeup_tagdrive);
	fprintf(stderr," tagmatch (W): %g\n",power->lsq_wakeup_tagmatch);
	fprintf(stderr," decode_power (W): %g\n",power->lsq_rs_decoder);
	fprintf(stderr," wordline_power (W): %g\n",power->lsq_rs_wordline);
	fprintf(stderr," bitline_power (W): %g\n",power->lsq_rs_bitline);
	fprintf(stderr,"Arch. Register File Power Consumption: %g  (%.3g%%)\n",regfile_power,100*regfile_power/total_power);
	fprintf(stderr," decode_power (W): %g\n",power->regfile_decoder);
	fprintf(stderr," wordline_power (W): %g\n",power->regfile_wordline);
	fprintf(stderr," bitline_power (W): %g\n",power->regfile_bitline);
	fprintf(stderr,"Result Bus Power Consumption: %g  (%.3g%%)\n",power->resultbus,100*power->resultbus/total_power);
	fprintf(stderr,"Total Clock Power: %g  (%.3g%%)\n",power->clock_power,100*power->clock_power/total_power);
	fprintf(stderr,"Int ALU Power: %g  (%.3g%%)\n",power->ialu_power,100*power->ialu_power/total_power);
	fprintf(stderr,"FP ALU Power: %g  (%.3g%%)\n",power->fpalu_power,100*power->fpalu_power/total_power);
	fprintf(stderr,"Instruction Cache Power Consumption: %g  (%.3g%%)\n",icache_power,100*icache_power/total_power);
	fprintf(stderr," decode_power (W): %g\n",power->icache_decoder);
	fprintf(stderr," wordline_power (W): %g\n",power->icache_wordline);
	fprintf(stderr," bitline_power (W): %g\n",power->icache_bitline);
	fprintf(stderr," senseamp_power (W): %g\n",power->icache_senseamp);
	fprintf(stderr," tagarray_power (W): %g\n",power->icache_tagarray);
	fprintf(stderr,"Itlb_power (W): %g (%.3g%%)\n",power->itlb,100*power->itlb/total_power);
	fprintf(stderr,"Data Cache Power Consumption: %g  (%.3g%%)\n",dcache_power,100*dcache_power/total_power);
	fprintf(stderr," decode_power (W): %g\n",power->dcache_decoder);
	fprintf(stderr," wordline_power (W): %g\n",power->dcache_wordline);
	fprintf(stderr," bitline_power (W): %g\n",power->dcache_bitline);
	fprintf(stderr," senseamp_power (W): %g\n",power->dcache_senseamp);
	fprintf(stderr," tagarray_power (W): %g\n",power->dcache_tagarray);
	fprintf(stderr,"Dtlb_power (W): %g (%.3g%%)\n",power->dtlb,100*power->dtlb/total_power);
	fprintf(stderr,"Level 2 Cache Power Consumption: %g (%.3g%%)\n",dcache2_power,100*dcache2_power/total_power);
	fprintf(stderr," decode_power (W): %g\n",power->dcache2_decoder);
	fprintf(stderr," wordline_power (W): %g\n",power->dcache2_wordline);
	fprintf(stderr," bitline_power (W): %g\n",power->dcache2_bitline);
	fprintf(stderr," senseamp_power (W): %g\n",power->dcache2_senseamp);
	fprintf(stderr," tagarray_power (W): %g\n",power->dcache2_tagarray);
	
	// fprintf(stdout,"Out dump_power_stats\n");
}

/*======================================================================*/

/* 
 * This part of the code contains routines for each section as
 * described in the tech report.  See the tech report for more details
 * and explanations */

/*----------------------------------------------------------------------*/
	
double driver_size(double driving_cap, double desiredrisetime) {
	double nsize, psize;
	double Rpdrive;

	Rpdrive = desiredrisetime/(driving_cap*log(VSINV)*-1.0);
	psize = restowidth(	Rpdrive,PCH);
	nsize = restowidth(	Rpdrive,NCH);
	if (psize > Wworddrivemax) {
		psize = Wworddrivemax;
	}
	if (psize < 4.0 * LSCALE)
		psize = 4.0 * LSCALE;

	return (psize);

}

/* Decoder delay:  (see section 6.1 of tech report) */

double array_decoder_power(rows, cols, predeclength, rports, wports, cache)
	int rows, cols;double predeclength;int rports, wports;int cache; {
	double Ctotal=0;
	double Ceq=0;
	int numstack;
	int decode_bits=0;
	int ports;
	double rowsb;

	/* read and write ports are the same here */
	ports = rports + wports;

	rowsb = (double)rows;

	/* number of input bits to be decoded */
	decode_bits = ceil((logtwo(rowsb)));

	/* First stage: driving the decoders */

	/* This is the capacitance for driving one bit (and its complement).
	 -There are #rowsb 3->8 decoders contributing gatecap.
	 - 2.0 factor from 2 identical sets of drivers in parallel
	 */
	Ceq = 2.0 * (draincap(Wdecdrivep, PCH, 1) +draincap(Wdecdriven, NCH, 1))+gatecap(Wdec3to8n + Wdec3to8p, 10.0) * rowsb;

	/* There are ports * #decode_bits total */
	Ctotal += ports * decode_bits * Ceq;

	if (verbose)
		fprintf(stderr,"Decoder -- Driving decoders            == %g\n",.3*Ctotal*Powerfactor);

	/* second stage: driving a bunch of nor gates with a nand 
	 numstack is the size of the nor gates -- ie. a 7-128 decoder has
	 3-input NAND followed by 3-input NOR  */

	numstack = ceil((1.0/3.0)*logtwo(rows));

	if (numstack<=0) numstack = 1;
	if (numstack>5) numstack = 5;

	/* There are #rowsb NOR gates being driven*/
	Ceq = (3.0*draincap(Wdec3to8p,PCH,1) +draincap(Wdec3to8n,NCH,3) +gatecap(WdecNORn+WdecNORp,((numstack*40)+20.0)))*rowsb;

	Ctotal+=ports*Ceq;

	if (verbose)
		fprintf(stderr,"Decoder -- Driving nor w/ nand         == %g\n",.3*ports*Ceq*Powerfactor);

	/* Final stage: driving an inverter with the nor 
	 (inverter preceding wordline driver) -- wordline driver is in the next section*/

	Ceq = (gatecap(Wdecinvn+Wdecinvp,20.0)+numstack*draincap(WdecNORn,NCH,1)+draincap(WdecNORp,PCH,numstack));

	if (verbose)
		fprintf(stderr,"Decoder -- Driving inverter w/ nor     == %g\n",.3*ports*Ceq*Powerfactor);

	Ctotal+=ports*Ceq;

	/* assume Activity Factor == .3  */

	return (.3*Ctotal*Powerfactor);
}
	
double simple_array_decoder_power(rows, cols, rports, wports, cache)
	int rows, cols;int rports, wports;int cache; {
	double predeclength=0.0;
	return (array_decoder_power(rows,cols,predeclength,rports,wports,cache));
}

double array_wordline_power(rows, cols, wordlinelength, rports, wports, cache)
	int rows, cols;double wordlinelength;int rports, wports;int cache; {
	double Ctotal=0;
	double Ceq=0;
	double Cline=0;
	double Cliner, Clinew=0;
	double desiredrisetime, psize, nsize;
	int ports;
	double colsb;

	ports = rports+wports;

	colsb = (double)cols;

	/* Calculate size of wordline drivers assuming rise time == Period / 8 
	 - estimate cap on line 
	 - compute min resistance to achieve this with RC 
	 - compute width needed to achieve this resistance */

	desiredrisetime = Period/16;
	Cline = (gatecappass(Wmemcellr,1.0))*colsb + wordlinelength*CM3metal;psize = driver_size(Cline,desiredrisetime);

	/* how do we want to do p-n ratioing? -- here we just assume the same ratio 
	 from an inverter pair  */
	nsize = psize * Wdecinvn/Wdecinvp;

	if(verbose)
	fprintf(stderr,"Wordline Driver Sizes -- nsize == %f, psize == %f\n",nsize,psize);

	Ceq = draincap(Wdecinvn,NCH,1) + draincap(Wdecinvp,PCH,1) +
	gatecap(nsize+psize,20.0);

	Ctotal+=ports*Ceq;

	if(verbose)
	fprintf(stderr,"Wordline -- Inverter -> Driver         == %g\n",ports*Ceq*Powerfactor);

	/* Compute caps of read wordline and write wordlines 
	 - wordline driver caps, given computed width from above
	 - read wordlines have 1 nmos access tx, size ~4
	 - write wordlines have 2 nmos access tx, size ~2
	 - metal line cap
	 */

	Cliner = (gatecappass(Wmemcellr,(BitWidth-2*Wmemcellr)/2.0))*colsb+
	wordlinelength*CM3metal+
	2.0*(draincap(nsize,NCH,1) + draincap(psize,PCH,1));
	Clinew = (2.0*gatecappass(Wmemcellw,(BitWidth-2*Wmemcellw)/2.0))*colsb+
	wordlinelength*CM3metal+
	2.0*(draincap(nsize,NCH,1) + draincap(psize,PCH,1));

	if(verbose) {
		fprintf(stderr,"Wordline -- Line                       == %g\n",1e12*Cline);
		fprintf(stderr,"Wordline -- Line -- access -- gatecap  == %g\n",1e12*colsb*2*gatecappass(Wmemcella,(BitWidth-2*Wmemcella)/2.0));
		fprintf(stderr,"Wordline -- Line -- driver -- draincap == %g\n",1e12*draincap(nsize,NCH,1) + draincap(psize,PCH,1));
		fprintf(stderr,"Wordline -- Line -- metal              == %g\n",1e12*wordlinelength*CM3metal);
	}
	Ctotal+=rports*Cliner+wports*Clinew;

	/* AF == 1 assuming a different wordline is charged each cycle, but only
	 1 wordline (per port) is actually used */

	return(Ctotal*Powerfactor);
}
	
double simple_array_wordline_power(rows, cols, rports, wports, cache)
	int rows, cols;int rports, wports;int cache; {
	double wordlinelength;
	int ports = rports + wports;
	wordlinelength = cols * (RegCellWidth + 2 * ports * BitlineSpacing);
	return (array_wordline_power(rows,cols,wordlinelength,rports,wports,cache));
}

double array_bitline_power(rows, cols, bitlinelength, rports, wports, cache)
	int rows, cols;
	double bitlinelength;
	int rports, wports;
	int cache;
{
	double Ctotal=0;
	double Ccolmux=0;
	double Cbitrowr=0;
	double Cbitroww=0;
	double Cprerow=0;
	double Cwritebitdrive=0;
	double Cpregate=0;
	double Cliner=0;
	double Clinew=0;
	int ports;
	double rowsb;
	double colsb;

	double desiredrisetime, Cline, psize, nsize;

	ports = rports + wports;

	rowsb = (double)rows;
	colsb = (double)cols;

	/* Draincaps of access tx's */

	Cbitrowr = draincap(Wmemcellr,NCH,1);
	Cbitroww = draincap(Wmemcellw,NCH,1);

	/* Cprerow -- precharge cap on the bitline
	 -simple scheme to estimate size of pre-charge tx's in a similar fashion
	 to wordline driver size estimation.
	 -FIXME: it would be better to use precharge/keeper pairs, i've omitted this
	 from this version because it couldn't autosize as easily.
	 */

	desiredrisetime = Period/8;

	Cline = rowsb*Cbitrowr+CM2metal*bitlinelength;
	psize = driver_size(Cline,desiredrisetime);

	/* compensate for not having an nmos pre-charging */
	psize = psize + psize * Wdecinvn/Wdecinvp;

	if (verbose)
		printf(	"Cprerow auto   == %g (psize == %g)\n",	draincap(psize,PCH,1),psize);

	Cprerow = draincap(	psize,PCH,1);

	/* Cpregate -- cap due to gatecap of precharge transistors -- tack this
	 onto bitline cap, again this could have a keeper */
	Cpregate = 4.0*gatecap(	psize,10.0);
	global_clockcap+=rports*cols*2.0*Cpregate;

	/* Cwritebitdrive -- write bitline drivers are used instead of the precharge
	 stuff for write bitlines
	 - 2 inverter drivers within each driver pair */

	Cline = rowsb*Cbitroww+CM2metal*bitlinelength;

	psize = driver_size(Cline,desiredrisetime);
	nsize = psize * Wdecinvn/Wdecinvp;

	Cwritebitdrive = 2.0*(draincap(	psize,PCH,1)+draincap(nsize,NCH,1));

	/* 
	 reg files (cache==0) 
	 => single ended bitlines (1 bitline/col)
	 => AFs from pop_count
	 caches (cache ==1)
	 => double-ended bitlines (2 bitlines/col)
	 => AFs = .5 (since one of the two bitlines is always charging/discharging)
	 */

#ifdef STATIC_AF
	if (cache == 0) {
		/* compute the total line cap for read/write bitlines */
		Cliner = rowsb*Cbitrowr+CM2metal*bitlinelength+Cprerow;
		Clinew = rowsb*Cbitroww+CM2metal*bitlinelength+Cwritebitdrive;

		/* Bitline inverters at the end of the bitlines (replaced w/ sense amps
		 in cache styles) */
		Ccolmux = gatecap(MSCALE*(29.9+7.8),0.0)+gatecap(MSCALE*(47.0+12.0),0.0);
		Ctotal+=(1.0-POPCOUNT_AF)*rports*cols*(Cliner+Ccolmux+2.0*Cpregate);
		Ctotal+=.3*wports*cols*(Clinew+Cwritebitdrive);
	}
	else {
		Cliner = rowsb*Cbitrowr+CM2metal*bitlinelength+Cprerow + draincap(Wbitmuxn,NCH,1);
		Clinew = rowsb*Cbitroww+CM2metal*bitlinelength+Cwritebitdrive;
		Ccolmux = (draincap(Wbitmuxn,NCH,1))+2.0*gatecap(WsenseQ1to4,10.0);
		Ctotal+=.5*rports*2.0*cols*(Cliner+Ccolmux+2.0*Cpregate);
		Ctotal+=.5*wports*2.0*cols*(Clinew+Cwritebitdrive);
	}
#else
	if (cache == 0) {
		/* compute the total line cap for read/write bitlines */
		Cliner = rowsb*Cbitrowr+CM2metal*bitlinelength+Cprerow;
		Clinew = rowsb*Cbitroww+CM2metal*bitlinelength+Cwritebitdrive;

		/* Bitline inverters at the end of the bitlines (replaced w/ sense amps
		 in cache styles) */
		Ccolmux = gatecap(MSCALE*(29.9+7.8),0.0)+gatecap(MSCALE*(47.0+12.0),0.0);
		Ctotal += rports*cols*(Cliner+Ccolmux+2.0*Cpregate);
		Ctotal += .3*wports*cols*(Clinew+Cwritebitdrive);
	} else {
		Cliner = rowsb*Cbitrowr+CM2metal*bitlinelength+Cprerow + draincap(Wbitmuxn,NCH,1);
		Clinew = rowsb*Cbitroww+CM2metal*bitlinelength+Cwritebitdrive;
		Ccolmux = (draincap(Wbitmuxn,NCH,1))+2.0*gatecap(WsenseQ1to4,10.0);
		Ctotal+=.5*rports*2.0*cols*(Cliner+Ccolmux+2.0*Cpregate);
		Ctotal+=.5*wports*2.0*cols*(Clinew+Cwritebitdrive);
	}
#endif

	if (verbose) {
		fprintf(stderr,"Bitline -- Precharge                   == %g\n",1e12*Cpregate);
		fprintf(stderr,"Bitline -- Line                        == %g\n",1e12*(Cliner+Clinew));
		fprintf(stderr,"Bitline -- Line -- access draincap     == %g\n",1e12*rowsb*Cbitrowr);
		fprintf(stderr,"Bitline -- Line -- precharge draincap  == %g\n",1e12*Cprerow);
		fprintf(stderr,"Bitline -- Line -- metal               == %g\n",1e12*bitlinelength*CM2metal);
		fprintf(stderr,"Bitline -- Colmux                      == %g\n",1e12*Ccolmux);

		fprintf(stderr,"\n");
	}

	if (cache==0)
		return (Ctotal*Powerfactor);
	else
		return(Ctotal*SensePowerfactor*.4);

}

double simple_array_bitline_power(rows, cols, rports, wports, cache)
	int rows, cols;
	int rports, wports;
	int cache; 
{
	double bitlinelength;

	int ports = rports + wports;

	bitlinelength = rows * (RegCellHeight + ports * WordlineSpacing);

	return (array_bitline_power(rows,cols,bitlinelength,rports,wports,cache));

}

/* estimate senseamp power dissipation in cache structures (Zyuban's method) */
double senseamp_power(int cols) {
	return ((double)cols * Vdd/8* .5e-3);
}

/* estimate comparator power consumption (this comparator is similar
 to the tag-match structure in a CAM */

double compare_cap(int compare_bits) {
	double c1, c2;
	/* bottom part of comparator */
	c2 = (compare_bits)*(draincap(Wcompn,NCH,1)+draincap(Wcompn,NCH,2))+draincap(Wevalinvp,PCH,1) + draincap(Wevalinvn,NCH,1);

	/* top part of comparator */
	c1 = (compare_bits)*(draincap(Wcompn,NCH,1)+draincap(Wcompn,NCH,2)+draincap(Wcomppreequ,NCH,1))+gatecap(WdecNORn,1.0)+gatecap(WdecNORp,3.0);

	return (c1 + c2);
}

/* power of depency check logic */
double dcl_compare_power(int compare_bits) {
	double Ctotal;
	int num_comparators;

	num_comparators = (ruu_decode_width - 1) * (ruu_decode_width);

	Ctotal = num_comparators * compare_cap(compare_bits);

	return (Ctotal*Powerfactor*AF);
}

double simple_array_power(rows, cols, rports, wports, cache)
	int rows, cols; 
	int rports, wports; 
	int cache; 
{
	if (cache==0)
		return (simple_array_decoder_power(rows,cols,rports,wports,cache) + 
				simple_array_wordline_power(rows,cols,rports,wports,cache) + 
				simple_array_bitline_power(rows,cols,rports,wports,cache));
	else
		return (simple_array_decoder_power(rows,cols,rports,wports,cache) + 
				simple_array_wordline_power(rows,cols,rports,wports,cache) + 
				simple_array_bitline_power(rows,cols,rports,wports,cache) + 
				senseamp_power(cols));
}

double cam_tagdrive(rows, cols, rports, wports)
	int rows, cols, rports, wports; {
	double Ctotal, Ctlcap, Cblcap, Cwlcap;
	double taglinelength;
	double wordlinelength;
	double nsize, psize;
	int ports;
	Ctotal=0;

	ports = rports + wports;

	taglinelength = rows *(CamCellHeight + ports * MatchlineSpacing);

	wordlinelength = cols *(CamCellWidth + ports * TaglineSpacing);

	/* Compute tagline cap */
	Ctlcap = Cmetal * taglinelength +
	rows * gatecappass(Wcomparen2,2.0) +
	draincap(Wcompdrivern,NCH,1)+draincap(Wcompdriverp,PCH,1);

	/* Compute bitline cap (for writing new tags) */
	Cblcap = Cmetal * taglinelength +
	rows * draincap(Wmemcellr,NCH,2);

	/* autosize wordline driver */
	psize = driver_size(Cmetal * wordlinelength + 2 * cols * gatecap(Wmemcellr,2.0),Period/8);
	nsize = psize * Wdecinvn/Wdecinvp;

	/* Compute wordline cap (for writing new tags) */
	Cwlcap = Cmetal * wordlinelength +
	draincap(nsize,NCH,1)+draincap(psize,PCH,1) +
	2 * cols * gatecap(Wmemcellr,2.0);

	Ctotal += (rports * cols * 2* Ctlcap) +(wports * ((cols * 2* Cblcap) + (rows * Cwlcap)));

	return (Ctotal*Powerfactor*AF);
}
	
double cam_tagmatch(rows, cols, rports, wports)
	int rows, cols, rports, wports; {
	double Ctotal, Cmlcap;
	double matchlinelength;
	int ports;
	Ctotal=0;

	ports = rports + wports;

	matchlinelength = cols *(CamCellWidth + ports * TaglineSpacing);

	Cmlcap = 2 * cols * draincap(Wcomparen1,NCH,2) +Cmetal * matchlinelength+ draincap(Wmatchpchg,NCH,1) +gatecap(Wmatchinvn+Wmatchinvp,10.0) +gatecap(Wmatchnandn+Wmatchnandp,10.0);

	Ctotal += rports * rows * Cmlcap;

	global_clockcap += rports * rows * gatecap(Wmatchpchg,5.0);

	/* noring the nanded match lines */
	if (ruu_issue_width >= 8)
		Ctotal += 2 * gatecap(Wmatchnorn+Wmatchnorp,10.0);

	return (Ctotal*Powerfactor*AF);
}

double cam_array(rows, cols, rports, wports)
	int rows, cols, rports, wports; {
	return (cam_tagdrive(rows,cols,rports,wports) + 
			cam_tagmatch(rows,cols,rports,wports));
}

double selection_power(int win_entries) {
	double Ctotal, Cor, Cpencode;
	int num_arbiter=1;

	Ctotal=0;

	while (win_entries > 4) {
		win_entries = (int)ceil((double)win_entries / 4.0);
		num_arbiter += win_entries;
	}

	Cor = 4 * draincap(WSelORn,NCH,1) + draincap(WSelORprequ,PCH,1);

	Cpencode = draincap(WSelPn,NCH,1) + draincap(WSelPp,PCH,1) + 
			   2*draincap(WSelPn,NCH,1) + draincap(WSelPp,PCH,2) + 
			   3*draincap(WSelPn,NCH,1) + draincap(WSelPp,PCH,3) + 
			   4*draincap(WSelPn,NCH,1) + draincap(WSelPp,PCH,4) + 
			   4*gatecap(WSelEnn+WSelEnp,20.0) +4*draincap(WSelEnn,NCH,1) + 
			   4*draincap(WSelEnp,PCH,1);

	Ctotal += ruu_issue_width * num_arbiter*(Cor+Cpencode);

	return (Ctotal*Powerfactor*AF);
}

/* very rough clock power estimates */
double total_clockpower(double die_length) {

	double clocklinelength;
	double Cline, Cline2, Ctotal;
	double pipereg_clockcap=0;
	double global_buffercap = 0;
	double Clockpower;

	double num_piperegs;

	int npreg_width = (int)ceil(logtwo((double)RUU_size));

	/* Assume say 8 stages (kinda low now).
	 FIXME: this could be a lot better; user could input
	 number of pipestages, etc  */

	/* assume 8 pipe stages and try to estimate bits per pipe stage */
	/* pipe stage 0/1 */
	num_piperegs = ruu_issue_width*inst_length + data_width;
	/* pipe stage 1/2 */
	num_piperegs += ruu_issue_width*(inst_length + 3 * RUU_size);
	/* pipe stage 2/3 */
	num_piperegs += ruu_issue_width*(inst_length + 3 * RUU_size);
	/* pipe stage 3/4 */
	num_piperegs += ruu_issue_width*(3 * npreg_width + pow2(opcode_length));
	/* pipe stage 4/5 */
	num_piperegs += ruu_issue_width*(2*data_width + pow2(opcode_length));
	/* pipe stage 5/6 */
	num_piperegs += ruu_issue_width*(data_width + pow2(opcode_length));
	/* pipe stage 6/7 */
	num_piperegs += ruu_issue_width*(data_width + pow2(opcode_length));
	/* pipe stage 7/8 */
	num_piperegs += ruu_issue_width*(data_width + pow2(opcode_length));

	/* assume 50% extra in control signals (rule of thumb) */
	num_piperegs = num_piperegs * 1.5;

	pipereg_clockcap = num_piperegs * 4*gatecap(10.0,0);

	/* estimate based on 3% of die being in clock metal */
	Cline2 = Cmetal * (.03 * die_length * die_length/BitlineSpacing) * 1e6 * 1e6;

	/* another estimate */
	clocklinelength = die_length*(.5 + 4 * (.25 + 2*(.25)+ 4 * (.125)));
	Cline = 20 * Cmetal* (clocklinelength) * 1e6;
	global_buffercap = 12*gatecap(1000.0,10.0)+16*gatecap(200,10.0)+16*8*2*gatecap(100.0,10.00) + 2*gatecap(.29*1e6,10.0);
	/* global_clockcap is computed within each array structure for pre-charge tx's*/
	Ctotal = Cline+global_clockcap+pipereg_clockcap+global_buffercap;

	if(verbose)
	fprintf(stderr,"num_piperegs == %f\n",num_piperegs);

	
	/* PowerSMT Added */
	/* add I_ADD Clockcap and F_ADD Clockcap */
	// Clockpower = Ctotal*Powerfactor + res_ialu * I_ADD_CLOCK + res_fpalu * F_ADD_CLOCK;
	
	Clockpower = Ctotal * Powerfactor + res_ialu * I_ADD_CLOCK + 
										res_fpalu * F_ADD_CLOCK +			/* FP-ALU, floating point adder/subtractor */
										res_imult * MAX(I_MULT_CLOCK, I_DIV_CLOCK) + 	/* integer-MULT/DIV, integer multiplier/divider */
										res_memport * (RD_PORT_CLOCK + WR_PORT_CLOCK) +			/* memory-port */
										res_fpmult * (MAX(F_MULT_CLOCK, F_DIV_CLOCK) + F_SQRT_CLOCK) +	/* FP-MULT/DIV, floating point multiplier/divider */
										res_divmult * (F_DIV_MULT_CLOCK + MAX(I_ADD_CLOCK, F_ADD_CLOCK) + F_CMP_CLOCK + F_CVT_CLOCK + MAX(I_MULT_CLOCK, F_MULT_CLOCK) + MAX(I_DIV_CLOCK, F_DIV_CLOCK)  + F_SQRT_CLOCK) + /* DIV/MULT, divider/multiplier */
										res_homo * (MAX(I_ADD_CLOCK, F_ADD_CLOCK) + F_CMP_CLOCK + F_CVT_CLOCK + MAX(I_MULT_CLOCK, F_MULT_CLOCK) + MAX(I_DIV_CLOCK, F_DIV_CLOCK)  + F_SQRT_CLOCK + RD_PORT_CLOCK + WR_PORT_CLOCK);	/* homogeneous */
	/* PowerSMT Added */
	
	if(verbose) {
		fprintf(stderr,"Global Clock Power: %g\n",Clockpower);
		fprintf(stderr," Global Metal Lines   (W): %g\n",Cline*Powerfactor);
		fprintf(stderr," Global Metal Lines (3%%) (W): %g\n",Cline2*Powerfactor);
		fprintf(stderr," Global Clock Buffers (W): %g\n",global_buffercap*Powerfactor);

		/* PowerSMT Added */
		// fprintf(stderr," Global Clock Cap (Explicit) (W): %g\n",global_clockcap * Powerfactor + I_ADD_CLOCK + F_ADD_CLOCK);
		fprintf(stderr," Global Clock Cap (Explicit) (W): %g\n",global_clockcap * Powerfactor + I_ADD_CLOCK + F_ADD_CLOCK + MAX(I_MULT_CLOCK, I_DIV_CLOCK) + (RD_PORT_CLOCK + WR_PORT_CLOCK) + (MAX(F_MULT_CLOCK, F_DIV_CLOCK) + F_SQRT_CLOCK) + (F_DIV_MULT_CLOCK + MAX(I_ADD_CLOCK, F_ADD_CLOCK) + F_CMP_CLOCK + F_CVT_CLOCK + MAX(I_MULT_CLOCK, F_MULT_CLOCK) + MAX(I_DIV_CLOCK, F_DIV_CLOCK)  + F_SQRT_CLOCK) + (MAX(I_ADD_CLOCK, F_ADD_CLOCK) + F_CMP_CLOCK + F_CVT_CLOCK + MAX(I_MULT_CLOCK, F_MULT_CLOCK) + MAX(I_DIV_CLOCK, F_DIV_CLOCK)  + F_SQRT_CLOCK + RD_PORT_CLOCK + WR_PORT_CLOCK));
		/* PowerSMT Added */
		fprintf(stderr," Global Clock Cap (Implicit) (W): %g\n",pipereg_clockcap*Powerfactor);
	}
	
	return(Clockpower);

}

/* very rough global clock power estimates */
double global_clockpower(double die_length) {

	double clocklinelength;
	double Cline, Cline2, Ctotal;
	double global_buffercap = 0;

	Cline2 = Cmetal * (.03 * die_length * die_length/BitlineSpacing) * 1e6 * 1e6;

	clocklinelength = die_length*(.5 + 4 * (.25 + 2*(.25)+ 4 * (.125)));
	Cline = 20 * Cmetal* (clocklinelength) * 1e6;
	global_buffercap = 12*gatecap(1000.0,10.0)+16*gatecap(200,10.0)+16*8*2*gatecap(100.0,10.00) + 2*gatecap(.29*1e6,10.0);
	Ctotal = Cline+global_buffercap;

	if(verbose) {
		fprintf(stderr,"Global Clock Power: %g\n",Ctotal*Powerfactor);
		fprintf(stderr," Global Metal Lines   (W): %g\n",Cline*Powerfactor);
		fprintf(stderr," Global Metal Lines (3%%) (W): %g\n",Cline2*Powerfactor);
		fprintf(stderr," Global Clock Buffers (W): %g\n",global_buffercap*Powerfactor);
	}

	return(Ctotal*Powerfactor);

}

double compute_resultbus_power() {
	double Ctotal, Cline;

	double regfile_height;

	/* compute size of result bus tags */
	int npreg_width = (int)ceil(logtwo((double)RUU_size));

	Ctotal=0;

	regfile_height = RUU_size * (RegCellHeight +
	WordlineSpacing * 3 * ruu_issue_width);

	/* assume num alu's == ialu  (FIXME: generate a more detailed result bus network model*/
	Cline = Cmetal * (regfile_height + .5 * res_ialu * 3200.0 * LSCALE);

	/* or use result bus length measured from 21264 die photo */
	/*  Cline = Cmetal * 3.3*1000;*/

	/* Assume ruu_issue_width result busses -- power can be scaled linearly
	 for number of result busses (scale by writeback_access) */
	Ctotal += 2.0 * (data_width + npreg_width)* (ruu_issue_width)* Cline;

#ifdef STATIC_AF
	return(Ctotal*Powerfactor*AF);
#else
	return (Ctotal*Powerfactor);
#endif

}

void calculate_power(power)
	power_result_type *power; 
{
		
	// fprintf(stdout,"in calculate_power\n");
	
	// fprintf(stdout,"FUDGEFACTOR: %f", FUDGEFACTOR); 
	
	double clockpower;
	double predeclength, wordlinelength, bitlinelength;
	
	/* CACTI 4.0 */
	// int ndwl, ndbl, nspd, ntwl, ntbl, ntspd, c, b, a, cache, rowsb, colsb;
	int ndwl, ndbl, ntwl, ntbl, ntspd, c, b, a, cache, rowsb, colsb;
	double nspd;
	/* CACTI 4.0 */
	
	
	int trowsb, tcolsb, tagsize;
	
	// VA acredita-se que seja Virtual Address. Aqui defini-se o tamanho do endereçamento virtual considerado.
	int va_size = 48;

	int npreg_width = (int)ceil(logtwo((double)RUU_size));

	/* these variables are needed to use Cacti to auto-size cache arrays (for optimal delay) */
	/* CACTI 4.0 */
	
	// time_result_type time_result;
	// time_parameter_type time_parameters;
	
	total_result_type result_total;
		
	/* CACTI 4.0 */

	/* used to autosize other structures, like bpred tables */
	int scale_factor;

	global_clockcap = 0;

	cache=0;

	/* FIXME: ALU power is a simple constant, it would be better
	 to include bit AFs and have different numbers for different
	 types of operations */
	// power->ialu_power = res_ialu * I_ADD;
	// power->falu_power = res_fpalu * F_ADD;
	
	/* PowerSMT Added */
	power->ialu_power  		= res_ialu * I_ADD; 							/* integer-ALU, instructions classes treated (ICT): IntALU */
	// res_imult -> integer-MULT/DIV.quantify.
	power->imult_div_power 	= res_imult * MAX(I_MULT, I_DIV);				/* integer-MULT/DIV, integer multiplier/divider, ICT: IntMULT, IntDIV */
	power->mem_port_power 	= res_memport * (RD_PORT + WR_PORT);			/* memory-port, ICT: RdPort, WrPort */
	power->fpalu_power 			= res_fpalu * F_ADD;						/* FP-ALU, floating point adder/subtractor, ITC: FloatADD, FloatCMP, FloatCVT */
	power->fpmult_div_power = res_fpmult * (MAX(F_MULT, F_DIV) + F_SQRT);	/* FP-MULT/DIV, floating point multiplier/divider, ICT: FloatMULT, FloatDIV, 
		  														 		       FloatSQRT */
	power->divmult_power 	= res_divmult * (F_DIV_MULT + MAX(I_ADD, F_ADD) + F_CMP + F_CVT + MAX(I_MULT, F_MULT) + MAX(I_DIV, F_DIV)  + F_SQRT); 		/* DIV/MULT, divider/multiplier, ICT: IntALU, FloatADD, FloatCMP, FloatCVT, 
		  														 		       IntMULT, IntDIV, FloatMULT, FloatDIV, FloatSQRT */
	power->homo_power 		= res_homo * (MAX(I_ADD, F_ADD) + F_CMP + F_CVT + MAX(I_MULT, F_MULT) + MAX(I_DIV, F_DIV)  + F_SQRT + RD_PORT + WR_PORT);	/* homogeneous: ICT: IntALU, IntMULT, IntDIV, FloatADD, FloatCMP, FloatCVT,IntMULT, IntDIV, FloatMULT, FloatDIV, FloatSQRT, RdPort, WrPort */ 
	/* PowerSMT Added */

	nvreg_width = (int)ceil(logtwo((double)MD_NUM_IREGS));
	npreg_width = (int)ceil(logtwo((double)RUU_size));

	/* RAT has shadow bits stored in each cell, this makes the
	 cell size larger than normal array structures, so we must
	 compute it here */

	predeclength = MD_NUM_IREGS * (RatCellHeight + 3 * ruu_decode_width * WordlineSpacing);

	wordlinelength = npreg_width *(RatCellWidth + 6 * ruu_decode_width * BitlineSpacing + RatShiftRegWidth*RatNumShift);

	bitlinelength = MD_NUM_IREGS * (RatCellHeight + 3 * ruu_decode_width * WordlineSpacing);

	if (verbose)
		fprintf(stderr,"rat power stats\n");
	power->rat_decoder = array_decoder_power(MD_NUM_IREGS,npreg_width,predeclength,2*ruu_decode_width,ruu_decode_width,cache);
	power->rat_wordline = array_wordline_power(MD_NUM_IREGS,npreg_width,wordlinelength,2*ruu_decode_width,ruu_decode_width,cache);
	power->rat_bitline = array_bitline_power(MD_NUM_IREGS,npreg_width,bitlinelength,2*ruu_decode_width,ruu_decode_width,cache);
	power->rat_senseamp = 0;

	power->dcl_compare = dcl_compare_power(nvreg_width);
	power->dcl_pencode = 0;
	power->inst_decoder_power = ruu_decode_width * simple_array_decoder_power(opcode_length,1,1,1,cache);
	power->wakeup_tagdrive =cam_tagdrive(RUU_size,npreg_width,ruu_issue_width,ruu_issue_width);
	power->wakeup_tagmatch =cam_tagmatch(RUU_size,npreg_width,ruu_issue_width,ruu_issue_width);
	power->wakeup_ormatch =0;

	power->selection = selection_power(RUU_size);

	predeclength = MD_NUM_IREGS * (RegCellHeight + 3 * ruu_issue_width * WordlineSpacing);

	wordlinelength = data_width *(RegCellWidth +
	6 * ruu_issue_width * BitlineSpacing);

	bitlinelength = MD_NUM_IREGS * (RegCellHeight + 3 * ruu_issue_width * WordlineSpacing);

	if (verbose)
		fprintf(stderr,"regfile power stats\n");

	power->regfile_decoder = array_decoder_power(MD_NUM_IREGS,data_width,predeclength,2*ruu_issue_width,ruu_issue_width,cache);
	power->regfile_wordline = array_wordline_power(MD_NUM_IREGS,data_width,wordlinelength,2*ruu_issue_width,ruu_issue_width,cache);
	power->regfile_bitline = array_bitline_power(MD_NUM_IREGS,data_width,bitlinelength,2*ruu_issue_width,ruu_issue_width,cache);
	power->regfile_senseamp =0;

	predeclength = RUU_size * (RegCellHeight + 3 * ruu_issue_width * WordlineSpacing);

	wordlinelength = data_width *(RegCellWidth + 6 * ruu_issue_width * BitlineSpacing);

	bitlinelength = RUU_size * (RegCellHeight + 3 * ruu_issue_width * WordlineSpacing);

	if (verbose)
		fprintf(stderr,"res station power stats\n");
	power->rs_decoder = array_decoder_power(RUU_size,
																					data_width,
																					predeclength,
																					2*ruu_issue_width,
																					ruu_issue_width,
																					cache);
	power->rs_wordline = array_wordline_power(RUU_size,
																						data_width,
																						wordlinelength,
																						2*ruu_issue_width,
																						ruu_issue_width,
																						cache);
	power->rs_bitline = array_bitline_power(RUU_size,
																					data_width,
																					bitlinelength,
																					2*ruu_issue_width,
																					ruu_issue_width,
																					cache);
	/* no senseamps in reg file structures (only caches) */
	power->rs_senseamp =0;

	/* addresses go into lsq tag's */
	power->lsq_wakeup_tagdrive =cam_tagdrive(	LSQ_size,
																						data_width,
																						res_memport,
																						res_memport);
	power->lsq_wakeup_tagmatch =cam_tagmatch(	LSQ_size,
																						data_width,
																						res_memport,
																						res_memport);
	power->lsq_wakeup_ormatch =0;

	wordlinelength = data_width *(RegCellWidth +
	4 * res_memport * BitlineSpacing);

	bitlinelength = RUU_size * (RegCellHeight + 4 * res_memport * WordlineSpacing);

	/* rs's hold data */
	if (verbose)
		fprintf(stderr,"lsq station power stats\n");
	power->lsq_rs_decoder = array_decoder_power(LSQ_size,data_width,predeclength,res_memport,res_memport,cache);
	power->lsq_rs_wordline = array_wordline_power(LSQ_size,
																								data_width,
																								wordlinelength,
																								res_memport,
																								res_memport,
																								cache);
	power->lsq_rs_bitline = array_bitline_power(LSQ_size,
																							data_width,
																							bitlinelength,
																							res_memport,
																							res_memport,
																							cache);
	power->lsq_rs_senseamp =0;

	power->resultbus = compute_resultbus_power();

	/* Load cache values into what cacti is expecting */
	// time_parameters.cache_size = btb_config[0] * (data_width/8)* btb_config[1]; /* C */
	// time_parameters.block_size = (data_width/8); /* B */
	// time_parameters.associativity = btb_config[1]; /* A */
	// time_parameters.number_of_sets = btb_config[0]; /* C/(B*A) */
	
	fprintf(stderr,"\n*** Calculating btb consumption parameters\n");

	/* have Cacti compute optimal cache config */
	// calculate_time(	 &time_result, &time_parameters);
	// output_data(&time_result, &time_parameters);
	
	result_total = cacti_interface(/*C*/ (btb_config[0] * (data_width/8)* btb_config[1]), 
			 				  	   /*B*/ (data_width/8), 
			 				  	   /*A*/ btb_config[1], 
			 				  	   /*RWP*/ 1, 
			 				  	   /*ERP*/ 0, 
			 				  	   /*EWP*/ 0, 
			 				  	   /*NSER*/ 0 , 
			 				  	   /*Nbanks*/ 1, 
			 				  	   /*TECH*/ TECH_LENGTH , 
			 				  	   /*OUTPUTWIDTH*/ 64, 
			 				  	   /*CUSTOMTAG*/ 0, 
			 				  	   /*TAGWIDTH*/ 0, 
			 				  	   /*ACCESSMODE*/ 0, 
			 				  	   /*PURESRAM*/ 0);
	
	output_data(&result_total.result, &result_total.area, &result_total.params);

	/* extract Cacti results */
//	ndwl=time_result.best_Ndwl;
//	ndbl=time_result.best_Ndbl;
//	nspd=time_result.best_Nspd;
//	ntwl=time_result.best_Ntwl;
//	ntbl=time_result.best_Ntbl;
//	ntspd=time_result.best_Ntspd;
//	c = time_parameters.cache_size;
//	b = time_parameters.block_size;
//	a = time_parameters.associativity;
	
	ndwl=result_total.result.best_Ndwl;
	ndbl=result_total.result.best_Ndbl;
	nspd=result_total.result.best_Nspd;
	ntwl=result_total.result.best_Ntwl;
	ntbl=result_total.result.best_Ntbl;
	ntspd=result_total.result.best_Ntspd;
	c = (btb_config[0] * (data_width/8)* btb_config[1]);
	b = (data_width/8);
	a = btb_config[1];
	
	cache=1;

	/* Figure out how many rows/cols there are now */
	rowsb = c/(b*a*ndbl*nspd);
	colsb = 8*b*a*nspd/ndwl;

	if (verbose) {
		fprintf(stderr,"%d KB %d-way btb (%d-byte block size):\n",c,a,b);
		fprintf(stderr,"ndwl == %d, ndbl == %d, nspd == %f\n",ndwl,ndbl,nspd);
		fprintf(stderr,"%d sets of %d rows x %d cols\n",ndwl*ndbl,rowsb,colsb);
	}

	predeclength = rowsb * (RegCellHeight + WordlineSpacing);
	wordlinelength = colsb * (RegCellWidth + BitlineSpacing);
	bitlinelength = rowsb * (RegCellHeight + WordlineSpacing);

	if (verbose)
		fprintf(stderr,"btb power stats\n");
	power->btb = ndwl*ndbl*(array_decoder_power(rowsb,
												colsb,
												predeclength,
												1,
												1,
												cache) 
						   + array_wordline_power(rowsb,
								   				  colsb,
								   				  wordlinelength,
								   				  1,
								   				  1,
								   				  cache) 
						   + array_bitline_power(rowsb,
								   				 colsb,
								   				 bitlinelength,
								   				 1,
								   				 1,
								   				 cache) 
						   + senseamp_power(colsb));

	cache=1;

	scale_factor = squarify(twolev_config[0], twolev_config[2]);
	predeclength = (twolev_config[0] / scale_factor)* (RegCellHeight + WordlineSpacing);
	wordlinelength = twolev_config[2] * scale_factor * (RegCellWidth + BitlineSpacing);
	bitlinelength = (twolev_config[0] / scale_factor) * (RegCellHeight + WordlineSpacing);

	if (verbose)
		fprintf(stderr,"local predict power stats\n");

	power->local_predict = array_decoder_power(	twolev_config[0]/scale_factor,
												twolev_config[2]*scale_factor,
												predeclength,
												1,
												1,
												cache) 
						   + array_wordline_power(twolev_config[0]/scale_factor,
								   				  twolev_config[2]*scale_factor,
								   				  wordlinelength,
								   				  1,
								   				  1,
								   				  cache) 
						   + array_bitline_power(twolev_config[0]/scale_factor,
								   				 twolev_config[2]*scale_factor,
								   				 bitlinelength,
								   				 1,
								   				 1,
								   				 cache) 
						   + senseamp_power(twolev_config[2]*scale_factor);

	scale_factor = squarify(twolev_config[1],3);

	predeclength = (twolev_config[1] / scale_factor)* (RegCellHeight + WordlineSpacing);
	wordlinelength = 3 * scale_factor * (RegCellWidth + BitlineSpacing);
	bitlinelength = (twolev_config[1] / scale_factor) * (RegCellHeight + WordlineSpacing);

	if (verbose)
		fprintf(stderr,"local predict power stats\n");
	power->local_predict += array_decoder_power(twolev_config[1]/scale_factor,
												3*scale_factor,
												predeclength,
												1,
												1,
												cache) 
							+ array_wordline_power(twolev_config[1]/scale_factor,
												   3*scale_factor,
												   wordlinelength,
												   1,
												   1,
												   cache) 
							+ array_bitline_power(twolev_config[1]/scale_factor,
												  3*scale_factor,
												  bitlinelength,
												  1,
												  1,
												  cache) 
							+ senseamp_power(3*scale_factor);

	if (verbose)
		fprintf(stderr,"bimod_config[0] == %d\n",bimod_config[0]);

	scale_factor = squarify(bimod_config[0], 2);

	predeclength = bimod_config[0]/scale_factor * (RegCellHeight + WordlineSpacing);
	wordlinelength = 2*scale_factor * (RegCellWidth + BitlineSpacing);
	bitlinelength = bimod_config[0]/scale_factor * (RegCellHeight + WordlineSpacing);

	if (verbose)
		fprintf(stderr,"global predict power stats\n");
	power->global_predict = array_decoder_power(bimod_config[0]/scale_factor,
																							2*scale_factor,
																							predeclength,
																							1,
																							1,
																							cache) + array_wordline_power(bimod_config[0]/scale_factor,
																																						2*scale_factor,
																																						wordlinelength,
																																						1,
																																						1,
																																						cache) + array_bitline_power(	bimod_config[0]/scale_factor,
																																																					2*scale_factor,
																																																					bitlinelength,
																																																					1,
																																																					1,
																																																					cache) + senseamp_power(2*scale_factor);

	scale_factor = squarify(comb_config[0],
													2);

	predeclength = comb_config[0]/scale_factor * (RegCellHeight + WordlineSpacing);
	wordlinelength = 2*scale_factor * (RegCellWidth + BitlineSpacing);
	bitlinelength = comb_config[0]/scale_factor * (RegCellHeight + WordlineSpacing);

	if (verbose)
		fprintf(stderr,"chooser predict power stats\n");
	power->chooser = array_decoder_power(comb_config[0]/scale_factor,
																				2*scale_factor,
																				predeclength,
																				1,
																				1,
																				cache) + array_wordline_power(comb_config[0]/scale_factor,
																																			2*scale_factor,
																																			wordlinelength,
																																			1,
																																			1,
																																			cache) + array_bitline_power(	comb_config[0]/scale_factor,
																																																		2*scale_factor,
																																																		bitlinelength,
																																																		1,
																																																		1,
																																																		cache) + senseamp_power(2*scale_factor);

	if (verbose)
		fprintf(stderr,"RAS predict power stats\n");
	power->ras = simple_array_power(ras_size,
																	data_width,
																	1,
																	1,
																	0);

	tagsize = va_size - ((int)logtwo(cache_dl1->nsets) + (int)logtwo(cache_dl1->bsize));

	if (verbose)
		fprintf(stderr,"dtlb predict power stats\n");
	power->dtlb = res_memport*(cam_array(	dtlb->nsets,
																				va_size - (int)logtwo((double)dtlb->bsize),
																				1,
																				1) + simple_array_power(dtlb->nsets,
																																tagsize,
																																1,
																																1,
																																cache));

	tagsize = va_size - ((int)logtwo(cache_il1->nsets) + (int)logtwo(cache_il1->bsize));

	predeclength = itlb->nsets * (RegCellHeight + WordlineSpacing);
	wordlinelength = logtwo((double)itlb->bsize) * (RegCellWidth + BitlineSpacing);
	bitlinelength = itlb->nsets * (RegCellHeight + WordlineSpacing);

	if (verbose)
		fprintf(stderr,"itlb predict power stats\n");
	power->itlb = cam_array(itlb->nsets,
													va_size - (int)logtwo((double)itlb->bsize),
													1,
													1) + simple_array_power(itlb->nsets,
																									tagsize,
																									1,
																									1,
																									cache);

	cache=1;

	// time_parameters.cache_size = cache_il1->nsets * cache_il1->bsize* cache_il1->assoc; /* C */
	// time_parameters.block_size = cache_il1->bsize; /* B */
	// time_parameters.associativity = cache_il1->assoc; /* A */
	// time_parameters.number_of_sets = cache_il1->nsets; /* C/(B*A) */
	
	/* CACTI 4.0 */
	
	c = cache_il1->nsets * cache_il1->bsize * cache_il1->assoc; /* C */
	b = cache_il1->bsize; /* B */
	a = cache_il1->assoc; /* A */
	// time_parameters.number_of_sets = cache_il1->nsets; /* C/(B*A) */
	
	/* CACTI 4.0 */
	
	fprintf(stderr,"\n*** Calculating il1 consumption parameters\n");

	/* Call the CACTI functions */
	// calculate_time(	 &time_result, &time_parameters);
	// output_data(&time_result, &time_parameters);
	
	result_total = cacti_interface(/*C*/c, 
				 			 /*B*/ b, 
				 			 /*A*/ a, 
							 /*RWP*/ 1, 
							 /*ERP*/ 0, 
							 /*EWP*/ 0, 
							 /*NSER*/ 0 , 
							 /*Nbanks*/ 1, 
							 /*TECH*/ TECH_LENGTH , 
							 /*OUTPUTWIDTH*/ 64, 
							 /*CUSTOMTAG*/ 0, 
							 /*TAGWIDTH*/ 0, 
							 /*ACCESSMODE*/ 0, 
							 /*PURESRAM*/ 0);
	
	output_data(&result_total.result, &result_total.area, &result_total.params);
	
	
	// ndwl=time_result.best_Ndwl;
	// ndbl=time_result.best_Ndbl;
	// nspd=time_result.best_Nspd;
	// ntwl=time_result.best_Ntwl;
	// ntbl=time_result.best_Ntbl;
	// ntspd=time_result.best_Ntspd;

	// c = time_parameters.cache_size;
	// b = time_parameters.block_size;
	// a = time_parameters.associativity;
	
	
	ndwl=result_total.result.best_Ndwl;
	ndbl=result_total.result.best_Ndbl;
	nspd=result_total.result.best_Nspd;
	ntwl=result_total.result.best_Ntwl;
	ntbl=result_total.result.best_Ntbl;
	ntspd=result_total.result.best_Ntspd;
	

	rowsb = c/(b*a*ndbl*nspd);
	colsb = 8*b*a*nspd/ndwl;

	tagsize = va_size - ((int)logtwo(cache_il1->nsets) + (int)logtwo(cache_il1->bsize));
	trowsb = c/(b*a*ntbl*ntspd);
	tcolsb = a * (tagsize + 1 + 6)* ntspd/ntwl;

	if (verbose) {
		fprintf(stderr,"%d KB %d-way cache (%d-byte block size):\n",c,a,b);
		fprintf(stderr,"ndwl == %d, ndbl == %d, nspd == %f\n",ndwl,ndbl,nspd);
		fprintf(stderr,"%d sets of %d rows x %d cols\n",ndwl*ndbl,rowsb,colsb);
		fprintf(stderr,"tagsize == %d\n",tagsize);
	}

	predeclength = rowsb * (RegCellHeight + WordlineSpacing);
	wordlinelength = colsb * (RegCellWidth + BitlineSpacing);
	bitlinelength = rowsb * (RegCellHeight + WordlineSpacing);

	if (verbose)
		fprintf(stderr,"icache power stats\n");
	power->icache_decoder = ndwl*ndbl*array_decoder_power(rowsb, colsb, predeclength, 1, 1, cache);
	power->icache_wordline = ndwl*ndbl*array_wordline_power(rowsb, colsb, wordlinelength, 1, 1, cache);
	power->icache_bitline = ndwl*ndbl*array_bitline_power(rowsb, colsb, bitlinelength, 1, 1, cache);
	power->icache_senseamp = ndwl*ndbl*senseamp_power(colsb);
	power->icache_tagarray = ntwl*ntbl*(simple_array_power(	trowsb, tcolsb, 1, 1, cache));

	power->icache_power = power->icache_decoder + power->icache_wordline+ power->icache_bitline+ power->icache_senseamp+ power->icache_tagarray;

	
	// time_parameters.cache_size = cache_dl1->nsets * cache_dl1->bsize* cache_dl1->assoc; /* C */
	// time_parameters.block_size = cache_dl1->bsize; /* B */
	// time_parameters.associativity = cache_dl1->assoc; /* A */
	// time_parameters.number_of_sets = cache_dl1->nsets; /* C/(B*A) */
	
	c = cache_dl1->nsets * cache_dl1->bsize* cache_dl1->assoc; /* C */
	b = cache_dl1->bsize; /* B */
	a = cache_dl1->assoc; /* A */
	
	fprintf(stderr,"\n*** Calculating dl1 consumption parameters\n");

	// calculate_time(	 &time_result, &time_parameters);
	// output_data(&time_result, &time_parameters);
	
	result_total = cacti_interface(/*C*/c, 
					 		 /*B*/ b, 
					 		 /*A*/ a, 
							 /*RWP*/ 1, 
							 /*ERP*/ 0, 
							 /*EWP*/ 0, 
							 /*NSER*/ 0 , 
							 /*Nbanks*/ 1, 
							 /*TECH*/ TECH_LENGTH , 
							 /*OUTPUTWIDTH*/ 64, 
							 /*CUSTOMTAG*/ 0, 
							 /*TAGWIDTH*/ 0, 
							 /*ACCESSMODE*/ 0, 
							 /*PURESRAM*/ 0);
		
	output_data(&result_total.result, &result_total.area, &result_total.params);
	

	/*ndwl=time_result.best_Ndwl;
	ndbl=time_result.best_Ndbl;
	nspd=time_result.best_Nspd;
	ntwl=time_result.best_Ntwl;
	ntbl=time_result.best_Ntbl;
	ntspd=time_result.best_Ntspd;
	c = time_parameters.cache_size;
	b = time_parameters.block_size;
	a = time_parameters.associativity;*/
		
	ndwl=result_total.result.best_Ndwl;
	ndbl=result_total.result.best_Ndbl;
	nspd=result_total.result.best_Nspd;
	ntwl=result_total.result.best_Ntwl;
	ntbl=result_total.result.best_Ntbl;
	ntspd=result_total.result.best_Ntspd;

	cache=1;

	rowsb = c/(b*a*ndbl*nspd);
	colsb = 8*b*a*nspd/ndwl;

	tagsize = va_size - ((int)logtwo(cache_dl1->nsets) + (int)logtwo(cache_dl1->bsize));
	trowsb = c/(b*a*ntbl*ntspd);
	/* PowerSMT Added */
	// tcolsb = a * (tagsize + 1 + 6)* ntspd/ntwl;
	/* No processador SMT o número do slot faz parte da tag do endereçamento, pois o mesmo é usado 
	 * para evitar que instruções de um processo sejam acessadas por outro e vice-versa.
	 * VA acredita-se que seja Virtual Address. Aqui defini-se o tamanho do endereçamento virtual considerado.
	 */
	tcolsb = a * (tagsize + 1 + 6 + logtwo((double)process_num))* ntspd/ntwl;
	/* PowerSMT Added */
	
	
	

	if (verbose) {
		fprintf(stderr,"%d KB %d-way cache (%d-byte block size):\n",c,a,b);
		fprintf(stderr,"ndwl == %d, ndbl == %d, nspd == %f\n",ndwl,ndbl,nspd);
		fprintf(stderr,"%d sets of %d rows x %d cols\n",ndwl*ndbl,rowsb,colsb);
		fprintf(stderr,"tagsize == %d\n",tagsize);

		fprintf(stderr,"\nntwl == %d, ntbl == %d, ntspd == %d\n",ntwl,ntbl,ntspd);
		fprintf(stderr,"%d sets of %d rows x %d cols\n",ntwl*ntbl,trowsb,tcolsb);
	}

	predeclength = rowsb * (RegCellHeight + WordlineSpacing);
	wordlinelength = colsb * (RegCellWidth + BitlineSpacing);
	bitlinelength = rowsb * (RegCellHeight + WordlineSpacing);

	if (verbose)
		fprintf(stderr,"dcache power stats\n");
	power->dcache_decoder = res_memport*ndwl*ndbl*array_decoder_power(rowsb,
																																		colsb,
																																		predeclength,
																																		1,
																																		1,
																																		cache);
	power->dcache_wordline = res_memport*ndwl*ndbl*array_wordline_power(rowsb,
																																			colsb,
																																			wordlinelength,
																																			1,
																																			1,
																																			cache);
	power->dcache_bitline = res_memport*ndwl*ndbl*array_bitline_power(rowsb,
																																		colsb,
																																		bitlinelength,
																																		1,
																																		1,
																																		cache);
	power->dcache_senseamp = res_memport*ndwl*ndbl*senseamp_power(colsb);
	power->dcache_tagarray = res_memport*ntwl*ntbl*(simple_array_power(	trowsb,
																																			tcolsb,
																																			1,
																																			1,
																																			cache));

	power->dcache_power = power->dcache_decoder + power->dcache_wordline+ power->dcache_bitline+ power->dcache_senseamp+ power->dcache_tagarray;

	clockpower = total_clockpower(.018);
	power->clock_power = clockpower;
	if (verbose) {
		fprintf(stderr,"result bus power == %f\n",power->resultbus);
		fprintf(stderr,"global clock power == %f\n",clockpower);
	}
	
	/* DL2 consumption */

	// time_parameters.cache_size = cache_dl2->nsets * cache_dl2->bsize* cache_dl2->assoc; /* C */
	// time_parameters.block_size = cache_dl2->bsize; /* B */
	// time_parameters.associativity = cache_dl2->assoc; /* A */
	// time_parameters.number_of_sets = cache_dl2->nsets; /* C/(B*A) */
	
	c = cache_dl2->nsets * cache_dl2->bsize* cache_dl2->assoc; /* C */
	b = cache_dl2->bsize; /* B */
	a = cache_dl2->assoc; /* A */
	
	fprintf(stderr,"Calculating dl2 consumption parameters\n");

	// calculate_time(	 &time_result, &time_parameters);
	// output_data(&time_result, &time_parameters);
	
	result_total = cacti_interface(/*C*/c, 
						 		 /*B*/ b, 
						 		 /*A*/ a, 
								 /*RWP*/ 1, 
								 /*ERP*/ 0, 
								 /*EWP*/ 0, 
								 /*NSER*/ 0 , 
								 /*Nbanks*/ 1, 
								 /*TECH*/ TECH_LENGTH , 
								 /*OUTPUTWIDTH*/ 64, 
								 /*CUSTOMTAG*/ 0, 
								 /*TAGWIDTH*/ 0, 
								 /*ACCESSMODE*/ 0, 
								 /*PURESRAM*/ 0);
			
	output_data(&result_total.result, &result_total.area, &result_total.params);
		

	/*ndwl=time_result.best_Ndwl;
	ndbl=time_result.best_Ndbl;
	nspd=time_result.best_Nspd;
	ntwl=time_result.best_Ntwl;
	ntbl=time_result.best_Ntbl;
	ntspd=time_result.best_Ntspd;
	c = time_parameters.cache_size;
	b = time_parameters.block_size;
	a = time_parameters.associativity;*/
			
	ndwl=result_total.result.best_Ndwl;
	ndbl=result_total.result.best_Ndbl;
	nspd=result_total.result.best_Nspd;
	ntwl=result_total.result.best_Ntwl;
	ntbl=result_total.result.best_Ntbl;
	ntspd=result_total.result.best_Ntspd;

	rowsb = c/(b*a*ndbl*nspd);
	colsb = 8*b*a*nspd/ndwl;

	tagsize = va_size - ((int)logtwo(cache_dl2->nsets) + (int)logtwo(cache_dl2->bsize));
	trowsb = c/(b*a*ntbl*ntspd);
	/* PowerSMT Added */
	// tcolsb = a * (tagsize + 1+ 6)* ntspd/ntwl;
	/* No processador SMT o número do slot faz parte da tag do endereçamento, pois o mesmo é usado 
	 * para evitar que instruções de um processo sejam acessadas por outro e vice-versa.
	 * VA acredita-se que seja Virtual Address. Aqui defini-se o tamanho do endereçamento virtual considerado.
	 */
	tcolsb = a * (tagsize + 1+ 6 + logtwo((double)process_num))* ntspd/ntwl;
	/* PowerSMT Added */
	
	if (verbose) {
		fprintf(stderr,"%d KB %d-way cache (%d-byte block size):\n",c,a,b);
		fprintf(stderr,"ndwl == %d, ndbl == %d, nspd == %f\n",ndwl,ndbl,nspd);
		fprintf(stderr,"%d sets of %d rows x %d cols\n",ndwl*ndbl,rowsb,colsb);
		fprintf(stderr,"tagsize == %d\n",tagsize);
	}

	predeclength = rowsb * (RegCellHeight + WordlineSpacing);
	wordlinelength = colsb * (RegCellWidth + BitlineSpacing);
	bitlinelength = rowsb * (RegCellHeight + WordlineSpacing);

	if (verbose)
		fprintf(stderr,"dcache2 power stats\n");
	power->dcache2_decoder = array_decoder_power(	rowsb,
																								colsb,
																								predeclength,
																								1,
																								1,
																								cache);
	power->dcache2_wordline = array_wordline_power(	rowsb,
																									colsb,
																									wordlinelength,
																									1,
																									1,
																									cache);
	power->dcache2_bitline = array_bitline_power(	rowsb,
																								colsb,
																								bitlinelength,
																								1,
																								1,
																								cache);
	power->dcache2_senseamp = senseamp_power(colsb);
	power->dcache2_tagarray = simple_array_power(	trowsb,
																								tcolsb,
																								1,
																								1,
																								cache);

	power->dcache2_power = power->dcache2_decoder + power->dcache2_wordline + power->dcache2_bitline + power->dcache2_senseamp + power->dcache2_tagarray;
	
	
	/* PowerSMT Added */
	// For each module. Modules are equals in each system cache (icache, dcache), this value must be multiplied for number of modules.
	power->icache_bank_selector = simple_array_decoder_power(il1_banks_num,1,1,1,0);
	// IL1_BANKS_TOTAL  (il1_modules_num*il1_banks_num)
	// power->icache_bank_selector = simple_array_decoder_power((process_num / il1_modules_num),1,1,1,0);
	
	// In dl1 cache not exists modules.
	power->dcache_bank_selector = simple_array_decoder_power(dl1_banks_num,1,1,1,0);
	
	power->cachel2_bank_selector = simple_array_decoder_power(l2_banks_num,1,1,1,0);
	
	
	
	// One for all modules in each system cache (icache, dcache).
	// power->icache_module_selector = simple_array_decoder_power(il1_modules_num,1,1,1,0);
	// dl1_modules_num?????
	// power->dcache_module_selector = simple_array_decoder_power(il1_modules_num,1,1,1,0);
	
	// Decoder of FETCH to instruction fetch queue (IFQ). Deve ser somada de todos os slots.
	// FETCH >> IFQ.
	// power->fetch_ifq_selector = simple_array_decoder_power(ruu_ifq_size,1,1,1,0);
	power->fetch_ifq_selector = simple_array_decoder_power((process_num / il1_modules_num),1,1,1,0);
	
	// Verificar se é distribuido.
	// Decoder of DECODE to instruction fetch queue.
	// DECODE << IFQ.
	//power->decode_ifq_selector = simple_array_decoder_power(process_num,1,1,1,0);
	// Nao tem. O Decode Stage pega 1 de cada fila no mínimo. 
	
	if (!mystricmp(ruulsq_opt, "distributed")){
		// Decoder of DECODE to RUU.
		// DECODE >> RUU.
		power->decode_ruu_selector = simple_array_decoder_power(process_num,1,1,1,0);
		// Decoder of ISSUE << RUU. 
		power->issue_ruu_selector = simple_array_decoder_power(process_num,1,1,1,0);		
		
	}else{ /* all slots shared the structure, don't need decoder to one entry */
		power->decode_ruu_selector = 0.0;
		power->issue_ruu_selector = 0.0;
	}
	
	// Decoder of ISSUE >> RS.
	// power->issue_readyqueue_selector = simple_array_decoder_power(process_num,1,1,1,0);
	
	// Decoder of WRITEBACK >> RUU.
	power->writeback_ruu_selector = power->issue_ruu_selector;
	
	// ROB selector.
	power->rob_selector = simple_array_decoder_power(process_num,1,1,1,0);
	
	power->itlb_selector = simple_array_decoder_power(process_num,1,1,1,0);
	power->dtlb_selector = simple_array_decoder_power(process_num,1,1,1,0);
	power->btb_selector = simple_array_decoder_power(process_num,1,1,1,0);
	
	
	fprintf(stdout," |-icache_bank_selector: %g\n", power->icache_bank_selector);
	fprintf(stdout," |-dcache_bank_selector: %g\n", power->dcache_bank_selector);
	fprintf(stdout," |-cachel2_bank_selector: %g\n", power->cachel2_bank_selector);
	fprintf(stdout," |-fetch_ifq_selector: %g\n", power->fetch_ifq_selector);
	fprintf(stdout," |-decode_ruu_selector: %g\n", power->decode_ruu_selector);
	fprintf(stdout," |-issue_ruu_selector: %g\n", power->issue_ruu_selector);		
	fprintf(stdout," |-writeback_ruu_selector: %g\n", power->writeback_ruu_selector);
	fprintf(stdout," |-rob_selector: %g\n", power->rob_selector); 
	fprintf(stdout," |-itlb_selector: %g\n", power->itlb_selector);
	fprintf(stdout," |-dtlb_selector: %g\n", power->dtlb_selector);
	fprintf(stdout," |-btb_selector: %g\n", power->btb_selector);
		
	
	/* PowerSMT Added */
	

	power->rat_decoder *= crossover_scaling;
	power->rat_wordline *= crossover_scaling;
	power->rat_bitline *= crossover_scaling;

	power->dcl_compare *= crossover_scaling;
	power->dcl_pencode *= crossover_scaling;
	power->inst_decoder_power *= crossover_scaling;
	power->wakeup_tagdrive *= crossover_scaling;
	power->wakeup_tagmatch *= crossover_scaling;
	power->wakeup_ormatch *= crossover_scaling;

	power->selection *= crossover_scaling;

	power->regfile_decoder *= crossover_scaling;
	power->regfile_wordline *= crossover_scaling;
	power->regfile_bitline *= crossover_scaling;
	power->regfile_senseamp *= crossover_scaling;

	power->rs_decoder *= crossover_scaling;
	power->rs_wordline *= crossover_scaling;
	power->rs_bitline *= crossover_scaling;
	power->rs_senseamp *= crossover_scaling;

	power->lsq_wakeup_tagdrive *= crossover_scaling;
	power->lsq_wakeup_tagmatch *= crossover_scaling;

	power->lsq_rs_decoder *= crossover_scaling;
	power->lsq_rs_wordline *= crossover_scaling;
	power->lsq_rs_bitline *= crossover_scaling;
	power->lsq_rs_senseamp *= crossover_scaling;

	power->resultbus *= crossover_scaling;

	power->btb *= crossover_scaling;
	power->local_predict *= crossover_scaling;
	power->global_predict *= crossover_scaling;
	power->chooser *= crossover_scaling;

	power->dtlb *= crossover_scaling;

	power->itlb *= crossover_scaling;

	power->icache_decoder *= crossover_scaling;
	power->icache_wordline*= crossover_scaling;
	power->icache_bitline *= crossover_scaling;
	power->icache_senseamp*= crossover_scaling;
	power->icache_tagarray*= crossover_scaling;

	power->icache_power *= crossover_scaling;

	power->dcache_decoder *= crossover_scaling;
	power->dcache_wordline *= crossover_scaling;
	power->dcache_bitline *= crossover_scaling;
	power->dcache_senseamp *= crossover_scaling;
	power->dcache_tagarray *= crossover_scaling;

	power->dcache_power *= crossover_scaling;

	power->clock_power *= crossover_scaling;

	power->dcache2_decoder *= crossover_scaling;
	power->dcache2_wordline *= crossover_scaling;
	power->dcache2_bitline *= crossover_scaling;
	power->dcache2_senseamp *= crossover_scaling;
	power->dcache2_tagarray *= crossover_scaling;

	power->dcache2_power *= crossover_scaling;
	
	/* PowerSMT Added */
	power->icache_bank_selector *= crossover_scaling;
	power->dcache_bank_selector *= crossover_scaling;
	
	power->cachel2_bank_selector *= crossover_scaling;
	// power->icache_module_selector *= crossover_scaling; 
	// power->dcache_module_selector *= crossover_scaling;
	power->fetch_ifq_selector *= crossover_scaling;
	// power->decode_ifq_selector *= crossover_scaling;
	power->decode_ruu_selector *= crossover_scaling;
	power->issue_ruu_selector *= crossover_scaling;		
	// power->issue_readyqueue_selector *= crossover_scaling;
	power->writeback_ruu_selector *= crossover_scaling;
	
	power->rob_selector *= crossover_scaling; 
	power->itlb_selector *= crossover_scaling;
	power->dtlb_selector *= crossover_scaling;
	power->btb_selector *= crossover_scaling;
	/* PowerSMT Added */
	
	power->total_power = power->local_predict + power->global_predict+power->chooser+ power->btb+power->rat_decoder+ power->rat_wordline+power->rat_bitline+ power->rat_senseamp+power->dcl_compare+ power->dcl_pencode+power->inst_decoder_power+power->wakeup_tagdrive+ power->wakeup_tagmatch
			+power->selection+power->regfile_decoder+ power->regfile_wordline+power->regfile_bitline+ power->regfile_senseamp+power->rs_decoder+ power->rs_wordline+power->rs_bitline+ power->rs_senseamp+power->lsq_wakeup_tagdrive+ power->lsq_wakeup_tagmatch+power->lsq_rs_decoder+ power->lsq_rs_wordline
			+power->lsq_rs_bitline+ power->lsq_rs_senseamp+power->resultbus+power->clock_power+power->icache_power+power->itlb+power->dcache_power+power->dtlb+power->dcache2_power 
			+power->icache_bank_selector + power->dcache_bank_selector; 

	power->total_power_nodcache2 =power->local_predict + power->global_predict+power->chooser+ power->btb+power->rat_decoder+ power->rat_wordline+power->rat_bitline+ power->rat_senseamp+power->dcl_compare+ power->dcl_pencode+power->inst_decoder_power+power->wakeup_tagdrive+ power->wakeup_tagmatch
			+power->selection+power->regfile_decoder+ power->regfile_wordline+power->regfile_bitline+ power->regfile_senseamp+power->rs_decoder+ power->rs_wordline+power->rs_bitline+ power->rs_senseamp+power->lsq_wakeup_tagdrive+ power->lsq_wakeup_tagmatch+power->lsq_rs_decoder+ power->lsq_rs_wordline
			+power->lsq_rs_bitline+ power->lsq_rs_senseamp+power->resultbus+power->clock_power+power->icache_power+power->itlb+power->dcache_power+power->dtlb+power->dcache2_power;

	power->bpred_power = power->btb + power->local_predict+ power->global_predict+ power->chooser+ power->ras;

	power->rat_power = power->rat_decoder +power->rat_wordline+ power->rat_bitline+ power->rat_senseamp;

	power->dcl_power = power->dcl_compare + power->dcl_pencode;

	power->rename_power = power->rat_power +power->dcl_power+power->inst_decoder_power;

	power->wakeup_power = power->wakeup_tagdrive + power->wakeup_tagmatch+power->wakeup_ormatch;

	power->rs_power = power->rs_decoder +power->rs_wordline+ power->rs_bitline+ power->rs_senseamp;

	power->rs_power_nobit = power->rs_decoder +power->rs_wordline+ power->rs_senseamp;

	power->window_power = power->wakeup_power + power->rs_power + power->selection;

	power->lsq_rs_power = power->lsq_rs_decoder +power->lsq_rs_wordline+ power->lsq_rs_bitline+power->lsq_rs_senseamp;

	power->lsq_rs_power_nobit = power->lsq_rs_decoder +power->lsq_rs_wordline+ power->lsq_rs_senseamp;

	power->lsq_wakeup_power = power->lsq_wakeup_tagdrive + power->lsq_wakeup_tagmatch;

	power->lsq_power = power->lsq_wakeup_power + power->lsq_rs_power;

	power->regfile_power = power->regfile_decoder +power->regfile_wordline+ power->regfile_bitline+power->regfile_senseamp;

	power->regfile_power_nobit = power->regfile_decoder +power->regfile_wordline+ power->regfile_senseamp;

	fprintf(stderr,"\n**Call dump_power_stats:\n");
	
	dump_power_stats(power);

	dumpVarsValues();

}

void dumpVarsValues(){
	fprintf(stderr,"Dump Variables and values in SW Scope:\n");
	fprintf(stderr,"ADDRESS_BITS: %d\n",ADDRESS_BITS);
	fprintf(stderr,"BITOUT: %d\n",BITOUT);
	fprintf(stderr,"MAXN: %d\n",MAXN); 
	fprintf(stderr,"MAXSUBARRAYS: %d\n",MAXSUBARRAYS);
	fprintf(stderr,"MAXSPD: %d\n", MAXSPD);
	fprintf(stderr,"FUDGEFACTOR: %g\n",FUDGEFACTOR);
	fprintf(stderr,"GEN_POWER_FACTOR: %g\n", GEN_POWER_FACTOR);
	fprintf(stderr,"CSCALE: %g\n",CSCALE);
	fprintf(stderr,"RSCALE: %g\n",RSCALE);
	fprintf(stderr,"LSCALE: %g\n",LSCALE);
	fprintf(stderr,"ASCALE: %g\n",ASCALE);
	fprintf(stderr,"VSCALE: %g\n",VSCALE);
	fprintf(stderr,"VTSCALE: %g\n",VTSCALE);
	fprintf(stderr,"SSCALE: %g\n",SSCALE);
	fprintf(stderr,"TECH_LENGTH: %g\n",TECH_LENGTH);
	fprintf(stderr,"Cwordmetal: %g\n",Cwordmetal);
	fprintf(stderr,"Cbitmetal: %g\n",Cbitmetal);
	fprintf(stderr,"Cmetal: %g\n",Cmetal);
	fprintf(stderr,"CM3metal: %g\n",CM3metal);  
	fprintf(stderr,"CM2metal: %g\n",CM2metal);
	fprintf(stderr,"Cndiffarea: %g\n",Cndiffarea);
	fprintf(stderr,"Cpdiffarea: %g\n",Cpdiffarea);
	fprintf(stderr,"Cndiffside: %g\n",Cndiffside);
	fprintf(stderr,"Cpdiffside: %g\n",Cpdiffside);
	fprintf(stderr,"Cndiffovlp: %g\n",Cndiffovlp);
	fprintf(stderr,"Cpdiffovlp: %g\n",Cpdiffovlp);
	fprintf(stderr,"Cnoxideovlp: %g\n",Cnoxideovlp);
	fprintf(stderr,"Cpoxideovlp: %g\n",Cpoxideovlp);
	fprintf(stderr,"Leff: %g\n",Leff);
	fprintf(stderr,"Cgate: %g\n",Cgate);
	fprintf(stderr,"Cgatepass: %g\n",Cgatepass);
	fprintf(stderr,"Cpolywire: %g\n",Cpolywire);
	fprintf(stderr,"Rnchannelstatic: %g\n",Rnchannelstatic);
	fprintf(stderr,"Rpchannelstatic: %g\n",Rpchannelstatic);
	fprintf(stderr,"Rnchannelon: %g\n",Rnchannelon);
	fprintf(stderr,"Rpchannelon: %g\n",Rpchannelon);
	fprintf(stderr,"Rbitmetal: %g\n",Rbitmetal);
	fprintf(stderr,"Rwordmetal: %g\n",Rwordmetal);
	fprintf(stderr,"Vdd: %g\n",Vdd);
	fprintf(stderr,"Mhz: %g\n", Mhz);
	fprintf(stderr,"Period: %g\n",Period);
	fprintf(stderr,"krise: %g\n",krise);
	fprintf(stderr,"tsensedata: %g\n",tsensedata);
	fprintf(stderr,"tsensetag: %g\n",tsensetag);
	fprintf(stderr,"tfalldata: %g\n",tfalldata);
	fprintf(stderr,"tfalltag: %g\n",tfalltag);
	fprintf(stderr,"Vbitpre: %g\n",Vbitpre);
	fprintf(stderr,"Vt: %g\n",Vt);
	fprintf(stderr,"Vbitsense: %g\n",Vbitsense);
	fprintf(stderr,"Powerfactor: %g\n",Powerfactor);
	fprintf(stderr,"SensePowerfactor3: %g\n",SensePowerfactor3);
	fprintf(stderr,"SensePowerfactor2: %g\n",SensePowerfactor2);
	fprintf(stderr,"SensePowerfactor: %g\n",SensePowerfactor);
	fprintf(stderr,"AF: %g\n",AF);
	fprintf(stderr,"POPCOUNT_AF: %g\n",POPCOUNT_AF);
	fprintf(stderr,"VSINV: %g\n",VSINV);
	fprintf(stderr,"VTHINV100x60: %g\n",VTHINV100x60);
	fprintf(stderr,"VTHNAND60x90: %g\n",VTHNAND60x90);
	fprintf(stderr,"VTHNOR12x4x1: %g\n",VTHNOR12x4x1);
	fprintf(stderr,"VTHNOR12x4x2: %g\n",VTHNOR12x4x2);
	fprintf(stderr,"VTHNOR12x4x3: %g\n",VTHNOR12x4x3);
	fprintf(stderr,"VTHNOR12x4x4: %g\n",VTHNOR12x4x4);
	fprintf(stderr,"VTHOUTDRINV: %g\n",VTHOUTDRINV);
	fprintf(stderr,"VTHOUTDRNOR: %g\n",VTHOUTDRNOR);
	fprintf(stderr,"VTHOUTDRNAND: %g\n",VTHOUTDRNAND);
	fprintf(stderr,"VTHOUTDRIVE: %g\n",VTHOUTDRIVE);
	fprintf(stderr,"VTHCOMPINV: %g\n",VTHCOMPINV);
	fprintf(stderr,"VTHMUXDRV1: %g\n",VTHMUXDRV1);
	fprintf(stderr,"VTHMUXDRV2: %g\n",VTHMUXDRV2);
	fprintf(stderr,"VTHMUXDRV3: %g\n",VTHMUXDRV3);
	fprintf(stderr,"VTHEVALINV: %g\n",VTHEVALINV);
	fprintf(stderr,"VTHSENSEEXTDRV: %g\n",VTHSENSEEXTDRV);
	fprintf(stderr,"Wdecdrivep: %g\n",Wdecdrivep);
	fprintf(stderr,"Wdecdriven: %g\n",Wdecdriven);
	fprintf(stderr,"Wdec3to8n: %g\n",Wdec3to8n);
	fprintf(stderr,"Wdec3to8p: %g\n",Wdec3to8p);
	fprintf(stderr,"WdecNORn: %g\n",WdecNORn);
	fprintf(stderr,"WdecNORp: %g\n",WdecNORp);
	fprintf(stderr,"Wdecinvn: %g\n",Wdecinvn);
	fprintf(stderr,"Wdecinvp: %g\n",Wdecinvp);
	fprintf(stderr,"Wworddrivemax: %g\n",Wworddrivemax);
	fprintf(stderr,"Wmemcella: %g\n",Wmemcella);
	fprintf(stderr,"Wmemcellr: %g\n",Wmemcellr);
	fprintf(stderr,"Wmemcellw: %g\n",Wmemcellw);
	fprintf(stderr,"Wmemcellbscale: %g\n",Wmemcellbscale);
	fprintf(stderr,"Wbitpreequ: %g\n",Wbitpreequ);
	fprintf(stderr,"Wbitmuxn: %g\n",Wbitmuxn);
	fprintf(stderr,"WsenseQ1to4: %g\n",WsenseQ1to4);
	fprintf(stderr,"Wcompinvp1: %g\n",Wcompinvp1);
	fprintf(stderr,"Wcompinvn1: %g\n",Wcompinvn1);
	fprintf(stderr,"Wcompinvp2: %g\n",Wcompinvp2);
	fprintf(stderr,"Wcompinvn2: %g\n",Wcompinvn2);
	fprintf(stderr,"Wcompinvp3: %g\n",Wcompinvp3);
	fprintf(stderr,"Wcompinvn3: %g\n",Wcompinvn3);
	fprintf(stderr,"Wevalinvp: %g\n",Wevalinvp);
	fprintf(stderr,"Wevalinvn: %g\n",Wevalinvn);
	fprintf(stderr,"Wcompn: %g\n",Wcompn);
	fprintf(stderr,"Wcompp: %g\n",Wcompp);
	fprintf(stderr,"Wcomppreequ: %g\n",Wcomppreequ);
	fprintf(stderr,"Wmuxdrv12n: %g\n",Wmuxdrv12n);
	fprintf(stderr,"Wmuxdrv12p: %g\n",Wmuxdrv12p);
	fprintf(stderr,"WmuxdrvNANDn: %g\n",WmuxdrvNANDn);
	fprintf(stderr,"WmuxdrvNANDp: %g\n",WmuxdrvNANDp);
	fprintf(stderr,"WmuxdrvNORn: %g\n",WmuxdrvNORn);
	fprintf(stderr,"WmuxdrvNORp: %g\n",WmuxdrvNORp);
	fprintf(stderr,"Wmuxdrv3n: %g\n",Wmuxdrv3n);
	fprintf(stderr,"Wmuxdrv3p: %g\n",Wmuxdrv3p);
	fprintf(stderr,"Woutdrvseln: %g\n",Woutdrvseln);
	fprintf(stderr,"Woutdrvselp: %g\n",Woutdrvselp);
	fprintf(stderr,"Woutdrvnandn: %g\n",Woutdrvnandn);
	fprintf(stderr,"Woutdrvnandp: %g\n",Woutdrvnandp);
	fprintf(stderr,"Woutdrvnorn: %g\n",Woutdrvnorn);
	fprintf(stderr,"Woutdrvnorp: %g\n",Woutdrvnorp);
	fprintf(stderr,"Woutdrivern: %g\n",Woutdrivern);
	fprintf(stderr,"Woutdriverp: %g\n",Woutdriverp);
	fprintf(stderr,"Wcompcellpd2: %g\n",Wcompcellpd2);
	fprintf(stderr,"Wcompdrivern: %g\n",Wcompdrivern);
	fprintf(stderr,"Wcompdriverp: %g\n",Wcompdriverp);
	fprintf(stderr,"Wcomparen2: %g\n",Wcomparen2);
	fprintf(stderr,"Wcomparen1: %g\n",Wcomparen1);
	fprintf(stderr,"Wmatchpchg: %g\n",Wmatchpchg);
	fprintf(stderr,"Wmatchinvn: %g\n",Wmatchinvn);
	fprintf(stderr,"Wmatchinvp: %g\n",Wmatchinvp);
	fprintf(stderr,"Wmatchnandn: %g\n",Wmatchnandn);
	fprintf(stderr,"Wmatchnandp: %g\n",Wmatchnandp);
	fprintf(stderr,"Wmatchnorn: %g\n",Wmatchnorn);
	fprintf(stderr,"Wmatchnorp: %g\n",Wmatchnorp);
	fprintf(stderr,"WSelORn: %g\n",WSelORn);
	fprintf(stderr,"WSelORprequ: %g\n",WSelORprequ);
	fprintf(stderr,"WSelPn: %g\n",WSelPn);
	fprintf(stderr,"WSelPp: %g\n",WSelPp);
	fprintf(stderr,"WSelEnn: %g\n",WSelEnn);
	fprintf(stderr,"WSelEnp: %g\n",WSelEnp);
	fprintf(stderr,"Wsenseextdrv1p: %g\n",Wsenseextdrv1p);
	fprintf(stderr,"Wsenseextdrv1n: %g\n",Wsenseextdrv1n);
	fprintf(stderr,"Wsenseextdrv2p: %g\n",Wsenseextdrv2p);
	fprintf(stderr,"Wsenseextdrv2n: %g\n",Wsenseextdrv2n);
	fprintf(stderr,"BitWidth: %g\n",BitWidth);
	fprintf(stderr,"BitHeight: %g\n",BitHeight);
	fprintf(stderr,"Cout: %g\n",Cout);
	fprintf(stderr,"RatCellHeight: %g\n",RatCellHeight);
	fprintf(stderr,"RatCellWidth: %g\n",RatCellWidth);
	fprintf(stderr,"RatShiftRegWidth: %g\n",RatShiftRegWidth);
	fprintf(stderr,"RatNumShift: %f\n",RatNumShift);
	fprintf(stderr,"BitlineSpacing: %g\n",BitlineSpacing);
	fprintf(stderr,"WordlineSpacing: %g\n",WordlineSpacing);
	fprintf(stderr,"RegCellHeight: %g\n",RegCellHeight);
	fprintf(stderr,"RegCellWidth: %g\n",RegCellWidth);
	fprintf(stderr,"CamCellHeight: %g\n",CamCellHeight);
	fprintf(stderr,"CamCellWidth: %g\n",CamCellWidth);
	fprintf(stderr,"MatchlineSpacing: %g\n",MatchlineSpacing);
	fprintf(stderr,"TaglineSpacing: %g\n",TaglineSpacing);
	
}
