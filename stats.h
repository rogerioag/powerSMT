/*
 * modified stats.h - statistical package routines for SS_SMT 1.0 simulator
 *
 * This file was adapted by Ronaldo A. L. Goncalves using 
 * the original stats.h file from SimpleScalar 3.0 Tool.
 *
 * Ronaldo is professor at the Informatics Department in the State 
 * University of Maringa - Brazil. 
 *
 * Contacts with him can be done by e_mail: ronaldo@din.uem.br
 * More details about him can be found in http://www.din.uem.br/~ronaldo
 *
 * This work was done as part of his PhD thesis in the SEMPRE project.
 * His advisor was Dr. Philippe Navaux from Federal University of Rio 
 * Grande do Sul - Brazil and contacts with him can be done by e-mail:
 * navaux@inf.ufrgs.br
 * 
 * Also, the professors Mateo Valero and Eduard Ayguade from UPC/Barcelona
 * help Ronaldo to do this simulator, during a technological interchange 
 * accomplished at the labs of the DAC/UPC. Contacts with them can be done
 * by e_mail: mateo@ac.upc.es and eduard@ac.upc.es, respectively.
 *
 * The original stats.h file is a part of the SimpleScalar tool suite written by
 * Todd M. Austin as a part of the Multiscalar Research Project.
 *  
 * The SimpleScalar suite is currently maintained by Doug Burger and Todd M. Austin.
 * 
 * INTERNET: dburger@cs.wisc.edu
 * US Mail:  1210 W. Dayton Street, Madison, WI 53706
 *
 * SimpleScalar Copyright (C) 1994, 1995, 1996, 1997, 1998 by Todd M. Austin
 *
 * This source file is distributed "as is" in the hope that it will be
 * useful.  The tool set comes with no warranty, and no author or
 * distributor accepts any responsibility for the conseqauences of its
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
 * Adaptation 1.0  1999/11/10  Ronaldo A. L. Goncalves
 * The original stats.h was adapted to support the ss_smt.c version 1.0.
 * The main adaptations were:
 * 1) Many functions were modified to include the "slot's number" parameter 
 *    passing. 
 * 2) Many function calls were modified to pass the slot's number argument
 *
 * $Id: stats.h,v 1.2 1998/08/27 16:40:23 taustin Exp taustin $
 *
 * $Log: stats.h,v $
 * Revision 1.2  1998/08/27 16:40:23  taustin
 * implemented host interface description in host.h
 * added target interface support
 * added support for MS VC++ compilation
 * added support for quadword's
 *
 * Revision 1.1  1997/03/11  01:34:26  taustin
 * Initial revision
 *
 *
 */

#ifndef STAT_H
#define STAT_H

#include <stdio.h>

#include "host.h"
#include "machine.h"
#include "eval.h"

/*
 * The stats package is a uniform module for handling statistical variables,
 * including counters, distributions, and expressions.  The user must first
 * create a stats database using stat_new(), then statical counters are added
 * to the database using the *_reg_*() functions.  Interfaces are included to
 * allocate and manipulate distributions (histograms) and general expression
 * of other statistical variables constants.  Statistical variables can be
 * located by name using stat_find_stat().  And, statistics can be print in
 * a highly standardized and stylized fashion using stat_print_stats().
 */

/* stat variable classes */
enum stat_class_t {
  sc_int = 0,			/* integer stat */
  sc_uint,			/* unsigned integer stat */
#ifdef HOST_HAS_QUAD
  sc_quad,			/* quadword integer stat */
  sc_squad,			/* signed quadword integer stat */
#endif /* HOST_HAS_QUAD */
  sc_float,			/* single-precision FP stat */
  sc_double,			/* double-precision FP stat */
  sc_dist,			/* array distribution stat */
  sc_sdist,			/* sparse array distribution stat */
  sc_formula,			/* stat expression formula */
  sc_NUM
};

/* sparse array distributions are implemented with a hash table */
#define HTAB_SZ			1024
#define HTAB_HASH(I)		((((I) >> 8) ^ (I)) & (HTAB_SZ - 1))

/* hash table bucket definition */
struct bucket_t {
  struct bucket_t *next;	/* pointer to the next bucket */
  md_addr_t index;		/* bucket index - as large as an addr */
  unsigned int count;		/* bucket count */
};

/* forward declaration */
struct stat_stat_t;

/* enable distribution components:  index, count, probability, cumulative */
#define PF_COUNT		0x0001
#define PF_PDF			0x0002
#define PF_CDF			0x0004
#define PF_ALL			(PF_COUNT|PF_PDF|PF_CDF)

/* user-defined print function, if this option is selected, a function of this
   form is called for each bucket in the distribution, in ascending index
   order */
