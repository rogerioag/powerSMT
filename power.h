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

#include "stats.h"

/*  The following are things you might want to change
 *  when compiling
 */

/*
 * The output can be in 'long' format, which shows everything, or
 * 'short' format, which is just what a program like 'grap' would
 * want to see
 */

#define LONG 1
#define SHORT 2

#define OUTPUTTYPE LONG

/* Do we want static AFs (STATIC_AF) or Dynamic AFs (DYNAMIC_AF) */
/* #define DYNAMIC_AF */
#define DYNAMIC_AF

/*
 * Address bits in a word, and number of output bits from the cache 
 */

#define ADDRESS_BITS 64
#define BITOUT 64

/* limits on the various N parameters */

#define MAXN 8            /* Maximum for Ndwl,Ntwl,Ndbl,Ntbl */
#define MAXSUBARRAYS 8    /* Maximum subarrays for data and tag arrays */
#define MAXSPD 8          /* Maximum for Nspd, Ntspd */

/*===================================================================*/

/*
 * The following are things you probably wouldn't want to change.  
 */


#define TRUE 1
#define FALSE 0
#define OK 1
#define ERROR 0
#define BIGNUM 1e30
#define DIVIDE(a,b) ((b)==0)? 0:(a)/(b)
#ifndef MAX
#define MAX(a,b) (((a)>(b))?(a):(b))
#endif

/* Used to communicate with the horowitz model */

#define RISE 1
#define FALL 0
#define NCH  1
#define PCH  0

/*
 * The following scale factor can be used to scale between technologies.
 * To convert from 0.8um to 0.5um, make FUDGEFACTOR = 1.6
 */

/* Tech 0.8um */
#define FUDGEFACTOR 1.0

/*===================================================================*/
/*
 * Cache layout parameters and process parameters 
 * Thanks to Glenn Reinman for the technology scaling factors
 */

/* Used to pass values around the program */

/*typedef struct {
   int tech;
   int iw;
   int winsize;
   int nvreg;
   int npreg;
   int nvreg_width;
   int npreg_width;
   int data_width;
} parameter_type;*/

