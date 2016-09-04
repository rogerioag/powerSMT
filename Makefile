# Modified Makefile - simulator suite make file for powerSMT simulator.
# Readapted by Rogerio A. Goncalves using the Makefile from ss_smt.
# Contact: rogerio.rag@gmail.com
#
# Modified Makefile - simulator suite make file for ss_smt simulator
#
# This file was adapted by Ronaldo A. L. Goncalves using the original
# Makefile from SimpleScalar 3.0 Tool
# Contact: ronaldo@din.uem.br (http://www.din.uem.br/~ronaldo)
#
# The original original file is a part of the SimpleScalar tool suite written by
# Todd M. Austin as a part of the Multiscalar Research Project.
#  
# The SimpleScalar suite is currently maintained by Doug Burger and Todd M. Austin.
#
# INTERNET: dburger@cs.wisc.edu
# US Mail:  1210 W. Dayton Street, Madison, WI 53706
#
# SimpleScalar Copyright (C) 1994, 1995, 1996, 1997, 1998 by Todd M. Austin
#
# This source file is distributed "as is" in the hope that it will be
# useful.  It is distributed with no warranty, and no author or
# distributor accepts any responsibility for the consequences of its
# use. 
#
# Everyone is granted permission to copy, modify and redistribute
# this source file under the following conditions:
#
#    This tool set is distributed for non-commercial use only. 
#    Please contact the maintainer for restrictions applying to 
#    commercial use of these tools.
#
#    Permission is granted to anyone to make or distribute copies
#    of this source code, either as received or modified, in any
#    medium, provided that all copyright notices, permission and
#    nonwarranty notices are preserved, and that the distributor
#    grants the recipient permission for further redistribution as
#    permitted by this document.
#
#    Permission is granted to distribute this file in compiled
#    or executable form under the same conditions that apply for
#    source code, provided that either:
#
#    A. it is accompanied by the corresponding machine-readable
#       source code,
#    B. it is accompanied by a written offer, with no time limit,
#       to give anyone a machine-readable copy of the corresponding
#       source code in return for reimbursement of the cost of
#       distribution.  This written offer must permit verbatim
#       duplication by anyone, or
#    C. it is distributed by someone who received only the
#       executable form, and is accompanied by a copy of the
#       written offer of source code that they received concurrently.
#
# In other words, you are welcome to use, share and improve this
# source file.  You are forbidden to forbid anyone else to use, share
# and improve what you give them.
# 
# Adaptation 1.2  2007/11/12  Rogerio A. Goncalves
# The Makefile was adapted to support the powerSMT version 1.0.
# 
# Adaptation 1.1  2002/01/06  Guilherme Dal Pizzol
# The original Makefile was adapted to support the multiproc.c and ss_smt
# version 1.0.
# The Makefile was simplyfied in order to become specific to ss_smt 1.0
#
# Adaptation 1.0  1999/11/10  Ronaldo A. L. Goncalves
# The original Makefile was adapted to support the multiproc.c version 1.0.
# The Makefile was simplyfied in order to become specific to multiPROC 1.0
#
# $Id: Makefile,v 1.8 1998/08/31 17:05:49 taustin Exp taustin $
#
# $Log: Makefile,v $
# Revision 1.8  1998/08/31 17:05:49  taustin
# added support for MS VC++ NMAKE builds (works with v5.0 SR3 or later)
#
# Revision 1.7  1998/08/27 07:40:03  taustin
# reorganized Makefile: it now works with MS VC++ NMAKE, and many host
#    configurations are supplied in the header; added target configuration
#    support; converted "sim-tests" target to use "-redir:sim" and
#    "-redir:prog" options, this eliminates the need for the "redir"
#    scripts
#
# Revision 1.6  1997/04/16  22:08:40  taustin
# added standalone loader support
#
# Revision 1.5  1997/03/11  01:04:13  taustin
# updated copyright
# CC target now supported
# RANLIB target now supported
# MAKE target now supported
# CFLAGS reorganized
# MFLAGS and MLIBS to improve portability
#
# Revision 1.1  1996/12/05  18:56:09  taustin
# Initial revision
#
# 

