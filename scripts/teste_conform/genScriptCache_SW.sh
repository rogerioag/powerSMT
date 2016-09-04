#!/bin/bash
# Script to generate Command Lines to SimpleScalar.
# Run SPEC2000 Benchmarks.
# Author: Rogério Aparecido Gonçalves (rogerio.rag@gmail.com)

# Target Simulator Identifier.
# SS: SimpleScalar, SW: Sim-Wattch
TARGET_SIM="SW"

# SPEC Identifier.
SPEC_NAME="SPEC2000"

# TEST identifier.
TEST_NAME="CACHE_FREQ"

# File name to generate.
OUT_PUT_NAME="RUN_${SPEC_NAME}_${TEST_NAME}_${TARGET_SIM}"
# Extension for script files.
SCRIPT_EXT="sh"
# Header identification of generate script.
SCRIPT_HEADER="#!/bin/bash"

# Script to test references  (REF) output values of Simulator.

# Target Architecture and Optimization of Binaries.
TARGET_ARCH="ss-little"

# Optimization 03.
OPT="O3"

# Binaries and them inputs directories.
# SPEC2000.
HOME_BENCHMARKS="/opt/simuladores/benchmarks/SPEC/SPEC2000/SPEC2000-SS/spec2k.bin"
HOME_INPUTS="/opt/simuladores/benchmarks/SPEC/SPEC2000/inputs-spec2000"

# Simulator home dir.
HOME_SIM="/home/rogerio/projetos.eclipse/projetos.cpp/sim-wattch-1.02-cache-histogr-2"

# Results dir.
HOME_RESULTS="/home/rogerio/mestrado/pesquisa/simulacoes/resultados/sim-wattch"


# Keep the current dir.
START_DIR=`pwd`

echo "-----------------------------------------------------------------------"
echo "Start script to generate Command lines to SimpleScalar, SS_SMT and powerSMT Simulators."
echo "This script has writed by Rogerio A. Gonçalves (rogerio.rag@gmail.com) "
echo "Variables assumed:													 "
echo "HOME_SIM: " ${HOME_SIM}
echo "HOME_BENCHMARKS: " ${HOME_BENCHMARKS}
echo "HOME_INPUTS: " ${HOME_INPUTS}
echo "HOME_RESULTS: " ${HOME_RESULTS}
echo "START_DIR: " ${START_DIR}
echo "Generate file: " ${OUT_PUT_NAME}
echo "-----------------------------------------------------------------------"
echo "Processing..."

# Build the out put dir.
NOME_DIR=`date +%d%m%Y%H%M%S`_CF-2
DIR_SAIDA=$HOME_RESULTS/$NOME_DIR

mkdir $DIR_SAIDA

# ------------------------------------------------------------------------------
# Configuration of simulator parameters.
# ------------------------------------------------------------------------------

# Number of instructions to fastforward (aquecimento).
NUM_INST_AQUEC=0
# Max number of instructions to execute.
NUM_INST_MAX=500000000

cd $HOME_INPUTS
echo "In "`pwd`" directory."

# ------------------------------------------------------------------------------
# INT benchmarks.
# ------------------------------------------------------------------------------

echo "-----------------------------------------------------------------------"
echo "                          Integer Benchmarks.                          "
echo "-----------------------------------------------------------------------"

# 164.gzip:
# Command Lines examples.
# gzip.exe input.source 60 >result\input.source.out 2>result\input.source.err
# gzip.exe input.log 60 >result\input.log.out 2>result\input.log.err
# gzip.exe input.graphic 60 >result\input.graphic.out 2>result\input.graphic.err
# gzip.exe input.random 60 >result\input.random.out 2>result\input.random.err
# gzip.exe input.program 60 >result\input.program.out 2>result\input.program.err

#1 Integer
benchmark_index=1
echo "Defining benchmark #${benchmark_index}."
benchmark_name[${benchmark_index}]="gzip"
benchmark_type[${benchmark_index}]="Integer"
benchmark_inputs[${benchmark_index}]="${HOME_INPUTS}/input.source 60"
benchmark_command_line[${benchmark_index}]="${HOME_BENCHMARKS}/${benchmark_name[${benchmark_index}]}.${TARGET_ARCH}.${OPT} ${benchmark_inputs[${benchmark_index}]}"
benchmark_output_id[${benchmark_index}]="gzip_input_source"
echo "> ${benchmark_name[${benchmark_index}]}"

