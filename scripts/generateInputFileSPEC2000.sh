#!/bin/bash
# Script to generate Input Files to SS_SMT and powerSMT simulators.
# Run SPEC2000.
# Author: Rogério Aparecido Gonçalves (rogerio.rag@gmail.com)


# SPEC Identifier.
SPEC_NAME="SPEC2000"

# File name to generate.
OUT_PUT_NAME="RUN_${SPEC_NAME}"

# Binaries and them inputs directories.
# SPEC2000.
HOME_BENCHMARKS="/opt/simuladores/benchmarks/SPEC/SPEC2000/SPEC2000-SS/spec2k.bin"
HOME_INPUTS="/opt/simuladores/benchmarks/SPEC/SPEC2000/inputs-spec2000"

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

# float Point:
# 168.wupwise  172.mgrid  177.mesa    179.art     187.facerec  189.lucas  200.sixtrack 171.swim	173.applu  178.galgel  183.equake  188.ammp     191.fma3d  301.apsi

# Integer
# 164.gzip  175.vpr  176.gcc  181.mcf  186.crafty  197.parser  252.eon  253.perlbmk  254.gap  255.vortex  256.bzip2  300.twolf

benchmark_name[1]="ammp.ss-little.O1"
benchmark_type[1]="float Point"
benchmark_command_line[1]="${HOME_BENCHMARKS}/ammp.ss-little.O1 ${HOME_INPUTS}/ammp.in < ${HOME_INPUTS}/all.init.ammp"

benchmark_name[2]="applu.ss-little.O3"
benchmark_type[2]="float Point"
benchmark_command_line[2]="${HOME_BENCHMARKS}/applu.ss-little.O3 < ${HOME_INPUTS}/applu.in"

benchmark_name[3]="apsi.ss-little.O3"
benchmark_type[3]="float Point"
benchmark_command_line[3]="${HOME_BENCHMARKS}/apsi.ss-little.O3 < ${HOME_INPUTS}/apsi.in"

benchmark_name[4]="art.ss-little.O3"
benchmark_type[4]="float Point"
benchmark_command_line[4]="${HOME_BENCHMARKS}/art.ss-little.O3 -scanfile ${HOME_INPUTS}/c756hel.in -trainfile1 ${HOME_INPUTS}/a10.img -stride 2 -startx 134 -starty 220 -endx 139 -endy 225 -objects 10"

benchmark_name[5]="cc1.ss-little.O3"
benchmark_type[5]="???"
benchmark_command_line[5]="${HOME_BENCHMARKS}/cc1.ss-little.O3 cccp.i -o cccp.s"

benchmark_name[6]="equake.ss-little.O1"
benchmark_type[6]="float Point"
benchmark_command_line[6]="${HOME_BENCHMARKS}/equake.ss-little.O1 < ${HOME_INPUTS}/inp.in"

benchmark_name[7]="mgrid.ss-little.O3"
benchmark_type[7]="float Point"
benchmark_command_line[7]="${HOME_BENCHMARKS}/mgrid.ss-little.O3 < ${HOME_INPUTS}/mgrid.in"

benchmark_name[8]="sixtrack.ss-little.O3"
benchmark_type[8]="float Point"
benchmark_command_line[8]="${HOME_BENCHMARKS}/sixtrack.ss-little.O3 < ${HOME_INPUTS}/inp.in"

benchmark_name[9]="swim.ss-little.O3"
benchmark_type[9]="float Point"
benchmark_command_line[9]="${HOME_BENCHMARKS}/swim.ss-little.O3 < ${HOME_INPUTS}/swim.in"

benchmark_name[10]="wupwise.ss-little.O3"
benchmark_type[10]="float Point"
benchmark_command_line[10]="${HOME_BENCHMARKS}/wupwise.ss-little.O3"

benchmark_name[11]="mesa.ss-little.O3"
benchmark_type[11]="float Point"
benchmark_command_line[11]="${HOME_BENCHMARKS}/mesa.ss-little.O3 -frames 11 -meshfile ${HOME_INPUTS}/mesa.in -ppmfile ${HOME_INPUTS}/mesa.ppm"

