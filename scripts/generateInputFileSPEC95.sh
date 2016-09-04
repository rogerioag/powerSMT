#!/bin/bash
# Script to generate Input Files to SS_SMT and powerSMT simulators.
# Run SPEC95.
# Author: Rogério Aparecido Gonçalves (rogerio.rag@gmail.com)


# SPEC Identifier.
SPEC_NAME="SPEC95"

# File name to generate.
OUT_PUT_NAME="RUN_${SPEC_NAME}"

# Binaries and them inputs directories.
# SPEC2000.
HOME_BENCHMARKS="/opt/simuladores/benchmarks/SPEC/SPEC95/spec95.ss/spec95-little"
HOME_INPUTS="/opt/simuladores/benchmarks/SPEC/SPEC95/inputs-spec95"

# Keep the current dir.
START_DIR=`pwd`

echo "-----------------------------------------------------------------------"
echo "Start script to generate Input Files to SS_SMT and powerSMT Simulators."
echo "This script has writed by Rogerio A. Gonçalves (rogerio.rag@gmail.com) "
echo "Variables assumed:													 "
echo "HOME_BENCHMARKS: " ${HOME_BENCHMARKS}
echo "HOME_INPUTS: " ${HOME_INPUTS}
echo "START_DIR: " ${START_DIR}
echo "Generate file: " ${OUT_PUT_NAME}
echo "-----------------------------------------------------------------------"
echo "Processing..."

cd $HOME_INPUTS

# Benchmarks SPEC95
# applu.ss  cc1.ss         fpppp.ss  hydro2d.ss  li.ss       mgrid.ss  su2cor.ss  tomcatv.ss  vortex.ss
# apsi.ss   compress95.ss  go.ss     ijpeg.ss    m88ksim.ss  perl.ss   swim.ss    turb3d.ss   wave5.ss

# Command Lines.

# applu.ss
#1 float Point
# #../spec95.big/applu.ss ../inputs/applu.in 
benchmark_name[1]="applu.ss"
benchmark_type[1]="float Point"
benchmark_command_line[1]="${HOME_BENCHMARKS}/applu.ss < ${HOME_INPUTS}/applu.in"

# cc1.ss
#2 Integer
#../spec95.big/cc1.ss -quiet -funroll-loops -fforce-mem -fcse-follow-jumps  -fcse-skip-blocks -fexpensive-optimizations -fstrength-reduce -fpeephole  -fschedule-insns -finline-functions -fschedule-insns2 -O ../inputs/cccp.i -o ../inputs/cccp.s
benchmark_name[2]="cc1.ss"
benchmark_type[2]="Integer"
benchmark_command_line[2]="${HOME_BENCHMARKS}/cc1.ss -quiet -funroll-loops -fforce-mem -fcse-follow-jumps  -fcse-skip-blocks -fexpensive-optimizations -fstrength-reduce -fpeephole  -fschedule-insns -finline-functions -fschedule-insns2 -O ${HOME_INPUTS}/cccp.i -o ${HOME_INPUTS}/cccp.s"

# fpppp.ss
#3 float Point
#../spec95.big/fpppp.ss < ../inputs/natoms.in
benchmark_name[3]="fpppp.ss"
benchmark_type[3]="float Point"
benchmark_command_line[3]="${HOME_BENCHMARKS}/fpppp.ss < ${HOME_INPUTS}/natoms.in"

# hydro2d.ss
#4 ????
#../spec95.big/hydro2d.ss
# input: hydro2d.in (necessario estar no diretório de inputs)
benchmark_name[4]="hydro2d.ss"
benchmark_type[4]="????"
benchmark_command_line[4]="${HOME_BENCHMARKS}/hydro2d.ss"

# li.ss
#4 Integer
#../spec95.big/li.ss ../inputs/boyer.lsp
benchmark_name[4]="li.ss"
benchmark_type[4]="Integer"
benchmark_command_line[4]="${HOME_BENCHMARKS}/li.ss ${HOME_INPUTS}/boyer.lsp"

# mgrid.ss
#5 float Point
#../spec95.big/mgrid.ss < ../inputs/mgrid.in
benchmark_name[5]="mgrid.ss"
benchmark_type[5]="float Point"
benchmark_command_line[5]="${HOME_BENCHMARKS}/mgrid.ss < ${HOME_INPUTS}/mgrid.in"

# su2cor.ss
# Command line: su2cor.ss
# Input: su2cor.in
benchmark_name[6]="su2cor.ss"
benchmark_type[6]="????"
benchmark_command_line[6]="${HOME_BENCHMARKS}/su2cor.ss"

# tomcatv.ss
# Command line: tomcatv.ss
# Input: tomcatv.in
benchmark_name[7]="tomcatv.ss"
benchmark_type[7]="????"
benchmark_command_line[7]="${HOME_BENCHMARKS}/tomcatv.ss"