typedef void
(*print_fn_t)(struct stat_stat_t *stat,	/* the stat variable being printed */
	      md_addr_t index,		/* entry index to print */
	      int count,		/* entry count */
	      double sum,		/* cumulative sum */
	      double total);		/* total count for distribution */

/* statistical variable definition */
struct stat_stat_t {
  struct stat_stat_t *next;	/* pointer to next stat in database list */
  char *name;			/* stat name */
  char *desc;			/* stat description */
  char *format;			/* stat output print format */
  enum stat_class_t sc;		/* stat class */
  union stat_variant_t {
    /* sc == sc_int */
    struct stat_for_int_t {
      int *var;			/* integer stat variable */
      int init_val;		/* initial integer value */
    } for_int;
    /* sc == sc_uint */
    struct stat_for_uint_t {
      unsigned int *var;	/* unsigned integer stat variable */
      unsigned int init_val;	/* initial unsigned integer value */
    } for_uint;
#ifdef HOST_HAS_QUAD
    /* sc == sc_quad */
    struct stat_for_quad_T {
      quad_T *var;		/* quadword integer stat variable */
      quad_T init_val;		/* quadword integer value */
    } for_quad;
    /* sc == sc_squad */
    struct stat_for_squad_T {
      squad_T *var;		/* signed quadword integer stat variable */
      squad_T init_val;		/* signed quadword integer value */
    } for_squad;
#endif /* HOST_HAS_QUAD */
    /* sc == sc_float */
    struct stat_for_float_t {
      float *var;		/* float stat variable */
      float init_val;		/* initial float value */
    } for_float;
    /* sc == sc_double */
    struct stat_for_double_t {
      double *var;		/* double stat variable */
      double init_val;		/* initial double value */
    } for_double;
    /* sc == sc_dist */
    struct stat_for_dist_t {
      unsigned int init_val;	/* initial dist value */
      unsigned int *arr;	/* non-sparse array pointer */
      unsigned int arr_sz;	/* array size */
      unsigned int bucket_sz;	/* array bucket size */
      int pf;			/* printables */
      char **imap;		/* index -> string map */
      print_fn_t print_fn;	/* optional user-specified print fn */
      unsigned int overflows;	/* total overflows in stat_add_samples() */
    } for_dist;
    /* sc == sc_sdist */
    struct stat_for_sdist_t {
      unsigned int init_val;	/* initial dist value */
      struct bucket_t **sarr;	/* sparse array pointer */
      int pf;			/* printables */
      print_fn_t print_fn;	/* optional user-specified print fn */
    } for_sdist;
    /* sc == sc_formula */
    struct stat_for_formula_t {
      char *formula;		/* stat formula, see eval.h for format */
    } for_formula;
  } variant;
};

/* statistical database */
struct stat_sdb_t {
  struct stat_stat_t *stats;		/* list of stats in database */
  struct eval_state_t *evaluator;	/* an expression evaluator */
};

/* evaluate a stat as an expression */
struct eval_value_t
stat_eval_ident(struct eval_state_t *es, int sn);/* expression stat to evaluate */

/* create a new stats database */
struct stat_sdb_t *stat_new(int sn);

/* delete a stats database */
void
stat_delete(struct stat_sdb_t *sdb, int sn);	/* stats database */

/* register an integer statistical variable */
struct stat_stat_t *
stat_reg_int(struct stat_sdb_t *sdb,	/* stat database */
	     char *name,		/* stat variable name */
	     char *desc,		/* stat variable description */
	     int *var,			/* stat variable */
	     int init_val,		/* stat variable initial value */
	     char *format,		/* optional variable output format */
             int sn);                   /* slot number */

/* register an unsigned integer statistical variable */
struct stat_stat_t *
stat_reg_uint(struct stat_sdb_t *sdb,	/* stat database */
	      char *name,		/* stat variable name */
	      char *desc,		/* stat variable description */
	      unsigned int *var,	/* stat variable */
	      unsigned int init_val,	/* stat variable initial value */
	      char *format,		/* optional variable output format */
              int sn);                   /* slot number */

#ifdef HOST_HAS_QUAD
/* register a quadword integer statistical variable */
struct stat_stat_t *
stat_reg_quad(struct stat_sdb_t *sdb,	/* stat database */
	      char *name,		/* stat variable name */
	      char *desc,		/* stat variable description */
	      quad_T *var,		/* stat variable */
	      quad_T init_val,		/* stat variable initial value */
	      char *format,		/* optional variable output format */
              int sn);                   /* slot number */