# 175.vpr:
# vpr.exe net.in arch.in place.out dum.out -nodisp -place_only -init_t 5 -exit_t 0.005 -alpha_t 0.9412 -inner_num 2 >result\place_log.out 2>result\place_log.err
# vpr.exe net.in arch.in place.in route.out -nodisp -route_only -route_chan_width 15 -pres_fac_mult 2 -acc_fac 1 -first_iter_pres_fac 4 -initial_pres_fac 8 >result\route_log.out 2>result\route_log.err 
#6 Integer
benchmark_index=2
echo "Defining benchmark #${benchmark_index}."
benchmark_name[${benchmark_index}]="vpr"
benchmark_type[${benchmark_index}]="Integer"
benchmark_inputs[${benchmark_index}]="${HOME_INPUTS}/net.in ${HOME_INPUTS}/arch.in ${HOME_INPUTS}/place.out ${HOME_INPUTS}/dum.out -nodisp -place_only -init_t 5 -exit_t 0.005 -alpha_t 0.9412 -inner_num 2"
benchmark_command_line[${benchmark_index}]="${HOME_BENCHMARKS}/${benchmark_name[${benchmark_index}]}.${TARGET_ARCH}.${OPT} ${benchmark_inputs[${benchmark_index}]}"
benchmark_output_id[${benchmark_index}]="vpr_net_arch_place_dum"
echo "> ${benchmark_name[${benchmark_index}]}"

# 176.gcc:
# cc1.exe 200.i -o 200.s >result\200.out 2>result\200.err
# cc1.exe integrate.i -o integrate.s >result\integrate.out 2>result\integrate.err
# cc1.exe 166.i -o 166.s >result\166.out 2>result\166.err
# cc1.exe scilab.i -o scilab.s >result\scilab.out 2>result\scilab.err
# cc1.exe expr.i -o expr.s >result\expr.out 2>result\expr.err
#8 Integer
benchmark_index=3
echo "Defining benchmark #${benchmark_index}."
benchmark_name[${benchmark_index}]="cc1"
benchmark_type[${benchmark_index}]="Integer"
benchmark_inputs[${benchmark_index}]="${HOME_INPUTS}/200.i -o ${DIR_SAIDA}/cc1_200.s"
benchmark_command_line[${benchmark_index}]="${HOME_BENCHMARKS}/${benchmark_name[${benchmark_index}]}.${TARGET_ARCH}.${OPT} ${benchmark_inputs[${benchmark_index}]}"
benchmark_output_id[${benchmark_index}]="cc1_200"
echo "> ${benchmark_name[${benchmark_index}]}"

# 181.mcf:
# mcf.exe inp.in >result\inp.out 2>result\inp.err
#13 Integer
benchmark_index=4
echo "Defining benchmark #${benchmark_index}."
benchmark_name[${benchmark_index}]="mcf"
benchmark_type[${benchmark_index}]="Integer"
benchmark_inputs[${benchmark_index}]="${HOME_INPUTS}/mcf_inp.in"
benchmark_command_line[${benchmark_index}]="${HOME_BENCHMARKS}/${benchmark_name[${benchmark_index}]}.${TARGET_ARCH}.${OPT} ${benchmark_inputs[${benchmark_index}]}"
benchmark_output_id[${benchmark_index}]="mcf"
echo "> ${benchmark_name[${benchmark_index}]}"

# 197.parser:
# parser.exe 2.1.dict -batch <ref.in >result\ref.out 2>result\ref.err
#14 Integer
benchmark_index=5
echo "Defining benchmark #${benchmark_index}."
benchmark_name[${benchmark_index}]="parser"
benchmark_type[${benchmark_index}]="Integer"
benchmark_inputs[${benchmark_index}]="${HOME_INPUTS}/2.1.dict -batch < ${HOME_INPUTS}/ref.in"
benchmark_command_line[${benchmark_index}]="${HOME_BENCHMARKS}/${benchmark_name[${benchmark_index}]}.${TARGET_ARCH}.${OPT} ${benchmark_inputs[${benchmark_index}]}"
benchmark_output_id[${benchmark_index}]="parser"
echo "> ${benchmark_name[${benchmark_index}]}"

# 255.vortex:
# vortex.exe lendian1.raw >result\vortex1.out 2>result\vortex1.err
# vortex.exe lendian2.raw >result\vortex2.out 2>result\vortex2.err
# vortex.exe lendian3.raw >result\vortex3.out 2>result\vortex3.err
#15 Integer
benchmark_index=6
echo "Defining benchmark #${benchmark_index}."
benchmark_name[${benchmark_index}]="vortex"
benchmark_type[${benchmark_index}]="Integer"
benchmark_inputs[${benchmark_index}]="${HOME_INPUTS}/lendian1.raw"
benchmark_command_line[${benchmark_index}]="${HOME_BENCHMARKS}/${benchmark_name[${benchmark_index}]}.${TARGET_ARCH}.${OPT} ${benchmark_inputs[${benchmark_index}]}"
benchmark_output_id[${benchmark_index}]="vortex_lendian1"
echo "> ${benchmark_name[${benchmark_index}]}"