# vortex.ss
# 147.vortex: vortex.ss vortex.in
# require the file person.1k, find in inputs directories.
# Test: vortex.ss vortex.in {uses vortex.raw, lendian.rnv, lendian.wnv, persons.1k}
# Train: vortex.ss vortex.in {uses vortex.raw, lendian.rnv, lendian.wnv, persons.250}
# Reference: vortex.ss vortex.in {uses vortex.raw, lendian.rnv, lendian.wnv, persons.1k}
# NOTES: The lendian.rnv and lendian.wnv files are identical for all test sets.
#        The persons.1k and vortex.raw files differ for all test sets.
#		 The vortex.raw file must be modified to indicate the endian-ness.
benchmark_name[8]="vortex.ss"
benchmark_type[8]="Integer"
benchmark_command_line[8]="${HOME_BENCHMARKS}/vortex.ss ${HOME_INPUTS}/lendian1.raw"

# apsi.ss
benchmark_name[9]="apsi.ss"
benchmark_type[9]="float Point"
benchmark_command_line[9]="${HOME_BENCHMARKS}/apsi.ss < ${HOME_INPUTS}/apsi.in"

# compress95.ss
#9 Integer
#../spec95.big/compress95.ss < ../inputs/bigtest.in
benchmark_name[10]="compress95.ss"
benchmark_type[10]="Integer"
benchmark_command_line[10]="${HOME_BENCHMARKS}/compress95.ss < ${HOME_INPUTS}/bigtest.in"

# go.ss
# Test: go.ss 40 19 null.in
# Train: go.ss 50 9 2stone9.in
# Reference: go.ss 50 21 null.in
#            go.ss 50 21 9stone21.in
#            go.ss 50 21 5stone21.in
benchmark_name[11]="go.ss"
benchmark_type[11]="????"
benchmark_command_line[11]="${HOME_BENCHMARKS}/go.ss 50 21 ${HOME_INPUTS}/null.in"

# ijpeg.ss
#4 Integer
#../spec95.big/ijpeg.ss -image_file ../inputs/specmun.ppm -compression.quality 90 -compression.optimize_coding 0 -compression.smoothing_factor 90 -difference.image 1 -difference.x_stride 10 -difference.y_stride 10 -verbose 1 -GO.findoptcomp
benchmark_name[12]="ijpeg.ss"
benchmark_type[12]="Integer"
benchmark_command_line[12]="${HOME_BENCHMARKS}/ijpeg.ss -image_file ${HOME_INPUTS}/specmun.ppm -compression.quality 90 -compression.optimize_coding 0 -compression.smoothing_factor 90 -difference.image 1 -difference.x_stride 10 -difference.y_stride 10 -verbose 1 -GO.findoptcomp"

# m88ksim.ss
# m88ksim.ss -c < ctl.in {uses ctl.raw, dhry.lit}
benchmark_name[13]="m88ksim.ss"
benchmark_type[13]="????"
benchmark_command_line[13]="${HOME_BENCHMARKS}/m88ksim.ss -c < ${HOME_INPUTS}/ctl.in {uses ctl.raw, dhry.lit}"

# perl.ss
#2 Integer
#../spec95.big/perl.ss ../inputs/scrabbl.pl < ../inputs/scrabbl.in
benchmark_name[14]="perl.ss"
benchmark_type[14]="Integer"
benchmark_command_line[14]="${HOME_BENCHMARKS}/perl.ss ${HOME_INPUTS}/scrabbl.pl < ${HOME_INPUTS}/scrabbl.in"

# swim.ss
#1 float Point
#../spec95.big/swim.ss < ../inputs/swim.in
benchmark_name[15]="swim.ss"
benchmark_type[15]="float Point"
benchmark_command_line[15]="${HOME_BENCHMARKS}/swim.ss < ${HOME_INPUTS}/swim.in"

# turb3d.ss
benchmark_name[16]="turb3d.ss"
benchmark_type[16]="????"
benchmark_command_line[16]="${HOME_BENCHMARKS}/turb3d.ss"

# wave5.ss
#5 float Point
#../spec95.big/wave5.ss < ../inputs/wave5.in
benchmark_name[17]="wave5.ss"
benchmark_type[17]="float Point"
benchmark_command_line[17]="${HOME_BENCHMARKS}/wave5.ss < ${HOME_INPUTS}/wave5.in"

FILE_OUT_PUT=${START_DIR}/${OUT_PUT_NAME}

echo "# File generated by Script ($0) at `date +%d/%m/%Y-%H:%M:%S`." > ${FILE_OUT_PUT}
echo "# Run ${SPEC_NAME} benchmarks." >> ${FILE_OUT_PUT}
echo "" >> ${FILE_OUT_PUT}

# linhas de comando
for index in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 
do
  echo "#${index} ${benchmark_type[index]}" >> ${FILE_OUT_PUT}
  echo "${benchmark_command_line[index]}" >> ${FILE_OUT_PUT}
  echo "" >> ${FILE_OUT_PUT}
done

echo "File ${OUT_PUT_NAME} generated."

echo "End of Script Execution."
echo "-----------------------------------------------------------------------"