##################################################################
#
# Modify the following definitions to suit your build environment,
# NOTE: most platforms should not require any changes
#
##################################################################

#
# Define below C compiler and flags, machine-specific flags and libraries,
# build tools and file extensions, these are specific to a host environment,
# pre-tested environments follow...
#

##
## vanilla Unix, GCC build
##
## NOTE: the SimpleScalar simulators must be compiled with an ANSI C
## compatible compiler.
##
## tested hosts:
##
##	Slackware Linux version 2.0.33, GNU GCC version 2.7.2.2
##	FreeBSD version 3.0-current, GNU egcs version 2.91.50
##	Alpha OSF1 version 4.0, GNU GCC version 2.7.2
##	PA-RISC HPUX version B.10.01, GNU GCC version 2.7-96q3
##	SPARC SunOS version 5.5.1, GNU egcs-2.90.29
##	RS/6000 AIX Unix version 4, GNU GCC version cygnus-2.7-96q4
##	Windows NT version 4.0, Cygnus CygWin/32 beta 19
##
CC = gcc
OFLAGS = -O0 -g -Wall
MFLAGS = `./sysprobe -flags`
MLIBS  = `./sysprobe -libs` -lm
ENDIAN = `./sysprobe -s`
MAKE = make
AR = ar qcv
AROPT =
RANLIB = ranlib
RM = rm -f
RMDIR = rm -f
LN = ln -s
LNDIR = ln -s
DIFF = diff
OEXT = o
LEXT = a
LEX = flex
EEXT =
CS = ;
X=/

##
## Alpha OSF1 version 4.0, DEC C compiler version V5.2-036
##
#CC = cc -std
#OFLAGS = -O0 -g -w
#MFLAGS = `./sysprobe -flags`
#MLIBS  = `./sysprobe -libs` -lm
#ENDIAN = `./sysprobe -s`
#MAKE = make
#AR = ar qcv
#AROPT =
#RANLIB = ranlib
#RM = rm -f
#RMDIR = rm -f
#LN = ln -s
#LNDIR = ln -s
#DIFF = diff
#OEXT = o
#LEXT = a
#EEXT =
#CS = ;
#X=/

##
## PA-RISC HPUX version B.10.01, c89 HP C compiler version A.10.31.02
##
#CC = c89 +e -D__CC_C89
#OFLAGS = -g
#MFLAGS = `./sysprobe -flags`
#MLIBS  = `./sysprobe -libs` -lm
#ENDIAN = `./sysprobe -s`
#MAKE = make
#AR = ar qcv
#AROPT =
#RANLIB = ranlib
#RM = rm -f
#RMDIR = rm -f
#LN = ln -s
#LNDIR = ln -s
#DIFF = diff
#OEXT = o
#LEXT = a
#EEXT =
#CS = ;
#X=/

##
## SPARC SunOS version 5.5.1, Sun WorkShop C Compiler (acc) version 4.2
##
#CC = /opt/SUNWspro/SC4.2/bin/acc
#OFLAGS = -O0 -g
#MFLAGS = `./sysprobe -flags`
#MLIBS  = `./sysprobe -libs` -lm
#ENDIAN = `./sysprobe -s`
#MAKE = make
#AR = ar qcv
#AROPT =
#RANLIB = ranlib
#RM = rm -f
#RMDIR = rm -f
#LN = ln -s
#LNDIR = ln -s
#DIFF = diff
#OEXT = o
#LEXT = a
#EEXT =
#CS = ;
#X=/