# 256.bzip2:
# bzip2.exe input.source 58 >result\input.source.out 2>result\input.source.err
# bzip2.exe input.graphic 58 >result\input.graphic.out 2>result\input.graphic.err 
# bzip2.exe input.program 58 >result\input.program.out 2>result\input.program.err

#18 Integer
benchmark_index=7
echo "Defining benchmark #${benchmark_index}."
benchmark_name[${benchmark_index}]="bzip2"
benchmark_type[${benchmark_index}]="Integer"
benchmark_inputs[${benchmark_index}]="${HOME_INPUTS}/input.source 58"
benchmark_command_line[${benchmark_index}]="${HOME_BENCHMARKS}/${benchmark_name[${benchmark_index}]}.${TARGET_ARCH}.${OPT} ${benchmark_inputs[${benchmark_index}]}"
benchmark_output_id[${benchmark_index}]="bzip2_input_source"
echo "> ${benchmark_name[${benchmark_index}]}"

# 300.twolf:
# twolf.exe ref >result\ref.stdout 2>result\ref.err
#21 Integer
benchmark_index=8
echo "Defining benchmark #${benchmark_index}."
benchmark_name[${benchmark_index}]="twolf"
benchmark_type[${benchmark_index}]="Integer"
benchmark_inputs[${benchmark_index}]="${HOME_INPUTS}/twolf.ref"
benchmark_command_line[${benchmark_index}]="${HOME_BENCHMARKS}/${benchmark_name[${benchmark_index}]}.${TARGET_ARCH}.${OPT} ${benchmark_inputs[${benchmark_index}]}"
benchmark_output_id[${benchmark_index}]="twolf"
echo "> ${benchmark_name[${benchmark_index}]}"

# ------------------------------------------------------------------------------
#                                FP benchmarks
# ------------------------------------------------------------------------------

echo "--------------------------------------------------------------------------"
echo " Float Point Benchmarks."
echo "--------------------------------------------------------------------------"

# 168.wupwise:# wupwise.exe >result\wupwise.out 2>result\wupwise.err
#22 float Point
benchmark_index=9
echo "Defining benchmark #${benchmark_index}."
benchmark_name[${benchmark_index}]="wupwise"
benchmark_type[${benchmark_index}]="float Point"
benchmark_inputs[${benchmark_index}]=""
benchmark_command_line[${benchmark_index}]="${HOME_BENCHMARKS}/${benchmark_name[${benchmark_index}]}.${TARGET_ARCH}.${OPT} ${benchmark_inputs[${benchmark_index}]}"
benchmark_output_id[${benchmark_index}]="wupwise"
echo "> ${benchmark_name[${benchmark_index}]}"

# 171.swim:
# swim.exe <swim.in >result\swim.out 2>result\swim.err
#23 float Point
benchmark_index=10
echo "Defining benchmark #${benchmark_index}."
benchmark_name[${benchmark_index}]="swim"
benchmark_type[${benchmark_index}]="float Point"
benchmark_inputs[${benchmark_index}]="< ${HOME_INPUTS}/swim.in"
benchmark_command_line[${benchmark_index}]="${HOME_BENCHMARKS}/${benchmark_name[${benchmark_index}]}.${TARGET_ARCH}.${OPT} ${benchmark_inputs[${benchmark_index}]}"
benchmark_output_id[${benchmark_index}]="swim"
echo "> ${benchmark_name[${benchmark_index}]}"

# 172.mgrid:
# mgrid.exe <mgrid.in >result\mgrid.out 2>result\mgrid.err
#24 float Point
benchmark_index=11
echo "Defining benchmark #${benchmark_index}."
benchmark_name[${benchmark_index}]="mgrid"
benchmark_type[${benchmark_index}]="float Point"
benchmark_inputs[${benchmark_index}]="< ${HOME_INPUTS}/mgrid.in"
benchmark_command_line[${benchmark_index}]="${HOME_BENCHMARKS}/${benchmark_name[${benchmark_index}]}.${TARGET_ARCH}.${OPT} ${benchmark_inputs[${benchmark_index}]}"
benchmark_output_id[${benchmark_index}]="mgrid"
echo "> ${benchmark_name[${benchmark_index}]}"