typedef struct {
  double btb;
  double local_predict;
  double global_predict;
  double chooser;
  double ras;
  double rat_driver;
  double rat_decoder;
  double rat_wordline;
  double rat_bitline;
  double rat_senseamp;
  double dcl_compare;
  double dcl_pencode;
  double inst_decoder_power;
  double wakeup_tagdrive;
  double wakeup_tagmatch;
  double wakeup_ormatch;
  double lsq_wakeup_tagdrive;
  double lsq_wakeup_tagmatch;
  double lsq_wakeup_ormatch;
  double selection;
  double regfile_driver;
  double regfile_decoder;
  double regfile_wordline;
  double regfile_bitline;
  double regfile_senseamp;
  double reorder_driver;
  double reorder_decoder;
  double reorder_wordline;
  double reorder_bitline;
  double reorder_senseamp;
  double rs_driver;
  double rs_decoder;
  double rs_wordline;
  double rs_bitline;
  double rs_senseamp;
  double lsq_rs_driver;
  double lsq_rs_decoder;
  double lsq_rs_wordline;
  double lsq_rs_bitline;
  double lsq_rs_senseamp;
  double resultbus;

  double icache_decoder;
  double icache_wordline;
  double icache_bitline;
  double icache_senseamp;
  double icache_tagarray;

  double icache;

  double dcache_decoder;
  double dcache_wordline;
  double dcache_bitline;
  double dcache_senseamp;
  double dcache_tagarray;

  double dtlb;
  double itlb;

  double dcache2_decoder;
  double dcache2_wordline;
  double dcache2_bitline;
  double dcache2_senseamp;
  double dcache2_tagarray;

  double total_power;
  double total_power_nodcache2;
  
  /* PowerSMT Added */
  // double ialu_power;
  // double falu_power;

  /* FUs Consumptions */
  
  double ialu_power;				/* integer-ALU, instructions classes treated (ICT): IntALU */
  double imult_div_power;		/* integer-MULT/DIV, integer multiplier/divider, ICT: IntMULT, IntDIV */
  double mem_port_power;		/* memory-port, ICT: RdPort, WrPort */
  double fpalu_power;				/* FP-ALU, floating point adder/subtractor, ITC: FloatADD, FloatCMP, FloatCVT */
  double fpmult_div_power;	/* FP-MULT/DIV, floating point multiplier/divider, ICT: FloatMULT, FloatDIV, 
  														 FloatSQRT */
  double divmult_power;			/* DIV/MULT, divider/multiplier, ICT: IntALU, FloatADD, FloatCMP, FloatCVT, 
  														 IntMULT, IntDIV, FloatMULT, FloatDIV, FloatSQRT */
  double homo_power;				/* homogeneous: ICT: IntALU, IntMULT, IntDIV, FloatADD, FloatCMP, FloatCVT, 
  														 FloatMULT, FloatDIV, FloatSQRT, RdPort, WrPort */
  
  /* +--------------------+---------+---------+---------+-----------+-----------+-----------+-----------+-----------+-----------+---------+---------+	
   * |	FU/ICT						|	IntALU	|	IntMULT	|	IntDIV	|	FloatADD	|	FloatCMP	|	FloatCVT	|	FloatMULT	|	FloatDIV	|	FloatSQRT	|	RdPort	|	WrPort	|		
   * +--------------------+---------+---------+---------+-----------+-----------+-----------+-----------+-----------+-----------+---------+---------+	
   * |	integer-ALU				|    X		|					|					|						|						|						|						|						|						|					|					|
   * +--------------------+---------+---------+---------+-----------+-----------+-----------+-----------+-----------+-----------+---------+---------+	
   * |	integer-MULT/DIV	|					|    X		|    X		|						|						|						|						|						|						|     		|     		|
   * +--------------------+---------+---------+---------+-----------+-----------+-----------+-----------+-----------+-----------+---------+---------+	
   * |	memory-port				|     		|					|					|						|						|						|						|						|						|    X		|    X		|
   * +--------------------+---------+---------+---------+-----------+-----------+-----------+-----------+-----------+-----------+---------+---------+	
   * |	FP-ALU						|     		|					|					|    X			|    X			|    X			|						|						|						|     		|     		|
   * +--------------------+---------+---------+---------+-----------+-----------+-----------+-----------+-----------+-----------+---------+---------+	
   * |	FP-MULT/DIV				|     		|					|					|						|						|						|    X			|    X			|    X			|     		|     		|
   * +--------------------+---------+---------+---------+-----------+-----------+-----------+-----------+-----------+-----------+---------+---------+	
   * |	DIV/MULT					|    X 		|    X		|    X		|    X			|			X			|			X			|    X			|    X			|    X			|     		|     		|
   * +--------------------+---------+---------+---------+-----------+-----------+-----------+-----------+-----------+-----------+---------+---------+	
   * |	homogeneous				|    X 		|    X		|    X		|    X			|			X			|			X			|    X			|    X			|    X			|    X 		|    X 		|
   * +--------------------+---------+---------+---------+-----------+-----------+-----------+-----------+-----------+-----------+---------+---------+	
   * */
  
  
  
  /* PowerSMT Added */
  
  double bpred_power;
  double rename_power;
  double rat_power;
  double dcl_power;
  double window_power;
  double lsq_power;
  double wakeup_power;
  double lsq_wakeup_power;
  double rs_power;
  double rs_power_nobit;
  double lsq_rs_power;
  double lsq_rs_power_nobit;
  double selection_power;
  double regfile_power;
  double regfile_power_nobit;
  double result_power;
  double icache_power;
  double dcache_power;
  double dcache2_power;

  double clock_power;
  
  /* PowerSMT Added */
  // For each module. Modules are equals in each system cache (icache, dcache), this value must be multiplied for number of modules.
  double icache_bank_selector;
  double dcache_bank_selector;
  
  double cachel2_bank_selector;
  // One for all modules in each system cache (icache, dcache).
  // double icache_module_selector;
  // double dcache_module_selector;
  // Decoder of FETCH to instruction fetch queue. Deve ser somada de todos os slots.
  double fetch_ifq_selector;
  // Decoder of DECODE to instruction fetch queue.
  // double decode_ifq_selector;
  
  
  // Decoder of DECODE to RUU.
  // DECODE >> RUU.
  double decode_ruu_selector;
  // Decoder of ISSUE << RUU. 
  double issue_ruu_selector;		
  		
  // Decoder of ISSUE >> RS.
  // double issue_readyqueue_selector;
  	
  // Decoder of WRITEBACK >> RUU.
  double writeback_ruu_selector;
  
  // ROB selector.
  double rob_selector;
  double itlb_selector;
  double dtlb_selector;
  double btb_selector;
  
  /* PowerSMT Added */

} power_result_type;