##
## RS/6000 AIX Unix version 4, xlc compiler build
##
#CC = xlc -D__CC_XLC
#OFLAGS = -g
#MFLAGS = `./sysprobe -flags`
#MLIBS  = `./sysprobe -libs` -lm
#ENDIAN = `./sysprobe -s`
#MAKE = make
#AR = ar qcv
#AROPT =
#RANLIB = ranlib
#RM = rm -f
#RMDIR = rm -f
#LN = ln -s
#LNDIR = ln -s
#DIFF = diff
#OEXT = o
#LEXT = a
#EEXT =
#CS = ;
#X=/

##
## WinNT, MS VC++ build
##
## NOTE: requires MS VC++ version 5.0 + service pack 3 or later
## NOTE1: before configuring the simulator, delete the symbolic link "tests/"
##
#CC = cl /Za /nologo
#OFLAGS = /W3 /Zi
#MFLAGS = -DBYTES_LITTLE_ENDIAN -DWORDS_LITTLE_ENDIAN -DFAST_SRL -DFAST_SRA
#MLIBS  =
#ENDIAN = little
#MAKE = nmake /nologo
#AR = lib
#AROPT = -out:
#RANLIB = dir
#RM = del/f/q
#RMDIR = del/s/f/q
#LN = copy
#LNDIR = xcopy/s/e/i
#DIFF = dir
#OEXT = obj
#LEXT = lib
#EEXT = .exe
#CS = &&
#X=\\\\

#
# Compilation-specific feature flags
#
# -DDEBUG	- turns on debugging features
# -DBFD_LOADER	- use libbfd.a to load programs (also required BINUTILS_INC
#		  and BINUTILS_LIB to be defined, see below)
# -DGZIP_PATH	- specifies path to GZIP executable, only needed if SYSPROBE
#		  cannot locate binary
# -DSLOW_SHIFTS	- emulate all shift operations, only used for testing as
#		  sysprobe will auto-detect if host can use fast shifts
#
FFLAGS = -DDEBUG

# include by Rogério A. Gonçalves (rogerio.rag@gmail.com)
# to solve compilation problem.
# /usr/bin/ld: errno: TLS definition in /lib/libc.so.6 section .tbss mismatches non-TLS reference in eval.o
# /lib/libc.so.6: could not read symbols: Bad value
# collect2: ld returned 1 exit status
# conforme post: http://www.opencascade.org/org/forum/thread_9224/
# Bob Mitchel  	2005-12-13 08:45
# If you get an error such as this:
# What you need to do is this: open the appropriate makefile (i.e. in TKIGES), find the line DEFAULT_INCLUDES, 
# and add -include /usr/include/errno.h to the end. This applies to gcc-3.3.6, at least. 
# Bob
ADD_INCLUDES = -include /usr/include/errno.h

#
# Point the Makefile to your Simplescalar-based bunutils, these definitions
# should indicate where the include and library directories reside.
# NOTE: these definitions are only required if BFD_LOADER is defined.
#
#BINUTILS_INC = -I../include
#BINUTILS_LIB = -L../lib

#
#


##################################################################
#
# YOU SHOULD NOT NEED TO MODIFY ANYTHING BELOW THIS COMMENT
#
##################################################################

#
# complete flags
#
CFLAGS = $(MFLAGS) $(FFLAGS) $(OFLAGS) $(BINUTILS_INC) $(BINUTILS_LIB) $(ADD_INCLUDES)

#
# all the sources
#

SRCS =	main.c powerSMT.c \
        memory.c regs.c cache.c bpred.c ptrace.c \
	resource.c endian.c dlite.c symbol.c eval.c options.c range.c \
	eio.c stats.c misc.c machine.c loader.c syscall.c libexo.c powerinit.c power.c activationctrl.c


HDRS =	syscall.h memory.h regs.h sim.h loader.h cache.h bpred.h ptrace.h \
	resource.h endian.h dlite.h symbol.h eval.h bitmap.h eio.h \
    range.h version.h misc.h machine.h machine.def ecoff.h \
    power.h activationctrl.h