# 173.applu:
# applu.exe <applu.in >result\applu.out 2>result\applu.err
#25 float Point
benchmark_index=12
echo "Defining benchmark #${benchmark_index}."
benchmark_name[${benchmark_index}]="applu"
benchmark_type[${benchmark_index}]="float Point"
benchmark_inputs[${benchmark_index}]="< ${HOME_INPUTS}/applu.in"
benchmark_command_line[${benchmark_index}]="${HOME_BENCHMARKS}/${benchmark_name[${benchmark_index}]}.${TARGET_ARCH}.${OPT} ${benchmark_inputs[${benchmark_index}]}"
benchmark_output_id[${benchmark_index}]="applu"
echo "> ${benchmark_name[${benchmark_index}]}"

# 177.mesa:
# mesa.exe -frames 1000 -meshfile mesa.in -ppmfile mesa.ppm
#26 float Point
benchmark_index=13
echo "Defining benchmark #${benchmark_index}."
benchmark_name[${benchmark_index}]="mesa"
benchmark_type[${benchmark_index}]="float Point"
benchmark_inputs[${benchmark_index}]="-frames 1000 -meshfile ${HOME_INPUTS}/mesa.in -ppmfile ${HOME_INPUTS}/mesa.ppm"
benchmark_command_line[${benchmark_index}]="${HOME_BENCHMARKS}/${benchmark_name[${benchmark_index}]}.${TARGET_ARCH}.${OPT} ${benchmark_inputs[${benchmark_index}]}"
benchmark_output_id[${benchmark_index}]="mesa"
echo "> ${benchmark_name[${benchmark_index}]}"

# 179.art:
# art.exe -scanfile c756hel.in -trainfile1 a10.img -trainfile2 hc.img -stride 2 -startx 110 -starty 200 -endx 160 -endy 240 -objects 10 >result\ref.1.out 2>result\ref.1.err
# art.exe -scanfile c756hel.in -trainfile1 a10.img -trainfile2 hc.img -stride 2 -startx 470 -starty 140 -endx 520 -endy 180 -objects 10 >result\ref.2.out 2>result\ref.2.err
#27 float Point
benchmark_index=14
echo "Defining benchmark #${benchmark_index}."
benchmark_name[${benchmark_index}]="art"
benchmark_type[${benchmark_index}]="float Point"
benchmark_inputs[${benchmark_index}]="-scanfile ${HOME_INPUTS}/c756hel.in -trainfile1 ${HOME_INPUTS}/a10.img -trainfile2 ${HOME_INPUTS}/hc.img -stride 2 -startx 110 -starty 200 -endx 160 -endy 240 -objects 10"
benchmark_command_line[${benchmark_index}]="${HOME_BENCHMARKS}/${benchmark_name[${benchmark_index}]}.${TARGET_ARCH}.${OPT} ${benchmark_inputs[${benchmark_index}]}"
benchmark_output_id[${benchmark_index}]="art_2_110_200_160_240_10"
echo "> ${benchmark_name[${benchmark_index}]}"

# 183.equake:
# equake.exe <inp.in >result\inp.out 2>result\inp.err
# rename the input file inp.in to equake_inp.in
#29 float Point
benchmark_index=15
echo "Defining benchmark #${benchmark_index}."
benchmark_name[${benchmark_index}]="equake"
benchmark_type[${benchmark_index}]="float Point"
benchmark_inputs[${benchmark_index}]="< ${HOME_INPUTS}/equake_inp.in"
benchmark_command_line[${benchmark_index}]="${HOME_BENCHMARKS}/${benchmark_name[${benchmark_index}]}.${TARGET_ARCH}.${OPT} ${benchmark_inputs[${benchmark_index}]}"
benchmark_output_id[${benchmark_index}]="equake"
echo "> ${benchmark_name[${benchmark_index}]}"

# 188.ammp:
# ammp.exe <ammp.in >result\ammp.out 2>result\ammp.err
#30 float Point
benchmark_index=16
echo "Defining benchmark #${benchmark_index}."
benchmark_name[${benchmark_index}]="ammp"
benchmark_type[${benchmark_index}]="float Point"
benchmark_inputs[${benchmark_index}]="< ${HOME_INPUTS}/ammp.in"
benchmark_command_line[${benchmark_index}]="${HOME_BENCHMARKS}/${benchmark_name[${benchmark_index}]}.${TARGET_ARCH}.${OPT} ${benchmark_inputs[${benchmark_index}]}"
benchmark_output_id[${benchmark_index}]="ammp"
echo "> ${benchmark_name[${benchmark_index}]}"


#--------------------------------------------------------------------------------
#                        Extra integers benchmarks
#--------------------------------------------------------------------------------