benchmark_name[12]="bzip2.ss-little.O3.program"
benchmark_type[12]="Integer"
benchmark_command_line[12]="${HOME_BENCHMARKS}/bzip2.ss-little.O3 ${HOME_INPUTS}/input.program 58"

benchmark_name[13]="bzip2.ss-little.O3.source"
benchmark_type[13]="Integer"
benchmark_command_line[13]="${HOME_BENCHMARKS}/bzip2.ss-little.O3 ${HOME_INPUTS}/input.source 58"

benchmark_name[14]="gzip.ss-little.O1.program"
benchmark_type[14]="Integer"
benchmark_command_line[14]="${HOME_BENCHMARKS}/gzip.ss-little.O1 ${HOME_INPUTS}/input.program 60"

benchmark_name[15]="gzip.ss-little.O1.source"
benchmark_type[15]="Integer"
benchmark_command_line[15]="${HOME_BENCHMARKS}/gzip.ss-little.O1 ${HOME_INPUTS}/input.source 60"

benchmark_name[16]="gzip.ss-little.O1.random"
benchmark_type[16]="Integer"
benchmark_command_line[16]="${HOME_BENCHMARKS}/gzip.ss-little.O1 ${HOME_INPUTS}/input.random 60"

benchmark_name[17]="gzip.ss-little.O1.log"
benchmark_type[17]="Integer"
benchmark_command_line[17]="${HOME_BENCHMARKS}/gzip.ss-little.O1 ${HOME_INPUTS}/input.log 60"

benchmark_name[18]="gzip.ss-little.O1.graphic"
benchmark_type[18]="Integer"
benchmark_command_line[18]="${HOME_BENCHMARKS}/gzip.ss-little.O1 ${HOME_INPUTS}/input.graphic 60"

benchmark_name[19]="mcf.ss-little.O1"
benchmark_type[19]="Integer"
benchmark_command_line[19]="${HOME_BENCHMARKS}/mcf.ss-little.O1 ${HOME_INPUTS}/inp.in"

benchmark_name[20]="parser.ss-little.O3"
benchmark_type[20]="Integer"
benchmark_command_line[20]="${HOME_BENCHMARKS}/parser.ss-little.O3 ${HOME_INPUTS}/2.1.dict -batch < ${HOME_INPUTS}/ref.in"

benchmark_name[21]="twolf.ss-little.O3"
benchmark_type[21]="Integer"
benchmark_command_line[21]="${HOME_BENCHMARKS}/twolf.ss-little.O3 test"

benchmark_name[22]="vpr.ss-little.O3"
benchmark_type[22]="Integer"
benchmark_command_line[22]="${HOME_BENCHMARKS}/vpr.ss-little.O3 ${HOME_INPUTS}/net.in ${HOME_INPUTS}/arch.in ${HOME_INPUTS}/place.in -nodisp -route_only -route_chan_width 15 -pres_fac_mult 2 -acc_fac 1 -first_iter_pres_fac 4 -initial_pres_fac 8"

# require the file person.1k, find in inputs directories.
benchmark_name[23]="vortex.ss-little.O2"
benchmark_type[23]="Integer"
benchmark_command_line[23]="${HOME_BENCHMARKS}/vortex.ss-little.O2 ${HOME_INPUTS}/lendian1.raw"

FILE_OUT_PUT=${START_DIR}/${OUT_PUT_NAME}

echo "# File generated by Script ($0) at `date +%d/%m/%Y-%H:%M:%S`." > ${FILE_OUT_PUT}
echo "# Run ${SPEC_NAME} benchmarks." >> ${FILE_OUT_PUT}
echo "" >> ${FILE_OUT_PUT}

# linhas de comando
for index in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 
do
  echo "#${index} ${benchmark_type[index]}" >> ${FILE_OUT_PUT}
  echo "${benchmark_command_line[index]}" >> ${FILE_OUT_PUT}
  echo "" >> ${FILE_OUT_PUT}
done

echo "File ${OUT_PUT_NAME} generated."

echo "End of Script Execution."
echo "-----------------------------------------------------------------------"