#
# common objects
#
OBJS =	main.$(OEXT) syscall.$(OEXT) memory.$(OEXT) regs.$(OEXT) \
	loader.$(OEXT) endian.$(OEXT) dlite.$(OEXT) symbol.$(OEXT) \
	eval.$(OEXT) options.$(OEXT) stats.$(OEXT) eio.$(OEXT) \
	range.$(OEXT) misc.$(OEXT) machine.$(OEXT) power.$(OEXT) \
	activationctrl.$(OEXT)

#
# programs to build
#

PROGS = powerSMT$(EEXT) 

#
# all targets, NOTE: library ordering is important...
#
all: $(PROGS)
	@echo "my work is done here..."


clean: 
	$(RM) *.o *.a $(PROGS) sysprobe$(EEXT) *~ Makefile.bak
	cd cacti $(CS) $(MAKE) "RM=$(RM)" "CS=$(CS)" clean $(CS) cd ..

powerSMT$(EEXT):	sysprobe$(EEXT) powerSMT.$(OEXT) cache.$(OEXT) bpred.$(OEXT) resource.$(OEXT) ptrace.$(OEXT) powerinit.$(OEXT) $(OBJS) libexo.$(LEXT) cacti/libcacti.$(LEXT)
	$(CC) -o powerSMT$(EEXT) $(CFLAGS) powerSMT.$(OEXT) cache.$(OEXT) bpred.$(OEXT) resource.$(OEXT) ptrace.$(OEXT) powerinit.$(OEXT) $(OBJS) libexo.$(LEXT) cacti/libcacti.$(LEXT) $(MLIBS)

sysprobe$(EEXT):	sysprobe.c
	$(CC) $(FFLAGS) -o sysprobe$(EEXT) sysprobe.c
	@echo endian probe results: $(ENDIAN)
	@echo probe flags: $(MFLAGS)
	@echo probe libs: $(MLIBS)

libexo.$(LEXT):	libexo.$(OEXT) exolex.$(OEXT)
	$(RM) libexo.$(LEXT)
	$(AR) $(AROPT)libexo.$(LEXT) libexo.$(OEXT) exolex.$(OEXT)
	$(RANLIB) libexo.$(LEXT)
	
cacti cacti/libcacti.$(LEXT): sysprobe$(EEXT)
	cd cacti $(CS) \
	$(MAKE) "MAKE=$(MAKE)" "CC=$(CC)" "AR=$(AR)" "AROPT=$(AROPT)" "RANLIB=$(RANLIB)" "CFLAGS=$(MFLAGS) $(FFLAGS) $(SAFEOFLAGS)" "OEXT=$(OEXT)" "LEXT=$(LEXT)" "EEXT=$(EEXT)" "X=$(X)" "RM=$(RM)" libcacti.$(LEXT)
	
power$(EEXT):	power.c
	$(CC) $(SAFECFLAGS) -c power.c

.c.$(OEXT):
	$(CC) $(CFLAGS) -c $*.c

exolex.c:	exolex.l
	$(LEX) exolex.l
	mv -f lex.yy.c exolex.c


filelist:
	@echo $(SRCS) $(HDRS) Makefile


# DO NOT DELETE THIS LINE -- make depend depends on it.

main.$(OEXT): host.h misc.h machine.h machine.def endian.h version.h dlite.h
main.$(OEXT): regs.h memory.h options.h stats.h eval.h loader.h sim.h