#2 Integer
benchmark_index=17
echo "Defining benchmark #${benchmark_index}."
benchmark_name[${benchmark_index}]="gzip"
benchmark_type[${benchmark_index}]="Integer"
benchmark_inputs[${benchmark_index}]="${HOME_INPUTS}/input.log 60"
benchmark_command_line[${benchmark_index}]="${HOME_BENCHMARKS}/${benchmark_name[${benchmark_index}]}.${TARGET_ARCH}.${OPT} ${benchmark_inputs[${benchmark_index}]}"
benchmark_output_id[${benchmark_index}]="gzip_input_log"
echo "> ${benchmark_name[${benchmark_index}]}"

#3 Integer
benchmark_index=18
echo "Defining benchmark #${benchmark_index}."
benchmark_name[${benchmark_index}]="gzip"
benchmark_type[${benchmark_index}]="Integer"
benchmark_inputs[${benchmark_index}]="${HOME_INPUTS}/input.graphic 60"
benchmark_command_line[${benchmark_index}]="${HOME_BENCHMARKS}/${benchmark_name[${benchmark_index}]}.${TARGET_ARCH}.${OPT} ${benchmark_inputs[${benchmark_index}]}"
benchmark_output_id[${benchmark_index}]="gzip_input_graphic"
echo "> ${benchmark_name[${benchmark_index}]}"

#4 Integer
benchmark_index=19
echo "Defining benchmark #${benchmark_index}."
benchmark_name[${benchmark_index}]="gzip"
benchmark_type[${benchmark_index}]="Integer"
benchmark_inputs[${benchmark_index}]="${HOME_INPUTS}/input.random 60"
benchmark_command_line[${benchmark_index}]="${HOME_BENCHMARKS}/${benchmark_name[${benchmark_index}]}.${TARGET_ARCH}.${OPT} ${benchmark_inputs[${benchmark_index}]}"
benchmark_output_id[${benchmark_index}]="gzip_input_random"
echo "> ${benchmark_name[${benchmark_index}]}"

#5 Integer
benchmark_index=20
echo "Defining benchmark #${benchmark_index}."
benchmark_name[${benchmark_index}]="gzip"
benchmark_type[${benchmark_index}]="Integer"
benchmark_inputs[${benchmark_index}]="${HOME_INPUTS}/input.program 60"
benchmark_command_line[${benchmark_index}]="${HOME_BENCHMARKS}/${benchmark_name[${benchmark_index}]}.${TARGET_ARCH}.${OPT} ${benchmark_inputs[${benchmark_index}]}"
benchmark_output_id[${benchmark_index}]="gzip_input_program"
echo "> ${benchmark_name[${benchmark_index}]}"

#7 Integer
benchmark_index=21
echo "Defining benchmark #${benchmark_index}."
benchmark_name[${benchmark_index}]="vpr"
benchmark_type[${benchmark_index}]="Integer"
benchmark_inputs[${benchmark_index}]="${HOME_INPUTS}/net.in ${HOME_INPUTS}/arch.in ${HOME_INPUTS}/place.in ${HOME_INPUTS}/route.out -nodisp -route_only -route_chan_width 15 -pres_fac_mult 2 -acc_fac 1 -first_iter_pres_fac 4 -initial_pres_fac 8"
benchmark_command_line[${benchmark_index}]="${HOME_BENCHMARKS}/${benchmark_name[${benchmark_index}]}.${TARGET_ARCH}.${OPT} ${benchmark_inputs[${benchmark_index}]}"
benchmark_output_id[${benchmark_index}]="vpr_net_arch_place_route"
echo "> ${benchmark_name[${benchmark_index}]}"

#9 Integer
benchmark_index=22
echo "Defining benchmark #${benchmark_index}."
benchmark_name[${benchmark_index}]="cc1"
benchmark_type[${benchmark_index}]="Integer"
benchmark_inputs[${benchmark_index}]="${HOME_INPUTS}/integrate.i -o ${DIR_SAIDA}/cc1_integrate.s"
benchmark_command_line[${benchmark_index}]="${HOME_BENCHMARKS}/${benchmark_name[${benchmark_index}]}.${TARGET_ARCH}.${OPT} ${benchmark_inputs[${benchmark_index}]}"
benchmark_output_id[${benchmark_index}]="cc1_integrate"
echo "> ${benchmark_name[${benchmark_index}]}"