/* Used to pass values around the program */

/* CACTI 4.0 */

/*typedef struct {
   int cache_size;
   int number_of_sets;
   int associativity;
   int block_size;
} time_parameter_type;

typedef struct {
   double access_time,cycle_time;
   int best_Ndwl,best_Ndbl;
   int best_Nspd;
   int best_Ntwl,best_Ntbl;
   int best_Ntspd;
   double decoder_delay_data,decoder_delay_tag;
   double dec_data_driver,dec_data_3to8,dec_data_inv;
   double dec_tag_driver,dec_tag_3to8,dec_tag_inv;
   double wordline_delay_data,wordline_delay_tag;
   double bitline_delay_data,bitline_delay_tag;
  double sense_amp_delay_data,sense_amp_delay_tag;
  double senseext_driver_delay_data;
   double compare_part_delay;
   double drive_mux_delay;
   double selb_delay;
   double data_output_delay;
   double drive_valid_delay;
   double precharge_delay;
   
} time_result_type;*/



typedef struct {
	double dynamic;
	double leakage;
} powerComponents;

typedef struct {
	powerComponents readOp;
	powerComponents writeOp;
} powerDef;


struct cache_params_t
{
  unsigned int nsets;
  unsigned int assoc;
  unsigned int dbits;
  unsigned int tbits;

  unsigned int nbanks;
  unsigned int rport;
  unsigned int wport;
  unsigned int rwport;
  unsigned int serport; // single-ended bitline read ports 

  unsigned int obits;
  unsigned int abits;

  double dweight;
  double pweight;
  double aweight;
};

struct subarray_params_t
{
  unsigned int Ndwl;
  unsigned int Ndbl;
  unsigned int Nspd;
  unsigned int Ntwl;
  unsigned int Ntbl;
  unsigned int Ntspd;
  unsigned int muxover;
};


struct tech_params_t 
{
  double tech_size;
  double crossover;
  double standby;
  double VddPow;
  double scaling_factor;
};


typedef struct {
	double height;
	double width;
	double scaled_area;
}area_type;

typedef struct {
        area_type dataarray_area,datapredecode_area;
        area_type datacolmuxpredecode_area,datacolmuxpostdecode_area;
		area_type datawritesig_area;
        area_type tagarray_area,tagpredecode_area;
        area_type tagcolmuxpredecode_area,tagcolmuxpostdecode_area;
        area_type tagoutdrvdecode_area;
        area_type tagoutdrvsig_area;
        double totalarea, subbankarea;
		double total_dataarea;
        double total_tagarea;
		double max_efficiency, efficiency;
		double max_aspect_ratio_total, aspect_ratio_total;
		double perc_data, perc_tag, perc_cont, sub_eff, total_eff;
}arearesult_type;