powerSMT.$(OEXT): host.h misc.h machine.h machine.def regs.h memory.h
powerSMT.$(OEXT): options.h stats.h eval.h cache.h loader.h syscall.h
powerSMT.$(OEXT): bpred.h resource.h bitmap.h ptrace.h range.h dlite.h
powerSMT.$(OEXT): sim.h
powerSMT.$(OEXT): activationctrl.h
memory.$(OEXT): host.h misc.h machine.h machine.def options.h stats.h eval.h
memory.$(OEXT): memory.h
regs.$(OEXT): host.h misc.h machine.h machine.def loader.h regs.h memory.h
regs.$(OEXT): options.h stats.h eval.h
cache.$(OEXT): host.h misc.h machine.h machine.def cache.h memory.h options.h
cache.$(OEXT): stats.h eval.h
bpred.$(OEXT): host.h misc.h machine.h machine.def bpred.h stats.h eval.h
ptrace.$(OEXT): host.h misc.h machine.h machine.def range.h ptrace.h
resource.$(OEXT): host.h misc.h resource.h
endian.$(OEXT): endian.h loader.h host.h misc.h machine.h machine.def regs.h
endian.$(OEXT): memory.h options.h stats.h eval.h
dlite.$(OEXT): host.h misc.h machine.h machine.def version.h eval.h regs.h
dlite.$(OEXT): memory.h options.h stats.h sim.h symbol.h loader.h range.h
dlite.$(OEXT): dlite.h
symbol.$(OEXT): host.h misc.h ecoff.h loader.h machine.h
symbol.$(OEXT): machine.def regs.h memory.h options.h stats.h eval.h symbol.h
eval.$(OEXT): host.h misc.h eval.h machine.h machine.def
options.$(OEXT): host.h misc.h options.h
range.$(OEXT): host.h misc.h machine.h machine.def symbol.h loader.h regs.h
range.$(OEXT): memory.h options.h stats.h eval.h range.h
eio.$(OEXT): host.h misc.h machine.h machine.def regs.h memory.h options.h
eio.$(OEXT): stats.h eval.h loader.h libexo.h host.h misc.h machine.h
eio.$(OEXT): syscall.h sim.h endian.h eio.h
stats.$(OEXT): host.h misc.h machine.h machine.def eval.h stats.h
endian.$(OEXT): endian.h loader.h host.h misc.h machine.h machine.def regs.h
powerinit.$(OEXT): power.h stats.h options.h
endian.$(OEXT): memory.h options.h stats.h eval.h
misc.$(OEXT): host.h misc.h machine.h machine.def
power.$(OEXT): host.h misc.h machine.h machine.def cache.h memory.h options.h
power.$(OEXT): stats.h eval.h power.h
loader.$(OEXT): host.h misc.h machine.h machine.def endian.h regs.h memory.h
loader.$(OEXT): options.h stats.h eval.h sim.h eio.h loader.h ecoff.h
syscall.$(OEXT): host.h misc.h machine.h machine.def regs.h memory.h
syscall.$(OEXT): options.h stats.h eval.h loader.h sim.h endian.h eio.h
syscall.$(OEXT): syscall.h
symbol.$(OEXT): host.h misc.h ecoff.h loader.h machine.h
symbol.$(OEXT): machine.def regs.h memory.h options.h stats.h eval.h symbol.h
alpha.$(OEXT): host.h misc.h machine.h machine.def eval.h regs.h
loader.$(OEXT): host.h misc.h machine.h machine.def endian.h regs.h memory.h
loader.$(OEXT): options.h stats.h eval.h sim.h eio.h loader.h ecoff.h
syscall.$(OEXT): host.h misc.h machine.h machine.def regs.h memory.h
syscall.$(OEXT): options.h stats.h eval.h loader.h sim.h endian.h eio.h
syscall.$(OEXT): syscall.h
symbol.$(OEXT): host.h misc.h loader.h machine.h machine.def regs.h memory.h
symbol.$(OEXT): options.h stats.h eval.h symbol.h ecoff.h
machine.$(OEXT): host.h misc.h machine.h eval.h regs.h
libexo.$(OEXT): host.h misc.h machine.h host.h misc.h
libexo.$(OEXT): machine.def libexo.h
exolex.$(OEXT): host.h misc.h libexo.h machine.h host.h misc.h
exolex.$(OEXT): machine.def