#10 Integer
benchmark_index=23
echo "Defining benchmark #${benchmark_index}."
benchmark_name[${benchmark_index}]="cc1"
benchmark_type[${benchmark_index}]="Integer"
benchmark_inputs[${benchmark_index}]="${HOME_INPUTS}/166.i -o ${DIR_SAIDA}/cc1_166.s"
benchmark_command_line[${benchmark_index}]="${HOME_BENCHMARKS}/${benchmark_name[${benchmark_index}]}.${TARGET_ARCH}.${OPT} ${benchmark_inputs[${benchmark_index}]}"
benchmark_output_id[${benchmark_index}]="cc1_166"
echo "> ${benchmark_name[${benchmark_index}]}"

#11 Integer
benchmark_index=24
echo "Defining benchmark #${benchmark_index}."
benchmark_name[${benchmark_index}]="cc1"
benchmark_type[${benchmark_index}]="Integer"
benchmark_inputs[${benchmark_index}]="${HOME_INPUTS}/scilab.i -o ${DIR_SAIDA}/cc1_scilab.s"
benchmark_command_line[${benchmark_index}]="${HOME_BENCHMARKS}/${benchmark_name[${benchmark_index}]}.${TARGET_ARCH}.${OPT} ${benchmark_inputs[${benchmark_index}]}"
benchmark_output_id[${benchmark_index}]="cc1_scilab"
echo "> ${benchmark_name[${benchmark_index}]}"

#12 Integer
benchmark_index=25
echo "Defining benchmark #${benchmark_index}."
benchmark_name[${benchmark_index}]="cc1"
benchmark_type[${benchmark_index}]="Integer"
benchmark_inputs[${benchmark_index}]="${HOME_INPUTS}/expr.i -o ${DIR_SAIDA}/cc1_expr.s"
benchmark_command_line[${benchmark_index}]="${HOME_BENCHMARKS}/${benchmark_name[${benchmark_index}]}.${TARGET_ARCH}.${OPT} ${benchmark_inputs[${benchmark_index}]}"
benchmark_output_id[${benchmark_index}]="cc1_expr"
echo "> ${benchmark_name[${benchmark_index}]}"

#16 Integer
benchmark_index=26
echo "Defining benchmark #${benchmark_index}."
benchmark_name[${benchmark_index}]="vortex"
benchmark_type[${benchmark_index}]="Integer"
benchmark_inputs[${benchmark_index}]="${HOME_INPUTS}/lendian2.raw"
benchmark_command_line[${benchmark_index}]="${HOME_BENCHMARKS}/${benchmark_name[${benchmark_index}]}.${TARGET_ARCH}.${OPT} ${benchmark_inputs[${benchmark_index}]}"
benchmark_output_id[${benchmark_index}]="vortex_lendian2"
echo "> ${benchmark_name[${benchmark_index}]}"

#17 Integer
benchmark_index=27
echo "Defining benchmark #${benchmark_index}."
benchmark_name[${benchmark_index}]="vortex"
benchmark_type[${benchmark_index}]="Integer"
benchmark_inputs[${benchmark_index}]="${HOME_INPUTS}/lendian3.raw"
benchmark_command_line[${benchmark_index}]="${HOME_BENCHMARKS}/${benchmark_name[${benchmark_index}]}.${TARGET_ARCH}.${OPT} ${benchmark_inputs[${benchmark_index}]}"
benchmark_output_id[${benchmark_index}]="vortex_lendian3"
echo "> ${benchmark_name[${benchmark_index}]}"

#19 Integer
benchmark_index=28
echo "Defining benchmark #${benchmark_index}."
benchmark_name[${benchmark_index}]="bzip2"
benchmark_type[${benchmark_index}]="Integer"
benchmark_inputs[${benchmark_index}]="${HOME_INPUTS}/input.graphic 58"
benchmark_command_line[${benchmark_index}]="${HOME_BENCHMARKS}/${benchmark_name[${benchmark_index}]}.${TARGET_ARCH}.${OPT} ${benchmark_inputs[${benchmark_index}]}"
benchmark_output_id[${benchmark_index}]="bzip2_input_graphic"
echo "> ${benchmark_name[${benchmark_index}]}"

#20 Integer
benchmark_index=29
echo "Defining benchmark #${benchmark_index}."
benchmark_name[${benchmark_index}]="bzip2"
benchmark_type[${benchmark_index}]="Integer"
benchmark_inputs[${benchmark_index}]="${HOME_INPUTS}/input.program 58"
benchmark_command_line[${benchmark_index}]="${HOME_BENCHMARKS}/${benchmark_name[${benchmark_index}]}.${TARGET_ARCH}.${OPT} ${benchmark_inputs[${benchmark_index}]}"
benchmark_output_id[${benchmark_index}]="bzip2_input_program"
echo "> ${benchmark_name[${benchmark_index}]}"