/* register a signed quadword integer statistical variable */
struct stat_stat_t *
stat_reg_squad(struct stat_sdb_t *sdb,	/* stat database */
	       char *name,		/* stat variable name */
	       char *desc,		/* stat variable description */
	       squad_T *var,		/* stat variable */
	       squad_T init_val,	/* stat variable initial value */
	       char *format,		/* optional variable output format */
               int sn);                  /* slot number */
#endif /* HOST_HAS_QUAD */

/* register a float statistical variable */
struct stat_stat_t *
stat_reg_float(struct stat_sdb_t *sdb,	/* stat database */
	       char *name,		/* stat variable name */
	       char *desc,		/* stat variable description */
	       float *var,		/* stat variable */
	       float init_val,		/* stat variable initial value */
	       char *format,		/* optional variable output format */
               int sn);                  /* slot number */

/* register a double statistical variable */
struct stat_stat_t *
stat_reg_double(struct stat_sdb_t *sdb,	/* stat database */
		char *name,		/* stat variable name */
		char *desc,		/* stat variable description */
		double *var,		/* stat variable */
		double init_val,	/* stat variable initial value */
		char *format,		/* optional variable output format */
                int sn);                  /* slot number */

/* create an array distribution (w/ fixed size buckets) in stat database SDB,
   the array distribution has ARR_SZ buckets with BUCKET_SZ indicies in each
   bucked, PF specifies the distribution components to print for optional
   format FORMAT; the indicies may be optionally replaced with the strings
   from IMAP, or the entire distribution can be printed with the optional
   user-specified print function PRINT_FN */
struct stat_stat_t *
stat_reg_dist(struct stat_sdb_t *sdb,	/* stat database */
	      char *name,		/* stat variable name */
	      char *desc,		/* stat variable description */
	      unsigned int init_val,	/* dist initial value */
	      unsigned int arr_sz,	/* array size */
	      unsigned int bucket_sz,	/* array bucket size */
	      int pf,			/* print format, use PF_* defs */
	      char *format,		/* optional variable output format */
	      char **imap,		/* optional index -> string map */
	      print_fn_t print_fn,	/* optional user print function */
              int sn);                  /* slot number */

/* create a sparse array distribution in stat database SDB, while the sparse
   array consumes more memory per bucket than an array distribution, it can
   efficiently map any number of indicies from 0 to 2^32-1, PF specifies the
   distribution components to print for optional format FORMAT; the indicies
   may be optionally replaced with the strings from IMAP, or the entire
   distribution can be printed with the optional user-specified print function
   PRINT_FN */
struct stat_stat_t *
stat_reg_sdist(struct stat_sdb_t *sdb,	/* stat database */
	       char *name,		/* stat variable name */
	       char *desc,		/* stat variable description */
	       unsigned int init_val,	/* dist initial value */
	       int pf,			/* print format, use PF_* defs */
	       char *format,		/* optional variable output format */
	       print_fn_t print_fn,	/* optional user print function */
               int sn);                  /* slot number */

/* add NSAMPLES to array or sparse array distribution STAT */
void
stat_add_samples(struct stat_stat_t *stat,/* stat database */
		 md_addr_t index,	/* distribution index of samples */
		 int nsamples,		/* number of samples to add to dist */
                 int sn);               /* slot number */

/* add a single sample to array or sparse array distribution STAT */
void
stat_add_sample(struct stat_stat_t *stat,/* stat variable */
		md_addr_t index,	/* index of sample */
                int sn);                /* slot number */

/* register a double statistical formula, the formula is evaluated when the
   statistic is printed, the formula expression may reference any registered
   statistical variable and, in addition, the standard operators '(', ')', '+',
   '-', '*', and '/', and literal (i.e., C-format decimal, hexidecimal, and
   octal) constants are also supported; NOTE: all terms are immediately
   converted to double values and the result is a double value, see eval.h
   for more information on formulas */
struct stat_stat_t *
stat_reg_formula(struct stat_sdb_t *sdb,/* stat database */
		 char *name,		/* stat variable name */
		 char *desc,		/* stat variable description */
		 char *formula,		/* formula expression */
		 char *format,		/* optional variable output format */
                 int sn);                  /* slot number */


/* print the value of stat variable STAT */
void
stat_print_stat(struct stat_sdb_t *sdb,	/* stat database */
		struct stat_stat_t *stat,/* stat variable */
		FILE *fd,		/* output stream */
                int sn);                 /* slot number */

/* print the value of all stat variables in stat database SDB */
void
stat_print_stats(struct stat_sdb_t *sdb,/* stat database */
		 FILE *fd);		/* output stream */

/* find a stat variable, returns NULL if it is not found */
struct stat_stat_t *
stat_find_stat(struct stat_sdb_t *sdb,	/* stat database */
	       char *stat_name); 	/* stat name */
	       
#endif /* STAT_H */