typedef struct {
   int cache_size;
   int number_of_sets;
   //int associativity;
   int tag_associativity, data_associativity;
   int block_size;
   int num_write_ports;
   int num_readwrite_ports;
   int num_read_ports;
   int num_single_ended_read_ports;
  char fully_assoc;
  double fudgefactor;
  double tech_size;
  double VddPow;
  int sequential_access;
  int fast_access;
  int force_tag;
  int tag_size;
  int nr_bits_out;
  int pure_sram;
} parameter_type;

typedef struct {
	int subbanks;
   double access_time,cycle_time;
  double senseext_scale;
  powerDef total_power;
   int best_Ndwl,best_Ndbl;
  double max_power, max_access_time;
   double best_Nspd;
   int best_Ntwl,best_Ntbl;
   int best_Ntspd;
   int best_muxover;
   powerDef total_routing_power;
   powerDef total_power_without_routing, total_power_allbanks;
   double subbank_address_routing_delay;
   powerDef subbank_address_routing_power;
   double decoder_delay_data,decoder_delay_tag;
   powerDef decoder_power_data,decoder_power_tag;
   double dec_data_driver,dec_data_3to8,dec_data_inv;
   double dec_tag_driver,dec_tag_3to8,dec_tag_inv;
   double wordline_delay_data,wordline_delay_tag;
   powerDef wordline_power_data,wordline_power_tag;
   double bitline_delay_data,bitline_delay_tag;
   powerDef bitline_power_data,bitline_power_tag;
  double sense_amp_delay_data,sense_amp_delay_tag;
  powerDef sense_amp_power_data,sense_amp_power_tag;
  double total_out_driver_delay_data;
  powerDef total_out_driver_power_data;
   double compare_part_delay;
   double drive_mux_delay;
   double selb_delay;
   powerDef compare_part_power, drive_mux_power, selb_power;
   double data_output_delay;
   powerDef data_output_power;
   double drive_valid_delay;
   powerDef drive_valid_power;
   double precharge_delay;
  int data_nor_inputs;
  int tag_nor_inputs;
} result_type;

typedef struct{
	result_type result;
	arearesult_type area;
	parameter_type params;
}total_result_type;

/* CACTI 4.0 */

void power_init();

double logtwo(double x);
double gatecap(double width,double wirelength);
double gatecappass(double width,double wirelength);
double draincap(double width,int nchannel,int stack);
double restowidth(double res,int nchannel);
double simple_array_power(int rows,int cols,int rports,int wports,int cache);
double simple_array_decoder_power(int rows,int cols,int rports,int wports,int cache);
double simple_array_bitline_power(int rows,int cols,int rports,int wports,int cache);
double simple_array_wordline_power(int rows,int cols,int rports,int wports,int cache);
double squarify_new(int rows,int cols);
void clear_access_stats();
void update_power_stats();
/* register power stats */
void power_reg_stats(struct stat_sdb_t *sdb);/* stats database */

/* CACTI 4.0 */
// void calculate_time(time_result_type*, time_parameter_type*);
// void output_data(time_result_type*, time_parameter_type*);
/* CACTI 4.0 */

void calculate_power(power_result_type*);
int pop_count(quad_t bits);
int pop_count_slow(quad_t bits);

void init_all_variables_power_model();
void init_power_variables(int sn);


/* CACTI 4.0 */

total_result_type cacti_interface(
		int cache_size,
		int line_size,
		int associativity,
		int rw_ports,
		int excl_read_ports,
		int excl_write_ports,
		int single_ended_read_ports,
		int banks,
		double tech_node,
		int output_width,
		int specific_tag,
		int tag_width,
		int access_mode,
		int pure_sram);

void output_data(result_type *result,arearesult_type *arearesult, parameter_type *parameters);

/* CACTI 4.0 */


void dumpVarsValues(void);