# ------------------------------------------------------------------------------
#                          INT Binaries not avaialable.
# ------------------------------------------------------------------------------

# 186.crafty:
# crafty.exe <crafty.in >result\crafty.out 2>result\crafty.err

# 252.eon:
# eon.exe chair.control.cook chair.camera chair.surfaces chair.cook.ppm ppm pixels_out.cook  >result\cook_log.out 2>result\cook_log.err
# eon.exe chair.control.rushmeier chair.camera chair.surfaces chair.rushmeier.ppm ppm pixels_out.rushmeier >result\rushmeir_log.out 2>result\rushmeir_log.err
# eon.exe chair.control.kajiya chair.camera chair.surfaces chair.kajiya.ppm ppm pixels_out.kajiya >result\kajiya_log.out 2>result\kajiya_log.err

# 253.perlbmk:
# perlbmk.exe -I./lib diffmail.pl 2 550 15 24 23 100 >result\2.550.15.24.23.100.out 2>2.550.15.24.23.100.err
# perlbmk.exe -I./lib perfect.pl b 3 m 4 >result\b.3.m.4.out 2>b.3.m.4.err
# perlbmk.exe -I./lib splitmail.pl 850 5 19 18 1500 >result\850.5.19.18.1500.out 2>850.5.19.18.1500.err
# perlbmk.exe -I./lib splitmail.pl 704 12 26 16 836 >result\704.12.26.16.836.out 2>704.12.26.16.836.err
# perlbmk.exe -I./lib splitmail.pl 535 13 25 24 1091 >result\535.13.25.24.1091.out 2>535.13.25.24.1091.err
# perlbmk.exe -I./lib splitmail.pl 957 12 23 26 1014 >result\957.12.23.26.1014.out 2>957.12.23.26.1014.err
# perlbmk.exe -I. -I./lib makerand.pl >result\makerand.out 2>makerand.err

# 254.gap:
# gap.exe -l ./ -q -m 192M <ref.in >result\ref.out 2>result\ref.err


# ------------------------------------------------------------------------------
#                                Extra FP benchmarks
# ------------------------------------------------------------------------------

#28 float Point
benchmark_index=30
echo "Defining benchmark #${benchmark_index}."
benchmark_name[${benchmark_index}]="art"
benchmark_type[${benchmark_index}]="float Point"
benchmark_inputs[${benchmark_index}]="-scanfile ${HOME_INPUTS}/c756hel.in -trainfile1 ${HOME_INPUTS}/a10.img -trainfile2 ${HOME_INPUTS}/hc.img -stride 2 -startx 470 -starty 140 -endx 520 -endy 180 -objects 10"
benchmark_command_line[${benchmark_index}]="${HOME_BENCHMARKS}/${benchmark_name[${benchmark_index}]}.${TARGET_ARCH}.${OPT} ${benchmark_inputs[${benchmark_index}]}"
benchmark_output_id[${benchmark_index}]="art_2_470_140_520_180_10"
echo "> ${benchmark_name[${benchmark_index}]}"

# 200.sixtrack:# sixtrack.exe <inp.in >result\inp.out 2>result\inp.err
#31 float Point
benchmark_index=31
echo "Defining benchmark #${benchmark_index}."
benchmark_name[${benchmark_index}]="sixtrack"
benchmark_type[${benchmark_index}]="float Point"
benchmark_inputs[${benchmark_index}]="< ${HOME_INPUTS}/sixtrack_inp.in"
benchmark_command_line[${benchmark_index}]="${HOME_BENCHMARKS}/${benchmark_name[${benchmark_index}]}.${TARGET_ARCH}.${OPT} ${benchmark_inputs[${benchmark_index}]}"
benchmark_output_id[${benchmark_index}]="sixtrack"
echo "> ${benchmark_name[${benchmark_index}]}"

# 301.apsi:
# apsi.exe >result\apsi.out 2>result\apsi.err
#32 float Point
benchmark_index=32
echo "Defining benchmark #${benchmark_index}."
benchmark_name[${benchmark_index}]="apsi"
benchmark_type[${benchmark_index}]="float Point"
benchmark_inputs[${benchmark_index}]=""
benchmark_command_line[${benchmark_index}]="${HOME_BENCHMARKS}/${benchmark_name[${benchmark_index}]}.${TARGET_ARCH}.${OPT} ${benchmark_inputs[${benchmark_index}]}"
benchmark_output_id[${benchmark_index}]="apsi"
echo "> ${benchmark_name[${benchmark_index}]}"

# -----------------------------------------------------------------------
# FP Binaries not avaialable.
# -----------------------------------------------------------------------

