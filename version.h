/*
 * version.h - simulator suite version definitions
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
 * $Id: version.h,v 1.4 1998/08/27 16:42:15 taustin Exp taustin $
 *
 * $Log: version.h,v $
 * Revision 1.4  1998/08/27 16:42:15  taustin
 * added target designator
 * updated version
 *
 * Revision 1.3  1997/03/11  01:35:16  taustin
 * update copyright
 * version updated for second release
 *
 * Revision 1.1  1996/12/05  18:50:23  taustin
 * Initial revision
 *
 *
 */

#if defined(TARGET_PISA)
#define VER_TARGET		"PISA"
#elif defined(TARGET_ALPHA)
#define VER_TARGET		"Alpha"
#else
#error Cannot decode SimpleScalar target...
#endif

#define VER_MAJOR		3	/* second release */
#define VER_MINOR		0

#define VER_UPDATE	        "September, 1998"


/* SS_SMT */
#define SS_SMT_VER_MAJOR			1
#define SS_SMT_VER_MINOR			0
#define SS_SMT_VER_UPDATE			"2000"

/* Sim-Wattch */
#define SW_VER_MAJOR			1
#define SW_VER_MINOR			2
#define SW_VER_UPDATE			"2000"

/* CACTI */
#define CACTI_VER_MAJOR			4
#define CACTI_VER_MINOR			0
#define CACTI_VER_UPDATE		"2005"

/* PowerSMT */
#define POWER_SMT_VER_MAJOR		1
#define POWER_SMT_VER_MINOR		0
#define POWER_SMT_VER_UPDATE "August, 2008"