# 178.galgel:
# galgel.exe <galgel.in >result\galgel.out 2>result\galgel.err

# 187.facerec:
# facerec.exe <ref.in >result\ref.out 2>result\ref.err

# 189.lucas:
# lucas.exe <lucas2.in >result\lucas2.out 2>result\lucas2.err

# 191.fma3d:
# fma3d.exe <fma3d.in >result\fma3d.out 2>result\fma3d.err

# ------------------------------------------------------------------------
# Loop to file generate.
# ------------------------------------------------------------------------
echo "Generating file..."

FILE_OUT_PUT=${START_DIR}/${OUT_PUT_NAME}.${SCRIPT_EXT}

echo ${SCRIPT_HEADER} > ${FILE_OUT_PUT}

echo "# File generated by Script ($0) at `date +%d/%m/%Y-%H:%M:%S`." >> ${FILE_OUT_PUT}
echo "# Run ${SPEC_NAME} benchmarks." >> ${FILE_OUT_PUT}
echo "# This script must be executed in ${HOME_INPUTS}, because the inputs of inputs." >> ${FILE_OUT_PUT}
echo "" >> ${FILE_OUT_PUT}

TLBS_DEFS="-tlb:itlb itlb:8:4096:8:l -tlb:dtlb dtlb:16:4096:8:l"
STAGES_DEFS="-fetch:ifqsize 8 -decode:width 16 -issue:inorder FALSE -issue:width 16 -commit:width 16"
RUU_LSQ_DEFS="-ruu:size 16 -lsq:size 8"
RES_DEFS="-res:ialu 5 -res:imult 2 -res:memport 3 -res:fpalu 5 -res:fpmult 2"

# linhas de comando
for tamCache in 16384 32768 65536 131072 262144 524288 1048576 2097152 4194304
do
	for blockSize in 32
	do
		for assoc in 4
  		do
    		for index in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 
    		do
				echo "Generating Command Line: (${tamCache}, ${blockSize}, ${assoc}, ${index})."
				echo "echo 'Executando config (${tamCache}, ${blockSize}, ${assoc}, ${index}).'" >> ${FILE_OUT_PUT}
				DATE_CMD='`date`'
				echo "echo \"Inicio: ${DATE_CMD}.\"" >> ${FILE_OUT_PUT}
				echo "#${index} ${benchmark_type[index]}" >> ${FILE_OUT_PUT}
				SAIDA_SIM="${DIR_SAIDA}/${benchmark_output_id[index]}_${tamCache}_${blockSize}_${assoc}_sim.out"
				SAIDA_PROG="${DIR_SAIDA}/${benchmark_output_id[index]}_${tamCache}_${blockSize}_${assoc}_prog.out"
				ADD_SIM_OPT="${HOME_SIM}/sim-outorder -fastfwd ${NUM_INST_AQUEC} -max:inst ${NUM_INST_MAX} -redir:sim ${SAIDA_SIM} -redir:prog ${SAIDA_PROG}"

				# Cache definitions.
				il1_nSets=$[tamCache / blockSize / assoc]
				CACHE_IL1_DEF="-cache:il1 il1:${il1_nSets}:${blockSize}:${assoc}:l"

				# Cache de dados com o dobro do tamanho da de instrucoes.
				dl1_nSets=$[il1_nSets * 2]
				CACHE_DL1_DEF="-cache:dl1 dl1:${dl1_nSets}:${blockSize}:${assoc}:l"

				# Não mexe no nivel 2.
				CACHE_IL2_DEF="-cache:il2 dl2"
				CACHE_DL2_DEF="-cache:dl2 ul2:1024:128:8:l"
				
				CACHES_DEFS="${CACHE_IL1_DEF} ${CACHE_DL1_DEF} ${CACHE_IL2_DEF} ${CACHE_DL2_DEF}"
								
				ADD_SIM_OPT="${ADD_SIM_OPT} ${CACHES_DEFS} ${TLBS_DEFS} ${STAGES_DEFS} ${RUU_LSQ_DEFS} ${RES_DEFS}"
				echo "${ADD_SIM_OPT} ${benchmark_command_line[index]}" >> ${FILE_OUT_PUT}
				echo "echo \"Termino: ${DATE_CMD}.\"" >> ${FILE_OUT_PUT}
				echo "" >> ${FILE_OUT_PUT}
    		done
  		done
	done
done

echo "File ${OUT_PUT_NAME} generated."

echo "End of Script Execution."
echo "Execute the ${OUT_PUT_NAME}.${SCRIPT_EXT} in ${HOME_INPUTS} directory."

echo "-----------------------------------------------------------------------"

